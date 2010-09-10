#!/bin/bash

[[ -f "./run.sh" ]] || { echo no run.sh; exit 1; }

SERVER=${1:-default}

rm -fr ../server/$SERVER/{work,log,tmp}
./run.sh -c $SERVER

