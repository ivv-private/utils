#!/bin/bash

TARGET_DIR=/home/ivv/projects
rm ${TARGET_DIR}/TAGS; locate  --existing "${TARGET_DIR}*\.java" "${TARGET_DIR}*\.xhtml" | xargs -n1 -P0 etags -o "${TARGET_DIR}/TAGS" -a

# # old
# locate '/home/ivv/projects/*prj.el' | sed 's/prj.el/TAGS/' | xargs rm -fr

# for i in $(locate '/home/ivv/projects/*prj.el' | xargs -n1 dirname)
# do
#     find $i \( \( -path \*/.svn -o -path \*/target \) -prune -o -type f \) \
#         -a \( -name '*.java' -o -name '*.xhtml' \) \
#         -exec etags -o /TAGS -a {} \; 
# done
