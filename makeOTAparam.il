; load("makeOTAparam.il")
load("abInvokeCdfCallbacks.il")

; (4.29u-26.24n*pPar("Voff")/3.3m) M
; 4.29u-26.24n*%s/3.3m M
cvp=dbOpenCellViewByType( "LARZIC_32" "OTA_pPar" "schematic" "schematic" "r")
cvs=dbOpenCellViewByType( "LARZIC_32" "OTA_pPar" "symbol" "schematicSymbol" "r")

newRlist='("1.5m" "3m" "6m" "12m" "24m" "48m")
newRlist='("-1.5m" "-3m" "-6m" "-12m" "-24m" "-48m")
newRlist='("-0.75m" "0.75m")
newRlist='("-96m" "96m")
newRlist='("-192m" "192m")
newRlist='("-384m" "384m")
newRlist='("-768m" "768m")

; newR="1.5m"
foreach( newR newRlist
cellName=strcat(cvp~>cellName "_" newR)

when(cvss=dbCopyCellView( cvs cvs~>libName cellName "symbol")
dbSave(cvss) dbClose(cvss) printf("copy symbol\n"))

when(cv=dbCopyCellView( cvp cvp~>libName cellName cvp~>cellViewType)

inst=car(setof(c cv~>instances c~>baseName=="R7"))
propR=car(setof( c cdfGetInstCDF(inst)~>parameters c->name=="r" ))
propR->value=sprintf(nil "%g" evalstring(sprintf(nil "40K+1*%s/3.3m*1K" newR)))
abInvokeInstCdfCallbacks(inst ?order list("r"))

cellName=strcat(cvp~>cellName "_" newR)
inst=car(setof(c cv~>instances c~>baseName=="R6"))
propR=car(setof( c cdfGetInstCDF(inst)~>parameters c->name=="r" ))
propR->value=sprintf(nil "%g" evalstring(sprintf(nil "40K-1*%s/3.3m*1K" newR)))
abInvokeInstCdfCallbacks(inst ?order list("r"))

newList=list("MN12" "MN25" "MN28")
;newL=car(newList)
foreach(newL newList
cellName=strcat(cvp~>cellName "_" newR)
inst=car(setof(c cv~>instances c~>baseName==newL))
propR=car(setof( c cdfGetInstCDF(inst)~>parameters c->name=="l" ))
propR->value=sprintf(nil "%g" evalstring(sprintf(nil "4.29u-26.24n*%s/3.3m" newR)))
abInvokeInstCdfCallbacks(inst ?order list("l"))
)
dbSave(cv)
dbClose(cv)
)
)

dbClose(cvp)


