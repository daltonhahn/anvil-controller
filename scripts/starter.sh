#!/bin/bash

read -p "Client nodes: " numClients

cd ..
docker-compose start s1
sleep 5

SList="s2 s3 s4 s5"

for i in $(seq 1 $numClients)
do
	SList+=" c$i"

done

docker-compose start $SList

cd scripts
