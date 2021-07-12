#!/bin/bash

docker stop $(docker ps -a -q) > /dev/null 2>&1
docker rm $(docker ps -a -q) > /dev/null 2>&1


read -p "Client nodes: " numClients

GKEY=`cat ../art0/gossip.key`

for i in $(seq 1 5)
do
	cp -f ../templates/test_config.tmp ../configs/server${i}_test_config.yaml
	cp -f ../templates/Dockerfile.tmp.quorum ../Dockerfile_server${i}

	TVAL=`cat ../art0/server${i}/acl.yaml`

	sed -i '' "s|{GKEY}|${GKEY}|g" ../configs/server${i}_test_config.yaml 
	sed -i '' "s|{NAME}|server${i}|g" ../configs/server${i}_test_config.yaml
	sed -i '' "s|{NAME}|server${i}|g" ../Dockerfile_server${i}
	echo "$TVAL" >> ../configs/server${i}_test_config.yaml

	# IF ABOVE COMMANDS FAIL, USE THESE FOR LINUX
	#sed -i "s|{GKEY}|${GKEY}|g" ../configs/server${i}_test_config.yaml 
	#sed -i "s|{NAME}|server${i}|g" ../configs/server${i}_test_config.yaml
	#sed -i "s|{NAME}|server${i}|g" ../Dockerfile_server${i}
	#echo "$TVAL" >> ../configs/server${i}_test_config.yaml

	if [ $i -eq 1 ]; then
		sed -i '' "s|{STARTUP}|leader_startup.sh|g" ../Dockerfile_server${i}
		#sed -i "s|{STARTUP}|leader_startup.sh|g" ../Dockerfile_server${i}

		cd ..
		#docker run --privileged --name server${i} --hostname server${i} -it -d --network=dev $(docker build -f Dockerfile_server${i} -q .)
		cd scripts
		sleep 2
	else
		sed -i '' "s|{STARTUP}|server_startup.sh|g" ../Dockerfile_server${i}
		#sed -i "s|{STARTUP}|server_startup.sh|g" ../Dockerfile_server${i}

		cd ..
		#docker run --privileged --name server${i} --hostname server${i} -it -d --network=dev $(docker build -f Dockerfile_server${i} -q .) &
		cd scripts
	fi
done

for i in $(seq 1 $numClients)
do
	cp -f ../templates/test_config.tmp ../configs/client${i}_test_config.yaml
	cp -f ../templates/Dockerfile.tmp.client ../Dockerfile_client${i}

	TVAL=`cat ../art0/client${i}/acl.yaml`

	sed -i '' "s|{GKEY}|${GKEY}|g" ../configs/client${i}_test_config.yaml 
	sed -i '' "s|{NAME}|client${i}|g" ../configs/client${i}_test_config.yaml
	sed -i '' "s|{NAME}|client${i}|g" ../Dockerfile_client${i}
	echo "$TVAL" >> ../configs/client${i}_test_config.yaml

	# IF ABOVE COMMANDS FAIL, USE THESE FOR LINUX
	#sed -i "s|{GKEY}|${GKEY}|g" ../configs/client${i}_test_config.yaml 
	#sed -i "s|{NAME}|client${i}|g" ../configs/client${i}_test_config.yaml
	#sed -i "s|{NAME}|client${i}|g" ../Dockerfile_client${i}
	#echo "$TVAL" >> ../configs/client${i}_test_config.yaml

	sed -i '' "s|{STARTUP}|client_startup.sh|g" ../Dockerfile_client${i}
	#sed -i "s|{STARTUP}|client_startup.sh|g" ../Dockerfile_client${i}

	cd ..
	#docker run --privileged --name client${i} --hostname client${i} -it -d --network=dev $(docker build -f Dockerfile_client${i} -q .) &
	cd scripts
done
