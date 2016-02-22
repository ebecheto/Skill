;; copyleft ebecheto

;load("hexagone.array.il")
;create hexagon pads in an opended layout. based on ams drawing layers.

cv=geGetWindowCellView()
when(cv~>viewName!="layout" lib1=car(sort(setof(lib ddGetLibList() lib~>isWritable)~>name nil))
lib1="AAA"
cv=dbOpenCellViewByType(lib1 "hexagoneArray"  "layout" "maskLayout" "a"))



unless(fboundp('createHexagon) load("hexagone.proc.il"))
xStep=8
yStep=xStep/sqrt(3)*2
xCon=0.5 yCon=0.5
r=8/sqrt(3)
pw=1
row=0 col=0
xa=0 ya=3*yStep
xb=xStep yb=yStep+r*sqrt(3)/2
xc=xStep yc=-yStep-r*sqrt(3)/2
;; PB de chemin a travers vias => il faut des-axer les emplacements de vias et donc de Path
xva=-r/2 yva=0
xvb=r/4 yvb=r*sqrt(3)/4
xvc=r/4 yvc=-r*sqrt(3)/4

l_V1=list("VIA1" "drawing"); contact (via colour pour A
l_M1=list("MET1" "drawing"); pad colour for A
l_W1=list("POLY1" "drawing"); wire for A
l_V2=list("VIA2" "drawing"); contact (via colour pour B
l_M2=list("MET2" "drawing"); pad colour for B
l_W2=list("POLY2" "drawing"); wire for B
l_V3=list("VIA3" "drawing"); contact (via colour pour C
l_M3=list("MET3" "drawing"); pad colour for C
l_W3=list("DIFF" "drawing"); wire for C

for(row 0 5 
	ya=0
	for(col 0 5
;; creation du premier demi motif pour A
		createHexagon(xa ya "MET1" cv)
		rodCreateRect(?cvId cv ?layer l_V1 ?bBox list((xva+xa-xCon:yva+ya-yCon) (xva+xa+xCon:yva+ya+yCon)))
		rodCreatePath(?cvId cv ?layer l_W1 ?width pw ?pts  list((xva+xa:yva+ya) (xva+xa:yva+ya+3*yStep)))
;; creation du premier demi motif pour B
		xb=xa yb=ya+yStep
		createHexagon(xb yb "MET2" cv)
		rodCreateRect(?cvId cv ?layer l_V2 ?bBox list((xvb+xb-xCon:yvb+yb-yCon) (xvb+xb+xCon:yvb+yb+yCon)))
		rodCreatePath(?cvId cv ?layer l_W2 ?width pw ?pts  list((xvb+xb:yvb+yb) (xvb+xb+xStep:yvb+yb+xStep*sqrt(3))))
;; creation du premier demi motif pour C
		xc=xa yc=yb+yStep
		createHexagon(xc yc "MET3" cv)
		rodCreateRect(?cvId cv ?layer l_V3 ?bBox list((xvc+xc-xCon:yvc+yc-yCon) (xvc+xc+xCon:yvc+yc+yCon)))
		rodCreatePath(?cvId cv ?layer l_W3 ?width pw ?pts  list((xvc+xc:yvc+yc) (xvc+xc+xStep:yvc+yc-xStep*sqrt(3))))

	ya=ya+3*yStep
	);for col
	
xa=xa+2*xStep
);for row


;; colonnes paires
xa=xStep
for(row 0 5 
	ya=xStep*sqrt(3)
	for(col 0 5
		createHexagon(xa ya "MET1" cv)
		rodCreateRect(?cvId cv ?layer l_V1 ?bBox list((xva+xa-xCon:yva+ya-yCon) (xva+xa+xCon:yva+ya+yCon)))
		rodCreatePath(?cvId cv ?layer l_W1 ?width pw ?pts  list((xva+xa:yva+ya) (xva+xa:yva+ya+3*yStep)))
		xb=xa yb=ya+yStep
		createHexagon(xb yb "MET2" cv)
		rodCreateRect(?cvId cv ?layer l_V2 ?bBox list((xvb+xb-xCon:yvb+yb-yCon) (xvb+xb+xCon:yvb+yb+yCon)))
		rodCreatePath(?cvId cv ?layer l_W2 ?width pw ?pts  list((xvb+xb:yvb+yb) (xvb+xb+xStep:yvb+yb+xStep*sqrt(3))))
		xc=xa yc=yb+yStep
		createHexagon(xc yc "MET3" cv)
		rodCreateRect(?cvId cv ?layer l_V3 ?bBox list((xvc+xc-xCon:yvc+yc-yCon) (xvc+xc+xCon:yvc+yc+yCon)))
		rodCreatePath(?cvId cv ?layer l_W3 ?width pw ?pts  list((xvc+xc:yvc+yc) (xvc+xc+xStep:yvc+yc-xStep*sqrt(3))))

	ya=ya+3*yStep
	);for col
	
xa=xa+2*xStep
);for row

; load("~/Skill/hexagone.proc.il")
; geSelectAllFig() leHiMerge() leHiConvertShapeToPolygon()
if(apply('or foreach(mapcar win hiGetWindowList() win~>cellView~>cellName==cv~>cellName)) then printf("%s already opened\n" cv~>cellName) else 
printf("Opening %s\n" cv~>cellName) geOpen( ?lib cv~>libName ?cell cv~>cellName  ?view cv~>viewName )) ;; <== check results
