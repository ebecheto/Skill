; ineed('routePath t)
ineed('(createPinLPPcv))
;; Y1=dy
;; X1=dx
;; X0=0
;; Y0=dy
;; MWs = list(list("AVSS" 5 minM1_s "M2") list("AVDD" 5 minM1_s "M2"))
;; ;MW  = list("AVSS" "M2" 5 minM1_s)
; (setq stepXY 0:-1)(setq XY0 0:50)(setq XY1 dx:50)(setq rot "R0")(setq perc 1)
;; (setq XY1 150:0)
;; apply('max XY1)
;larg=200
; [TODO] : modify and verify the script with extended featyre
; pS="extendExtend"; pathStyle="truncateExtend" ;<= default
; to route one path from xy => space = -larg/2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      1:0 => VERTICAL  (i should have choosen the way around)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      0:1 => HORIZONTAL
;                                    XY          +x +y        direction               '((name larg space lpp))
defun(routePath (@optional (cv nil) (XY0 0:50) (XY1 140:0) (stepXY 0:-1) (MWs list(list("AVSS" 5 minM1_s "M2") list("AVDD" 5 minM1_s "M2"))) (perc 1)(pinW nil) (pS "truncateExtend"))
let((pinName larg space lpp X0 Y0 X1 Y1 sX sY X Y rot path pathes fin pin)
sX=car(stepXY) sY=cadr(stepXY)
unless(rot rot="R0")
unless(cv cv= geGetWindowCellView())
when(sX!=0 rot="R90")
X0=car(XY0)    
Y0=cadr(XY0)
X1=car(XY1)    Y1=cadr(XY1)
X=X0 Y=Y0
;MW=car(MWs)
pathes=foreach(mapcar MW MWs
pinName=car(MW) larg=cadr(MW) space=nth(2 MW) lpp=nth(3 MW)
when(listp(pinName) pinName=car(pinName) fin=t)
pinW=if(larg>=apply('max XY1) apply('max XY1)/2.0 larg/2.0)
;pinW=apply('max append(XY1 list(larg)))
;unless(pinW pinW=larg/2.0)
; printf("pinW %L\n" pinW)
X=X+sX*space
;printf("%L\n " list(lpp larg space Y X sY sX X1 Y1))
X=X+sX*larg/2.0*perc
;printf("%L\n " list(lpp larg space Y X sY sX X1 Y1))
Y=Y+sY*space
;printf("%L\n " list(lpp larg space Y X sY sX X1 Y1))
Y=Y+sY*larg/2.0*perc
;printf("%L\n " list(lpp larg space Y X sY sX X1 Y1))
printf("%L\n " list(pinName lpp larg space Y X sY sX X1 Y1))
path=dbCreatePath(cv lpp list(X:Y X+X1:Y+Y1) larg pS)
;; TODO : pin box +/-1
when(pinName 
if(fin
pin=createPinLPPcv(pinName xy2bBox(X+abs(sY)*pinW:Y+abs(sX)*pinW pinW) lpp nil cv t "centerLeft" pinW rot)
pin=createPinLPPcv(pinName xy2bBox(X+X1+abs(sY)*pinW:Y+Y1+abs(sX)*pinW pinW) lpp nil cv t "centerLeft" pinW rot)
)
pin~>fig~>parent=path;<= good idea or not? => then we can recover pinName from path => return only path instead of list(path pin)
) ;; ie : pin~>fig~>children~>theLabel;=> ("VBN_adj")
Y=Y+sY*larg/2.0
X=X+sX*larg/2.0
list(path pin));<=foreach end
list(X:Y pathes) ;<= return 
);let
);defun

;; cv= geGetWindowCellView() minM1_s=0.23;<= space between two M1 
;; larg =2 spaceBefore= 4.5

;; leftNames='("VrefP" "VrefN" "VBN_adj" "VBN" "VBP" )
;; enaNames='("ENA_CM1" "ENA_D2P" "ENA_D1P" )
;; MWs1=foreach(mapcar name leftNames list(name Wreste minM1_s "M1"))
;; MWs2=foreach(mapcar name enaNames list(name minM1_s minM1_s "M1"))
;; MWs3=list("Pulsing" 0.46 0.23 "M1")
;; MWs=append(MWs1 append(MWs2 list(MWs3)))

;;                         0:-1 means no step in x , next value down Y
;; routePath(cv 0:dy dx:0  0:-1 MWs)    ;<= HORIZONTAL
; routePath(cv 0:dy dx:0  0:-1 list(list("AVSS" 5 minM1_s "M2") list("AVDD" 5 minM1_s "M2")))
;; routePath(cv 0:0   0:dy 1:0  list(list("AVSS" 2 minM1_s "M1") list("AVDD" 2 minM1_s "M1")))
;; routePath(cv 0:0   0:dy 1:0  list(list("AVSS" 2 minM1_s "M1") list("AVDD" larg spaceBefore "M1")))
;; xpath=routePath(cv 0:0   0:dy 1:0  list(list(nil 2 5 "M1") list(nil 3 4 "M1")))  ;<= VERTICAL
;; caaadr(xpath)~>children~>pin~>figs~>??
;; inst=caar(caaadr(xpath)~>children~>pin~>figs)
;; dbMoveFig(inst nil list(0:-dy "R0"))
;; foreach(mapcar pn cadr(xpath) p=car(pn) fig=caar(p~>children~>pin~>figs) dbMoveFig(fig nil list(0:-dy "R0")))


; return list(X:Y path pin) preferably instead of only X:Y

