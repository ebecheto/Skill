;; copyleft ebecheto

;load("hexagone.tricot.il")
;load("~/Skill/hexagone.tricot.il")
;create hexagon pads in an opended layout. based on ams drawing layers.

cv=geGetWindowCellView()
when(cv~>viewName!="layout" lib1=car(sort(setof(lib ddGetLibList() lib~>isWritable)~>name nil))
lib1="picmic0_master"
cv=dbOpenCellViewByType(lib1 "hexagoneTricot"  "layout" "maskLayout" "a"))
tech = techGetTechFile(cv)

via3="ML_M5_2"
via2="M5_M4_S"
via1="M4_M3_S"

MET1="MET1"
MET2="MET2"
MET3="MET3"

viat3 = techFindViaDefByName(tech via3)
viat2 = techFindViaDefByName(tech via2)
viat1 = techFindViaDefByName(tech via1)
;; via1 = dbCreateVia(cv viat1 list(5 5) "R0")
;; via2 = dbCreateVia(cv viat2 list(5 5) "R0")
;; via3 = dbCreateVia(cv viat3 list(5 5) "R0")



unless(fboundp('createHexagon) load("hexagone.proc.il"))
xStep=6
xStep=3
yStep=xStep/sqrt(3)*2
xCon=0.5 yCon=0.5
r=xStep/sqrt(3)
pw=1
row=0 col=0
xa=0 ya=3*yStep
xb=xStep yb=yStep+r*sqrt(3)/2
xc=xStep yc=-yStep-r*sqrt(3)/2
;; PB de chemin a travers vias => il faut des-axer les emplacements de vias et donc de Path
xva=0 yva=0
xvb=0 yvb=0
xvc=0 yvc=0
;; xva=-r/2 yva=0
;; xvb=r/4 yvb=r*sqrt(3)/4
;; xvc=r/4 yvc=-r*sqrt(3)/4


l_V1=list(via1 "drawing"); contact (via colour pour A
l_M1=list(MET1 "drawing"); pad colour for A
l_W1=list(MET1 "drawing"); wire for A
l_V2=list(via2 "drawing"); contact (via colour pour B
l_M2=list(MET2 "drawing"); pad colour for B
l_W2=list(MET2 "drawing"); wire for B
l_V3=list(via3 "drawing"); contact (via colour pour C
l_M3=list(MET3 "drawing"); pad colour for C
l_W3=list(MET3 "drawing"); wire for C

NX=5 NY=5
NX=3 NY=3
NX=2 NY=2
NX=1 NY=1

for(row 0 NX
	ya=0
	for(col 0 NY
;; creation du premier demi motif pour A
		createHexagon(xa ya "TOP_M" cv r)
foreach(mapcar v list(viat1 viat2 viat3) dbCreateVia(cv v centerBox(list((xva+xa-xCon:yva+ya-yCon) (xva+xa+xCon:yva+ya+yCon))) "R0"))
		rodCreatePath(?cvId cv ?layer l_W1 ?width pw ?pts  list((xva+xa:yva+ya) (xva+xa:yva+ya+3*yStep)))
;; creation du premier demi motif pour B
		xb=xa yb=ya+yStep
		createHexagon(xb yb "TOP_M" cv r)
foreach(mapcar v list(viat2 viat3) dbCreateVia(cv v centerBox(list((xvb+xb-xCon:yvb+yb-yCon) (xvb+xb+xCon:yvb+yb+yCon))) "R0"))
		rodCreatePath(?cvId cv ?layer l_W2 ?width pw ?pts  list((xvb+xb:yvb+yb) (xvb+xb+xStep:yvb+yb+xStep*sqrt(3))))
;; creation du premier demi motif pour C
		xc=xa yc=yb+yStep
		createHexagon(xc yc "TOP_M" cv r)
foreach(mapcar v list(viat3) CVIA=dbCreateVia(cv v centerBox(list((xvc+xc-xCon:yvc+yc-yCon) (xvc+xc+xCon:yvc+yc+yCon))) "R0"))
		rodCreatePath(?cvId cv ?layer l_W3 ?width pw ?pts  list((xvc+xc:yvc+yc) (xvc+xc+xStep:yvc+yc-xStep*sqrt(3))))
	ya=ya+3*yStep
	);for col
xa=xa+2*xStep
);for row


;; colonnes paires
xa=xStep
for(row 0 NX
	ya=xStep*sqrt(3)
	for(col 0 NY
		createHexagon(xa ya "TOP_M" cv r)
;		rodCreateRect(?cvId cv ?layer l_V1 ?bBox list((xva+xa-xCon:yva+ya-yCon) (xva+xa+xCon:yva+ya+yCon)))
foreach(mapcar v list(viat1 viat2 viat3) dbCreateVia(cv v centerBox(list((xva+xa-xCon:yva+ya-yCon) (xva+xa+xCon:yva+ya+yCon))) "R0"))
		rodCreatePath(?cvId cv ?layer l_W1 ?width pw ?pts  list((xva+xa:yva+ya) (xva+xa:yva+ya+3*yStep)))
		xb=xa yb=ya+yStep
		createHexagon(xb yb "TOP_M" cv r)
;		rodCreateRect(?cvId cv ?layer l_V2 ?bBox list((xvb+xb-xCon:yvb+yb-yCon) (xvb+xb+xCon:yvb+yb+yCon)))
foreach(mapcar v list(viat2 viat3) dbCreateVia(cv v centerBox(list((xvb+xb-xCon:yvb+yb-yCon) (xvb+xb+xCon:yvb+yb+yCon))) "R0"))
		rodCreatePath(?cvId cv ?layer l_W2 ?width pw ?pts  list((xvb+xb:yvb+yb) (xvb+xb+xStep:yvb+yb+xStep*sqrt(3))))
		xc=xa yc=yb+yStep
		createHexagon(xc yc "TOP_M" cv r)
;		rodCreateRect(?cvId cv ?layer l_V3 ?bBox list((xvc+xc-xCon:yvc+yc-yCon) (xvc+xc+xCon:yvc+yc+yCon)))
foreach(mapcar v list(viat3) dbCreateVia(cv v centerBox(list((xvc+xc-xCon:yvc+yc-yCon) (xvc+xc+xCon:yvc+yc+yCon))) "R0"))
		rodCreatePath(?cvId cv ?layer l_W3 ?width pw ?pts  list((xvc+xc:yvc+yc) (xvc+xc+xStep:yvc+yc-xStep*sqrt(3))))

	ya=ya+3*yStep
	);for col
	
xa=xa+2*xStep
);for row

; load("~/Skill/hexagone.proc.il")
; geSelectAllFig() leHiMerge() leHiConvertShapeToPolygon()
if(apply('or foreach(mapcar win hiGetWindowList() win~>cellView~>cellName==cv~>cellName)) then printf("%s already opened\n" cv~>cellName) else 
printf("Opening %s\n" cv~>cellName) geOpen( ?lib cv~>libName ?cell cv~>cellName  ?view cv~>viewName )) ;; <== check results


;; hiZoomIn(cv list(101.6906 180.1333))
;; leZoomToPoint( getCurrentWindow() list(101.6906 180.1333))
;; lf("Zoom")
;; hiZoomIn(getCurrentWindow() CVIA~>bBox)
