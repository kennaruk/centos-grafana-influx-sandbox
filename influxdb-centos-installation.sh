#!/bin/bash

debug() {
	if [ "$INFLUX_INSTALLATION_DEBUG" == "*" ] ; then
		echo "==================== DEBUG: $1 ===================="
	fi
}

installDependencies() {
	yum install -y expect
}

setUpInfluxRepository() {
cat << EOF | tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
}

installAndStartInfluxDB() {
	yum install -y influxdb
	systemctl start influxdb
}

createDefaultInfluxAdmin() {
	debug "Password parameter: $1"

	CREATE_ADMIN_QUERY="influx -execute 'CREATE USER $DBuser WITH PASSWORD '$1' WITH ALL PRIVILEGES'"
	debug "$CREATE_ADMIN_QUERY"

	while true ;
	do
		{ # try
			CREATE_ADMIN_RESULT=$($CREATE_ADMIN_QUERY)
			if [ "$CREATE_ADMIN_RESULT" == "" ]; then
				break
			fi
			debug "NOW RESULT: $CREATE_ADMIN_RESULT"
		} || { # catch
			debug "Something err: $CREATE_ADMIN_RESULT"
		}
	done

	# enable authentication
	sed -i "s/# auth-enabled = false/auth-enabled = true/" /etc/influxdb/influxdb.conf

	# restart service
	systemctl restart influxdb
}

getPassword () {
    word=`mkpasswd -l $1 -s 0 2>/dev/nul`
    echo $word
}

setDefaults() {
	INFLUXETCDIR=/etc/influxdb # main conf file
	INFLUXVARDIR=/var/lib/influxdb # data storage

	DBuser="pragma_admin"
	DBpassword=$(getPassword 10)

	createDefaultInfluxAdmin $DBpassword
	
	PASS_FILE=$INFLUXETCDIR/$DBuser.pass
	debug "Write password file at: $PASS_FILE"
}

createPassFile () {
    # create a file with pasword for DB access, save previous if exist
    saveFile $PASS_FILE
    echo $DBPASSWD > $PASS_FILE
    chmod 600 $PASS_FILE 
}

echo "INFLUX_INSTALLATION_DEBUG = $INFLUX_INSTALLATION_DEBUG"

debug "install dependencies"
installDependencies

debug "setup Influx repository"
setUpInfluxRepository

debug "install and start influxdb"
installAndStartInfluxDB

debug "set Defaults (params, user, pass, etc)"
setDefaults