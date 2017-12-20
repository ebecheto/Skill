
flip='(("INV0" "INVERT_A")("INV1" "INVERT_B")("INV2" "INVERT_C")("INV3" "INVERT_D")("INV4" "INVERT_E")("INV6" "INVERT_F")("INV8" "INVERT_H")("INV10" "INVERT_I")("INV12" "INVERT_J")("INV15" "INVERT_K"))
flip=append(flip '(("NOR20" "NOR2_A")("NOR21" "NOR2_B")("NOR22" "NOR2_C")("NOR23" "NOR2_D")("NOR24" "NOR2_E")("NOR26" "NOR2_F")("NOR28" "NOR2_H")) )
flip=append(flip '(("BUF2" "BUFFER_C")("BUF4" "BUFFER_D")("BUF6" "BUFFER_E")("BUF8" "BUFFER_F")("BUF12" "BUFFER_H")("BUF15" "BUFFER_I")) )
flip=append(flip '(("NAND20" "NAND2_A")("NAND21" "NAND2_B")("NAND22" "NAND2_C")("NAND23" "NAND2_D")("NAND24" "NAND2_E")("NAND26" "NAND2_F")("NAND28" "NAND2_H")) )
flip=append(flip '(("DF1" "DFFR_E") ))

; DIGITAL construct list
dftNewLib="cmos8rf" concFlip='()
foreach(fp flip 
when(length(fp)==1 fp=append(fp list(fp)))
when(length(fp)==2 fp=append(fp list(dftNewLib)))
concFlip=tconc(concFlip fp)
) flip=car(concFlip);=> ("INV0" "INVERT_A" "cmos8rf") ("INV1" "INVERT_B" "cmos8rf")

; PRIMLIB => new Lib construc
flip=append(flip '("subc"  ("rpolyhc" "oprppres")("rpolyh" "oprppres")("rpoly2c" "oprppres")("rpoly2" "oprppres")))
flip=append(flip '(("cpoly" "mimcap" "cmrf8sf" (("flipPin" (("PLUS" "D")("MINUS" "S")))))))
flip=append(flip '(("nmos4" "nfet" "cmrf8sf"   (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf")))))))
flip=append(flip '(("pmos4" "pfet" "cmrf8sf"   (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf")))))))
dftNewLib="cmrf8sf" concFlip='()
foreach(fp flip 
when(!listp(fp) fp=list(fp))
when(length(fp)==1 fp=append(fp fp))
when(length(fp)==2 fp=append(fp list(dftNewLib)))
when(length(fp)>4 printf("For now AST of 4 max not %d %L\n" length(fp) fp))
concFlip=tconc(concFlip fp)
) flip=car(concFlip)

;; append options for pins correspondences ie. 'rpolyhc' terminals are : MINUS, PLUS REF, where 'oprppres' terminals are S, D and G.
flip=foreach(mapcar fp flip 
if(cadr(fp)=="oprppres"&&length(fp)==3 then fp=append(fp '((("flipPin" (("MINUS" "S")("PLUS" "D")("REF" "G")))))) else fp))

;; for DIGITAL cells, PRIMLIB output is named Q but cmos8rf output is named Z
flip=foreach(mapcar fp flip 
if(caddr(fp)=="cmos8rf"&&length(fp)>=3 then fp=append(fp '((("flipPin" (("Q" "Z")))))) else fp))

;; ; note that oprppres will also be vertically mirrored, but is does not cause any PB
;; ; If we want to adapt the difference in two different symbol from 2 dif. techno, ONE adjustement is possible
;; ; Please determine on your own what is the 'optimum' adjustment
;; AA=dbOpenCellViewByType("PRIMLIB" "rpolyhc" "symbol")
;; BB=dbOpenCellViewByType("cmrf8sf" "oprppres" "symbol")
;; adjust=rodSubPoints(getMasterTermPoint(AA "PLUS") getMasterTermPoint(BB "S"))
;; ;==> (0.0 0.1875)

;; AA=dbOpenCellViewByType("PRIMLIB" "nmos4" "symbol")
;; BB=dbOpenCellViewByType("cmrf8sf" "nfet" "symbol")
;; adjust=mapcar('minus rodSubPoints(getMasterTermPoint(AA "B") getMasterTermPoint(BB "B"))) 
;; ;==> (0.0625 0.0)


flip=foreach(mapcar fp flip 
if(and(or(car(fp)=="nmos4" car(fp)=="pmos4") length(fp)>=3) then 
list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0625 0.0) ))))
else fp))

flip=foreach(mapcar fp flip 
if(cadr(fp)=="oprppres"&&length(fp)>=3 then 
list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0 0.1875) ))))
else fp))


;; append(cadddr(f2) '(("adjust" '(0.0625 0.0) ))); => (  ("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))   ("adjust" '(0.0625 0.0))  )


;; f1='("pmos4" "pfet" "cmrf8sf")
;; f2='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) )
;; fp='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) (("adjust" '(0.0625 0.0))))
;; f4='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) (("adjust" '(0.0625 0.0))))



