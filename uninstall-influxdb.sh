#!/bin/bash

systemctl remove influxdb
yum remove -y influxdb
rm -rf /etc/influxdb /var/lib/influxdb