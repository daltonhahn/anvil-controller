#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

for i in {1..5}
do
	docker run --privileged --hostname server$i --network=dev -t -d anvil:rot-scale-quorum 
done

for i in {1..100}
do
	docker run --privileged --hostname client$i --network=dev -t -d anvil:rot-scale-quorum
done
