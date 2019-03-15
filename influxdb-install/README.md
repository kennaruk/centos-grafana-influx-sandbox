### RUN THESE SCRIPTS WITH SU PERMISSION

Installation script

```#!/bin/bash
curl -O https://raw.githubusercontent.com/kennaruk/centos-grafana-influx-sandbox/master/influxdb-install/influxdb-install.sh
```

How to use

```#!/bin/bash
chmod +x ./influxdb-install.sh
./influxdb-install.sh
```

With custom configuration

```#!/bin/bash
curl -O https://raw.githubusercontent.com/kennaruk/centos-grafana-influx-sandbox/master/influxdb-install/influxdb.config.example
```

How to use

```#!/bin/bash
./influxdb-install.sh influxdb.config.example
```

### With no cache (for test)

```#!/bin/bash
curl -O https://raw.githubusercontent.com/kennaruk/centos-grafana-influx-sandbox/master/influxdb-install/influxdb-install.sh?$(date +%s)
chmod +x ./influxdb-install.sh
./influxdb-install.sh

```
