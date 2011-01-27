#!/bin/bash
## settings

proj_home=~/projects/core-process
jb_home=~/opt/jboss-5.1.0.GA/server/liferay


# jb_home=$JBOSS_HOME/server/default/tmp
# jb_home=~/opt/GateIn-3.0.0-GA/server/default/tmp

proj_home=${proj_home}/web/src/main/webapp
jb_home=${jb_home}/tmp

##
echo $jb_home
jb_views=$(find ${jb_home}  -name "web-*\.war" -type d)
echo Making links '(*.xhtml)' from project directory to JBoss temporary deploing directory.

[[ -d "$jb_views" ]] || exit
[[ -d "$proj_home" ]] || exit

echo 'JBoss directory  :' ${jb_views}
echo 'Project directory:' ${proj_home}

pushd ${proj_home} > /dev/null
find . -path '*.svn' -prune -o -type f \( -name '*.css' -o -iname '*.xhtml' -o -iname '*.js' \) -printf "${PWD}/%p\\000${jb_views}/%p\\000" | sed 's/\.\///g'| xargs -0 -n2 -P4 ln -f
popd > /dev/null