; ineed('bBoxShrink t)
;; copyleft ebecheto
ineed('(bBoxHeight bBoxWidth))


defun(bBoxShrink (@optional (bBox css()~>bBox) (coef 0.5))
let((c w h cx cy)
; bBox=css()~>bBox;=> ((-2.619 -2.27) (2.621 2.27))
c= centerBox(bBox);=> (0.001 0.0)
w= bBoxWidth(bBox);=> 5.24
h=bBoxHeight(bBox);=> 4.54
cx=car(c)
cy=cadr(c)
;; coef=1.1 ;<= +10%
;; coef=0.9 ;<= -10%
list(list(cx-w/2*coef cy-h/2*coef) list(cx+w/2*coef cy+h/2*coef))
))

;; return the shrink value of the bBox by coef
;; newBox=list(list(cx-w/2*coef cy-h/2*coef) list(cx+w/2*coef cy+h/2*coef))

;; centerBox(newBox)
;; bBoxWidth(newBox)
;; bBoxHeight(newBox)
;; bBoxShrink(css()~>bBox)
;; bBoxShrink(css()~>bBox 90.0/100) ;<= 90% smaller
;; bBoxShrink(css()~>bBox 110.0/100) ;<= 10% bigger
;; bBoxShrink(css()~>bBox 1.1) ;=> inflate instead of shrinking
;; css()~>bBox;=> ((-2.619 -2.27) (2.621 2.27))
;; bBoxShrink(css()~>bBox 0.1);=> ((-0.261 -0.227) (0.263 0.227)) #<= 10% small

