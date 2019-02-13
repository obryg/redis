FROM redis:4.0.12-alpine

RUN set -x \
           && apk add sed bash tzdata

COPY redis-image/redis-master.conf /redis-master/redis.conf
COPY redis-image/redis-slave.conf /redis-slave/redis.conf
COPY redis-image/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 6379 26379

CMD [ "/run.sh" ]

ENTRYPOINT [ "bash", "-c" ]