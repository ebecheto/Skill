;; copyleft ebecheto
;; chgt repere rotation centre xyc
;; either of a point list or a bBox

defun(rotationCir (xyl  @optional (deg 60.0) (xyc 0:0))
let((pi teta KAR)
pi=acos(-1)
teta=deg*pi/180.0
when((atom (car xyl)) KAR=t xyl=list(xyl))
ret=foreach(mapcar xy xyl
x=car(xy) y=cadr(xy)
xc=car(xyc) yc=cadr(xyc)
x1=xc+(x-xc)*cos(teta)-(y-yc)*sin(teta)
y1=yc+(x-xc)*sin(teta)+(y-yc)*cos(teta)
list(x1 y1))
if(KAR car(ret) ret)
))


; rotationCir(list(2 0) -30);=> ((1.732051 -1.0))

; rotationCir('((2 0)(1 1)) -30 '(0 0)) ;; => ((1.732051 -1.0) (1.366025 0.3660254))
; rotationCir('((2 0)(1 1)) -30 '(10 10));=> ((-1.928203 5.339746) (-2.294229 6.705771))

