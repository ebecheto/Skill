;; copyleft ebecheto
;ineed('createHexagon t)

procedure(createHexagon( @optional (x 0) (y 0) (layer "MET1")  (cv nil) (r 8/sqrt(3)) (orient "R0")(fixGrid t))
let( (rot pi i pointList dg grid)
unless(cv cv=geGetWindowCellView())
grid=0.005
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
(when fixGrid pList=foreach(mapcar xy pList list(round(car(xy)/grid)*grid round(cadr(xy)/grid)*grid)) )
hex=dbCreatePolygon( cv dg pList)
cBox=centerBox(hex~>bBox)
dbMoveFig(hex nil list(0.5*r:-r*sqrt(3)/2 orient))
hex
);let
);proc
; load("~/Skill/hexagone.proc.il")

; createHexagon(0 0 "PAD")
;; fig=createHexagon(0 0 "PAD")
;; dbMoveFig(fig nil list(1:1 "R90"))

;;  dbMoveFig(fig nil list(5:5 "R0"))
;; createHexagon(5 5 "PAD")
; createHexagon(0 0 "TOP_M" nil 1)
; createHexagon(0 0 "TOP_M" nil 1 "R270")
;  createHexagon(0 0 "TOP_M" nil 1 "R0" nil)
;; createHexagon(0 0 "M5" nil 1 "R0" t)
;; createHexagon(0 0 "M5" nil (5-0.46)/sqrt(3) "R0" t)
;; createHexagon(0 0 "TOP_M" nil (5-0.46)/sqrt(3) "R0" t)
; r=(pitch-minTOP)/sqrt(3)  ; r=xStep/sqrt(3)  