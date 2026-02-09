;ineed('stackViasDef t)
ineed('xy2bBox)

; xy=1:1
; vName="M3_M2_S"
defun(stackViasDef (viasDef @optional (xy 0:0) (cv nil)(tj t)(rc 1:1)(grid nil))
let((tech met bBox via rec) 
;printf("NAME : %L \n" list(cv~>cellName rc xy))
unless(cv cv=geGetWindowCellView())
tech = techGetTechFile(cv)
row=car(rc) col=cadr(rc)
foreach(mapcar vName viasDef v=techFindViaDefByName(tech vName) 
via=dbCreateVia(cv v xy "R0")
dbReplaceProp(via "cutRows" 'int row)
dbReplaceProp(via "cutColumns" 'int col)

when(tj
met=cadr(parseString(vName "_"))
when(grid xy=foreach(mapcar x xy round(x/grid)*grid))
bBox=xy2bBox(xy 0.24)
rec=dbCreateRect(cv list(met "drawing") bBox))
rec~>parent=via
via)))
;0.13+0.06;=> ;=> 0.19

; grid=0.005

;stackViasDef( list("M3_M2_S" "M2_M1_S") 0:0 )
;stackViasDef( list("M3_M2_S" "M2_M1_S") 0:0 cv)
;stackViasDef( list("M3_M2_S" "M2_M1_S") 0:0 cv nil) ;<= si autre techno pour pas bugger
;stackViasDef( list("M3_M2_S" "M2_M1_S") 0:0 cv nil 1:2) ; no suround 2 column

; M4.A.1: M4 area must be min 0.202 sq.um  ( M4.A.1 ). 
; sqrt(0.202);=> 0.4494441
; 0.45/2;=> 0.225 instead of 0.18
; VL.E.2: envlosure 0.06
; vias dimention : 0.36
;0.36+0.06*2;=> 0.48
;0.48/2.0;=> 0.24