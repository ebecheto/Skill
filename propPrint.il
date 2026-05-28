;ineed('propPrint t)

defun( propPrint (@optional (insts geGetSelectedSet()))
unless(insts insts=geGetWindowCellView()~>instances)
foreach(mapcar inst insts
params=(cdfGetInstCDF inst)~>parameters
foreach(mapcar prop inst~>prop 
parm=car(setof(param params param~>name==prop~>name)) ;parm~>??
list(prop~>object~>cellName parm~>prompt prop~>name prop~>value parm~>callback))
;list(parm~>prompt prop~>name prop~>value parm~>callback))
)


;; inst=css()
;; inst~>prop;=> (db:0x58ba8f33 db:0x58ba8f5c db:0x58ba8f5f db:0x58ba8f5d db:0x58ba8f5b db:0x58ba8f5a db:0x58ba8f59 db:0x58ba8f58 db:0x58ba8f57 db:0x58ba8f54 db:0x58ba8f53 db:0x58ba8f52 db:0x58ba8f51)
;; prop=car(inst~>prop)
;; prop~>??
;; ;=> (db:0x58ba8f33 cellView db:0x58ba8e9a objType "prop" prop nil enum nil name "r" object db:0x58ba791a range nil value "15189.5" valueType "string" assocTextDisplays nil)
;; inst~>prop~>assocTextDisplays

;; inst~>prop~>name
;; ;=> ("r" "shapeType" "calcMethod" "rsh" "rtot" "rstrip" "encnxs" "encnxe" "encnx" "DoNotUse" "w" "l" "lstrip")
;; rtot=dbFindProp(inst "rtot")
;; rtot~>??;=> (db:0x58ba8f5b cellView db:0x58ba8e9a objType "prop" prop nil enum nil name "rtot" object db:0x58ba791a range nil value "iPar(\"r\")/iPar(\"m\")" valueType "string" assocTextDisplays nil)
;; rtot~>object~>??

;; inst=css()
;; cdfgData=(cdfGetInstCDF inst)
;; foreach(mapcar param cdfgData~>parameters list(param~>name param~>value)) ;=> too much, loop on prop first


;; prop=car(inst~>prop);=> db:0x58ba8f33
;; params=(cdfGetInstCDF inst)~>parameters
;; foreach(mapcar prop inst~>prop 
;; parm=car(setof(param params param~>name==prop~>name)) ;parm~>??
;; list(prop~>object~>cellName parm~>prompt prop~>name prop~>value parm~>callback))

;=> (description nil callback "XpcResCB()" choices nil data cdf:0x33bc2908 defValue "32.3133K" display "t" dontSave nil editable "XfabFormGetParValue( 'calcMethod )==\"Resistance\"" formField stringStruct@0x2c745470 id db:0x58ba791a name "r" paramType "string" parseAsCEL t parseAsNumber t prompt "Device Resistance" units "resistance" storeDefault nil type "instData" use nil value "15189.5")

;; parm~>??
;; prop~>object~>cellName
;=> (db:0x58ba791a cellView db:0x58ba8e9a objType "inst" prop (db:0x58ba8f33 db:0x58ba8f5d db:0x58ba8f5b db:0x58ba8f5a db:0x58ba8f59 db:0x58ba8f58 db:0x58ba8f57 db:0x58ba8f54 db:0x58ba8f53 db:0x58ba8f52 db:0x58ba8f51) bBox ((-0.25625 1.2125) (0.85625 1.8)) children nil groupMembers nil isAnyInst t isShape nil matchPoints nil net nil parent nil pin nil purpose "cell" textDisplays nil assocTextDisplays nil markers nil figGroup nil baseName "R1" cellName "rnp1h" instHeader db:0x58ba8e21 instTerms (db:0x58ba6f9b db:0x58ba6f9a) libName "PRIMLIB" master db:0x3e66229a name "R1" numInst 1 viewName "symbol" conns (db:0x58ba6f9b db:0x58ba6f9a) mag 1.0 orient "R180" status nil transform ((0.3125 1.3125) "R180" 1.0) xy (0.3125 1.3125) cluster nil blockages nil physOnly nil source "netlist")
;=> (db:0x58ba8f33 cellView db:0x58ba8e9a objType "prop" prop nil enum nil name "r" object db:0x58ba791a range nil value "15189.5" valueType "string" assocTextDisplays nil)
;=> (description nil callback "XpcResCB()" choices nil data cdf:0x33bc2908 defValue "10u" display nil dontSave nil editable "XfabFormGetParValue( 'calcMethod )==\"Strip Length\" " formField stringStruct@0x2c7454d0 id db:0x58ba791a name "lstrip" paramType "string" parseAsCEL t parseAsNumber t prompt "Strip Length" units "lengthMetric" storeDefault nil type "instData" use nil value "18.1u")
