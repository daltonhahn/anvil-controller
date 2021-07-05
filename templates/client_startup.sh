#!/bin/bash

{ /root/anvil/bin/anvil start & } && { sleep 15; /root/anvil/bin/anvil join server1; }
/bin/bash
