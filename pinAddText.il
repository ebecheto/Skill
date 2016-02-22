;; copyleft ebecheto
; load "pinAddText.il"
defun( pinAddText (@optional (purpose "label")(rot "R0")(cv geGetWindowCellView()) )
let((p1 f1 disp pnil sel)
unless(purpose pnil=nil)
; cv=geGetWindowCellView()
;; p=car(cv~>terminals~>pins)
;; term=car(cv~>terminals)

sel=setof(g geGetSelectedSet()~>pin~>term g~>objType=="term")
if(sel terms=sel terms=cv~>terminals)
foreach(term terms
p1=car(term~>pins) ;let supose term has only one pin
p1~>net~>name
f1=car(p1~>figs)   ;let supose p1 has only objType "rect" 
printf("F1%L ** %L\n" f1~>children~>lpp term~>??)
if(f1~>children ; when no attached text Display, let us create one (not a label, even if similar)
then
printf("Children exist Allready\n")
;update lpp
f1~>children~>lpp=f1~>lpp
child=car(f1~>children)
; remove it if erronous
; f1~>children=nil;<== marche pas
; f1~>children~>parent=nil
; dbDeleteObject(car(css()~>children))
child~>parent=nil
dbDeleteObject(child);<= ok remouve all superflu
else
when(pnil purpose=f1~>purpose)
printf("Lay%L\n" f1~>layerName)
when(f1~>layerName
disp=dbCreateLabel( cv f1~>lpp centerBox(f1~>bBox) p1~>net~>name "centerLeft" "R0" "roman" 0.5)

;; ;;textDisplay vs label...
;; disp=dbCreateTextDisplay( term term list(f1~>layerName  purpose ) t centerBox(f1~>bBox) "centerLeft" rot "roman" 0.5)
;; disp~>isNameVisible=nil ;makes the 'name=' invisible
;; disp~>parent=p1~>fig    ;makes the text moving with the rect pin
;; ; and now f1~>children is not nil => so a can re-run the script
;; printf("Added text %s in\nhiZoomIn(hiGetCurrentWindow() '%L)\n)" p1~>net~>name f1~>bBox)

)
))
))

;pinAddText(geGetWindowCellView() "drawing" "R90")
;  cv=geGetWindowCellView()
;; i=1
;; hName=tName="VDD"
;; hName=tName="VSS"
;; purpose="drawing"

defun(hierPin2Top (@optional (hName "VDD")(tName nil)(cv nil)(purpose nil)(deepi 1))
let((con tr dir accessDir rect pts layName lpp pin)
unless(cv cv=geGetWindowCellView())
unless(deepi deepi=1)
unless(tName tName=hName)
unless(purpose purpose="drawing")
conns=setof(con cv~>conns con~>name==hName)
when(deepi==t deepi=length(conns))
for(i 1 deepi
con=nthelem(i conns)
tr=con~>inst~>transform
dir=con~>term~>direction
accessDir=car(con~>term~>pins)~>accessDir
rect=car(con~>term~>pins)~>fig~>bBox
pts=dbTransformBBox(rect tr)
; hiZoomIn(hiGetCurrentWindow() pts)
layName=car(car(con~>term~>pins)~>figs)~>layerName;=>"M1"
lpp=list(layName purpose)
pin=leCreatePin(cv lpp "rectangle" pts tName dir accessDir)
;geSelectFigs(pin~>figs)
)))

printf("_______________function example______________\n")
printf("hierPin2Top(\"VDD\");<= ca fait quoi ca deja\n")
printf("hierPin2Top(\"VSS\")\n")
printf("pinAddText()<= rajoute des labels collant sur les pins sans label\n")

