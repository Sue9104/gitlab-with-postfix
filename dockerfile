FROM ubuntu:16.04
ARG DEBIAN_FRONTEND=noninteractive
COPY service /etc/service
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && apt update && \
  echo "postfix postfix/mailname string sgi.registry.ace.com" | debconf-set-selections && \
  echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections && \
  apt-get install -y postfix mailutils rsyslog runit
COPY conf/postfix.main.cf /etc/postfix/main.cf
COPY conf/rsyslog.conf /etc/rsyslog.conf
COPY conf/50-default.conf /etc/rsyslog.d/50-default.conf
ENTRYPOINT runsvdir -P /etc/service
#CMD /etc/init.d/postfix start 
