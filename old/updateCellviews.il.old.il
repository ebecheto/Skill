
; ______________________________________________________________________________
defun( updateCellviews (@optional (newLib geGetWindowCellView()~>libName))
let((ddLib cellName updateLib newMast)
; car(setof( inst geGetWindowCellView()~>instances inst~>libName==oldLib))~>master~>??
ddLib=setof(lib ddGetLibList() lib~>name==newLib) ; ddLib~>cells~>name
foreach(mapcar cell car(ddLib~>cells)
;___ oop on every cells in the targetted library _______________________________
; cv=geGetWindowCellView()
cellName=cell~>name
;___ use member before dbOpenCellViewByType to prevent warnings ________________
when(member("schematic" dbAllCellViews(car(ddLib) cellName))
cv=dbOpenCellViewByType( newLib cellName "schematic" "schematic"); oppen in append mode (editable)
updateLib=setof( inst cv~>instances  inst~>libName!=newLib)
foreach(mapcar inst updateLib 
;printf("Not from lib in %L %s %L\n" cv~>cellName newLib inst~>?? )
when(member("symbol" dbAllCellViews(car(ddLib) inst~>cellName))
newMast=dbOpenCellViewByType(newLib inst~>cellName "symbol")  inst~>master=newMast printf("REMASTER : %L\n" inst~>??))
)))))
