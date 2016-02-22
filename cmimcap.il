;; copyleft ebecheto
; load("cmimcap.il")
; foreach(mapcar c cdfGetInstCDF(css())~>parameters evalstring(c->callback||"" ))
defun( cmimFix (@optional (inst css() )) let((val) 
val=cdfFindParamByName( cdfGetInstCDF(inst) "c")~>value
when(and(val val!="") cmimSet(val inst))
))


defun( cmimSet ( Ct @optional (inst css()) (pourcent 0.0001)) ; oppresSet(1.2M) ou oppresSet("1.2M")
let( (paramL paramW paramCef paramC paramS Cold ratio minW minL maxWL calls cdfgData)
when(and( inst Ct) cdfgData=cdfGetInstCDF(inst)
printf("Ct : %L\n" Ct)
; maxL=maxW=1000u, mais 1000u*1000u not allowds (w*l<=100000)=> if w=l, maxW=maxL=sqrt(100000)=316.2278, let say 316.22
when(type(Ct)=='string Ct=aelNumber(Ct) ) Cold=aelSuffixNotation(Ct) ; Cold="1.2M" Ct=1.2e6
printf("%s %s WILL NOW be of %s Farad.\n" inst~>baseName inst~>cellName Cold )
maxWL="316.22u" minL="4u" minW=minL
calls="cmhv7sfmimGeom() cmhv7sfmimCap() cmhv7sfmimLength() cmhv7sfmimWidth() cmhv7sfmimGeom() cmhv7sfmimHD() cmhv7sfmimHD()"
if(!inst then printf("please select a compenent\n") else
paramL = cdfFindParamByName( cdfGetInstCDF(inst) "l"); => Length
paramW = cdfFindParamByName( cdfGetInstCDF(inst) "w"); => Width
paramCeff = cdfFindParamByName( cdfGetInstCDF(inst) "ceff"); => ceff=c*m
paramC = cdfFindParamByName( cdfGetInstCDF(inst) "c"); => cdf:
paramM = cdfFindParamByName( cdfGetInstCDF(inst) "m"); => Multiplicity
paramL~>value=minL
paramW~>value=minW
paramM~>value=1;<= ^^^ needed to update!!
evalstring(calls);<== updating ?
paramCeff~>value=evalstring(paramC->callback)
paramC~>value=aelSuffixNotation(aelNumber(paramCeff~>value)/paramM~>value)
printf("CAP:%g %L\n" pourcent list( aelNumber(paramW~>value) aelNumber(paramL->value) aelSuffixNotation(aelNumber(paramCeff->value)) paramC->value paramM->value))
printf("%s %s will now be of %s Farad.%L\n" inst~>baseName inst~>cellName Cold list(paramL~>value paramW~>value paramM~>value))
when(aelNumber(paramL~>value)<aelNumber(minL) paramL~>value=minL)
when(aelNumber(paramW~>value)<aelNumber(minW) paramL~>value=minW)
when(aelNumber(paramL~>value)>aelNumber(maxWL) paramL~>value=maxWL)
when(aelNumber(paramW~>value)>aelNumber(maxWL) paramL~>value=maxWL)
; suppose paramM~>value=1 then increase L
while((and aelNumber(paramCeff->value)<=aelNumber(Cold) aelNumber(paramL->value)<(aelNumber(maxWL)/1.1414))
evalstring(calls);<== updating ?
paramL~>value=aelSuffixNotation(aelNumber(paramL->value)*1.414); sqrt(2)
paramW~>value=paramL~>value
paramCeff~>value=evalstring(paramC->callback)
paramC~>value=aelSuffixNotation(aelNumber(paramCeff~>value)/paramM~>value)
printf("Reff=%L<%L L=%L\n" paramCeff->value Cold paramL->value )
);end while
;=> augmenter paramM
ratio=ceiling(aelNumber(Cold)/aelNumber(paramCeff->value))
paramM~>value=paramM~>value*ratio
printf("increasing Multiplicity bar by %d_%s %s\n" ratio Cold paramCeff->value)
evalstring(calls)
paramCeff~>value=evalstring(paramC->callback)
paramC~>value=aelSuffixNotation(aelNumber(paramCeff~>value)/paramM~>value)

; fonction recursive
defun( dichoCap (L1 L2 @optional (stop 0)) ; dichotomie algorithm; keyword dicotomie dicothomie
let(( m R) stop++
m=(L2+L1)/2
printf("L1=%s L2=%s m=%s Ct=%s C=%s\n" aelSuffixNotation(L1) aelSuffixNotation(L2) aelSuffixNotation(m) aelSuffixNotation(Ct) aelSuffixNotation(aelNumber(paramCeff->value)))
if((or (L2-L1)/L2<=pourcent stop>=20) then when(stop>=20 printf("STOPED.")) printf("%g<%g?\n" (L2-L1)/L2 pourcent ) ; stop here
else
paramL~>value=aelSuffixNotation(m)
paramW~>value=paramL~>value
evalstring(calls)
paramCeff~>value=evalstring(paramC->callback)
paramC~>value=aelSuffixNotation(aelNumber(paramCeff~>value)/paramM~>value)
C=aelNumber(paramCeff->value)
if(C>Ct then printf("dichoCap(%g %g)\n" L1 m)
dichoCap(L1 m stop); on iter a gauche
else printf("dichoCap(%g %g)\n" m L2)
dichoCap(m L2 stop); on iter a droite
))))

dichoCap(aelNumber(minL) aelNumber(paramL->value)*1.1414)
;=> augmenter W ou diminuer paramS... le choix de W est laisse a l'utilisateur.

when(not(and(
Ct*(1-pourcent)<aelNumber(paramCeff~>value)
aelNumber(paramCeff~>value)<=Ct*(1+pourcent)
))
printf("** Minimum cap reached %g< %g < %g. put them in series **\n" Ct*(1-pourcent) aelNumber(paramCeff~>value) Ct*(1+pourcent) ))

;; info sur inst  selection
list(;renvoie les valeurs finale pour verifier
aelNumber(paramW~>value)
aelNumber(paramL->value)
aelSuffixNotation(aelNumber(paramCeff->value))
paramC->value
)))))
printf("cmimSet(1.2p)\n")
; oppresSet(1.2M) ou oppresSet("1.2M")
