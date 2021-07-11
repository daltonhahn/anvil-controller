#!/bin/bash

echo -n > manifest.tmp

echo -e "---" >> manifest.tmp
echo -e "quorum:" >> manifest.tmp

for i in {1..5}
do
	echo -e "  - server${i}" >> manifest.tmp
done

echo -e "nodes:" >> manifest.tmp

for i in {1..10}
do
	echo -e "  - client${i}" >> manifest.tmp
done

echo -e "svcmap:" >> manifest.tmp

for i in {1..5}
do
	echo -e "  -" >> manifest.tmp
	echo -e "    node: server${i}" >> manifest.tmp
	echo -e "    svc: rotation" >> manifest.tmp
	echo -e "    tokname: s${i}r" >> manifest.tmp
	echo -e "    valid:" >> manifest.tmp
	echo -e "      - rotation" >> manifest.tmp
done

for i in {1..10}
do
	echo -e "  -" >> manifest.tmp
	echo -e "    node: client${i}" >> manifest.tmp
	echo -e "    svc: rotation" >> manifest.tmp
	echo -e "    tokname: c${i}r" >> manifest.tmp
	echo -e "    valid:" >> manifest.tmp
	echo -e "      - rotation" >> manifest.tmp
done
