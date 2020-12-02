;; copyleft ebecheto

defun(xy2bBox  (xy @optional (d 0.5) )
let(( x y)
x=car(xy) y=cadr(xy)
list(list(x-d y-d) list(x+d y+d))
))

;; xy point to a square bBox at this point
;;
;;  +-----+
;;  |     |
;;  |  xy |
;;  |     |
;;  +-----+
;; return bounding Box around the point
