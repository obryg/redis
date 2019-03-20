FROM centos:7

RUN set -xe; \
    yum install -y epel-release; \
     yum install -y wget nc bind-utils; \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    yum install -y --enablerepo=remi install redis; \   
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
