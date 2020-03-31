FROM redis:4.0

VOLUME /data

COPY redis-healthcheck.sh /redis-healthcheck.sh
RUN ["chmod", "+x", "/redis-healthcheck.sh"]

EXPOSE 6379

CMD ["redis-server"]
