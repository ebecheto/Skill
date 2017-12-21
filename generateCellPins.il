;; copyleft ebecheto
; could be improved in term of efficiency
; but better thant generateAllPins, because it works for :
; bus<1:N> to pin<1:k> of instances<1:N/k>
; use it with bindkey make it convenient :
; hiSetBindKey("Layout"	"Shift<key>space"	"ineed('generateCellPins) generateCellPins()")

printf("possibly run : \nineed('lpp2Set) ;<= afterwards\n")

ineed('(getInstTermPointLPP createPinLPP textDisplay2label metalPin2pinDrawing bus2flat bus2list lay2schName createPinLPPcv schInst2mapTable bBox_lpp_check))

; ineed('generateCellPins t)

;______________________________________________________________________________
defun(generateCellPins (@optional (cv t)(insts nil)(force nil))
let( (sinst cvs baseName sinst mapTable lpp lppi pn apn sigName bBox dir verb termNames)
verb=t; nil; <= verbose 
when(cv==t cv=geGetWindowCellView())
cvs=dbOpenCellViewByType(cv~>libName cv~>cellName "schematic")
unless(cvs printf("Hey dude, where is your schematic ? %L\n" list(cv~>libName cv~>cellName )))

;; insts='()
;; inst=css()
unless(insts insts=setof(sel geGetSelectedSet() sel~>objType=="inst"))
unless(insts insts=geGetWindowCellView()~>instances)
;; inst=nth(2 insts);=> db:0x2e6cf09d
;; insts~>name

;foreach(mapcar inst list(nth(0 geGetSelectedSet()))  ;insts
; cv=geGetWindowCellView())
; insts=geGetWindowCellView()~>instances
; inst=nth(0 insts);=> db:0x2e6cf09d

foreach(mapcar inst insts
cv=inst~>cellView ;<== layout cellview
cvs=dbOpenCellViewByType(cv~>libName cv~>cellName "schematic")
baseName=car(parseString(inst~>name "|()"));=> "MULT"
sinst=car(setof(x cvs~>instances x~>baseName==baseName));<= OKI MULT==MULT event for <:>
unless(sinst printf("WARNING, %L not matching %L in schematic\n" inst~>name baseName))
mapTable=schInst2mapTable(sinst)
EX=mapTable;<= debug, TOREMOVE
; remove non pin net name list
termNames=foreach(mapcan name cvs~>terminals~>name bus2list(name))
;termNames=foreach(mapcan name sinst~>cellView~>terminals~>name bus2list(name))
mapTable=setof(s mapTable member(nth(0 s) termNames))
EX1=mapTable;<= debug, TOREMOVE
printf("I=%L, MAP:%L\n" sinst~>name foreach(mapcar c mapTable car(c)))
when(verb printf("mapTable %L\n" mapTable))
lppi=getInstTermPointLPP(inst)
EX2=lppi
when(verb printf("lppi %L___%L__\n" lppi list(inst~>name inst~>cellName)))
; mat=car( mapTable) ; mat=nth(1 mapTable)
;=> ("IN<0>" "|MULT(0)" "dedans<0>" "inputOutput")

; mat=car(mapTable)
foreach(mapcar mat mapTable
;when(nth(1 mat)==sinst~>name) ;<== should i filter, if mapTableis ok?
when(car(parseString(nth(1 mat) "|"))==inst~>name ;<== should i filter, if mapTableis ok?
pn=nth(2 mat);=> "dedans<0>"
apn=assoc(pn lppi)
;=> ("dedans<0>" (-13.57 -3.6475) ("METAL1" "pin") ((-13.685 -4.005) (-13.455 -3.29)) db:0x2e6ce69e)
bBox=nth(3 apn) lpp=nth(2 apn); dir=nth(4 apn)~>pin~>term~>direction
sigName=nth(0 mat)
dir=nth(3 mat);=> "inputOutput"
;printf("createPinLPPcv%L\n" list(sigName bBox lpp dir))
if(
or(force when(bBox bBox_lpp_check(lpp bBox cv) ))
then 
when(verb||t printf("pin %L allready placed here\n" list(sigName centerBox(bBox) lpp)))
else 
when(verb printf("no pins here. OK?! bBox_lpp_check('%L '%L) ?\n" lpp bBox))
if(bBox&&lpp then npin=createPinLPPcv(sigName bBox lpp dir cv) else 
when(verb printf("NO LPP or bBox for:%L\n" list(sigName bBox lpp dir)))
)
)
);<== end when ;(unneeded when)
)
))
)

