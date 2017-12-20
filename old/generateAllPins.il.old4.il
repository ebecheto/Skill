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


;cvs~>sigNames
;=> ("in<15>" "Dzio<13>" "Dzio<10>" "Dzio<9>" "Dzio<12>" "out<8>" "out<2>" "VSS" "CHOP" "out<14>" "Dzio<11>" "RDIOD" "sub!" "VSB2" "out<13>" "out<12>" "Vref" "in<12>" "RN" "Dzio<14>" "in<8>" "out<11>" "out<10>" "out<7>" "in<0>" "Dzk" "in<11>" "Dzio<5>" "Dzio<1>" "in<10>" "in<9>" "T1" "Dzio<4>" "VDD" "out<9>" "Dzio<0>" "VDB1" "out<0>" "in<6>" "in<5>" "Dzio<3>" "Dzio<8>" "in<4>" "out<15>" "in<3>" "Dzo" "in<2>" "out<4>" "out<3>" "in<1>" "in<7>" "Dzio<2>" "Dzio<7>" "Cstim" "Dzio<6>" "out<6>" "in<14>" "out<5>" "Dzi" "ENA" "out<1>" "in<13>")
; cv=geGetWindowCellView()

defun(generateAllPins (@optional (cv t)(only1 t)(labelPin t))
let( (cvs  its flatBus noBus flats sig dir ins pn apn iname)
when(cv==t cv=geGetWindowCellView())
cvs=dbOpenCellViewByType(cv~>libName cv~>cellName "schematic")
unless(cvs printf("Hey dude, where is your schematic ? %L\n" list(cv~>libName cv~>cellName )))

nameDirs=foreach(mapcan tn cvs~>terminals 
if(length(parseString(tn~>name ":"))>1 foreach(mapcar bus bus2flat(tn~>name) list(bus tn~>direction)) list(list(tn~>name tn~>direction)))
);=>  (("ENA" "input")... ("out<11>" "inputOutput"))

sigNames=setof(s cvs~>sigNames dbFindSigByName(cvs s)~>term)

foreach(mapcar nameDir nameDirs
sigName=car(nameDir)
; name;=>"Q_0"
; itsd=cadr(its);=>(("Z" "I10") ("A" "I0"))
itsd=foreach(mapcar mit dbFindSigByName(cvs sigName)~>memInstTerms list(car(mit)~>name dbGetMemName(car(mit)~>inst~>name cadr(mit))))
dir=cadr(nameDir)

when(only1 itsd=list(car(itsd)))
foreach(mapcar it itsd
;it=car(itsd);=>("Z" "I10")
ins=cadr(it);=>"I10"
pn=car(it);=>"Z"  ;<== TODO : if instance as a pin Z<0:1> it bugs .... or do it before in the creation of itsd
printf("placing %s-pin on %s-term of %s-inst._%L\n" sigName pn||"pn?" ins||"ins?" list(only1 cv~>terminals~>name))
;cv~>instances~>name;=>("|I0" "|I5" "|I1" "|I2" "|I7" "|I3" "|I4" "|I6" "|I8" "|I9" "|I10" "I__167844" "I1")
unless(only1&&member(sigName cv~>terminals~>name) printf("pin%L\n" list(ins pn))
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
printf("createPinLPP%L\n" list(sigName bBox lpp dir))
if(bBox&&lpp then createPinLPP(sigName bBox lpp dir) else printf("NO LPP or bBox for:%L\n" list(sigName bBox lpp dir)))
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
printf("generateAllPins(t nil t)\n ;<= que j'utilise pour AMS035\n")
printf("generateAllPins(t nil);<= not only one => for all => overides\n")
printf("generateAllPins(t t t);<=default : one pin on each term for ams (label and PIN purpose)\n")
printf("generateAllPins(t t nil);<= one pin on each term for ibm (textdisplay, default layer)\n")


