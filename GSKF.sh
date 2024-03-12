#!/bin/bash
#
#
#
#
#


DORKER() {
BIN/dorker.sh
}
SEARCHER() {
BIN/api-cfg.sh
BIN/search.sh FILE/dorx.list
}
export -f DORKER SEARCHER



yad --form --align=right \
--field="Dorker:FBTN" 'bash -c DORKER' \
--field="Searcher:FBTN" 'bash -c SEARCHER' \
--plug=$$ --tabnum=1| \


yad --form --plug=$$ --tabnum=2 \
--field="TOOLS ::LBL" &

yad --paned --key=$$ --orient=vert --title="SCRIPT KID FRAMEWORK" --geometry=700x500 --image="ETC/x-icon.png" --image-on-top --borders=50
