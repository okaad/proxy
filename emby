#!/bin/bash

# 如果没有提供参数，则提示用户输入
if [ "$#" -lt 2 ]; then
    echo "请输入域名或IP:"
    read DOMAIN_OR_IP
    echo "注意确保输入的端口后2位未被使用"
    echo "如输入61000,那么61001和61002都不能被占用"
    echo "请输入端口:"
    read PORT
else
    DOMAIN_OR_IP=$1
    PORT=$2
fi

# 将输入的端口转为整数
PORT=$((PORT))

# 原始模板
NGINX_TEMPLATE=$(cat <<EOF
server {
    listen REPLACE_PORT;
    server_name REPLACE_DOMAIN;

    location ~ ^/(\\.user.ini|\\.htaccess|\\.git|\\.env|\\.svn|\\.project|LICENSE|README.md) {
        return 404;
    }

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
    proxy_set_header Sec-WebSocket-Extensions \$http_sec_websocket_extensions;
    proxy_set_header Sec-WebSocket-Key \$http_sec_websocket_key;
    proxy_set_header Sec-WebSocket-Version \$http_sec_websocket_version;
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
        proxy_set_header REMOTE-HOST \$remote_addr;
        proxy_ssl_verify off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_read_timeout 86400;
        add_header X-Cache \$upstream_cache_status;
        add_header Cache-Control no-cache;
    }
}
EOF
)

# 写入目录
CONFIG_DIR="/etc/nginx/conf.d"
mkdir -p "$CONFIG_DIR"

# -------- 原来的三个配置 -------- #
declare -A ORIGINAL_TARGETS=(
    ["emby.conf"]="hd.xmsl.org"
    ["emby1.conf"]="cfloacl.emby.moe"
    ["emby2.conf"]="line.xmsl.org"
)

INDEX=0
for FILE in "${!ORIGINAL_TARGETS[@]}"; do
    TARGET=${ORIGINAL_TARGETS[$FILE]}
    CUR_PORT=$((PORT + INDEX))

    CONFIG=$(echo "$NGINX_TEMPLATE" \
        | sed "s/REPLACE_PORT/$CUR_PORT/" \
        | sed "s/REPLACE_DOMAIN/$DOMAIN_OR_IP/" \
        | sed "s/REPLACE_TARGET/$TARGET/")

    echo "$CONFIG" > "$CONFIG_DIR/$FILE"
    INDEX=$((INDEX + 1))
done


# -------- 新增的 Emby 列表 -------- #
EXTRA_TARGETS=(
    "plus.younoyes.com"
    "line.xmsl.org"
    "emos.lol"
    "link00.okemby.org"
    "hka-emby.aliz.work"
    "matrix.313445.xyz"
    "media.nijigem.by"
    "emby.bangumi.ca"
)

# 从 PORT+3 开始
BASE_OFFSET=3

COUNT=0
for TARGET in "${EXTRA_TARGETS[@]}"; do
    CUR_PORT=$((PORT + BASE_OFFSET + COUNT))
    OUTFILE="$CONFIG_DIR/emby_extra_$COUNT.conf"

    CONFIG=$(echo "$NGINX_TEMPLATE" \
        | sed "s/REPLACE_PORT/$CUR_PORT/" \
        | sed "s/REPLACE_DOMAIN/$DOMAIN_OR_IP/" \
        | sed "s/REPLACE_TARGET/$TARGET/")

    echo "$CONFIG" > "$OUTFILE"
    COUNT=$((COUNT + 1))
done

echo "所有配置已生成于：$CONFIG_DIR"
echo "起始端口: $PORT ，你可使用 到 PORT+${COUNT}+2 的范围"
