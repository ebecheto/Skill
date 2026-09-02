#!/bin/bash
# for file in *.eps;do gs2png.sh $file;done
echo '$0 [' $0 '] should changes $1 [' $1 '] into ' $(echo $1 | sed 's/\.e\?ps$/\.png/')

if [ "$2" != "" ]; then reso=$2 ; else reso=600;fi
echo resolution=$reso

if [ "$1" != "" ]; then
    result=$(echo $1 | sed 's/\.e\?ps$/\.png/')
    cat $1|sed 's/1 setlinewidth/5 setlinewidth/;s/lineBlue *exch def/lineBlue 0 def/;s/lineGreen exch def/lineGreen 0 def/;s/lineRed *exch def/lineRed 0 def/' > $result.ps
    gs -I/usr/lib/ -dNOPAUSE -sDEVICE=png16m -dGraphicsAlphaBits=4 -r$reso -sOutputFile=$result.t.png -c "<</Orientation 3>> setpagedevice" -f $result.ps -c quit

convert $result.t.png -trim -matte -transparent 'rgb(255,255,255)' $result
rm $result.t.png
#     rm $result.ps
    echo '[generate] ' $result '[<>]'
else
    echo "please supply 1 argument to convert into png"
    echo "gs2png.sh file.ps # returns file.png with 600 dpi"
    echo "gs2png.sh file.eps # returns file.png with 600 dpi"
    echo "gs2png.sh file.ps 300 # returns file.png with 300 dpi"
fi

# echo '$0 [' $0 ']changes $1 [' $1 '] into ' $(echo $1 | sed 's/\.e\?ps$/\.png/')
# gs -I/usr/lib/ -dNOPAUSE -sDEVICE=png16m -dGraphicsAlphaBits=4 -r600 -sOutputFile=$1.gs.png -c "<</Orientation 3>> setpagedevice" -f $1.sed_bw.ps -c quit
