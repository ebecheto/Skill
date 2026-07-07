;; copyleft ebecheto
;ineed('xy2bBox t)

defun(xy2bBox  (xy @optional (d 0.5) )
let(( x y)
x=car(xy) y=cadr(xy)
list(list(x-d y-d) list(x+d y+d))
))

;; xy point to a square bBox at this point
;;  <-2d->
;;  +-----+ ^
;;  |     | |
;;  |  xy | 2d
;;  |     | |
;;  +-----+ v
;; return bounding Box around the point


defun(xy2bBox2  (xy @optional (dx 0.5) (dy nil) )
let(( x y)
unless(dy dy=dx)
x=car(xy) y=cadr(xy)
list(list(x-dx y-dy) list(x+dx y+dy))
))


;; xy point to a square bBox at this point
;;  <-2dx->
;;  +-----+ ^
;;  |     | |
;;  |  xy | 2dy
;;  |     | |
;;  +-----+ v
;; return bounding Box around the point
