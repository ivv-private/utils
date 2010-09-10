#!/bin/sh

HOME=/home/ivv
BASE_NAME=${HOME}/projects

sed -i '/use/ d' $HOME/.jdbrc

# SRC=$(locate -e "${BASE_NAME}*\.java" \
# | xargs -n1 -P0 awk '/^\t*package/ { sub(";",""); num=match(FILENAME, $2); print substr(FILENAME, 1, num - 2); exit}'  \
# | sort | uniq | tr '\n' ':' ) 

# mkfifo $TMP_FIFO
# locate -b '*\.java' | sed 's/\/[^\/]*\java$/\*/' | uniq > $TMP_FIFO &

# for i in $( locate "${BASE_NAME}*\.java" | sed 's/\/[^\/]*\java$/\*/' | uniq )
# do 
#  fn=$(find $i -iname '*\.java' | tail -n1)
#  awk '/^\t*package/ { sub(";",""); num=match(FILENAME, $2); print substr(FILENAME, 1, num - 2); exit}' $fn
# done

# rm $TMP_FIFO

# find -iname '*\.java' /home/ivv/projects/shark-persist/src/org/comsoft/sharkimpl/repository/model 

SRC=$(locate -e "${BASE_NAME}*\.java" \
| xargs -n1 -P0 awk '/^\t*package/ { sub(";",""); num=match(FILENAME, $2); print substr(FILENAME, 1, num - 2); exit}'  \
| sort | uniq | tr '\n' ':' ) 
echo use $SRC >> $HOME/.jdbrc