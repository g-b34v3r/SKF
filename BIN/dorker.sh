#!/bin/bash
#
#
######
DLIST=FILE/dorx.list
TLIST=FILE/templates.list

function MKDLIST {
VENDOR=$(csvtool col 7 .tmp/cfg.list)
PRODUCT=$(csvtool col 8 .tmp/cfg.list)
NAME=$(csvtool col 9 .tmp/cfg.list)
if [ $PRODUCT == TRUE ]
then
    nuclei -silent -nc -td -t $TLIST|grep product|sed s/\ \ \ \ product://g|sed s/\ //g|awk 'length($0) <= 30'|tee -a $DLIST
elif [ $VENDOR == TRUE ]
then
    nuclei -silent -nc -td -t $TLIST|grep vendor|sed s/\ \ \ \ vendor://g|sed s/\ //g|awk 'length($0) <= 30'|tee -a $DLIST
elif [ $NAME == TRUE ]
then
    nuclei -silent -nc -td -t $TLIST|grep -B 2 info:|sed s/info://g|sed s/id:\ //g|sed s/--//g|sed '/^$/d'|tee -a $DLIST
fi
}


yad --geometry 400x600+200+200 --form --separator=',' --borders=50 \
--field="TEMPLATELIST OPTIONS :LBL" \
--field="Severity :CB" \
--field="Type :CBE" \
--field="Directory :DIR" \ "/root/nuclei-templates/" \
--field="Tags :TXT" \
--field="DORKLIST OPTIONS :LBL" \
--field="Vendor:CHK" --field="Product:CHK" --field="Name:CHK" \
"critical\!high\!medium\!low\!info\!unknown" "cve\!rce\!sqli\!lfi\!kev\!unauth\!intrusive\!deserialization\!misconfig" | tee .tmp/cfg.list




SEVERITY=$(csvtool col 2 .tmp/cfg.list)
TYPE=$(csvtool col 3 .tmp/cfg.list)
DIR=$(csvtool col 4 .tmp/cfg.list)
TAGS=$(csvtool col 5 .tmp/cfg.list)


nuclei -nc -silent -tl -severity $SEVERITY -tags $TYPE -t $DIR | tee $TLIST

#if [ -n $TAGS ]
#then
#    nuclei -nc -silent -tl -t templates.list -tags $TAGS | tee  $TLIST
#fi

MKDLIST;cat $DLIST|sort -u|tee $DLIST



