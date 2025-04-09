;ineed('deleteEmptyCellsInstRefs t)
;; copyleft ebecheto

defun(emptyMasterp (@optional (cv nil)) unless(cv cv=geGetWindowCellView()) not(cv~>shapes || cv~>instHeaders || cv~>vias || cv~>rects|| cv~>instances))

;deleteEmptyCellsInstRefs("AIMPORT_FILL5")
;; USAGE : function used to remove the empty fillers in the imported gds generated to comply with DRC coverage

defun(deleteEmptyCellsInstRefs (@optional (libName nil))
let((cells toremove cellView)
unless(libName libName=geGetWindowCellView()~>libName); libName="AIMPORT_FILL4"
cells=ddGetObj(libName)~>cells
;; cell=car(cells)
;; cell=car(setof(cell cells cell~>name== "fill_AAdum"))
foreach(mapcar cell cells 
when(member("layout" cell~>views~>name) cellName=cell~>name
cellView = dbOpenCellViewByType(libName cellName "layout")
;cellView=car(setof(view cell~>views  view~>name=="layout"))
printf(" - look if %L is empty\n" cellName)
when( emptyMasterp(cellView)
;tosave=cellView~>instHeaderRefs
toremove=cellView~>instRefs
printf(" - Remove all %L instanciation of %L into %L-%L\n" length(toremove) cellName cell1 lib1)
foreach(i toremove dbDeleteObject(i))
printf(" - Delete empty object %L\n" list(cellView~>lib~>name cell~>name cellView~>viewName))
ddDeleteObj(ddGetObj(cellView~>lib~>name cell~>name cellView~>viewName))
);end empty cell
);when layout
); foreach cells

;; second loop to save and close all, instead of yousing multiple times instHeaderRefs, althoug would have been more clean
foreach(mapcar cell cells 
when(member("layout" cell~>views~>name) cellName=cell~>name
cellView = dbOpenCellViewByType(libName cellName "layout" "maskLayout" "a")
dbSave(cellView) dbClose(cellView)))
))