#!/bin/bash

HOME=/home/ivv
BASE_NAME=${HOME}/projects

SOURCE_DIRS=$(mktemp)

# findup sources
locate -e "${BASE_NAME}*\.java" \
| grep -v '\/\(examples\|test\|samples\|tests\)\/' \
| xargs -n1 -P0 awk '/^\t*package/ { sub(";",""); num=match(FILENAME, $2); print substr(FILENAME, 1, num - 2); exit}'  \
| sort | uniq | sed '/^$/ d' > ${SOURCE_DIRS}

# setup jdb
sed -i '/use/ d' $HOME/.jdbrc

{ 
    echo -n 'use '
    cat ${SOURCE_DIRS} | tr '\n' ':'
    echo ''
} >>  $HOME/.jdbrc


# setup emacs jdb
{ 
    echo "'(gud-jdb-directories (quote ("
    sed 's/.*/"\0"/' ${SOURCE_DIRS}
    echo ')))'
} > $HOME/.emacs.d/gud-jdb-directories.el
