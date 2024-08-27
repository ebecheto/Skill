-;; copyleft ebecheto
;; first hexagon draw example

rot=0
r=9;<== rayon
;; rodCreatePolygon( list('(0 0) '(0 1) '(1 1 )))
dbCreateLine( geGetWindowCellView() list("text" "drawing1") list(-0.5:-100 100:-100))
pi=acos(-1);=> 3.141593
j = complex(0.0, 1.0);

c=geGetWindowCellView()
l=list("METAL1" "drawing")
dbCreatePolygon( c l  list('(0 0) '(0 1) '(1 1 )))

x=0 y=0 rot=0
pointList='();
pointList=tconc(pointList list(x y))

for(i 0 5 
rot=rot+pi/3.0
x=x+r*cos(rot) y=y+r*sin(rot)
pointList=tconc(pointList list(x y))
);;end i
pList=car(pointList)
hex=dbCreatePolygon( c l  pList)
cBox=centerBox(hex~>bBox)

x=x+r*cos(rot) y=y+r*sin(rot)


;; pList
;; ((0 0) 
;;     (4.5 7.794229) 
;;     (2.664535e-15 15.58846) 
;;     (-9.0 15.58846) 
;;     (-13.5 7.794229)
;;     (-9.0 8.881784e-16) 
;;     (-7.105427e-15 -9.309792e-15)
;; )

length(pList);=> 7


i=-1 axes=foreach(mapcar p pList i=i+1
list(nth(i pList) nth(mod(i+3 7) pList)
))

ineed('nthcdr2)
axe3=nthcdr2(0 3 axes)

car(axe3);=> ((0 0) (-9.0 15.58846))
foreach(mapcar a axe3 dbCreateLine( geGetWindowCellView() list("text" "drawing1") a))

kntor=list(0:0 2.5:0.3)
leftK = dbTransformBBox(kntor '((-8 0.5) "R0" 1.0))
rightK = dbTransformBBox(kntor '((-3.5 0.5) "R0" 1.0))
dbCreateRect(c list("METAL4" "drawing") leftK) ; <== selection box rect
dbCreateRect(c list("METAL4" "drawing") rightK) ; <== selection box rect

foreach(mapcar i linRg(0 5 1)
rot=rot+pi/3.0
x=x+r*cos(rot) y=y+r*sin(rot)

cBox;=> (-4.5 7.794)
rotationCir( leftK 60 '(-4.5 7.794))

ineed('rotationCir)

master=(dbOpenCellViewByType "ED_TSMC130n" "HEXA" "layout")
(dbCreateInst cv master nil (list x y ) "R0")

; bBox=dbTransformBBox(bBox '((7.55 4.3) "R0" 1.0))
cv= geGetWindowCellView()
cv~>cellName;=> "HEXAx7"
;foreach( mapcar p pList x=car(p) y=cadr(p) (dbCreateInst cv master nil (list x y ) "R0"))

(dbCreateInst cv master nil pts "R0")

9*2
9*sqrt(3);<== a touch-touch
10*sqrt(3);<== espace de 1.73
rayon=9*sqrt(3)+1 ;<= espace de 1

deg=-30
foreach(mapcar i linRg(0 5 1)
pts=rotationCir(list(rayon 0) deg)
(dbCreateInst cv master nil pts "R0")
deg=deg+60b
)

(dbCreateInst cv master nil 0:0 "R0")