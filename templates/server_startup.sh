#!/bin/bash

{ /root/anvil-rotation/bin/rotation & } && { sleep 3; /root/anvil/bin/anvil start -s & } && { sleep 15; /root/anvil/bin/anvil join server1; }
/bin/bash
