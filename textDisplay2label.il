;; copyleft : ebecheto

; load("genBox.il")
; transform every textDisplay associated to a pin into a label (for ams_c35)

defun(textDisplay2label (@optional (cv nil))
unless(cv cv=geGetWindowCellView())
terms=cv~>terminals
;; mistake : pin is in fact a terminal in this case
foreach(term terms
;pin=car(pins);=> db:0x2f50839a
tdps=term~>assocTextDisplays
foreach(tdp tdps
; tdp=car(tdps)
label=dbCreateLabel(cv tdp~>lpp tdp~>xy term~>name tdp~>justify tdp~>orient tdp~>font tdp~>height)
;;label~>parent=car(term~>pins)~>fig
label~>parent=tdp~>parent
dbDeleteObject(tdp)
)
)
)