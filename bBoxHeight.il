;; copyleft ebecheto
;ineed('(bBoxHeight bBoxWidth))


defun(bBoxHeight (bBox) 
cadadr(bBox)-cadar(bBox)
)
