;; copyleft ebecheto

defun( maxBoxes (bBoxes)
let((X0s X1s Y0s Y1s X0 X1 Y0 Y1)
when(car(bBoxes)
; printf("XY01:%L\n" list(X0 Y0 X1 Y1 car(bBoxes)))
X0=  caar(car(bBoxes)) Y0= cadar(car(bBoxes))
X1= caadr(car(bBoxes)) Y1=cadadr(car(bBoxes))
;printf("XY01:%L\n" list(X0 Y0 X1 Y1) cdr(bBoxes))
foreach(s cdr(bBoxes)
;printf("%L vs %L\n" list(caar(s) cadar(s) caadr(s) cadadr(s)) list(X0:Y0 X1:Y1))
X0=min(X0   caar(s) )
Y0=min(Y0  cadar(s) )
X1=max(X1  caadr(s) )
Y1=max(Y1 cadadr(s) )
)  list(X0:Y0 X1:Y1))))
; renvoi nil s'il n'y a pas de 1er element
