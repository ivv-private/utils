#!/bin/bash

goals=$1
shift 1
for i in "$@" 
do
    pushd $i
    mvn $goals || { popd; exit 1; }
    popd
done
exit 0