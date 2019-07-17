# Starting from base CentOS image
FROM centos:7

# Enabling SystemD
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

# webserver service
RUN rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum install -y nginx
RUN systemctl enable nginx.service


# Mysql repo & installion
#RUN yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm && \
#yum install -y mysql mysql-server

RUN chkconfig --level 345 nginx on
RUN systemctl enable  nginx


#VOLUME [ "/var/lib/mysql" ]

# Port Expose
EXPOSE 80
CMD ["/usr/sbin/init"]