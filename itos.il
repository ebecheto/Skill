;; copyleft ebecheto

; integer to string; not nessessary, mais ca prends moins de place dans un code
defun(itos (i) 
cond(
(type(i)=='fixnum sprintf(nil "%d" i))
(type(i)=='flonum sprintf(nil "%g" i))
(t i)
))

;; itos(2);=> "2"
; chui con il existe la fonction a2s : all to string :
; a2s(2);=>"2"
; crotte a2s n'est pas definit dans ocean standalone...

;; itos(2.2) ;=> "2.2"
;; itos(2) ;=> "2"
;; itos(223333.9) ;=> "223334"
;; itos(0.0000778) ;=> "7.78e-05"
;; type(2.2);=>flonum
;; type(2);=>fixnum
;; i=0.000003876

