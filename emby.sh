# Emby 反代配置，从8085开始
server {
    listen 8085;
    server_name yourdomain.com;

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;

    location / {
        proxy_pass http://plus.younoyes.com;
        proxy_set_header Host plus.younoyes.com;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
    }
}

server {
    listen 8086;
    server_name yourdomain.com;

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;

    location / {
        proxy_pass http://line.xmsl.org;
        proxy_set_header Host line.xmsl.org;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
    }
}

server {
    listen 8087;
    server_name yourdomain.com;

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;

    location / {
        proxy_pass http://emos.lol;
        proxy_set_header Host emos.lol;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
    }
}

server {
    listen 8088;
    server_name yourdomain.com;

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;

    location / {
        proxy_pass http://link00.okemby.org;
        proxy_set_header Host link00.okemby.org;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
    }
}

server {
    listen 8089;
    server_name yourdomain.com;

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;

    location / {
        proxy_pass http://hka-emby.aliz.work;
        proxy_set_header Host hka-emby.aliz.work;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
    }
}

server {
    listen 8090;
    server_name yourdomain.com;

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;

    location / {
        proxy_pass http://matrix.313445.xyz;
        proxy_set_header Host matrix.313445.xyz;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
    }
}

server {
    listen 8091;
    server_name yourdomain.com;

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;

    location / {
        proxy_pass http://media.nijigem.by;
        proxy_set_header Host media.nijigem.by;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
    }
}

server {
    listen 8092;
    server_name yourdomain.com;

    client_max_body_size 5000M;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;

    location / {
        proxy_pass http://emby.bangumi.ca;
        proxy_set_header Host emby.bangumi.ca;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-Methods' '*';
        add_header 'Access-Control-Allow-Headers' '*';
    }
}

