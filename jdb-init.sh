#!/bin/bash

HOME=/home/ivv
BASE_NAME=${HOME}/projects

SEARCH_EXT="java groovy"
SEARCH_EXLUDE_PATH="examples test samples tests tmp"


# construct searching regexp
REGEXP_SEARCH=$(
    echo -n ${BASE_NAME}
    echo -n '.*\.('
    echo -n ${SEARCH_EXT} | sed 's/\ /|/g'
    echo -n ')$'
)

REGEXP_EXCLUDE=$(echo ${SEARCH_EXLUDE_PATH} | sed 's/\ /\\|/g' )
REGEXP_EXCLUDE="\/\(${REGEXP_EXCLUDE}\)\/"

# findup sources
locate -e --regex "${REGEXP_SEARCH}" | grep -v "${REGEXP_EXCLUDE}" \
| xargs -n1 -P0 awk '/^\t*package/ { sub(";",""); num=match(FILENAME, $2); print substr(FILENAME, 1, num - 2); exit}'  \
| sort | uniq | sed '/^$/ d' \
| tee \
    >(awk 'BEGIN {print "use ."} {print $0 }' \
    | tr '\n' ':' > ${HOME}/.jdbrc ) \
    >(awk 'BEGIN {print "(setq gud-jdb-sourcepath (quote ("} END {print ")))"} { print "\"" $0 "\"" } ' \
    | tr '\n' ' '  > ${HOME}/.emacs.d/site-lisp/jdb-directories.el) \
    > /dev/null
