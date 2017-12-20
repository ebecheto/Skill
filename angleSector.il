; copyleft ebecheto
; i used to call it angleSectionr
defun( angleSector (XY @optional (teta acos(-1)/2)) ;<= marche aussi
let((phi X Y pi Xr Yr) X=car(XY) Y=cadr(XY) pi=acos(-1)
;; printf("[angleSectionr]%L\n" list(XY X==0))
phi=cond(
(X==0 if(Y<0 -pi/2  pi/2))
(X<0 if(Y<0 atan(Y/X)-pi atan(Y/X)+pi))
(t atan(Y/X) ))
;; printf("phi:teta = %L\n" phi:teta)
;; printf("phi:teta = %L[deg]\n" list(phi/pi*180 teta/pi*180))
cond(
(teta-pi<=phi&&phi<-teta 0)
(-teta<=phi&&phi<teta 1)
(teta<=phi&&phi<pi-teta 2)
(t 3)
)))

