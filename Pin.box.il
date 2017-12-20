/**************************************************
* Authors : Edouard BECETHOILLE               	  *
*			IPNL (IN2P3-CNRS / UCBL ) *
* Version : 0.5   March 2009                      *
* History :                                       *
***************************************************/

;  load("~/Skill/Pin.box.il")

procedure(createSch( l_pins @optional (library getEditRep()~>libName ) (cell getEditRep()~>cellName)  (padCap "PAD_capa") (padLib "PAD_cell_S35D4")  )
let((IO nPad nSide mn tmp tmpList B R T L hstep lstep cstep xst yst edge Xstep Ystep Xq Yq Xlabel Ylabel Xlq Ylq Xcq Ycq X0 Y0 X1 Y1 W dbLib)
(setq nPad length(l_pins) )
(setq IO "PAD_IO")
;unless( ddGetObj(library) error("Couldn't open library %L. Please open any new layout.\n" library)  )
dbLib = ddGetObj(library)
printf("Generate Sch&Sym %d-pin in %L %L %L \n" length(l_pins) library cell list(dbLib))
nSide=nPad/4
hstep = 0.125 xst = 0.125
lstep = 0.375 yst = 0.125
mn=0 
Xcstep = 0.3125 
Ycstep = 0.375
edge=1
rotate = 0 X=0 Y=0 rot="R0"
;cv=getEditRep()~>cellView
;library=getEditRep()~>libName
;cell=getEditRep()~>cellName

tmpList = foreach( mapcar x l_pins if(!listp(x) then append(list(x) list(IO)) else x)) ;; pour les elements seul, "in", rajoute ("in" "PAD_IO") (normalement déjà fais ds pad_frame.il
l_pins = tmpList
tmp=nil B=nil R=nil T=nil L=nil ;  coupe la liste en quatre suivant : Bottom Right Top Left
for(i 1 nPad tmp=tconc(tmp car(tmpList)) tmpList=cdr(tmpList)) B=car(tmp) tmp=nil
for(i 1 nPad tmp=tconc(tmp car(tmpList)) tmpList=cdr(tmpList)) R=car(tmp) tmp=nil
for(i 1 nPad tmp=tconc(tmp car(tmpList)) tmpList=cdr(tmpList)) T=car(tmp) tmp=nil
for(i 1 nPad tmp=tconc(tmp car(tmpList)) tmpList=cdr(tmpList)) L=car(tmp) tmp=nil
T=reverse(T) L=reverse(L)

cvSch = dbOpenCellViewByType( library cell "schematic" "schematic" "w")
;printf("%L %L %L \n" library cell list(cvSch))
corSym = dbOpenCellViewByType( library cell "symbol.core" "schematicSymbol" "w")
cvSym = dbOpenCellViewByType( library cell "symbol" "schematicSymbol" "w")
schPin = dbOpenCellViewByType("basic" "iopin" "symbol")
symPin=dbOpenCellViewByType("basic" "sympin" "symbolNN" nil "r")


;; loop on pins
foreach(mapcar pad l_pins 
when(zerop(mod(mn nSide)) ; test on each first edge
case(edge 
(1 Xq=1 	Yq=0 	Xlq=0 	Ylq=-1	) 
(2 Xq=0 	Yq=1 	Xlq=1 	Ylq=0 	) 
(3 Xq=-1 	Yq=0   	Xlq=0 	Ylq=1 	) 
(4 Xq=0 	Yq=-1 	Xlq=-1	Ylq=0  	)
);fin case
Xstep =Xq*xst 		Ystep =Yq*yst
Xlabel=Xlq*hstep	Ylabel=Ylq*hstep
;printf(":: (%L)\n"  list(X Y))
signY=Ylq+Yq
signX=Xlq+Xq
; X+ signY*sizeX
X=X+ (Xlq+Xq)*0.5*( (1-(-1)**edge)*Ycstep + (1-(-1)**(1+edge))*Xcstep )
Y=Y+ (Ylq+Yq)*0.5*( (1-(-1)**edge)*Xcstep + (1-(-1)**(1+edge))*Ycstep )
;printf(" (%L) (%L) (%L) \n" list(X Y) list(Xlq Xq) list( 0.5*(1-(-1)**edge)*Xcstep  0.5*(1-(-1)**(1+edge))*Ycstep ))
;printf(" (%L) (%L) (%L) \n" list(X Y) list(Ylq Yq) list( 0.5*(1-(-1)**edge)*Ycstep  0.5*(1-(-1)**(1+edge))*Xcstep ))
dbCreateInstByMasterName(cvSch padLib padCap "symbol" sprintf(nil "corner_%d" edge) X:Y rot)
XC=X YC=Y ; center Ring for second symbol
when(edge==1 X0=X Y0=Y) when(edge==3 X1=X Y1=Y)
X=X+ (Xlq+Xq)*0.5*( (1-(-1)**edge)*Xcstep + (1-(-1)**(1+edge))*Ycstep )
Y=Y+ (Ylq+Yq)*0.5*( (1-(-1)**edge)*Ycstep + (1-(-1)**(1+edge))*Xcstep )
;printf(":: (%L) \n" list(X Y))
rotate = mod(rotate+90 360)
rot=sprintf(nil "R%d" rotate)
edge++
); fin when
; printf("mn:%2d edge:%d rot:%4s(X:Y) (%g:%g) (%L) (%L) \n" mn edge-1 rot X Y  list(Xq Yq) list(Xlq Ylq))

pinId = schCreatePin( cvSch schPin car(pad) "inputOutput" nil X:Y rot )
pinId~>children~>xy=(X+Xlabel:Y+Ylabel)  ; règle orientation pin label
pinId~>children~>justify="centerRight"   ; règle orientation pin label

symPinId = schCreateSymbolPin( cvSym symPin car(pad) "inputOutput" X:Y "R0" )
dbCreateLabel(cvSym  list("pin" "drawing") X+Xlabel:Y+Ylabel car(pad) "centerRight" rot "stick" 0.0625); label du symbol
dbCreateLabel(corSym list("pin" "drawing") XC+Xlabel:YC+Ylabel car(pad) "centerRight" rot "stick" 0.0625); label du symbol

;dbCreateInstByMasterName(cvSym padLib cadr(pad) "symbol"  sprintf(nil "PAD_%d" mn) X:Y rot)
dbCreateInstByMasterName(cvSch padLib cadr(pad) "symbol"  sprintf(nil "PAD_%d" mn) X:Y rot)

mn=mn+1
when(!zerop(mod(mn nSide)) X=X+Xstep Y=Y+Ystep)
when(!zerop(mod(mn nSide)) XC=XC+Xstep YC=YC+Ystep)

);end foreach mapcar
schCreateWire( cvSch "draw" "direct" list(X0:Y0 X0:Y1) 0.0625 0.0625 0.0125 ); <== creat wire line
schCreateWire( cvSch "draw" "direct" list(X0:Y1 X1:Y1) 0.0625 0.0625 0.0125 ); <== creat wire line
schCreateWire( cvSch "draw" "direct" list(X1:Y1 X1:Y0) 0.0625 0.0625 0.0125 ); <== creat wire line
schCreateWire( cvSch "draw" "direct" list(X1:Y0 X0:Y0) 0.0625 0.0625 0.0125 ); <== creat wire line
;printf("list(X Y):(%L)\n" list(X0 Y0 X1 Y1))
W=Ycstep;+Xcstep

shapeId = schCreateSymbolShape( cvSym "rectangle" "outline" list(X0:Y0 X1:Y1) )
shapeId = schCreateSymbolShape( cvSym "rectangle" "outline" list(X0-W:Y0-W X1+W:Y1+W) )
shapeId = schCreateSymbolShape( corSym "rectangle" "outline"      list(X0-W:Y0-W X1+W:Y1+W) )
                  dbCreateRect( corSym list("instance" "drawing") list(X0-W:Y0-W X1+W:Y1+W) ) ; <== selection box rect
labelId = schCreateSymbolLabel( cvSym 0:Y1 "instance label" "[@instanceName]" "lowerLeft" "R0" "euroStyle" 0.125 "NLPLabel" )
labelId = schCreateSymbolLabel( cvSym 0:Y1+0.15 "logical label" "Click here to edit" "lowerLeft" "R0" "roman" 0.0625 "normalLabel" )
dbCreateRect(cvSym list("instance" "drawing") list(X0-W:Y1 X1+W:Y1+W)) ; <== selection box rect

dbSave(cvSym) dbClose(cvSym) dbSave(corSym) dbClose(corSym) dbSave(cvSch) dbClose(cvSch) 
);end let
);end proc


innoPadList='(("gnd!" "PAD_GND") ("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND") ("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND") ("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND") ("gnd!" "PAD_GND") ("vdda!" "PAD_ALIM") ("Vbi_diff" "PAD_IO") ("Vbi_cmfb" "PAD_IO") ("vdda!" "PAD_ALIM") ("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND") ("gnd!" "PAD_GND") ("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND") ("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND") ("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND") ("gnd!" "PAD_GND") ("vdda!" "PAD_ALIM") ("IN1" "PAD_IO") ("IN2" "PAD_IO") ("Vcons" "PAD_IO") ("Vbias_casc" "PAD_IO") ("gnd!" "PAD_GND")) 


;createSch( innoPadList "INNOTEP_v4" "box2" )



;createSch( '("in0" "in1" "in2" "in3" "in4" "in5" "in6" "in7" "in8" "in9" "in10" "in11" "in12" "in13" "in14" "in15" "in16" "in17" "in18" "in19" "in20" "in21" "in22" "in23" "in24" "in25" "in26" "in27" "in28" "in29" "in30" "in31")) t
;createSch( '(("IN0" "PAD_IO") ("IN1" "PAD_IO") ("IN2" "PAD_IO") ("IN3" "PAD_IO") ("IN4" "PAD_IO") ("IN5" "PAD_IO") ("IN6" "PAD_IO") ("IN7" "PAD_IO") ("IN8" "PAD_IO") ("IN9" "PAD_IO") ("IN10" "PAD_IO") ("IN11" "PAD_IO") ("IN12" "PAD_IO") ("IN13" "PAD_IO") ("IN14" "PAD_IO") ("IN15" "PAD_IO")))


t2kNames = '( 
("gnd!" "PAD_GND") ("VDD" "PAD_ALIM")  "T1_8" "PS_ON1" "PS_ON7" "PS_ON8" "PS_RZ" "PS_RZ1" "Vref_SH" "Rpa" ("VDD" "PAD_ALIM") ("gnd!" "PAD_GND") ("VCC" "PAD_ALIM")
("VCC" "PAD_ALIM") ("gnd!" "PAD_GND" ) "OUT<0>" "OUT<1>" "OUT<2>" "OUT<3>" "OUT<4>" "OUT<5>" "OUT<6>" "OUT<7>" "OUT<8>" ("gnd!" "PAD_GND" ) ("VCC" "PAD_ALIM")
("gnd!" "PAD_GND") ("VDDB" "PAD_ALIM") "IN_BUF" "gnd!" "OUT_SH" "IN_SH" "Vref_SH1" ("VDD" "PAD_ALIM") "OUT_PA"  ("VDD1" "PAD_ALIM") "gnd!" "T1" ("gnd!" "PAD_GND" )
("VDD" "PAD_ALIM") ("gnd!" "PAD_GND" ) "IN<0>" "IN<1>" "IN<2>" "IN<3>" "IN<4>" ("VDD" "PAD_ALIM") "IN<5>" "IN<6>" "IN<7>" "IN<8>" ("gnd!" "PAD_GND" ) 
)

;createSch(t2kNames "T2K_2009" "box2" "PAD_capa" "PAD_cell")
