FROM openshift/redis:4.0.12-alpine3.9

#RUN set -x \
#	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
#	&& apk add --no-cache redis sed bash tzdata netcat-openbsd bind-tools \
#	&& cp /usr/share/zoneinfo/UTC /etc/localtime \
#    && echo "UTC" > /etc/timezone \
#    && apk del --no-cache tzdata

ADD config/redis-sentinel.conf /etc/redis-sentinel.conf
ADD config/redis.conf /etc/redis.conf
ADD config/redis-slave.conf /etc/redis-slave.conf
ADD config/fix-permissions /usr/local/bin/fix-permissions
ADD config/startup.sh /startup.sh

RUN chmod +x /startup.sh
RUN chmod +x /usr/local/bin/fix-permissions

EXPOSE 26379 6379
ENTRYPOINT ["/docker-entrypoint.sh"]
RUN set -xe ;\
    fix-permissions /usr/local/bin; \
    fix-permissions /etc;
USER 1001
CMD ["redis-server", "/etc/redis.conf"]
