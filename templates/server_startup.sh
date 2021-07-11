#!/bin/bash

{ /root/anvil-rotation/bin/rotation & } && { sleep 3; /root/anvil/bin/anvil start -s & } && { sleep 20; /root/anvil/bin/anvil join server1; }
/bin/bash
