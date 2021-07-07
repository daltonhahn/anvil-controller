#!/bin/bash

{ /root/anvil-rotation/bin/rotation & } && { sleep 3; /root/anvil/bin/anvil start -s & } && { sleep 12; /root/anvil/bin/anvil acl /root/anvil/config/base_acls.yaml; }
/bin/bash
