FROM alpine:3.8

RUN set -x \
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
	&& apk add --no-cache redis sed bash tzdata \
	&& cp /usr/share/zoneinfo/UTC /etc/localtime \
    && echo "UTC" > /etc/timezone \
    && apk del --no-cache tzdata

RUN mkdir -p /redis-master && mkdir /redis-slave
COPY image/redis-master.conf /redis-master/redis.conf
COPY image/redis-slave.conf /redis-slave/redis.conf
COPY image/run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]

ENTRYPOINT [ "bash", "-c" ]
