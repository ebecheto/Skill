;; copyleft ebecheto

defun(bBoxView (@optional (bBox css()~>bBox))
H=cadadr(bBox)-cadar(bBox)
W=caadr(bBox)-caar(bBox)
list(H W 
sprintf(nil "%.2f[mm**2]"  H*W*1u) 
centerBox(bBox)
))

; print Height, Width, Area, and center
; bBoxView()