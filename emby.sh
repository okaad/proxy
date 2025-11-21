#!/bin/bash

# 如果没有提供参数，则提示用户输入
if [ "$#" -lt 1 ]; then
    echo "请输入域名或IP:"
    read DOMAIN_OR_IP
else
    DOMAIN_OR_IP=$1
fi

# 起始端口
START_PORT=8085

# 需要反代的网址列表
TARGETS=(
    "hd.xmsl.org"
    "cfloacl.emby.moe"
    "line.xmsl.org"
    "plus.younoyes.com"
    "emos.lol:443"
    "link00.okemby.org"
    "hka-emby.aliz.work"
    "matrix.313445.xyz"
    "media.nijigem.by"
    "emby.bangumi.ca"
)

CONFIG_DIR="/etc/nginx/conf.d"
if [ ! -d "$CONFIG_DIR" ]; then
    echo "目录 $CONFIG_DIR 不存在，正在创建..."
    mkdir -p "$CONFIG_DIR"
fi

# 基础 Nginx 配置模板
NGINX_TEMPLATE=$(cat <<'EOF'
server {
    listen PORT; #使用的端口
    server_name SERVER_NAME;

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
        proxy_pass http://TARGET;
        proxy_set_header Host TARGET_HOST;
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

# 循环生成配置
PORT=$START_PORT
for TARGET in "${TARGETS[@]}"; do
    # 获取域名（去掉端口，如果有的话）
    TARGET_HOST=$(echo "$TARGET" | sed 's/:.*//')
    CONFIG_CONTENT=$(echo "$NGINX_TEMPLATE" | sed \
        -e "s/PORT/$PORT/" \
        -e "s/SERVER_NAME/$DOMAIN_OR_IP/" \
        -e "s|TARGET|$TARGET|" \
        -e "s|TARGET_HOST|$TARGET_HOST|"
    )
    CONFIG_FILE="$CONFIG_DIR/emby_$PORT.conf"
    echo "$CONFIG_CONTENT" > "$CONFIG_FILE"
    echo "生成配置: $CONFIG_FILE (反代 $TARGET)"
    ((PORT++))
done

echo "所有配置已生成完成。"
