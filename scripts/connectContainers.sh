#!/bin/bash

read -p "Number of clients: " numClients

for i in $(seq 1 5)
do
	if [ $i -eq 1 ]; then
		docker container exec -it -d server${i} /bin/bash -c 'echo A && echo B'
		#docker container exec -it -d server${i} /bin/bash -c '{ /root/anvil/bin/anvil start -s & } && { sleep 8; /root/anvil/bin/anvil acl /root/anvil/config/base_acls.yaml; }'
	else
		docker container exec -it -d server${i} /bin/bash -c 'echo C && echo D'
		#docker container exec -it -d server${i} /bin/bash -c '{ /root/anvil/bin/anvil start -s & } && { sleep 8; /root/anvil/bin/anvil join server1; }'
	fi
done

for i in $(seq 1 $numClients)
do
	docker container exec -it -d client${i} /bin/bash -c 'echo E && echo F'
	#docker container exec -it -d client${i} /bin/bash -c '{ /root/anvil/bin/anvil start & } && { sleep 10; /root/anvil/bin/anvil join server1; }'
done


sleep 15
docker container attach server1 
