;; copyleft ebecheto
;; first hexagon draw example

rot=0
r=9;<== rayon
;; rodCreatePolygon( list('(0 0) '(0 1) '(1 1 )))
dbCreateLine( geGetWindowCellView() list("text" "drawing1") list(-0.5:-100 100:-100))
pi=acos(-1);=> 3.141593
j = complex(0.0, 1.0);

c=geGetWindowCellView()
l=list("MET1" "drawing")
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
