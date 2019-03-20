FROM centos:7

RUN set -xe; \
    wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm; \
    rpm -Uvh remi-release-7*.rpm; \
    yum install -y redis nc bind-utils; \
    yum clean all;

ADD config/redis-sentinel.conf /etc/redis-sentinel.conf
ADD config/redis.conf /etc/redis.conf
ADD config/redis-slave.conf /etc/redis-slave.conf
ADD config/fix-permissions /usr/local/bin/fix-permissions
ADD config/startup.sh /startup.sh

RUN chmod +x /startup.sh
RUN chmod +x /usr/local/bin/fix-permissions

EXPOSE 26379 6379
ENTRYPOINT ["/startup.sh"]
RUN set -xe ;\
    fix-permissions /var/lib/redis; \
    fix-permissions /etc;
USER 1001
CMD ["redis-server", "/etc/redis.conf"]
