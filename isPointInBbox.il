;; copyleft ebecheto
;ineed('isPointInBbox)

; https://stackoverflow.com/questions/18295825/determine-if-point-is-within-bounding-box
;; function doesPointCollide(p,box) {
;;     return !(p.x < box.left || p.x > box.right || p.y < box.bottom || p.y > box.top
;; }

;isPointInBbox ;<= better name than doesPointCollide
defun(isPointInBbox (@optional (point '(2.105 1.215)) (bBox '((1.84 1.0) (2.16 1.32))))
let((xp yp ll ur x1 x2 y1 y2)
xp=car(point)
yp=cadr(point)

ll = car(bBox)
ur = cadr(bBox) ;same as car(cdr(bBox))
x1 = car(ll)
x2 = car(ur)
y1 = cadr(ll)
y2 = cadr(ur)
not(xp<x1||xp>x2||yp<y1||yp>y2)
))
;; point=car(setof( g geGetSelectedSet() g~>xy))~>xy;=> (2.105 1.215)
;; bBox=car(setof( g geGetSelectedSet() unless(g~>xy g~>bBox)))~>bBox;=> ((1.84 1.0) (2.16 1.32))
;; ;point=css()~>xy
;; point='(2.105 1.215)
;; ;bBox=css()~>bBox
;; bBox='((1.84 1.0) (2.16 1.32))
