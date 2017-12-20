;=> Nice one ! ouvrir fenetre layout avec les elements places, sans les pins.
; et ca place les pins la ou il faut tout seul comme un grand.
; marche pas sur les mos, car il n'y a pas de couches pins sur les mos... pity


ineed('(getInstTermPointLPP createPinLPP) )

; cv=geGetWindowCellView()
defun(generateAllPins (@optional (cv t)(only1 t))
let( (cvs sts its flatBus noBus flats sig dir ins pn apn)
when(cv==t cv=geGetWindowCellView())
cvs=dbOpenCellViewByType(cv~>libName cv~>cellName "schematic")
unless(cvs printf("Hey dude, where is your schematic ? %L\n" list(cv~>libName cv~>cellName )))
;;term1=car(last(cvs~>terminals))
sts=foreach(mapcar term1 cvs~>terminals
;; cvs~>terminals~>name;<= cas a traiter : bus
;; ("Dziout" "CLK" "Skip" "Dzin" "Q<1:10>")
;term1~>net~>allInstTerms  vs term1~>net~>signals~>allInstTerms
;cvs~>terminals~>net~>signals~>allInstTerms~>??
; term1~>net~>signals~>allInstTerms;
its=foreach(mapcar instTerm term1~>net~>allInstTerms 
;list(instTerm~>name instTerm~>inst~>name)
list(instTerm~>name instTerm~>inst~>name)
)
list(term1~>name its term1~>direction);=>("Q_0" (("Z" "I10") ("A" "I0")))
)

;; term1=nth(1 cvs~>terminals)
;; term1=nth(3 cvs~>terminals)

flatBus='()
noBus=remove(nil foreach(mapcar st sts if(cadr(st) then st else flatBus=append(flatBus list(st)) nil)))

; flatBus ;=> (("Q<1:10>" nil "inputOutput"))
flats=foreach(mapcan f flatBus 
;; nth(4 cvs~>terminals)~>net~>signals;(db:0x1f174320 db:0x1f174340 db:0x1f174325 db:0x1f174323 db:0x1f17432c db:0x1f174328 db:0x1f17433a db:0x1f17431c db:0x1f17432d db:0x1f17433d)
;; nth(1 cvs~>terminals)~>net~>signals;(db:0x1f174324)
dir=caddar(flatBus);=>"inputOutput"
fb=caar(flatBus)
dir=nth(2 f)
fb=car(f)

nats=car(setof(nat cvs~>terminals~>net nat~>name==fb))

;; te=nth(4 cvs~>terminals)~>net
;; te~>signals~>name ;=> ("Q<1>" "Q<2>" "Q<3>" "Q<4>" "Q<5>" "Q<6>" "Q<7>" "Q<8>" "Q<9>" "Q<10>")
; te~>signals~>instTerms~>name;=>(("Q<1>") ("Q<3>") ("Q<5>") ("Q<7>") ("Q<9>") ("Q<10>") ("Q<8>") ("Q<6>") ("Q<4>") ("Q<2>" "D1"))
; te~>signals~>instTerms~>inst~>name;=>(("I0") ("I0") ("I0") ("I0") ("I0") ("I0") ("I0") ("I0") ("I0") ("I0" "MUX21_H0"))
flats=foreach(mapcar si nats~>signals list(si~>name foreach(mapcar tem si~>instTerms list(tem~>name tem~>inst~>name)) dir))


sts=append(noBus flats)

;name=car(cvs~>terminals~>name);=>"Q_0"
;net=dbMakeNet(cv name)
; its=assoc(name sts);=>("Q_0" (("Z" "I10") ("A" "I0")))
;; foreach(mapcar st sts if(rexMatchp(":" car(st))
;; ))


foreach(mapcar its sts
name=car(its);=>"Q_0"
itsd=cadr(its);=>(("Z" "I10") ("A" "I0"))
dir=nth(2 its)
when(only1 itsd=list(car(itsd)))
foreach(mapcar it itsd
;it=car(itsd);=>("Z" "I10")
ins=cadr(it);=>"I10"
pn=car(it);=>"Z"
printf("placing %s-pin on %s-term of %s-inst\n" name pn||"pn?" ins||"ins?")
;cv~>instances~>name;=>("|I0" "|I5" "|I1" "|I2" "|I7" "|I3" "|I4" "|I6" "|I8" "|I9" "|I10" "I__167844" "I1")
unless(only1&&member(name cv~>terminals~>name)
if(inst=car(setof(inst cv~>instances inst~>name==strcat("|" ins))) then
;=>db:0x1989fe1c
;; tpns=setof(ter inst~>terminals ter~>name==pn);=>(db:0x1989fc5e)
;; tpn=car(tpns)
;; tpn~>??
;inst=css()
apn=assoc(pn getInstTermPointLPP(inst))
;=>("Z" (5.1 22.71) ("M1" "pin") ((5.0 22.41) (5.2 23.01)) db:0x1495141d)
; createPinLPP(name bBox lpp dir)
bBox=nth(3 apn) lpp=nth(2 apn); dir=nth(4 apn)~>pin~>term~>direction
printf("createPinLPP(%L)\n" list(name bBox lpp dir))
createPinLPP(name bBox lpp dir)
else
printf("%s not found\n" strcat("|" ins))
))
)
)
))

printf("generateAllPins()\n")
printf("generateAllPins(t)\n")
printf("generateAllPins(t t)\n")
printf("generateAllPins(t nil)\n")