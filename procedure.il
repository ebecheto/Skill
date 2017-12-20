;; obsolete
procedure(changeInstMovePoint(@optional   (newName "nfet") (flipPin '()) (newLib "cmrf8sf") (inst css()) (cv geGetWindowCellView())  )
let((sA sB  Axy)
;; A=old B=new
Axy=inst~>xy
A=dbOpenCellViewByType(inst~>libName inst~>cellName "symbol")
B=dbOpenCellViewByType(       newLib        newName "symbol")
; #### move nets of pins location modification
sA=sort(A~>terminals~>name nil)
sB=sort(B~>terminals~>name nil)
when(sA==sB flipPin=foreach(mapcar x sA append(flipPin list(x x))))
when(flipPin 
printf("FLIPPING  %L TOFLIP \n" flipPin)
foreach(pAB flipPin
pA=car(pAB) pB=cadr(pAB); ie. pin name "S"

; dbTransformPoint(getTermPoint(css() "S") css()~>transform);<== tjrs pas..,SI Si si mais je me suis trompe de pin :D

;; (0.0625 -1.125)
mvA=dbTransformPoint(getMasterTermPoint(A pA) inst~>transform)
mvB=dbTransformPoint(getMasterTermPoint(B pB) inst~>transform)
netName=getInstNetName(inst pA) ;get net name connected to inst "S" ie. => "net079"
printf("TOMOVE:%L %s %L %L\n" pAB netName mvA mvB)
when(mvA!=mvB
printf("different points: %L %L %L\n" netName mvA mvB)
foreach( net cv~>nets
when(netName||net~>name==netName||net~>name==strcat(netName "!")
printf("catch net: %L \n" netName)
isBetweenPoints(mvB netName cv); change to 'flight lines' a possible crossing net when netNames are differents
foreach( fig net~>figs
mvPoints=foreach(mapcar point fig~>points if(point==mvA then mvB else point)); check wheter point1 or point2 is to move
;and change only if a point match the pin location mA
printf("%L!=?FIG: \n%L \t\t\tA:%L B:%L\n" fig~>points  mvPoints mvA mvB)
when(fig~>points!=mvPoints fig~>points=mvPoints ;if a point had been changed it has to move
printf("\n** changing %L %s form %L to %L\n" fig netName fig~>points mvPoints)
))))))); when flipPin list is not nil
));end let proc

