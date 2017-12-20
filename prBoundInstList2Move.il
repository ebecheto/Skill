;; copyleft ebecheto

defun(prBoundInstList2Move (prBs @optional (HV t))
let(( XY Xs Ys iBox obj X0 Y0 Xs Ys Xm Ym XYm XYr Xn Yn XYnext)
; HV=t ; "H"||"V" ;<= Horizontal==true ou vertical==nil
XY=nil Xs=nil Ys=nil 
foreach(mapcar pr prBs
iBox=nth(0 pr)
obj=nth(1 pr);<= instance
; XY=car(iBox) #<== transformed, inst~>xy not transformed
XYi=obj~>xy
X0=caar(iBox)
Y0=nth(1 nth(0 iBox))
Xs=if(HV X0 0)        ;X0 or 0
Ys=if(HV 0 Y0);0 or Y0
unless(XY XY=X0:Y0 printf("START POSITION : %L\n" XY))
Xm=if(HV car(XY) 0)
Ym=if(HV 0 cadr(XY))
XYm=Xm:Ym ;<= X or Y move depending on HV
;when(first XY=mapcar('difference XY XYm) first=nil)
XYr=mapcar('difference XYm Xs:Ys);<== relative move of needed step, from xy instance position
Xn=if(HV caadr(iBox) 0) ;=> next box position
Yn=if(HV 0 nth(1 nth(1 iBox)))
XYnext=mapcar('difference Xn:Yn Xs:Ys)
printf("prevPos : %L, instPos: %L, rMove: %L iBox %L\n" XY XYi XYr iBox )
dbMoveFig(obj nil list(XYr "R0"))   ; dbMoveFig(css() nil list(-32.0:0.0 "R0"))
printf("XYs : %L XY %L, plus : %L \n" Xs:Ys XY, mapcar('plus XY Xs:Ys))
XY=mapcar('plus XY XYnext) ;<==> rodAddPoint
)))
