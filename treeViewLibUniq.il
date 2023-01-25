;ineed('treeViewLibUniq t)
;treeViewLibUniq()

ineed('MyUnique)
defun(isLib (@optional (libName "lojic_130_v2")) car(setof(g_lib  ddGetLibList() g_lib~>name==libName)))
;;not(isLib("tsmc13rf")) ;;not(isLib(inst~>libName))



defun(treeViewLibUniq (@optional (libName "lojic_130_v2") (libName0 "tsmc13rf") (viewName nil) (checkLib t))
let((lib cellNames view cv)
"return a list of all cellName in the library that corresponds to the chosen library. Optionally one can chose to see also the element not defined in the library with checkLib feature"
unless(viewName viewName="symbol")
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
remove(nil foreach(mapcar inst instances when((and (or inst~>libName==libName0 if(checkLib not(isLib(inst~>libName)) nil)) inst~>viewName==viewName) inst~>cellName)))
))

MyUnique(cellNames)
)); fin let ; fin defun
printf("treeViewLibUniq(\"lojic_130_v2\" nil) ;=> chech in library unknown symbols")
printf("treeViewLibUniq(libName libName0 viewName checkLib)")
printf("treeViewLibUniq( %L %L %L);<= check in library lojic_... tsmc and unknown symbol" "lojic_130_v2" "tsmc13rf" "symbol")
printf("treeViewLibUniq( %L %L %L nil);<= check in library lojic_... tsmc symbols " "lojic_130_v2" "tsmc13rf" "symbol")

;=> ("nmos1v_mis" "rnhpoly_mis" "TX_SLVS_VCM_low_v2B_mis" "INVD24" "mimcap_mis" "rnlpoly_mis" "pmos1v_mis" "mos_var" "spiral_sym" "INVD2" "BUFFLVTD2" "rphripoly_mis" "rphpoly_mis" "nmos1vdnw_mis_dfm" "nmos1vlvt_mis" "diodep" "dioden" "nmos2v" "nmos1vhvt" "rphpoly" "pmos2v" "rm1" "rm2" "nmos1vcap" "ND2D1" "ND3D1" "IND2D1" "AN2D0" "OR2D0" "BUFFD0" "BUFTD0" "INVD0" "DFCNLVTD2" "MUX2LVTD2" "spi_tb_top" "mimcap" "BUFFLVTD24" "BUFFLVTD12" "BUFFLVTD6" "INVD4" "MUX4LVTD2" "AN2LVTD2" "MUX3LVTD2" "nmos1v" "pmos1v" "spi_tb" "PDB3A" "PVSS2AC" "PVDD3AC" "spi")