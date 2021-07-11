#!/bin/bash

{ /root/anvil/bin/anvil start & } && { sleep 20; /root/anvil/bin/anvil join server1; }
/bin/bash
