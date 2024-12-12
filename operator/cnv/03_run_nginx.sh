sudo podman run --name win-nginx -d -p 8083:80 -v /root/windows:/usr/share/nginx/html:ro --privileged quay.io/ebattat/nginx:latest

