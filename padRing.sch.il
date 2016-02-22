;; copyleft ebecheto
/**** copyleft ************************************
* Authors : Edouard BECETHOILLE  IPNL (IN2P3-CNRS/UCBL) MICRHAU *
* Version : 0.8   sept 2012      termSkipList              *
* History : oppositePad feature                            *
*         : maj pour l_pins en AST 3-element par liste     * 
***************************************************/

procedure(createSch( l_pins @optional (library getEditRep()~>libName ) (cell getEditRep()~>cellName)  (padCap "PAD_capa") (padLib list("PAD_cell_S35D4")) @rest rest )
let((IO nPad mn tmp tmpList hstep lstep cstep xst yst edge Xstep Ystep Xq Yq Xlabel Ylabel Xlq Ylq Xcq Ycq X0 Y0 X1 Y1 W dbLib inst pinList termName termPoints termSkip termLabel termXY pinName orient l_rest oppositePad sideWay cb1 cb2 adjust xform shortList)

if(l_rest=assoc("oppositePad" rest) oppositePad=cadr(l_rest) oppositePad='("BBC4P") )
if(l_rest=assoc("oppositePadLib" rest) oppositePadLib=cadr(l_rest) oppositePadLib='("IOLIB_4M" "IOLIB_3B_4M") )
if(l_rest=assoc("shortList" rest) then  shortList=eval(cadr(lr)) else shortList='("APRIOP" "APRIOP_3B" "APRIOC_3B" )) ;shortTermList='("APRIOP" "APRIOP_3B" )
sideWay='(("R0" "MY")("R90" "MYR90")("R180" "MX")("R270" "MXR90"))
sideWay=append(sideWay foreach(mapcar x sideWay list(cadr(x) car(x)))); and the way around

dbLib = ddGetObj(library) pinList='() termSkip='("PAD" "DVDD" "GND")
printf("Generate Sch&Sym %d-pin in %L %L %L \n" length(l_pins) library cell list(dbLib))
nPad=length(l_pins)/4
hstep = 0.125*2 xst = 0.125*4
lstep = 0.375*2 yst = 0.125*4
Xcstep = 0.3125*2
Ycstep = 0.375*2
mn=0 edge=1 rotate = 0 X=0 Y=0 rot="R0" norient=0

cvSch  = dbOpenCellViewByType( library cell "schematic" "schematic" "w")
cvSym  = dbOpenCellViewByType( library cell    "symbol" "schematicSymbol" "w")
schPin = dbOpenCellViewByType("basic" "iopin"  "symbol")
symPin = dbOpenCellViewByType("basic" "sympin" "symbolNN" nil "r")


;; loop on pins
foreach(mapcar pad l_pins 

when(zerop(mod(mn nPad)) ; test on each first edge
case(edge 
(1 Xq=1 	Yq=0 	Xlq=0 	Ylq=-1	) 
(2 Xq=0 	Yq=1 	Xlq=1 	Ylq=0 	) 
(3 Xq=-1 	Yq=0   	Xlq=0 	Ylq=1 	) 
(4 Xq=0 	Yq=-1 	Xlq=-1	Ylq=0  	)
);fin case
Xstep =Xq*xst 		Ystep =Yq*yst
Xlabel=Xlq*hstep	Ylabel=Ylq*hstep
signY=Ylq+Yq
signX=Xlq+Xq
; X+ signY*sizeX
X=X+ (Xlq+Xq)*0.5*( (1-(-1)**edge)*Ycstep + (1-(-1)**(1+edge))*Xcstep )
Y=Y+ (Ylq+Yq)*0.5*( (1-(-1)**edge)*Xcstep + (1-(-1)**(1+edge))*Ycstep )
; capLib=whereExistCell(padCap padLib);<= normally allready checked. but need to redo it
capLib=whereExistCell(padCap padLib)  when(length(capLib)>=2 printf("WARNING %L exist in multiple Library, Taking %L." capLib car(capLib))) capLib=car(capLib)
;;commented : no CORNER sch&symbol 2011/07/27
;;dbCreateInstByMasterName(cvSch capLib padCap "symbol" sprintf(nil "corner_%d" edge) X:Y rot)
XC=X YC=Y ; center Ring for second symbol
when(edge==1 X0=X Y0=Y) when(edge==3 X1=X Y1=Y)
X=X+ (Xlq+Xq)*0.5*( (1-(-1)**edge)*Xcstep + (1-(-1)**(1+edge))*Ycstep )
Y=Y+ (Ylq+Yq)*0.5*( (1-(-1)**edge)*Ycstep + (1-(-1)**(1+edge))*Xcstep )
rotate = mod(rotate+90 360)
rot=sprintf(nil "R%d" rotate)
edge++
); fin when

;; when(zerop(mod(mn nPad)) 
;; rotate = mod(rotate+90 360) 
;; ;rot=sprintf(nil "R%d" rotate)
;; rot=sprintf(nil "R%d" mod(90*(norient+3) 360))
;; sign=(-1)**mod(norient/2 2)
;; X=X+3*Xcstep*sign*mod(norient+1 2)
;; Y=Y+3*Ycstep*sign*mod(norient 2)
;; Xlabel=hstep*sign*mod(norient+1 2)
;; Ylabel=hstep*sign*mod(norient 2)
;; Xstep =-xst*(-1)**mod((norient+1)/2 2)*mod(norient 2)
;; Ystep =-yst*(-1)**mod((norient+1)/2 2)*mod(norient+1 2)
;; norient++)

termName=car(pad)


inst='()
when(d_cell=(dbOpenCellViewByType caddr(pad) cadr(pad) "symbol") inst=dbCreateInst(cvSch d_cell sprintf(nil "PAD_%d" mn) X:Y rot) )
; inst=dbCreateInstByMasterName(cvSch caddr(pad) cadr(pad) "symbol"  sprintf(nil "PAD_%d" mn) X:Y rot) ;<= annoying when peri has no symbol => Marker

when( or( member(inst~>libName oppositePadLib) member(inst~>cellName oppositePad)) 
cb1=centerBox(inst~>bBox)
inst~>orient=cadr(assoc(rot sideWay)) ;<= changes orientation and place a bit
cb2=centerBox(inst~>bBox)
adjust=rodSubPoints(cb1 cb2)
xform=list(rodSubPoints(inst~>xy dbTransformPoint(adjust inst~>transform)) "R0" 1)
schStretch(list(inst) dbConcatTransform(dbConcatTransform(list(mapcar('minus inst~>xy) "R0" 1) xform) list(inst~>xy "R0" 1)))
; printf("\n** ADJUST %s %s \n" inst~>cellName||"nil" rot)
)


termPoints=getInstTermPoint(inst)
pinList=append(pinList list(list(termName termPoints)))

foreach(term termPoints
termLabel=car(term) termXY=cadr(term) pinName=termName
when(and( not(member(termLabel termSkip)) length(termPoints)!=1 not(member(inst~>cellName shortList)))  pinName=sprintf(nil "%s_%s" termLabel termName))
symPinId = schCreateSymbolPin( cvSym symPin pinName "inputOutput" termXY "R0" ) ;; pin for the symbol
dbCreateLabel(cvSym  list("pin" "drawing") rodAddPoints(termXY Xlabel:Ylabel) pinName "centerRight" rot "stick" 0.0625); label du symbol
orient=sprintf(nil "R%d" 90*orientSection(rodSubPoints(termXY centerBox(inst~>bBox)) ));; pin for the schematic

pinId = schCreatePin( cvSch schPin pinName "inputOutput" nil termXY orient )
;; pinId~>children~>xy=rodAddPoints(termXY list(Xlabel Ylabel))  ; regle orientation pin label
pinId~>children~>justify="upperLeft"   ; regle orientation pin label
)

mn=mn+1
when(!zerop(mod(mn nPad)) X=X+Xstep Y=Y+Ystep)
; when(!zerop(mod(mn nPad)) XC=XC+Xstep YC=YC+Ystep)

);end foreach mapcar pad l_pins 'MAIN LOOP'

W=Ycstep;+Xcstep

shapeId = schCreateSymbolShape( cvSym "rectangle" "outline" list(X0:Y0 X1:Y1) )
shapeId = schCreateSymbolShape( cvSym "rectangle" "outline" list(X0-W:Y0-W X1+W:Y1+W) )
labelId = schCreateSymbolLabel( cvSym 0:Y1 "instance label" "[@instanceName]" "lowerLeft" "R0" "euroStyle" 0.125 "NLPLabel" )
labelId = schCreateSymbolLabel( cvSym 0:Y1+0.15 "logical label" "Click here to edit" "lowerLeft" "R0" "roman" 0.0625 "normalLabel" )
dbCreateRect(cvSym list("instance" "drawing") list(X0-W:Y1 X1+W:Y1+W)) ; <== selection box rect

;netSetPatchf(cvSch)
dbSave(cvSym) dbClose(cvSym) 
schVIC(cvSch) schCheck(cvSch) dbSave(cvSch)  dbClose(cvSch)
; printf("pinList= %L\n" pinList)
pinList
);end let
);end proc
