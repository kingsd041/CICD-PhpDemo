#!/bin/sh
cd ${WORKSPACE}/src
docker build -t ksd.neunn.com/python-redis-demo:v${BUILD_NUMBER} .
docker push ksd.neunn.com/python-redis-demo:v${BUILD_NUMBER}

cd ${WORKSPACE}/test-build
sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
rancher-compose --url http://103.39.107.62:8080 --access-key BCCA0297BADDA26DFC2E --secret-key H2P5p1cdtpNU1Ntj5p6WEYQvbW2febgMv9rQKSp1 -p python-redis-demo-build${BUILD_NUMBER} up -d
