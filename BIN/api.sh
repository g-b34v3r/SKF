function ZOOM {
API='ZOOMEYE'
zoomeye search -type web -save=site,ip -num $QTY $DORK
cat *.json|sed s/\'\/\"/g|jq .|sed s/\"//g|grep ip:|sed s/ip:\ \//g|sed s/,//g|sed s/\ \//g|httprobe|tee -a $TLIST $ZDB
cat *.json|sed s/\'\/\"/g|jq .|sed s/\"//g|grep site:|sed s/\ site\:\ \//g|sed s/,//g|httprobe|tee -a $TLIST
mv *.json .TMP/
}

function NETLAS {
API='NETLAS'
netlas search -f json -p 2 $DORK|tee -a netlas.json
cat netlas.json|jq '.items[].data.domain'|sed s/\"\//g|sed s/\ \//g|sed s/,//g|sed s/]//g|sed "s/\[//g"|sed '/^$/d'|httprobe|tee -a $TLIST $NDB
mv netlas.json .TMP/$DORK.json
}

function EDGE {
API='BINARY-EDGE'
binaryedge search -p $QTY $DORK|tee edge.json;$ZZ
cat edge.json|jq .|sed s/\"//g|grep ip:|sed s/\ip://g|sed s/,//g|sed s/\ \//g|httprobe|tee -a $TLIST $EDB
rm -rf edge.json
}

function LEAK {
API='LEAK-IX'
curl -H 'api-key: ZtYPiRNSoxEe3GdXMqXZwTyv6EZNsflrTO35LpvZpwNeWzwz' -H 'accept: application/json' "https://leakix.net/search?scope=service&page=3&q=$DORK"|tee leak.json;$XX
cat leak.json|jq .|sed s/\"//g|grep ip:|sed s/\ip://g|sed s/geo\ {//g|sed s/,//g|sed s/\ \//g|httprobe|tee -a $TLIST $LDB
rm -rf leak.json
}
