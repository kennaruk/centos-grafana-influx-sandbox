yum -y install https://dl.grafana.com/oss/release/grafana-5.4.2-1.x86_64.rpm ;

echo -e "$(cat /etc/sysconfig/grafana-server)\n\
GF_AUTH_ANONYMOUS_ENABLED=true\n\
GF_SECURITY_ADMIN_USER="admin"\n\
GF_SECURITY_ADMIN_PASSWORD="pass"\
" > /etc/sysconfig/grafana-server;

service grafana-server start

