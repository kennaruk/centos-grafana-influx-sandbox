# install influxdb
cat << EOF | tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
yum install -y influxdb ;
systemctl start influxdb ;

sleep 2s ;
influx -execute "CREATE USER kenadmin WITH PASSWORD 'kenpassword' WITH ALL PRIVILEGES" ;
# create authentication user
# echo "influx fire" ;
# {
# 	RESULT=$(influx -execute "CREATE USER kenadmin WITH PASSWORD 'kenpassword' WITH ALL PRIVILEGES") ;
# } || {

# }
# echo "RESULT=$RESULT" ;
# while [ "$RESULT" != "" ];
# do
# 	RESULT=$(influx -execute "CREATE USER kenadmin WITH PASSWORD 'kenpassword' WITH ALL PRIVILEGES")
# done

# enable authentication
sed -i "s/# auth-enabled = false/auth-enabled = true/" /etc/influxdb/influxdb.conf ;

# start service
systemctl restart influxdb