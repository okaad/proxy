#!/bin/bash

# 如果没有提供参数，则提示用户输入域名或IP（server_name）
if [ "$#" -lt 1 ]; then
    echo "请输入你的服务器域名或IP:"
    read DOMAIN_OR_IP
else
    DOMAIN_OR_IP=$1
fi

# 起始端口
START_PORT=8080

# Emby 域名列表
EMBY_TARGETS=(
    "plus.younoyes.com"
    "line.xmsl.org"
    "emos.lol"
    "link00.okemby.org"
    "hka-emby.aliz.work"
    "matrix.313445.xyz"
    "media.nijigem.by"
    "emby.bangumi.ca"
)

# 配置模板
NGINX_TEMPLATE=$(cat <<'EOF'
server {
    listen REPLACE_PORT;
    server_name REPLACE_DOMAIN;

    location ~ ^/(\.user.ini|\.htaccess|\.git|\.env|\.svn|\.project|LICENSE|README.md) {
        return 404;
    }

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Sec-WebSocket-Extensions $http_sec_websocket_extensions;
    proxy_set_header Sec-WebSocket-Key $http_sec_websocket_key;
    proxy_set_header Sec-WebSocket-Version $http_sec_websocket_version;
    proxy_cache off;
    proxy_redirect off;
    proxy_buffering off;

    location / {
        proxy_pass http://REPLACE_TARGET;
        proxy_set_header Host REPLACE_TARGET;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
        proxy_set_header REMOTE-HOST $remote_addr;
        proxy_ssl_verify off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_read_timeout 86400;
        add_header X-Cache $upstream_cache_status;
        add_header Cache-Control no-cache;
    }
}
EOF
)

# 配置目录
CONFIG_DIR="/etc/nginx/conf.d"
mkdir -p "$CONFIG_DIR"

# 删除之前可能的旧配置
rm -f $CONFIG_DIR/emby_*.conf

# 生成新的配置
PORT=$START_PORT
for TARGET in "${EMBY_TARGETS[@]}"; do
    OUTFILE="$CONFIG_DIR/emby_$(echo $TARGET | tr '.' '_').conf"
    CONFIG=$(echo "$NGINX_TEMPLATE" \
        | sed "s/REPLACE_PORT/$PORT/" \
        | sed "s/REPLACE_DOMAIN/$DOMAIN_OR_IP/" \
        | sed "s/REPLACE_TARGET/$TARGET/")
    echo "$CONFIG" > "$OUTFILE"
    echo "生成 $OUTFILE -> $PORT -> $TARGET"
    PORT=$((PORT + 1))
done

# 提示完成
echo "所有 Emby 反代配置已生成于 $CONFIG_DIR"
echo "起始端口: $START_PORT"

