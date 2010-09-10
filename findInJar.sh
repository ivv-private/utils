#!/bin/bash


find "${1}"  \( -iname '*jar' -o -iname '*war' \) -type f -printf 'jar -tf %h/%f | xargs -n1 echo %h/%f\0' \
| xargs -0 -n1 -P10 bash --noediting -c \
| grep "${2}" #| sed 's/\ /:/'

exit

BUF_PATH=/tmp
BUF_WAR=$BUF_PATH/war
BUF_COMM=$BUF_PATH/commands

rm -f $BUF_WAR $BUF_COMM
mkfifo $BUF_WAR $BUF_COMM
echo > $BUF_COMM

find "${1}" \( -iname '*ear' -o -iname '*war' -o -iname '*jar' \) -type f > $BUF_WAR &

cat $BUF_WAR | while read file
do
 ext=${file##*.}
 case $ext in 
     jar) 
         printf "jar -tf %s\0" "$file">> $BUF_COMM &
         ;;

     war) 
         cmd="unzip -p ${file} %s | jar -t | awk '{print \"${file}:%s:\" \$0}'\0"
         jar -tf $file | grep '.jar' | sed 'p' | xargs -n2 printf "${cmd}" >> $BUF_COMM &
         ;;

     # ear) 
     #     cmd="unzip -p ${file} %s | jar -t | awk '{print \"${file}:%s:\" \$0}'\0"
     #     jar -tf $file | grep '.*jar\|.*war' | sed 'p' | xargs -n2 printf "${cmd}" >> $BUF_COMM &;;
 esac
done

# cat $BUF_COMM 
cat $BUF_COMM | xargs -0 -n1 -P0 bash --noediting -c
rm $BUF_WAR $BUF_COMM

exit


# for i in $(find "${1}" -iname '*jar' | xargs -n1 jar -tf ); do
# #   echo $i | grep "${2}" > /dev/null && echo $i
# echo $i
# done
