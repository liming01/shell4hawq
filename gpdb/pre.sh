#!/bin/bash

sed -i ''  '15,23 s/^/#/' ~/workspace/install/gpdb/bin/lib/gp_bash_functions.sh
sed -i ''  '28,36 s/^/#/' ~/workspace/install/gpdb4/bin/lib/gp_bash_functions.sh
