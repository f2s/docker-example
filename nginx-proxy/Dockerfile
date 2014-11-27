FROM ubuntu-base

#TAG nginx-proxy-test

RUN apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

WORKDIR /etc/nginx


EXPOSE 80/tcp
EXPOSE 443/tcp

CMD until nc -w1 upstream 80; do sleep 0.5; done; \
    service nginx start; \
    tail -f /var/log/nginx/*
