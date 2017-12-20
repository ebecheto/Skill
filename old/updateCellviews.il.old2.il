; newLib="T2K_V5_TRSLT"
; newLib="CPE_correction"
defun( updateCellviews (@optional (newLib geGetWindowCellView()~>libName))
let((ddLib cellName updateLib newMast) ddLib=ddGetObj(newLib)
printf("REMASTER Lib: %L\n" newLib)
foreach(cell ddLib~>cells cellName=cell~>name
when(member("schematic" dbAllCellViews(ddLib cellName)) cv=dbOpenCellViewByType( newLib cellName "schematic" "schematic")
updateLib=setof( inst cv~>instances inst~>libName!=newLib)
foreach(inst updateLib 
when(member("symbol" dbAllCellViews(ddLib inst~>cellName))
newMast=dbOpenCellViewByType(newLib inst~>cellName "symbol")  inst~>master=newMast printf("REMASTER : %L\n" inst~>??))
))) t))
; updateCellviews(newLib)

; renome les elements present dans une Lib a cette lib, utile quand copie de lib n'afffecte pas les elements a la lib en question.
defun( updateCellviewsL (@optional (newLib geGetWindowCellView()~>libName))
let((ddLib cellName updateLib newMast) ddLib=ddGetObj(newLib)
foreach(cell ddLib~>cells cellName=cell~>name
when(member("layout" dbAllCellViews(ddLib cellName)) cv=dbOpenCellViewByType( newLib cellName "layout")
updateLib=setof( inst cv~>instances inst~>libName!=newLib)
foreach(inst updateLib 
when(member("layout" dbAllCellViews(ddLib inst~>cellName))
newMast=dbOpenCellViewByType(newLib inst~>cellName "layout")  inst~>master=newMast printf("REMASTER : %L\n" inst~>??))
))) t))


; remaster vias into the good tech
defun( updateCellviewsV (@optional (newLib geGetWindowCellView()~>libName) (libList '("TECH_C35B4")))
let((ddLib cellName updateLib newMast ddlibList)
ddLib=ddGetObj(newLib) 
ddlibList=foreach(mapcar x libList ddGetObj(x))
foreach(cell ddLib~>cells cellName=cell~>name
when(member("layout" dbAllCellViews(ddLib cellName)) cv=dbOpenCellViewByType( newLib cellName "layout")
updateLib=setof( inst cv~>instances inst~>libName!=newLib)
foreach(inst updateLib
foreach(tekLib ddlibList
when(member("layout" dbAllCellViews(tekLib inst~>cellName))
newMast=dbOpenCellViewByType(tekLib~>name inst~>cellName "layout")  inst~>master=newMast printf("REMASTER : %L\n" inst~>??))
)))) t))


defun( updateCellviewsC (@optional (newLib geGetWindowCellView()~>libName))
let((ddLib cellName updateLib newMast cvl cvs cnt) cnt=0
printf("Check and Save all lib:%s\n" newLib)
ddLib=ddGetObj(newLib)
foreach(cell ddLib~>cells cellName=cell~>name
when(member("schematic" dbAllCellViews(ddLib cellName)) cvs=dbOpenCellViewByType( newLib cellName "schematic" "schematic" "a")
when(cvs  schCheck(cvs) dbSave(cvs)  dbClose(cvs) cnt++))
when(member("layout"    dbAllCellViews(ddLib cellName)) cvl=dbOpenCellViewByType( newLib cellName "layout" "maskLayout" "a") 
when(cvl dbCheck(cvl) dbSave(cvs) dbClose(cvl) cnt++))
) printf("Checked %d cells\n" cnt ) ))


;; defun( updateCellviews (@optional (newLib geGetWindowCellView()~>libName))
;; let((ddLib cellName updateLib newMast)
;; ; car(setof( inst geGetWindowCellView()~>instances inst~>libName==oldLib))~>master~>??
;; ddLib=setof(lib ddGetLibList() lib~>name==newLib) ; ddLib~>cells~>name
;; foreach(mapcar cell car(ddLib~>cells)
;; ; cv=geGetWindowCellView()
;; cellName=cell~>name
;; when(member("schematic" dbAllCellViews(car(ddLib) cellName))
;; cv=dbOpenCellViewByType( newLib cellName "schematic" "schematic"); oppen in append mode (editable)
;; updateLib=setof( inst cv~>instances  inst~>libName!=newLib)
;; foreach(mapcar inst updateLib 
;; ;printf("Not from lib in %L %s %L\n" cv~>cellName newLib inst~>?? )
;; when(member("symbol" dbAllCellViews(car(ddLib) inst~>cellName))
;; newMast=dbOpenCellViewByType(newLib inst~>cellName "symbol")  inst~>master=newMast printf("REMASTER : %L\n" inst~>??))
;; ))) t))
;; ; updateCellviews(newLib)
