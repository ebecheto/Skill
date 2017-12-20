;=> Nice one ! ouvrir fenetre layout avec les elements places, sans les pins.
; et ca place les pins la ou il faut tout seul comme un grand.
; marche pas sur les mos, car il n'y a pas de couches pins sur les mos... pity
; load("/home/validmgr/ebecheto/Skill/generateAllPins.il")

ineed('(getInstTermPointLPP createPinLPP textDisplay2label metalPin2pinDrawing bus2flat) )



;; cv~>??
;; setof(c cv~>conns rexMatchp("!$" c~>name));=>(db:0x6609b81a db:0x6609b81b db:0x6609b82c db:0x6609b82d) ;=> doublons
;; setof(c cv~>sigNames rexMatchp("!$" c));=>("gnd!" "vdd!") ;<= pas de doublons

; append(cvs~>terminals setof(c cv~>sigNames rexMatchp("!$" c)))
; TODO : Rajouter vdd! xxx! (globals) si c'est possible
; global terminals 
;; gloTerm=foreach(mapcan s setof(c cv~>sigNames rexMatchp("!$" c)) 
;; setof(st cvs~>terminals st~>name==s))

; cv=geGetWindowCellView()
defun(generateAllPins (@optional (cv t)(only1 t)(labelPin t))
let( (cvs  its flatBus noBus flats sig dir ins pn apn iname)
when(cv==t cv=geGetWindowCellView())
cvs=dbOpenCellViewByType(cv~>libName cv~>cellName "schematic")
unless(cvs printf("Hey dude, where is your schematic ? %L\n" list(cv~>libName cv~>cellName )))
sts=foreach(mapcar term1 cvs~>terminals
its=foreach(mapcar instTerm term1~>net~>allInstTerms 
list(instTerm~>name instTerm~>inst~>name)
)
list(term1~>name its term1~>direction);=>("Q_0" (("Z" "I10") ("A" "I0")))
)

flatBus='()
noBus=remove(nil foreach(mapcar st sts if(cadr(st) then st else flatBus=append(flatBus list(st)) nil)))
flats=foreach(mapcan f flatBus ; flatBus ;=> (("Q<1:10>" nil "inputOutput"))
dir=nth(2 f) 
fb=car(f)
nats=car(setof(nat cvs~>terminals~>net nat~>name=="out<11>"));nil
nats=car(setof(nat cvs~>terminals~>net nat~>name==fb))

flats=foreach(mapcar si nats~>signals SO=si list(si~>name 
foreach(mapcar tem si~>instTerms 
list(tem~>name tem~>inst~>name))
dir)
)) ; flatBus a transformer en  ;=> (("Q<1>" "OUT" "inputOutput")("Q<2>" "OUT" "inputOutput")...())

printf("flats___: %L\n" flats)

; tflats___='(("sub!" nil "output") ("in<0>" (("in_pa" "csa<0>")) "output") ("in<1>" nil "output") ("in<2>" nil "output") ("in<3>" nil "output") ("in<4>" nil "output") ("in<5>" nil "output") ("in<6>" nil "output") ("in<7>" (("in_pa" "csa<7>")) "output") ("in<8>" (("in_pa" "csa<8>")) "output") ("in<9>" nil "output") ("in<10>" nil "output") ("in<11>" nil "output") ("in<12>" nil "output") ("in<13>" nil "output") ("in<14>" nil "output") ("in<15>" (("in_pa" "csa<15>")) "output") ("out<0>" (("OUT" "csa<0>")) "inputOutput") ("out<1>" nil "inputOutput") ("out<2>" nil "inputOutput") ("out<3>" nil "inputOutput") ("out<4>" nil "inputOutput") ("out<5>" nil "inputOutput") ("out<6>" nil "inputOutput") ("out<7>" (("OUT" "csa<7>")) "inputOutput") ("out<8>" (("OUT" "csa<8>")) "inputOutput") ("out<9>" nil "inputOutput") ("out<10>" nil "inputOutput") ("out<11>" nil "inputOutput") ("out<12>" nil "inputOutput") ("out<13>" nil "inputOutput") ("out<14>" nil "inputOutput") ("out<15>" (("OUT" "csa<15>")) "inputOutput"))


sts=append(noBus flats)
;sts=noBus


foreach(mapcar its sts
name=car(its);=>"Q_0"
itsd=cadr(its);=>(("Z" "I10") ("A" "I0"))
dir=nth(2 its)
when(only1 itsd=list(car(itsd)))
foreach(mapcar it itsd
;it=car(itsd);=>("Z" "I10")
ins=cadr(it);=>"I10"
pn=car(it);=>"Z"
printf("placing %s-pin on %s-term of %s-inst._%L\n" name pn||"pn?" ins||"ins?" list(only1 cv~>terminals~>name))
;cv~>instances~>name;=>("|I0" "|I5" "|I1" "|I2" "|I7" "|I3" "|I4" "|I6" "|I8" "|I9" "|I10" "I__167844" "I1")
unless(only1&&member(name cv~>terminals~>name) printf("pin%L\n" list(ins pn))
unless(ins printf("WARNING ins=nil?=%L in : %L;<= CANNOT FIND\n" ins it))
when(ins 
iname=if(length(pins=parseString(ins "<>"))>1 strcat("|" car(pins) "(" cadr(pins) ")") strcat("|" ins))
if(inst=car(setof(inst cv~>instances inst~>name==iname))
;; schema inst INST<0:1> ==> layout |INST(0) et |INST(1) pourquoi ce cahngement ?
;; ||inst=car(setof(inst cv~>instances inst~>name==strcat("|" ins))) replace (par< et )par>
;; ceci deverait etre le default mode, mais permettre une liste de correspondance (dico)
then
apn=assoc(pn getInstTermPointLPP(inst))
;=>("Z" (5.1 22.71) ("M1" "pin") ((5.0 22.41) (5.2 23.01)) db:0x1495141d)
; createPinLPP(name bBox lpp dir)
bBox=nth(3 apn) lpp=nth(2 apn); dir=nth(4 apn)~>pin~>term~>direction
printf("createPinLPP%L\n" list(name bBox lpp dir))
if(bBox&&lpp then createPinLPP(name bBox lpp dir) else printf("NO LPP or bBox for:%L\n" list(name bBox lpp dir)))
else
printf("%s not found\n" iname)
)))
)
)
when(labelPin textDisplay2label(cv) metalPin2pinDrawing(cv))
))

printf("generateAllPins()\n")
printf("generateAllPins(t);=> geGetWindowCellView()\n")
printf("generateAllPins(t t)\n")
printf("generateAllPins(t nil);<= not only one => for all => overides\n")
printf("generateAllPins(t t t);<=default : one pin on each term for ams (label and PIN purpose)\n")
printf("generateAllPins(t t nil);<= one pin on each term for ibm (textdisplay, default layer)\n")


