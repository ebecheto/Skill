defun(bBox2array (@optional (bBox list(0:0 1:1))) let((X0 Y0 X1 Y1)
X0=caar(bBox);=> 0
Y0=cadar(bBox);=> 1
X1=caadr(bBox);=> 2
Y1=cadadr(bBox);=> 3
list(X0:Y0 X0:Y1 X1:Y1 X1:Y0)))

;pts=bBox2array(list( 0:140-58.24 50:58.24 ));=> ((0 81.76) (0 58.24) (50 58.24) (50 81.76))
