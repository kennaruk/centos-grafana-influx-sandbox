docker build -t centos-sandbox . ;
docker run -d -p 3000:3000 --privileged --name centos-grafana centos-sandbox ;
docker run -d -p 8086:8086 --privileged --name centos-influxdb centos-sandbox ;
docker exec -it os bash