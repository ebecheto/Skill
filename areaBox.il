;; copyleft ebecheto

;;abs(apply('times apply('mapcar 'difference  bBox)))
;; ^^^^^ will do the job too :  orr below _vvvvvv_v without abs or simply 
;; apply('times apply('mapcar 'difference  reverse(bBox)));=> 11796.08
;; apply('times apply('mapcar 'difference css()~>bBox));=> 11796.08

defun( areaBox (bBox)
let( (X0 Y0 X1 Y1 )
X0 = xCoord(lowerLeft(bBox))
X1 = xCoord(upperRight(bBox))
Y0 = yCoord(lowerLeft(bBox))
Y1 = yCoord(upperRight(bBox))
(X1-X0)*(Y1-Y0)
))

; grid=0.0625;schGetEnv("symSnapSpacing")
; round(yup/grid)*grid)

defun(fixZeroBox (bBox @optional (step 0.25)(grid nil))
let( (X0 Y0 X1 Y1)
unless(grid grid=0.0625)
X0=caar(bBox)
Y0=cadar(bBox)
X1=caadr(bBox)
Y1=cadadr(bBox)
xs=if(X0==X1 list(X0 round((X0+step)/grid)*grid) X0:X1)
ys=if(Y0==Y1 list(Y0 round((Y0+step)/grid)*grid) Y0:Y1)
apply('mapcar 'list list(xs ys))
))

;; defun(fixZeroBox (bBox @optional (ratio 1.1)(grid nil))
;; let( (X0 Y0 X1 Y1)
;; unless(grid grid=0.0625)
;; X0=caar(bBox)
;; Y0=cadar(bBox)
;; X1=caadr(bBox)
;; Y1=cadadr(bBox)
;; xs=if(X0==X1 list(X0 round(X0*ratio/grid)*grid) X0:X1)
;; ys=if(Y0==Y1 list(Y0 round(Y0*ratio/grid)*grid) Y0:Y1)
;; apply('mapcar 'list list(xs ys))
;; ))
;; bBox='((-0.5625 -0.875) (-0.5625 0.0))
;; fixZeroBox(bBox) ;=>((-0.5625 -0.875) (-0.625 0.0));<= mieux avec round/grid

;; bBox=css()~>bBox;=> ((925.935 -943.185) (1147.52 -889.95))
;; apply('mapcar 'difference  bBox);=> (-221.585 -53.235)


;; defun(fixZeroBox (bBox @optional (ratio 1.1)(grid nil))
;; let( (X0 Y0 X1 Y1)
;; X0=caar(bBox)
;; Y0=cadar(bBox)
;; X1=caadr(bBox)
;; Y1=cadadr(bBox)
;; xs=if(X0==X1 list(X0 X0*ratio) X0:X1)
;; ys=if(Y0==Y1 list(Y0 Y0*ratio) Y0:Y1)
;; apply('mapcar 'list list(xs ys))
;; ))
;; bBox='((-0.5625 -0.875) (-0.5625 0.0))
;; fixZeroBox(bBox);=> ((-0.5625 -0.875) (-0.61875 0.0))

