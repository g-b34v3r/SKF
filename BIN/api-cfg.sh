#!/bin/bash
#

NBKEY=$((1000 + RANDOM % 9000))
key="$NBKEY"
res1=.tmp/1.tmp
res2=.tmp/2.tmp
res3=.tmp/3.tmp
DLIST=FILE/dorx.list
CDLIST=FILE/cdorx.list
function cDLIST {
while IFS= read -r line
do
  echo FALSE|tee -a $CDLIST
  echo $line|tee -a $CDLIST
done < $DLIST
}
function APICFG {
cat .tmp/1.tmp|grep TRUE|sed s/TRUE//g|sed 's/|//g'|tee .tmp/dlist.tmp
cat .tmp/2.tmp|sed 's/|/,/g'|tee .tmp/2.tmp
}

export -f APICFG
cDLIST

#|>========<|<|[ DORX ]|>|>============<|
yad --plug=$key \
--tabnum=1 \
--list --checklist --print-all --editable --column="USE:CHK" --column="DORK :TEXT" \
< $CDLIST \
&> "$res1" &


#|>========<|<|[ CONFIG ]|>|>============<|
yad --plug=$key \
--tabnum=2 --form \
--field="RATE:SCL" 1..99\!10\!10 \
--field="Zoomeye ::CHK" \
--field="LeakIX ::CHK" \
--field="Netlas ::CHK" \
--field="Binary Edge ::CHK" \
&> "$res2" &


#|>========<|<|[  ]|>|>============<|
#yad --plug=$key \
#--tabnum=3 \
#&> "$res3" &


#|>========<|<|[  ]|>|>============<|
yad --notebook --key=$key --height=400 --width=700 --borders=30 --tab="DorksList" --tab="Configuration" 

