;; copyleft ebecheto
; (setq layer "TOP_M") 
;; x*cos(teta)
;; y*sin(teta)

defun(createHoney (@optional (x 0) (y 0) (layer "TOP_M")  (cv nil) (r 8/sqrt(3)) (fixGrid t))
let((pi teta grid)
pi=acos(-1) teta=pi/6
unless(cv cv=geGetWindowCellView())
dg=list(layer "drawing")
grid=0.001;<= might be ok, but 0.005 preferable
grid=0.005
pList=foreach(mapcar i linRg(0 5 1) list(x+r*cos(teta+i*pi/3) y+r*sin(teta+i*pi/3)))
(when fixGrid pList=foreach(mapcar xy pList list(round(car(xy)/grid)*grid round(cadr(xy)/grid)*grid)) )
hex=dbCreatePolygon( cv dg pList)
))
; dbMoveFig(hex nil list(0:0 "R90"))

; createHoney(0 0 "TOP_M" nil 2)
; createHoney(0 0 "TOP_M" nil 2)