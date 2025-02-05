;ineed('dbTransformBack t)

;; (setq XY 1:1) 
;; (setq transform list(list(2 3) "R0" 1))
defun(dbTransformBack ( @optional (XY 1:1) (transform list(2:3 "R0" 1)))
let((pi alpha beta x y rot mag xd yd xr yr)
pi=acos(-1);=> 3.141593
mapcar('setq '(x y) XY)
mapcar('setq '(rot mag) cdr(transform))
mapcar('setq '(xd yd) car(transform))
alpha=atoi(car(parseString(rot "R")))
beta=alpha*pi/180
xr= cos(beta)*(x-xd)+sin(beta)*(y-yd)
yr=-sin(beta)*(x-xd)+cos(beta)*(y-yd)
list(xr yr)
))