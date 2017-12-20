; copylef ebecheto
;  Thu Nov 23 18:14:24 CET 2017


defun(pointInbBox (@optional (point '(-6.22 -3.28)) (bBox '((-6.325 -4.41) (-6.115 -2.15))))
let((x y X0 X1 Y0 Y1 pt verb)
verb=nil
when(verb printf("point %L | bBox %L\n" point bBox))
pt=if(listp(car(point)) centerBox(point) point)
point=centerBox(point)
x=car(pt) y=cadr(pt)
     X0 = xCoord(lowerLeft(bBox))
     X1 = xCoord(upperRight(bBox))
     Y0 = yCoord(lowerLeft(bBox))
     Y1 = yCoord(upperRight(bBox))
;and(and(X0<x x<X1) and(Y0<y y<Y1))
and(and(X0<=x x<=X1) and(Y0<=y y<=Y1))
))



