;; copyleft ebecheto
;; needed anymore ?

;; defun( nthcdr2 (@optional (i 2) (j 2) (a '(1 2 3 4 5 6 7 8 9))) reverse(nthcdr(j reverse(nthcdr(i a)))))
;; ;nthcdr2();=> (3 4 5 6 7)


defun( nthcdr2 (@optional (i 2) (j 4) (a '(1 2 3 4 5 6 7 8 9))) reverse(nthcdr(length(a)-j reverse(nthcdr(i a)))))
nthcdr2();=> (3 4)
