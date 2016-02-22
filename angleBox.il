;; copyleft ebecheto
;; load("angleBox.il")
; ineed('(addCell));<= addCell pour la fonction ibBox ; danger loop de ineed ?
ineed('ibBox)


defun( angleSectionr (XY @optional (teta acos(-1)/2)) ;<= marche aussi
let((phi X Y pi Xr Yr) X=car(XY) Y=cadr(XY) pi=acos(-1)
;; printf("[angleSectionr]%L\n" list(XY X==0))
phi=cond(
(X==0 if(Y<0 -pi/2  pi/2))
(X<0 if(Y<0 atan(Y/X)-pi atan(Y/X)+pi))
(t atan(Y/X) ))
;; printf("phi:teta = %L\n" phi:teta)
;; printf("phi:teta = %L[deg]\n" list(phi/pi*180 teta/pi*180))
cond(
(teta-pi<=phi&&phi<-teta 0)
(-teta<=phi&&phi<teta 1)
(teta<=phi&&phi<pi-teta 2)
(t 3)
)))

;; phi se retrouve entre -pi et +pi
;; \ 2 2/
;;  \  /
;; 3 \/ 1
;; 3 /\ 1
;;  /  \
;; / 0 0\

; angleSection(x:y atan(cadadr(bBox)/cadar(bBox)))

defun( angleBox (XY bBox) let((X0 Y0 X1 Y1 teta)
X0 = caar(bBox)	    
Y0 = cadar(bBox) 
X1 = caadr(bBox)     
Y1 = cadadr(bBox)
teta=atan((Y1-Y0)/abs(X1-X0))
;printf("xy%L centr%L teta%L\n" XY centerBox(bBox) teta/acos(-1)*180)
;; angleSection(rodSubPoints(XY centerBox(bBox)) teta)
angleSectionr(rodSubPoints(XY centerBox(bBox)) teta)
))

;; angleBox('())
;; angleBox(0:0 '((0.0 -1.125) (0.5 0.0)))
;; angleBox(0.5:-1.125 '((0.0 -1.125) (0.5 0.0)))

;; rodSubPoints(0:0 centerBox('((0.0 -1.125) (0.5 0.0))))
;; list(X=-0.25 Y=0.5625)
;; pi-atan(Y/X);=>1.152572
;; 4.294165

;;         teta;=>1.152572
;; ibBox(inst)
;; bBox='((0.0 -1.125) (0.5 0.0))


defun(angleBoxg (@optional (inst css()))
foreach(mapcar np getInstTermPoint(inst) 
;printf("term: %s __" car(np))
cons(angleBox(cadr(np) ibBox(inst)) np)
))

; angleBoxg() ;=> ; ((0 "S<0>" (0.5 -1.125)) (0 "S<1>" (0.5 -1.0)) (0 "S<2>" (0.5 -0.875)) (0 "S<3>" (0.5 -0.75)) (3 "S<4>" (0.5 -0.625)) (3 "S<5>" (0.5 -0.5)) (3 "S<6>" (0.5 -0.375)) (0 "S<7>" (0.5 -0.25)) (0 "S<8>" (0.5 -0.125)) (0 "S<9>" (0.5 0.0)) (0 "Q<0>" (0.0 -1.125)) (3 "Q<1>" (0.0 -1.0)) (3 "Q<2>" (0.0 -0.875)) (3 "Q<3>" (0.0 -0.75)) (3 "Q<4>" (0.0 -0.625)) (3 "Q<5>" (0.0 -0.5)) (3 "Q<6>" (0.0 -0.375)) (3 "Q<7>" (0.0 -0.25)) (3 "Q<8>" (0.0 -0.125)) (3 "Q<9>" (0.0 0.0)))


;; foreach(mapcar g getInstTermPoint(css()) cons(angleBox(cadr(g) ibBox(css())) g))
