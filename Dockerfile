FROM openshift/redis:4.0.12-alpine3.9

ADD config/redis-sentinel.conf /etc/redis-sentinel.conf
ADD config/redis.conf /etc/redis.conf
ADD config/redis-slave.conf /etc/redis-slave.conf
ADD config/startup.sh /startup.sh

RUN chmod +x /startup.sh

EXPOSE 26379 6379
ENTRYPOINT ["/startup.sh"]
USER 1001
CMD ["redis-server", "/etc/redis.conf"]
