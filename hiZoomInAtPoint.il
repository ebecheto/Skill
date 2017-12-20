defun(hiZoomInAtPoint (@optional (pt '(0 0))(dx 0.2))
hiZoomIn(hiGetCurrentWindow() list(list(car(pt)-dx cadr(pt)-dx) list(car(pt)+dx cadr(pt)+dx)))
)


