


defun(my_modf (x y ) x-int(x/y)*y)
defun(my_modfr (x y ) x-round(x/y)*y)

;; pitch=5;=> 5
;; X= -204.959;=> -204.959

;; modf(X sqrt(3)*pitch);=> -5.773157
;; my_modf(X sqrt(3)*pitch);=> -5.773157
;; my_modfr(X sqrt(3)*pitch);=> 2.887097

;; round(-2.7);=> -3
;; int(-2.7);=> -2

;=> modf uses int approx, and not round approximation.
; i dunno what it should be