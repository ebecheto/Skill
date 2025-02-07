;; copyleft : ebecheto

; ineed('wirePinName t)
; corrected : schCreatePin(cv iop term~>name term~>direction nil XYw rot ) [OK]
ineed('terminal2pin) ;=> define pinOrient2

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
ori=assoc(term~>name olist);=> ("cfg_discri<895:0>" (1.5625 -0.375) "R0")
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
cond( (genConn=='io 
iop=cond((term~>direction=="input" ioi)(term~>direction=="output" ioo)(t ioio))
PIN=schCreatePin(cv iop term~>name term~>direction nil XYw rot )
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
printf("wirePinName('io \"IN_\");=> create IN_ filtre sur la creation des wire\n")
printf("wirePinName(nil nil 1.2);=> create wireLabel longueur 1.2\n")
