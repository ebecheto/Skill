; load("oppres.il")
; foreach(mapcar c cdfGetInstCDF(css())~>parameters evalstring(c->callback||"" ))
update=t;<= Why  evalstring(paramR->callback) method does not work ?
defun( oppresSet ( Rt @optional (inst css()) ) ; oppresSet(1.2M) ou oppresSet("1.2M")
let( (paramL paramW paramRef paramR paramS Rold ratio pourcent)
paramL = cdfFindParamByName( cdfGetInstCDF(inst) "l"); => cdf:
paramW = cdfFindParamByName( cdfGetInstCDF(inst) "w"); => cdf:
paramReff = cdfFindParamByName( cdfGetInstCDF(inst) "reff"); => cdf:
paramR = cdfFindParamByName( cdfGetInstCDF(inst) "r"); => cdf:
paramS = cdfFindParamByName( cdfGetInstCDF(inst) "s"); => cdf:
paramL~>value="1.1u"
paramW~>value="0.32u"
paramS~>value=1;<= needed to update!!

if(update 
then 
foreach(mapcar c cdfGetInstCDF(inst)~>parameters evalstring(c->callback||"" ))
paramReff~>value=evalstring(paramR->callback) 
paramR~>value=aelSuffixNotation(aelNumber(paramReff~>value)/paramS~>value)
else
schHiObjectProperty() hiFormDone(schObjPropForm)
)

printf("RES:%L\n" list( aelNumber(paramW~>value) aelNumber(paramL->value) aelSuffixNotation(aelNumber(paramReff->value)) paramS~>value paramR->value))
; paramReff->value
; inst=css() 
geSelectFig(inst);Si on rentre une instance et non css() il faut la rajouter dans la selection si on utilise schHiObjectProperty() hiFormDone(schObjPropForm)
when(type(Rt)=='string Rt=aelNumber(Rt) )
Rold=aelSuffixNotation(Rt)
; Rold="1.2M" Rt=1.2e6
printf("%s %s will now be of %s Ohm.%L\n" inst~>baseName inst~>cellName Rold list(paramL~>value paramW~>value paramS~>value))

))

printf("oppresSet(1.2M)\n")
