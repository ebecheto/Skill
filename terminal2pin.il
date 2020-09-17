;; copyleft : ebecheto

 ; load("terminal2pin.il")
; net=car(setof(term css()~>instTerms term~>name=="OUT_1_1"))~>net  net~>name ;==>"TATA"
; cv~>terminals~>name; => ("TATA")
ineed('getInstTermPoint)
; unless(fboundp('getInstTermPoint) load("padRing.proc.il"))
;unless(fboundp('sort123) load("sort123.il"))
; define bBoxWidth getInstTermPoint bBoxHeight

printf("________________________________________________________________________________\n")
defun( terminal2pin (@optional  (pinName t) (cv t) (termMatchName t) (rev t) (N 1)) let((pins lapins dir aPin XY iout pinId insts)
; or termSortName="OUT_1" ;=> filtre les noms de type ".*OUT_1.*"
when(cv=='t cv=geGetWindowCellView())
when(pinName=='t pinName="OUT")
when(termMatchName=='t (setq termMatchName "OUT")) ;=> default match name
if(cv then insts=cv~>instances else insts=geGetSelectedSet() cv=car(geGetSelectedSet())~>cellView) ; les inst de cellview ou les elements selectionnes
insts=setof(i insts and(i~>libName!="analogLib" i~>purpose!= "pin")); on prend les instances mais pas les pins
foreach(inst insts printf("SEE %s_%s\n" inst~>name||"rien" inst~>cellName||"rien")
pins=inst~>master~>terminals
when(termMatchName pins=setof(i inst~>master~>terminals  rexMatchp(termMatchName i~>name)))
;printf("inst %s pins:%L term %L\n" inst~>name pins inst~>master~>terminals~>name )
when(rev  pins=reverse(pins))
;printf("inst %s pins:%L term %L\n" inst~>name pins inst~>master~>terminals~>name )
lapins=foreach(mapcar pin pins
dir=pin~>direction
cond(
(dir=="input"       dir="ipin")
(dir=="output"      dir="opin")
(dir=="inputOutput" dir="iopin")
(t                  dir="iopin")
) list(pin dir));end foreach pin
; printf("lapins:%L\n" lapins)
foreach(lap lapins pin=car(lap) termName=pin~>name
; printf("term%s of net %s not in%L?\n" termName car(setof(term inst~>instTerms term~>name==termName))~>net~>name||"nil" cv~>terminals~>name)
unless(member(car(setof(term inst~>instTerms term~>name==termName))~>net~>name cv~>terminals~>name); on ne rajoute la pin que le terminal n'est pas deja connecte a une pin
aPin = dbOpenCellViewByType("basic" cadr(lap)  "symbol")
XY=cadr(assoc(termName getInstTermPoint(inst)))
iout=N while(member(sprintf(nil "%s_%d" pinName iout) cv~>terminals~>name) iout++)
pinId=schCreatePin( cv aPin sprintf(nil "%s_%d" pinName iout) pin~>direction nil XY "R0")
printf("Create %L\n" pinId~>??)
))
); end foreach
schCheck(cv) ))
; terminal2pin("OUT_1")
; terminal2pin()
printf("terminal2pin(pinName cv termMatchName rev N)\n")
printf("terminal2pin(\"Sync\" nil \"S\");<= toutes les instance selectionne dont les pins ont la lettre S => Sync_1 Sync_2 ... pins \n")
printf("terminal2pin(t t t t 20) ;=> Rejoute des pins OUT_20 OUT_21... a toutes les instances ayant un terminal OUT en commencant a partir de 20\n")
printf("terminal2pin(\"O\" t \"out\" ) ;=> Rajoute des pins O_1 O_2... a toutes les instances ayant un terminal out en commencant a partir de 1\n")

; terminal2pin(t t t t 20) ;=> commence à partir de 20
; terminal2pin("O" t "out" ) ;=> commence à partir de 20

ineed('io2dir)
ineed('terminalGen);<== moved to single file

defun( terminalGen1 (@optional (pins '("pin1" "pin2" "pin3"))) terminalGen(pins  1 1 t t nil nil t nil t))

; terminalGen('("pin1" "pin2" "pin3") 1 1 ) ;=> peut prendre une list. dans ce cat, N1 et N2 sont bidon
; terminalGen('("pin1" "pin2" "pin3") 1 1 t t nil nil t nil t)
; terminalGen('("pin1" "pin2" "pin3") 1 1 '("ipin" "ipin") t nil nil t nil t) ;=> ok


;terminalGen("OUT" 32 1 nil 0.25 t t) ;=> Generate OUT_1->OUT_20 pins

;; gss=geGetSelectedSet()
;; setof(g gss g~>cellName!="noConn"&&g~>cellName)
;; ;; foreach(mapcan g gss if(g~>cellName!="noConn"&&g~>cellName list(g) nil))


unless(fboundp('orientList) load("padRing.proc.il")) ;define also symbolBox


;; inst=css()
;; cv=inst~>cellView
;; inst~>terminals
;; inst~>terminals~>name
;; pat="PA_"

;; gss=css()
;; gss=geGetSelectedSet()

defun(wirePinName (@optional (genConn 'io)(pat nil)(wl nil)(gss geGetSelectedSet())(verb t))
(let (olist ori XYt rot wid nocRot i nocName cv tlist XYL)
cond((type(gss)=='dbobject gss=list(gss))(gss==nil gss=geGetSelectedSet()))
when(genConn=='io 
ioio =dbOpenCellViewByType("basic" "iopin" "symbol")
ioi  =dbOpenCellViewByType("basic" "ipin"  "symbol")
ioo  =dbOpenCellViewByType("basic" "opin"  "symbol"))
wl=cond((wl==nil 0.6)(wl==t 0.3)(t wl))
foreach(inst gss
cv=inst~>cellView
if(pat!=nil then tlist=setof(term inst~>terminals rexMatchp(pat term~>name)) else tlist=inst~>terminals)
;term=car(tlist)
when(verb printf("Treating:%s pr %L in %L\n" pat||"allpins" tlist~>name  gss~>cellName))
when(verb printf("%d-pins to loop\n" length(tlist)))
olist=pinOrient2(inst)
foreach(term tlist
if(car(term~>net~>sigNames)!=term~>name then
ori=assoc(term~>name olist)
XYt=cadr(ori)
rot=caddr(ori)
XYw=dbTransformPoint(wl:0 list(XYt rot 1))
wid=schCreateWire(cv "draw" "direct" list(XYt XYw) 0.0625 0.0625 0)
rotL=cond((rot=="R180" "R0")(rot=="R270" "R90")(t rot))
XYL=dbTransformPoint(0:0.0625 list(centerBox(list(XYt XYw)) rotL 1))
rotP=sprintf(nil "R%d" mod(evalstring(car(parseString(rot "R")))+270 360))
when(verb printf("Create: %s in %L\n" term~>name list(XYt rot)))
when(wid schCreateWireLabel(cv car(wid) XYL term~>name "centerCenter" rotL "euroStyle" 0.0625 nil ));<= when, car bug si ca coupe une autre pin
when(verb printf("Create label: %s in %L\n" term~>name list(XYL XYw)))
cond( (genConn=='io iop=cond((term~>direction=="input" ioi)(term~>direction=="output" ioo)(t ioio))
PIN=schCreatePin(cv iop term~>name "output" nil XYw rot )
; direction de schcreatepin adapt justify du textDisplay seulement => mettre output par defaut
;PIN~>children~>justify="centerCenter"
;PIN~>children~>justify="upperCenter";<= marche pas
; PIN~>children~>xy=PIN~>xy;<= remets par desseus maintenant a deplacer
PIN~>children~>xy=dbTransformPoint(0:0.2 list(PIN~>xy rotP 1))
PIN~>children~>justify="centerLeft"
)
(genConn=='t 
i=0 while(member(sprintf(nil "I%d" i) cv~>instances~>name) i++)
nocRot=sprintf(nil "R%d" mod(evalstring(car(parseString(rot "R")))+90 360))
nocName=sprintf(nil "I%d" i)
dbCreateInstByMasterName(cv "basic" "noConn" "symbol" nocName XYw nocRot)
));genConn
else printf("pin %L allready named-net: %L\n" car(term~>net~>sigNames) term~>name));unless net==pin names
))))

printf("wirePinName();=> create wires with pin ontop of symbol selected\n")
printf("wirePinName(t);=> create wires and noConn\n")
printf("wirePinName(nil);=> create wires only\n")
printf("wirePinName('io \"IN_\");=> create IN_ filtre sur la creation des wire\n")
printf("wirePinName(nil nil 1.2);=> create wireLabel longueur 1.2\n")

;; pp='((-0.15625 10.46875) (-0.15625 10.66875))
;; pt=car(pp)
;; dbTransformPoint(0.2:0 list(0:0 "R90" 1))
;; dbTransformPoint(0.2:0 list(pt "R90" 1))

;; PB => bBox donne la bBox de la selection box. pas le centre de l'enssemble des pins !!
;; => erreur de rotation dans les coins ??
;; => erreur dans la creation du net qui peut couper d'autres pins... sur le haut ou le bas par exemple.


defun( xyDegree (xy) (let (x y pi rest teta)
x=car(xy)*1.0 y=cadr(xy)*1.0 pi=acos(0)*2
if(x==0 then x else
teta=90-90*(x/abs(x))+atan(y/x)*180/pi
rest=teta-floor(teta)
mod(round(teta+360) 360)+rest)
))
;=> donne un resultat entre 0 et 360°

defun( pinOrient (@optional (inst css()) (angle 135))
; inst=css()
; angle=45
foreach(mapcar term getInstTermPoint(inst) 
; term=assoc("IN_16" getInstTermPoint(inst))
center=centerBox(symbolBox(inst)) 
xy=cadr(term)
;rodSubPoints(xy center)
xyDegree(rodSubPoints(xy center) )
sect=mod(floor(xyDegree(rodSubPoints(xy center))+angle)/90 4);<= secteur 0 1 2 ou 3
turn=mod(sect+3 4)
list(car(term) xy sprintf(nil "R%d" 90*turn ))))



defun( pinOrient2 (@optional (inst css()) (tr 3))
; inst=css()
; angle=135
foreach(mapcar term getInstTermPoint(inst) 
;term=assoc("VDD" getInstTermPoint(inst))
sBox=symbolBox(inst)
center=centerBox(sBox)
xy1=cadr(sBox)
xy=cadr(term)
teta=xyDegree(rodSubPoints(xy1 center))
;rodSubPoints(xy center)
xyd=xyDegree(rodSubPoints(xy center))
sect=cond(
( xyd>teta+180 && xyd<=360-teta  0)
( xyd<=teta        1) ; xyd>-teta &&
(xyd>teta && xyd<=180-teta     2)
(xyd<=180+teta && xyd>180-teta 3)
(t 1)
)
turn=mod(sect+tr 4)
list(car(term) xy sprintf(nil "R%d" 90*turn ))))




defun( _2bus (@optional (gss geGetSelectedSet())) underscore2bus(gss))




;; TODO : a modifier pour prendre en compte les pins layout css()~>net~>term~>name="TOTO"
; pour le schematic: css()~>net~>term~>name="TOTO" ;=> nil
; pour le schematic: css()~>pin~>net~>term~>name="TOTO" ;=> nil


defun( underscore2bus (@optional (gss geGetSelectedSet()))
let((lb plb llb ldr debut er nlb)
gss=setof(g gss g~>objType=="label")
foreach(mapcar s gss
;s=car(gss)
lb=s~>theLabel
;lb="A_AA_1"
plb=parseString(lb "_")
llb=car(last(plb))
ldr=reverse(cdr(reverse(plb)))
debut=buildString(ldr "_")
er=errset(evalstring(llb))

; numberp(evalstring(llb)) ;=>> error si pas nombre dans string
if(er then nlb=strcat(debut "<" llb ">") printf("modify %s into %s\n" lb nlb)
s~>theLabel=nlb
else printf("not a number? %L\n" llb)
lb)
)))

defun( bus2_ (@optional (gss geGetSelectedSet()))
foreach(mapcar s setof(g gss g~>objType=="label"||"textDisplay") s~>theLabel=buildString( parseString(s~>theLabel "<>") "_")))


printf("_2bus change les label selectionnes %L en %L\n" '("Vref" "IN_9" "T1_9" "ENA2" "IN_11") '("Vref" "IN<9>" "T1<9>" "ENA2" "IN<11>"))
printf("bus2_ change les label selectionnes %L en %L\n" '("Vref" "IN<9>" "T1<9>" "ENA2" "IN<11>") '("Vref" "IN_9" "T1_9" "ENA2" "IN_11"))

;/!\ schematic
;; css()~>pin~>term~>numBits;=> 2
;; css()~>pin~>term~>name="ZZ<1:2>";=> OK

;; css()~>objType;=> "inst"
;; css()~>pin~>term~>name="TUTU"

; pins=foreach(mapcar x netMakeBus("PTG" '(1 9) t "_") strcat(x "<1:9>"))
;; ("PTG_1<1:9>" "PTG_2<1:9>" "PTG_3<1:9>" "PTG_4<1:9>" "PTG_5<1:9>"
;;     "PTG_6<1:9>" "PTG_7<1:9>" "PTG_8<1:9>" "PTG_9<1:9>"
;; )
; terminalGen(pins 1 1 t 0.125)