;######## used procedured definition #################################" 
procedure(getTermPoint(@optional (inst css()) (NAME "PLUS") )
let((point) foreach( conn inst~>instTerms when(NAME==conn~>term~>name
point=centerBox(caar(conn~>term~>pins~>figs)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
)) point ));let proc

procedure(getTermFig(@optional (inst css()) (NAME "PLUS") )
let((fig) foreach( conn inst~>instTerms when(NAME==conn~>term~>name
fig=caar(conn~>term~>pins~>figs);<= OK car une seul pin "PLUS" dans le symbol(figs)
)) fig ));let proc

procedure(getInstNetName(@optional (inst css()) (NAME "S") )
let((netName) foreach( conn inst~>instTerms when(NAME==conn~>term~>name
netName=conn~>net~>name;<= OK car une seul pin "PLUS" dans le symbol(figs)
)) netName ));let proc



; isBetweenPoints('(5.4375 -0.84375) "net079")
; isBetweenPoints('(5.4375 -0.84375) "")

procedure(isBetweenPoints(@optional  (pt '(5.875 -0.78125)) (netName "") (cv geGetWindowCellView()) )
let((between pt1 pt2 xmax xmin ymax ymin)
foreach( net cv~>nets
foreach( fig net~>figs
when(fig
pt1=car(fig~>points)
pt2=cadr(fig~>points)
;;printf("Colinear points? %L :  %L off %s\n" pt fig~>points net~>name) 
when(pcColinearPoints(pt1 pt2 pt) 
xmax=max(car(pt1)  car(pt2))
ymax=max(cadr(pt1) cadr(pt2))
xmin=min(car(pt1)  car(pt2))
ymin=min(cadr(pt1) cadr(pt2))
between=and(not( car(pt)<xmin|| car(pt)>xmax)
	    not(cadr(pt)<ymin||cadr(pt)>ymax))
if(between&&net~>name!=netName then 
fig~>lpp='("wire" "flight") 
printf("Point %L Between  %L of %s\n" pt fig~>points net~>name) 
else
nil ;printf("Point %L not Between  %L off %s\n" pt fig~>points net~>name) 
);if
))))
))

;; pcColinearPoints('(4.75 -0.78125) '(5.875 -0.78125) '(5.875 -0.78125))
;; changeInstMovePoint("mimcap" '(("PLUS" "D")("MINUS" "S")))
;; changeInstMovePoint("pfet")
procedure(getMasterTermPoint(@optional (master css()) (NAME "PLUS") )
let((point) 
when(master~>objType=="inst" master=css()~>master)
foreach( conn master~>terminals when(NAME==conn~>name
point=centerBox(caar(conn~>pins~>figs)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
)) point ));let proc

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

