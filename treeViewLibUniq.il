ineed('MyUnique)
defun(isLib (@optional (libName "lojic_130_v2")) car(setof(g_lib  ddGetLibList() g_lib~>name==libName)))
;;not(isLib("tsmc13rf")) ;;not(isLib(inst~>libName))

defun(treeViewLibUniq (@optional (libName "lojic_130_v2") (viewName "symbol") (libName0 "tsmc13rf"))
let((lib cellNames view cv)
;; libName0="tsmc13rf"
;; viewName="symbol"
;; cv=geGetWindowCellView()
;; instances=cv~>instances
;; inst=car(instances)
;; inst~>viewName;=> "symbol"

; remove(nil foreach(mapcar inst instances when((and inst~>libName==libName inst~>viewName==viewName) inst~>cellName)))
;=> ("nmos1vcap" "mimcap_mis" "rnhpoly_mis")

lib=car(setof(g_lib  ddGetLibList() g_lib~>name=="lojic_130_v2")) ;=> dd:0x297bf250

cell=car(lib~>cells)
cellNames=foreach(mapcan cell lib~>cells
view=car(setof(views cell~>views views~>name=="schematic")) ;=> dd:0x2b28d220
when(view
lib~>name;=> "lojic_130_v2"
sheet~>name;=> "schematic"
cv=dbOpenCellViewByType( lib~>name cell~>name view~>name "schematic" "r")
instances=cv~>instances
; list the cellName of specific library or unexisting library
remove(nil foreach(mapcar inst instances when((and (or inst~>libName==libName0 not(isLib(inst~>libName))) inst~>viewName==viewName) inst~>cellName)))
))

MyUnique(cellNames)
)); fin let ; fin defun

printf("treeViewLibUniq(libName viewName libName0)")
printf("treeViewLibUniq( %L %L %L)" "lojic_130_v2" "symbol" "tsmc13rf")