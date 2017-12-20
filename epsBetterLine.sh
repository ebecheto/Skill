#!/bin/bash
# for file in *.eps;do epsBetterLine.sh $file;done
# gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=TOP.pdf *.ps

echo '$0 [' $0 '] should changes $1 [' $1 '] into ' $(echo $1 | sed 's/\.e\?ps$/\.png/')

if [ "$2" != "" ]; then reso=$2 ; else reso=600;fi
echo resolution=$reso

if [ "$1" != "" ]; then
    cat $1|sed 's/1 setlinewidth/5 setlinewidth/;s/lineBlue *exch def/lineBlue 0 def/;s/lineGreen exch def/lineGreen 0 def/;s/lineRed *exch def/lineRed 0 def/' > _${1%.*}.ps 2>/dev/null
    gs -dBATCH -dNOPAUSE -sDEVICE=ps2write -dPDFFitPage -sOutputFile=${1%.*}.ps  -c "/Courier findfont 12 scalefont setfont 50 765 moveto (${1%.*}) show" -f _${1%.*}.ps 2>/dev/null
     rm _${1%.*}.ps
    echo '[generate] ' ${1%.*}.ps '[<>]'
else
    echo "please supply 1 argument to convert into png"
    echo "gs2png.sh file.ps # returns file.png with 600 dpi"
    echo "gs2png.sh file.eps # returns file.png with 600 dpi"
    echo "gs2png.sh file.ps 300 # returns file.png with 300 dpi"
fi

# echo '$0 [' $0 ']changes $1 [' $1 '] into ' $(echo $1 | sed 's/\.e\?ps$/\.png/')
# gs -I/usr/lib/ -dNOPAUSE -sDEVICE=png16m -dGraphicsAlphaBits=4 -r600 -sOutputFile=$1.gs.png -c "<</Orientation 3>> setpagedevice" -f $1.sed_bw.ps -c quit
# gs -dBATCH -dNOPAUSE -dPDFFitPage -sDEVICE=pdfwrite  -sOutputFile=addedText.pdf  -c "/Courier (/home/validmgr/ebecheto/ProgFile/FONT/msttcorefonts/Courier_New.ttf) findfont 12 scalefont setfont 50 765 moveto (header text) show" -f xtract@xtract_v2,switch_CMOS_large,schematic.ps

# /TimesNewRomanPSMT (/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman.ttf)
# ($HOME/ProgFile/FONT/msttcorefonts/Courier_New.ttf)
# (/home/validmgr/ebecheto/ProgFile/FONT/msttcorefonts/Courier_New.ttf)

# gs -dBATCH -dNOPAUSE -dPDFFitPage -sDEVICE=pdfwrite  -sOutputFile=addedText.pdf  -c "/Courier findfont 12 scalefont setfont 50 765 moveto (header text) show" -f xtract@xtract_v2,switch_CMOS_large,schematic.ps

# function helloWolrd(){
# echo "prompt> " $1
# }

# oneline function definition
# function helloWolrd(){ echo "prompt> " $1; }
#  two space _  a ;      _                  ;_ 
