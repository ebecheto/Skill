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

sts=foreach(mapcar term1 cvs~>terminals
its=foreach(mapcar instTerm term1~>net~>allInstTerms 
list(instTerm~>name instTerm~>inst~>name)
)
list(term1~>name its term1~>direction);=>("Q_0" (("Z" "I10") ("A" "I0")))
)

;; fuck c pas le bon ordre...
flatBus='()
noBus=remove(nil foreach(mapcar st sts if(cadr(st) then st else flatBus=append(flatBus list(st)) nil)))
flats=foreach(mapcan f flatBus 
sig=car(f)
dir=nth(2 f)
foreach(mapcar si te~>signals
list(si~>name
list(append(
car(si~>signals~>instTerms~>name)
car(si~>signals~>instTerms~>inst~>name)))
dir))
)

sts=append(noBus flats)

foreach(mapcar its sts
name=car(its);=>"Q_0"
itsd=cadr(its);=>(("Z" "I10") ("A" "I0"))
dir=nth(2 its)
when(only1 itsd=list(car(itsd)))
foreach(mapcar it itsd
ins=cadr(it);=>"I10"
pn=car(it);=>"Z"
printf("placing %s-pin on %s-term of %s-inst\n" name pn||"pn?" ins||"ins?")
unless(only1&&member(name cv~>terminals~>name)
if(inst=car(setof(inst cv~>instances inst~>name==strcat("|" ins))) then
apn=assoc(pn getInstTermPointLPP(inst))
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