;unless(fboundp('pinLayoutGen) load("pinLayoutGen.il"))
;unless(fboundp('angleBox) load("padRing.proc.il"))
ineed('(angleBox pinLayoutGen))
printf("pinLayoutGen(%L nbrs)\n" "In")
printf("pinLayoutGen(%L nbrs 1.3);<= 1.3 step\n" "In")



defun( createInstPins (@optional (inst css()) (rot "R0") (cv geGetWindowCellView()))
foreach(mapcar el getInstTermPointLPP(inst)
name=car(el)
pos=cadr(el)
box=nth(3 el)
;box=list(rodSubPoints(pos 0.2:0.2) rodAddPoints(pos 0.2:0.2))
lpp=nth(2 el)
dir=nth(4 el)~>pin~>term~>direction;<= possible amelioration
printf("inst:%s_%L\n" inst~>instName||"nil" list(name lpp dir))
; dir="inputOutput";dir="input" 
accessDir=list("top" "bottom" "left" "right")
pin=leCreatePin(cv lpp "rectangle"  box name dir accessDir)
term=pin~>term
disp=dbCreateTextDisplay( term term lpp t pos "centerLeft" rot "roman" 0.5) 
disp~>isNameVisible=nil ;makes the 'name=' invisible
disp~>parent=pin~>fig    ;makes the text moving with the rect pin
))

printf("createInstPins();<= cree les pins de l'instance layout selectionnee\n")
printf("createInstPinsch();<= cree les pins de l'instance schematic selectionnee pr IBM c cool!\n")

(setq cv geGetWindowCellView())


defun( createInstPinsch (@optional (insts t) (cv nil)(nlist '(("D" "Zi")("CLK" "Zi")))(inc -1)(skip nil)(inci t)(incL '("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L") )(rev nil))
;inc="name" ||t || number(ie. 1)
unless(skip skip='("VDD" "NW" "SX" "GND"))
printf("inc=%L__%L\n" inc incL )
(setq font "euroStyle")
dx=0.125;*2
ic=0
unless(cv cv=geGetWindowCellView())
when(insts=='t insts=geGetSelectedSet())
unless(insts insts=cv~>instances)
insts=setof(inst insts inst~>objType=="inst")
foreach(inst insts ;inst=css()
when(inci ic++)
terms=inst~>terminals
foreach(term terms ;term=car(terms);~>??
pinName=term~>name
unless(term~>net~>figs
when( point=cadr(assoc(pinName getInstTermPoint(inst)))
unless(inci ic++)
sbBox=car(setof(x inst~>master~>shapes x~>layerName=="instance" && x~>objType=="rect")~>bBox)
bBox=dbTransformBBox(sbBox inst~>transform)
os=angleBox(point bBox)
;printf("os='%L point='%L bBox='%L pinName='%L\n"  os point bBox pinName)
x=car(point) y=cadr(point)
cond((os==0 y=y-dx)(os==1 x=x+dx)(os==2 y=y+dx)(os==3 x=x-dx))
orient=sprintf(nil "R%d" mod(90*(os+1) 360))
wid=schCreateWire( cv "draw" "direct" list(point x:y) 0.0625 0.0625 0 ); <== creat wire line
when(an=assoc(pinName nlist) pinName=cadr(an))
when(inc==t while(member(label=sprintf(nil "%s_%d" pinName ic) cv~>sigNames ) ic++))
switches=list(pinName cadr(parseString(inst~>cellName "_"))||inst~>cellName)
when(rev switches=reverse(switches))
when(inc=="name" label=sprintf(nil "%s_%s" nth(0 switches) nth(1 switches) ))
when(numberp(inc) label=sprintf(nil "%s%s" pinName nth(inc incL)||""))
when(member(pinName skip) label=pinName)
schCreateWireLabel(cv car(wid) centerBox(list(point x:y)) label "lowerRight" orient font 0.0625 nil)
)))))


printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L)\n" '(("D" "Zi_")("CLK" "Zi_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L)\n" '(("D" "Z_")("CLK" "Z_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L)\n" '(("A" "Z_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L)\n" '(("A" "Zi_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() nil %L)\n" "name")
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() nil t)\n")
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() nil -1 nil nil);<= last one in use\n")
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L -1 nil t '%L)\n" '(("A" "Zi_")) '("L" "1" "2" "3" "4" "6" "8"))
printf("CHECK AND SAVE BEFORE USING : createInstPinsch\n")
;css()~>terminals~>net~>figs
;; a='() for(i 1 11 a=append(a list("INVERT_B")))
;; addCell(a)
