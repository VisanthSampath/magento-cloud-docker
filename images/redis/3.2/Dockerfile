FROM redis:3.2

VOLUME /data

COPY redis-healthcheck.sh /redis-healthcheck.sh
RUN ["chmod", "+x", "/redis-healthcheck.sh"]

EXPOSE 6379

CMD ["redis-server"]
