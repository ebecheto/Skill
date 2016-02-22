;; copyleft ebecheto

; load("oppres.il")
; foreach(mapcar c cdfGetInstCDF(css())~>parameters evalstring(c->callback||"" ))
; this is a function to apply only to cmhv7sf resistors. : technology specific. oprppresx oprppres opppcresx opnpcresx opnpcres
; Min and max 1.1u 10000u could be addapted for other types
; ie : k1res 5u<w<30u  3.44u<l<1000u  ; todo later

load("abMute.il")
defun( oppresFix (@optional (inst css() )) let((val)
val=cdfFindParamByName( cdfGetInstCDF(inst) "r")~>value when(val oppresSet(val inst))))

defun( oppresSet ( Rt @optional (inst css()) (pourcent 0.0001)) ; oppresSet(1.2M) ou oppresSet("1.2M")
let( (paramL paramW paramRef paramR paramS Rold ratio minL minW maxL maxW)
minL="1.1u" minW="0.32u" maxL="1000u" maxW="1000u"
if(!inst then printf("please select a compenent\n") else  abMute(
cdfgData = cdfGetInstCDF(css());<== doit-t-on forcer l'existance globle de la variable cdfgData ??
cdfgData = cdfGetInstCDF(inst);<== doit-t-on forcer l'existance globle de la variable cdfgData ??
paramL = cdfFindParamByName( cdfGetInstCDF(inst) "l"); => cdf:
paramW = cdfFindParamByName( cdfGetInstCDF(inst) "w"); => cdf:
paramReff = cdfFindParamByName( cdfGetInstCDF(inst) "reff"); => cdf:
paramR = cdfFindParamByName( cdfGetInstCDF(inst) "r"); => cdf:
paramS = cdfFindParamByName( cdfGetInstCDF(inst) "s"); => cdf:
paramP = cdfFindParamByName( cdfGetInstCDF(inst) "pbar"); => parallel bars
paramL~>value=minL
paramW~>value=minW
paramP~>value=1
paramS~>value=1;<= ^^^ needed to update!!
foreach(mapcar c cdfGetInstCDF(inst)~>parameters evalstring(c->callback||"" ))
paramReff~>value=evalstring(paramR->callback)
paramR~>value=aelSuffixNotation(aelNumber(paramReff~>value)/paramS~>value)
printf("RES:%g %L\n" pourcent list( aelNumber(paramW~>value) aelNumber(paramL->value) aelSuffixNotation(aelNumber(paramReff->value)) paramS~>value paramR->value))
; paramReff->value
; inst=css() 
geSelectFig(inst);Si on rentre une instance et non css() il faut la rajouter dans la selection si on utilise schHiObjectProperty() hiFormDone(schObjPropForm)
when(type(Rt)=='string Rt=aelNumber(Rt) )
Rold=aelSuffixNotation(Rt)
; Rold="1.2M" Rt=1.2e6
printf("%s %s will now be of %s Ohm.%L\n" inst~>baseName inst~>cellName Rold list(paramL~>value paramW~>value paramS~>value))
when(aelNumber(paramL~>value)<aelNumber(minL) paramL~>value=minL)
when(aelNumber(paramW~>value)<aelNumber(minW) paramL~>value=minW)
when(aelNumber(paramL~>value)>aelNumber(maxL) paramL~>value=maxL)
when(aelNumber(paramW~>value)>aelNumber(maxW) paramL~>value=maxW)
; suppose paramS~>value=1 then increase L
while((and aelNumber(paramReff->value)<=aelNumber(Rold) aelNumber(paramL->value)<(aelNumber(maxL)/2)) 
paramL~>value=aelSuffixNotation(aelNumber(paramL->value)*2)
foreach(mapcar c cdfGetInstCDF(inst)~>parameters evalstring(c->callback||"" ))
paramReff~>value=evalstring(paramR->callback)
paramR~>value=aelSuffixNotation(aelNumber(paramReff~>value)/paramS~>value)
;printf("Reff=%L<%L L=%L eval=%L\n" paramReff->value Rold paramL->value foreach(mapcar c cdfGetInstCDF(inst)~>parameters evalstring(c->callback||"" )))
);end while
;=> augmenter paramS
ratio=ceiling(aelNumber(Rold)/aelNumber(paramReff->value))
paramS~>value=paramS~>value*ratio
; printf("increasing Series bar by %d_%s %s\n" ratio Rold paramReff->value)
foreach(mapcar c cdfGetInstCDF(inst)~>parameters evalstring(c->callback||"" ))
paramReff~>value=evalstring(paramR->callback)
paramR~>value=aelSuffixNotation(aelNumber(paramReff~>value)/paramS~>value)

; fonction recursive
defun( dichoL (L1 L2 @optional (stop 0)) ; dichotomie algorithm; keyword dicotomie dicothomie
let(( m R) stop++
m=(L2+L1)/2
printf("L1=%s L2=%s m=%s Rt=%s R=%s\n" aelSuffixNotation(L1) aelSuffixNotation(L2) aelSuffixNotation(m) aelSuffixNotation(Rt) aelSuffixNotation(aelNumber(paramReff->value)))
if((or (L2-L1)/L2<=pourcent stop>=20) then when(stop>=20 printf("STOPED.")) printf("%g<%g?\n" (L2-L1)/L2 pourcent ) ; stop here
else
paramL~>value=aelSuffixNotation(m)
foreach(mapcar c cdfGetInstCDF(inst)~>parameters evalstring(c->callback||"" ))
paramReff~>value=evalstring(paramR->callback)
paramR~>value=aelSuffixNotation(aelNumber(paramReff~>value)/paramS~>value)
R=aelNumber(paramReff->value)
if(R>Rt then printf("dichoL(%g %g)\n" L1 m)
dichoL(L1 m stop); on iter a gauche
else printf("dichoL(%g %g)\n" m L2)
dichoL(m L2 stop); on iter a droite
))))

;=> augmenter W ou diminuer paramS... le choix de W est laisse a l'utilisateur.

if((and Rt<aelNumber(paramReff~>value) paramS~>value==1)
then
ratio=ceiling(aelNumber(paramReff->value)/Rt)+1
printf("Is ratio enough ? %d %s %s" ratio paramReff->value Rold )
paramP~>value=paramP~>value*ratio
foreach(mapcar c cdfGetInstCDF(inst)~>parameters evalstring(c->callback||"" ))
paramReff~>value=evalstring(paramR->callback)
paramR~>value=paramReff~>value
dichoL(aelNumber(minL) aelNumber(paramL->value)*2)
else
dichoL(aelNumber(paramL->value)/2 aelNumber(maxL))
)

;; info sur inst  selection
list(;renvoie les valeurs finale pour verifier
aelNumber(paramW~>value)
aelNumber(paramL->value)
aelSuffixNotation(aelNumber(paramReff->value))
paramS~>value
paramR->value
)))))
printf("oppresSet(1.2M)\n")
; oppresSet(1.2M) ou oppresSet("1.2M")
