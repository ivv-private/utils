#!/bin/bash

TARGET_DIR=/home/ivv/projects
rm -f ${TARGET_DIR}/TAGS

locate --existing --regex "$TARGET_DIR/.*\.(java|groovy|xhtml|jspx)$" \
| xargs -n1 -P0 etags.emacs -o "${TARGET_DIR}/TAGS" -a

