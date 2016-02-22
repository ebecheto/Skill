;; copyleft ebecheto

defun(minmaxPts (@optional (pts '((1 2)(2.4 5)(3.3 0)(-1.2 2))))
let((xmin xmax ymin ymax tmp x y)
xmin=xmax=caar(pts)
ymin=ymax=cadar(pts)
tmp=cdr(pts)
foreach(mapcar xy tmp
x=car(xy)
y=cadr(xy)
when(x<xmin xmin=x)
when(y<ymin ymin=y)
when(x>xmax xmax=x)
when(y>ymax ymax=y)
) list(list(xmin ymin) list(xmax ymax))
))


;; width  = abs(apply('difference mapcar('car bBox)))    length = abs(apply('difference mapcar('cadr bBox)))

