FROM zabbix/zabbix-server-mysql:centos-5.0.2

# Debug Proxy config:
RUN env

# Yum install  would not  work as  "zabbix", there is  no sudo  in the
# image. Become root:
USER root

# In  /etc/odbcinst.ini there  are  already two  stubs  for MySQL  and
# Postgres. The ODBC dreivers are missing though. Terefore:
RUN yum install -y mysql-connector-odbc

USER zabbix
