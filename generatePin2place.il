ineed('(sig2instTerm instName2layout))

defun(generatePin2place (@optional (cv t)(only1 t)(labelPin t))
let( (cvs its flatBus noBus flats sig dir ins pn apn iname)
when(cv==t cv=geGetWindowCellView())
cvs=dbOpenCellViewByType(cv~>libName cv~>cellName "schematic")
unless(cvs printf("Hey dude, where is your schematic ? %L\n" list(cv~>libName cv~>cellName )))

sigs=sig2instTerm(nil cvs)
ast=foreach(mapcar s sigs list(car(s) cadr(s) instName2layout(nth(2 s))))

;=> (("IN<17>" "A" "|C2") ("TEST<0>" "A<0>" "|I5(10)") ... ("IN<19>" "noConn" "|I8(1)"))

foreach(mapcar it ast
sigName=nth(0 it)  ;=>"IN<17>" 
pn=nth(1 it)       ;=>"Z" or Z<1>
iname=nth(2 it)      ;=>"|I5(10)"
printf("placing %s-pin on %s-term of %s-inst._\n" sigName pn||"pn?" iname||"iname?" )
if(inst=car(setof(inst cv~>instances inst~>name==iname))
;; schema inst INST<0:1> ==> layout |INST(0) et |INST(1) pourquoi ce changement ?
;; ||inst=car(setof(inst cv~>instances inst~>name==strcat("|" ins))) replace (par< et )par>
;; ceci deverait etre le default mode, mais permettre une liste de correspondance (dico)
then
apn=assoc(pn getInstTermPointLPP(inst))
;=>("Z" (5.1 22.71) ("M1" "pin") ((5.0 22.41) (5.2 23.01)) db:0x1495141d)
; createPinLPP(name bBox lpp dir)
bBox=nth(3 apn) 
lpp =nth(2 apn)
dir =nth(4 apn)~>pin~>term~>direction
printf("createPinLPP%L\n" list(sigName bBox lpp dir))
if(bBox&&lpp then createPinLPP(sigName bBox lpp dir) else printf("NO LPP or bBox for:%L\n" list(sigName bBox lpp dir)))
else
printf("%s not found\n" iname)
)))
)

;; when(labelPin textDisplay2label(cv) metalPin2pinDrawing(cv))
;; 
