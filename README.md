# Grafana & InfluxDB Installation

`sudo su` before using these scripts

## Grafana installation

```
curl https://raw.githubusercontent.com/kennaruk/centos-grafana-influx-sandbox/master/grafana-centos-setup.sh | bash
```

## InfluxDB installation

```
curl https://raw.githubusercontent.com/kennaruk/centos-grafana-influx-sandbox/master/influxdb-centos-setup.sh | bash
```

# Refractored InfluxDB Installation

```
curl https://raw.githubusercontent.com/kennaruk/centos-grafana-influx-sandbox/master/influxdb-centos-installation.sh | bash
```

or

```
curl https://raw.githubusercontent.com/kennaruk/centos-grafana-influx-sandbox/master/influxdb-centos-installation.sh | INFLUX_INSTALLATION_DEBUG=* bash
```

# Uninstall InfluxDB

```
curl https://raw.githubusercontent.com/kennaruk/centos-grafana-influx-sandbox/master/uninstall-influxdb.sh | bash
```
