ineed('xy2bBox)

; xy=1:1
; vName="M3_M2_S"
defun( stackViasDef (viasDef @optional (xy 0:0) (cv nil)(tj t))
let((tech met bBox) 
unless(cv cv=geGetWindowCellView())
tech = techGetTechFile(cv)
;printf("NAME : %L \n" cv~>cellName)
foreach(mapcar vName viasDef v=techFindViaDefByName(tech vName) 
dbCreateVia(cv v xy "R0")
when(tj
met=cadr(parseString(vName "_"))
bBox=xy2bBox(xy 0.24)
dbCreateRect(cv list(met "drawing") bBox))
)))
;0.13+0.06;=> ;=> 0.19

; 

;stackViasDef( list("M3_M2_S" "M2_M1_S") 0:0 )
;stackViasDef( list("M3_M2_S" "M2_M1_S") 0:0 cv)
;stackViasDef( list("M3_M2_S" "M2_M1_S") 0:0 cv nil) ;<= si autre techno pour pas bugger

; M4.A.1: M4 area must be min 0.202 sq.um  ( M4.A.1 ). 
; sqrt(0.202);=> 0.4494441
; 0.45/2;=> 0.225 instead of 0.18
; VL.E.2: envlosure 0.06
; vias dimention : 0.36
;0.36+0.06*2;=> 0.48
;0.48/2.0;=> 0.24