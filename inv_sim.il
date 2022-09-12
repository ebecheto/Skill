;; source /pbs/throng/omme/bin/tsmc65n_grid
;load("nmos_sim.il")
; ineed('nmos_sim t)
ineed('(geOpenOrRaisecv rexFindCell terminalGen createInstPinsch getInstTermPoint getPropList))
;unless(rexFindCell("nmos_sim" '("TSMC65_ebecheto" )) )
;;unless(dbOpenCellViewByType( "TSMC65_ebecheto" "nmos_sim" "schematic" "" "r")

;; NOT FINISHED AT ALL
;; CREATE FIRST inv_schematic & symbol instead of inv_sim

;(setq npmoslib '(("nch" "pch") "tsmcN65"));=> (("nch" "pch") "tsmcN65")
(setq npmoslib '(("nmos" "pmos") "SG13_dev"));=> (("nch" "pch") "tsmcN65")

defun(inv_sim (@optional (cv nil) (npmoslib '(("nch" "pch") "tsmcN65"))
let((XY v1 param itp Pxy win v2 Sxy Bxy Gxy Dxy win libname nmos pmos nplib)
nmos=caar(npmoslib);=> "nch";=> "nmos"
pmos=cadar(npmoslib);=> "pch";=> "pmos"
nplib=cadr(npmoslib);=> "tsmcN65";=> "SG13_dev"
unless(cv 
libName=strcat(env("PRJ_NAME")||"design" "_" env("USER"));=> "ihp130_ebecheto"
if(
car(setof(lib ddGetLibList() lib~>name==libname))
then
cv=dbOpenCellViewByType(strcat(env("PRJ_NAME")||"design" "_" env("USER")) strcat("inv" "_sim") "schematic" "schematic" "w")
else
cv=geGetWindowCellView()
))

;cv=dbOpenCellViewByType( "TSMC65_ebecheto" "nmos_sim" "schematic" "schematic" "w");<= modifiable

XY=0:0
v1=dbCreateInstByMasterName(cv "analogLib" "vdc" "symbol" "V1" rodAddPoints(XY 0:0) "R0")
param=cdfFindParamByName( cdfGetInstCDF(v1) "vdc") param~>value="vgs"
dbCreateInstByMasterName(cv "analogLib" "gnd" "symbol" nil rodAddPoints(XY 0:-0.375) "R0")
itp=getInstTermPoint(v1) 
Pxy=cadr(assoc("PLUS" itp));=> (0.0 0.0)

wid=schCreateWire( cv "draw" "direct" list(Pxy rodAddPoints(Pxy 0:0.25)) 0.0625 0.0625 0.0125)
schCreateWireLabel(cv car(wid) rodAddPoints(Pxy -0.05:0.125) "vgs" "centerCenter" "R90" "euroStyle" 0.0625 nil)


XY=2:0
v2=dbCreateInstByMasterName(cv "analogLib" "vdc" "symbol" "V2" rodAddPoints(XY 0:0) "R0")
param=cdfFindParamByName( cdfGetInstCDF(v2) "vdc") param~>value="vds"
dbCreateInstByMasterName(cv "analogLib" "gnd" "symbol" nil rodAddPoints(XY 0:-0.375) "R0")
itp=getInstTermPoint(v2)
Pxy=cadr(assoc("PLUS" itp));=> (2.0 0.0)
wid=dbCreateLine( cv '("wire" "drawing")  list(Pxy rodAddPoints(Pxy 0:.25)))
label=dbCreateLabel(cv '("wire" "label") rodAddPoints(Pxy -0.125:0.125) "vds" "centerCenter" "R0" "euroStyle" 0.0625 )
label~>parent=wid
XY=1:0
inst=dbCreateInstByMasterName(cv lib nmos "symbol" "M1" rodAddPoints(XY 0:0) "R0")
; getPropList(inst)
pp='(("l" "string" "1u") ("w" "string" "400n"))
foreach(mapcar p pp param=cdfFindParamByName(cdfGetInstCDF(inst) car(p)) param~>value=nth(2 p))

itp=getInstTermPoint(inst) ;=> (("S" (1.25 -0.1875) ("pin" "drawing") ((1.225 -0.2125) (1.275 -0.1625))) ("G" (1.0 0.0) ("pin" "drawing") ((0.975 -0.025) (1.025 0.025))) ("B" (1.25 0.0) ("pin" "drawing") ((1.225 -0.025) (1.275 0.025))) ("D" (1.25 0.1875) ("pin" "drawing") ((1.225 0.1625) (1.275 0.2125))))
dbCreateInstByMasterName(cv "analogLib" "gnd" "symbol" nil rodAddPoints(XY 0.25:-0.1875) "R0")

aitp=assoc("S" itp);=> ("S" (1.25 -0.1875) ("pin" "drawing") ((1.225 -0.2125) (1.275 -0.1625)))
Sxy=cadr(aitp);=> (1.25 -0.1875)
Bxy=cadr(assoc("B" itp));=> (1.25 0.0)
Gxy=cadr(assoc("G" itp));=> (1.0 0.0)
Dxy=cadr(assoc("D" itp));=> (1.25 0.1875)

wid=schCreateWire( cv "draw" "direct" list(Sxy Bxy) 0.0625 0.0625 0)
wid=schCreateWire( cv "draw" "direct" list(Gxy rodAddPoints(Gxy -0.25:0)) 0.0625 0.0625 0)
schCreateWireLabel(cv car(wid) rodAddPoints(Gxy -0.125:0.05) "vgs" "centerCenter" "R0" "euroStyle" 0.0625 nil)
wid=schCreateWire( cv "draw" "direct" list(Dxy rodAddPoints(Dxy 0:.25)) 0.0625 0.0625 0)
schCreateWireLabel(cv car(wid) rodAddPoints(Dxy -0.125:0.125) "vds" "centerCenter" "R0" "euroStyle" 0.0625 nil)

;; TO BE CONTINUED

win=geOpenOrRaisecv(cv)
)
)

;libmos=nth(1 rexFindCell("nmos4"))
;libmos=car(rexFindCell("nmos4"))
;libmos=nth(2 rexFindCell("nmos"));=> ("techno_blabla" "nmos")
;;libmos=car(rexFindCell("nch"))
;libmos=car(rexFindCell("MOS_N3"))

;nmos_sim(nil nth(1 libmos) nth(0 libmos) )

printf("USAGE : identify the transistor you want : nmos nmos4 nch nfet MOS_N3\n")
printf("USAGE : check correct library you want rexFindCell(\"nmos4\")\n")
printf("USAGE : if second Find is OK, define libmos=nth(1 rexFindCell(\"nmos4\"))\n")
printf("USAGE : if second Find is OK, define libmos=nth(0 rexFindCell(\"^nch$\"))\n")
printf("USAGE : nmos_sim(nil nth(1 libmos) nth(0 libmos) )\n")
