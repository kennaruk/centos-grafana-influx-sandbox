debug() {
	if [ "$DEBUG" == "*" ] ; then
		echo $1
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
	echo "Password parameter: $1"

	# TODO: Dynamic password here
	CREATE_ADMIN_QUERY="influx -execute \"CREATE USER kenadmin WITH PASSWORD 'kenpassword' WITH ALL PRIVILEGES\""
	while true ;
	do
		{ # try
			CREATE_ADMIN_RESULT=$(CREATE_ADMIN_QUERY)
			if [ $CREATE_ADMIN_RESULT = "" ]; then
				break
			fi
		} || { # catch
			echo "Something err: $CREATE_ADMIN_RESULT"
		}
	done
}

getPassword () {
    word=`mkpasswd -l $1 -s 0 2>/dev/nul`
    echo $word
}

setDefaults() {
	ETCDIR=/etc/influxdb # main conf file
	VARDIR=/var/lib/influxdb # data storage

	DBuser="pragma_admin"
	DBpassword=$(getPassword 10)

	createDefaultInfluxAdmin $DBpassword
	
	PASS_FILE=$ETCDIR/$DBuser.pass

	influx -execute "CREATE USER kenadmin WITH PASSWORD 'kenpassword' WITH ALL PRIVILEGES" 
}

createPassFile () {
    # create a file with pasword for DB access, save previous if exist
    saveFile $pass1
    echo $DBPASSWD > $pass1
    chmod 600 $pass1 
}

debug "install dependencies"
installDependencies

debug "setup Influx repository"
setUpInfluxRepository

debug "install and start influxdb"
installAndStartInfluxDB