#!/bin/bash
#

XX='clear'
ZZ='sleep 2'
QTY=$(csvtool col 1 .tmp/2.tmp)
LEAKIX=$(csvtool col 3 .tmp/2.tmp)
NETLAS=$(csvtool col 4 .tmp/2.tmp)
EDGE=$(csvtool col 5 .tmp/2.tmp)
ZOOMEYE=$(csvtool col 2 .tmp/2.tmp)
HLIST=FILE/hosts.list

function ZOOM {
API='ZOOMEYE'
zoomeye search -type web -save=site,ip -num $QTY $DORK
cat *.json|sed s/\'\/\"/g|jq .|sed s/\"//g|grep ip:|sed s/ip:\ \//g|sed s/,//g|sed s/\ \//g|httprobe|tee -a $HLIST
cat *.json|sed s/\'\/\"/g|jq .|sed s/\"//g|grep site:|sed s/\ site\:\ \//g|sed s/,//g|httprobe|tee -a $HLIST
rm -rf *.json
}




cat .tmp/1.tmp|grep TRUE|sed s/TRUE//g|sed 's/|//g'|tee .tmp/dlist.tmp
cat .tmp/2.tmp|sed 's/|/,/g'|tee .tmp/2.tmp

while IFS= read -r DORK
do
  ZOOM
done < $1
