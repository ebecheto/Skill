;; copyleft ebecheto

defun(bBoxWidth (bBox) 
caadr(bBox)-caar(bBox)
)

; (setq bBox css()~>bBox)
; bBoxWidth(css()~>bBox)
;  abs(apply('difference mapcar('car bBox))) ;<== could doo too

;; bBox=css()~>bBox;=> ((-2.619 -2.27) (2.621 2.27))
;; centerBox(css()~>bBox);=> (0.001 0.0)
;; bBoxWidth(css()~>bBox);=> 5.24
;; ineed('bBoxHeight)
;; bBoxHeight(css()~>bBox);=> 4.54

