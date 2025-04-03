ineed('(geOpenOrRaisecv))
defun(copyFromToPurge (dbFrom libName cellName viewName @optional (raise t)) let((INTO viewType)
"erase create copy of a cell into another one and purge if existe, warning, dangerous erase forced"
;dbFrom=dbOpenCellViewByType( "picmic0_master" "VFE_CAP" "schematic" "schematic" "r");<= open read
viewType=case(viewName ("layout" "maskLayout" ) ("schematic" "schematic") ("symbol" "schematicSymbol") ( t "netlist"));=> "schematicSymbol"
INTO=dbOpenCellViewByType(libName cellName viewName viewType "w");<= open write
;; libName=INTO~>libName;=> "picmic0_master"
;; cellName=INTO~>cellName;=> "RO_B"
;; cellViewType=INTO~>cellViewType;=> "schematic"
; viewName=INTO~>viewName
when(INTO dbPurge(INTO))
cvs=dbCopyCellView(dbFrom libName cellName viewName nil nil t);<= last t overwrite
dbSave(cvs)
when(raise 
cvs=dbOpenCellViewByType(libName cellName viewName nil "a");<= open read/append
geOpenOrRaisecv(cvs))
cvs))


;; dbFrom=dbOpenCellViewByType( "picmic0_master" "VFE_CAP" "symbol" nil "r");<= open read
;; copyFromToPurge(dbFrom "picmic0_master" "RO_D" "symbol" t)
;; copyFromToPurge(dbFrom "picmic0_master" "RO_D" "schematic" t)


