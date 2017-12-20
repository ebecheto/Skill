xStep=8
yStep=xStep/sqrt(3)*2
xCon=0.5 yCon=0.5
r=8/sqrt(3)
pw=1
row=0 col=0
xa=0 ya=3*yStep
xb=xStep yb=yStep+r*sqrt(3)/2
xc=xStep yc=-yStep-r*sqrt(3)/2
cv=geGetWindowCellView()
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
		createHexagon(xa ya "MET1")
		rodCreateRect(?cvId cv ?layer l_V1 ?bBox list((xa-xCon:ya-yCon) (xa+xCon:ya+yCon)))
		rodCreatePath(?cvId cv ?layer l_W1 ?width pw ?pts  list((xa:ya) (xa:ya+3*yStep)))
;; creation du premier demi motif pour B
		xb=xa yb=ya+yStep
		createHexagon(xb yb "MET2")
		rodCreateRect(?cvId cv ?layer l_V2 ?bBox list((xb-xCon:yb-yCon) (xb+xCon:yb+yCon)))
		rodCreatePath(?cvId cv ?layer l_W2 ?width pw ?pts  list((xb:yb) (xb+xStep:yb+xStep*sqrt(3))))
;; creation du premier demi motif pour C
		xc=xa yc=yb+yStep
		createHexagon(xc yc "MET3")
		rodCreateRect(?cvId cv ?layer l_V3 ?bBox list((xc-xCon:yc-yCon) (xc+xCon:yc+yCon)))
		rodCreatePath(?cvId cv ?layer l_W3 ?width pw ?pts  list((xc:yc) (xc+xStep:yc-xStep*sqrt(3))))

	ya=ya+3*yStep
	);for col
	
xa=xa+2*xStep
);for row


;; colonnes paires
xa=xStep
for(row 0 5 
	ya=xStep*sqrt(3)
	for(col 0 5
		createHexagon(xa ya "MET1")
		rodCreateRect(?cvId cv ?layer l_V1 ?bBox list((xa-xCon:ya-yCon) (xa+xCon:ya+yCon)))
		rodCreatePath(?cvId cv ?layer l_W1 ?width pw ?pts  list((xa:ya) (xa:ya+3*yStep)))
		xb=xa yb=ya+yStep
		createHexagon(xb yb "MET2")
		rodCreateRect(?cvId cv ?layer l_V2 ?bBox list((xb-xCon:yb-yCon) (xb+xCon:yb+yCon)))
		rodCreatePath(?cvId cv ?layer l_W2 ?width pw ?pts  list((xb:yb) (xb+xStep:yb+xStep*sqrt(3))))
		xc=xa yc=yb+yStep
		createHexagon(xc yc "MET3")
		rodCreateRect(?cvId cv ?layer l_V3 ?bBox list((xc-xCon:yc-yCon) (xc+xCon:yc+yCon)))
		rodCreatePath(?cvId cv ?layer l_W3 ?width pw ?pts  list((xc:yc) (xc+xStep:yc-xStep*sqrt(3))))

	ya=ya+3*yStep
	);for col
	
xa=xa+2*xStep
);for row


;; rodCreateRect( ?cvId geGetWindowCellView() ?layer "CONT" ?origin list(5:5))

;; rodCreateRect(?cvId geGetWindowCellView() ?layer list("CONT" "drawing") ?bBox list((0:1) (2:2)))

;; 		rodCreateRect(?cvId geGetWindowCellView() ?layer list("CONT" "drawing") ?bBox list((5-0.5:5-0.5) (5+0.5:5+0.5)))

; load("~/Skill/hexagone.array.il")