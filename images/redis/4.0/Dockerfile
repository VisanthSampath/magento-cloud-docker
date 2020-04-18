FROM redis:4.0

VOLUME /data

COPY redis-healthcheck.sh /usr/local/bin/redis-healthcheck.sh
RUN ["chmod", "+x", "/usr/local/bin/redis-healthcheck.sh"]

HEALTHCHECK --retries=3 CMD ["bash", "/usr/local/bin/redis-healthcheck.sh"]

EXPOSE 6379

CMD ["redis-server"]
