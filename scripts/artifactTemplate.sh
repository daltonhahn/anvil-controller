#!/bin/bash

# nodeName
# svc
# tokName
# validList

echo -n > map.txt

echo -e "{" >> map.txt
echo -e "  \"quorum\": [" >> map.txt
for i in {1..5}
do
	echo -e "    \"server${i}\"," >> map.txt
done
echo -e "  ]," >> map.txt
echo -e "  \"nodes\": [" >> map.txt

for i in {1..100}
do
	echo -e "    \"client${i}\"," >> map.txt
done
echo -e "  ]," >> map.txt
echo -e "  \"svcmap\": [" >> map.txt

for i in {1..5}
do
	echo -e "    {" >> map.txt
	echo -e "      \"TokName\": \"s${i}r\"," >> map.txt
	echo -e "      \"Node\": \"server${i}\"," >> map.txt
	echo -e "      \"Svc\": \"rotation\"," >> map.txt
	echo -e "      \"Valid\": [\n        \"rotation\"\n      ]" >> map.txt
	echo -e "    }," >> map.txt
done

for i in {1..100}
do
	echo -e "    {" >> map.txt
	echo -e "      \"TokName\": \"c${i}r\"," >> map.txt
	echo -e "      \"Node\": \"client${i}\"," >> map.txt
	echo -e "      \"Svc\": \"rotation\"," >> map.txt
	echo -e "      \"Valid\": [\n        \"rotation\"\n      ]" >> map.txt
	echo -e "    }," >> map.txt
done
echo -e "  ]," >> map.txt

echo -e "  \"gossip\":true," >> map.txt
echo -e "  \"iteration\": 0," >> map.txt
echo -e "  \"prefix\": \"server1\"" >> map.txt
echo -e "}" >> map.txt
