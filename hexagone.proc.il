;; copyleft ebecheto

procedure(createHexagon( @optional (x 0) (y 0) (layer "MET1")  (cv geGetWindowCellView()) (r 8/sqrt(3)))
let( (rot pi i pointList dg)
pointList='()
rot=0
pi=acos(-1)
dg=list(layer "drawing")
pointList=tconc(pointList list(x y))

for(i 0 5 
rot=rot+pi/3.0
x=x+r*cos(rot) y=y+r*sin(rot)
pointList=tconc(pointList list(x y))
);;end i
pList=car(pointList)
hex=dbCreatePolygon( cv dg pList)
cBox=centerBox(hex~>bBox)
dbMoveFig(hex nil list(0.5*r:-r*sqrt(3)/2 "R0"))
hex
);let
);proc
; load("~/Skill/hexagone.proc.il")

; createHexagon(0 0 "PAD")
;; fig=createHexagon(0 0 "PAD")
;; dbMoveFig(fig nil list(1:1 "R90"))

;;  dbMoveFig(fig nil list(5:5 "R0"))
;; createHexagon(5 5 "PAD")