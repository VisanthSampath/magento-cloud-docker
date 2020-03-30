FROM nginx:1.9

COPY etc/vhost.conf /etc/nginx/conf.d/default.conf
COPY etc/certs/ /etc/nginx/ssl/
COPY bin/* /usr/local/bin/

EXPOSE 80 443

ENV UPLOAD_MAX_FILESIZE 64M
ENV FPM_HOST fpm
ENV FPM_PORT 9000
ENV MAGENTO_ROOT /app
ENV MAGENTO_RUN_MODE production
ENV DEBUG false

<<<<<<< Updated upstream
RUN ["chmod", "+x", "/usr/local/bin/docker-environment"]
=======
COPY etc/nginx.conf /etc/nginx/
COPY etc/vhost.conf /etc/nginx/conf.d/default.conf
COPY etc/xdebug-upstream.conf /etc/nginx/conf.d/xdebug/upstream.conf

RUN apt-get update && apt-get install -y openssl
RUN mkdir /etc/nginx/ssl \
  && echo -e "\n\n\n\n\n\n\n" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/magento.key -out /etc/nginx/ssl/magento.crt

RUN groupadd -g 1000 www && useradd -g 1000 -u 1000 -d ${MAGENTO_ROOT} -s /bin/bash www

VOLUME ${MAGENTO_ROOT}

COPY nginx-healthcheck.sh nginx-healthcheck.sh
RUN ["chmod", "+x", "/nginx-healthcheck.sh"]

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]

USER root

EXPOSE 80
>>>>>>> Stashed changes

ENTRYPOINT ["/usr/local/bin/docker-environment"]

CMD ["nginx", "-g", "daemon off;"]
