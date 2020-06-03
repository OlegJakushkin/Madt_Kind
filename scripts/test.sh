#!/usr/bin/env bash
cd /usr/local/bin/istio-1.6.0
echo "Start docker..."
/etc/init.d/docker start
sleep 1
echo "Pull kindest/node:v1.18.2 image" 
docker pull kindest/node:v1.18.2