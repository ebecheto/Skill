; load("genBox.il")

defun(metalPin2pinDrawing (@optional (cv nil)(purp "pin"))
let((tab vlpp)
tab='(("MET1" "metal1")("MET2" "metal2")("MET3" "metal3")("MET4" "metal4")("PAD" "pad"))
unless(cv cv=geGetWindowCellView())
terms=cv~>terminals
;; mistake : pin is in fact a terminal in this case
foreach(term terms ;term=car(terms);=> db:0x2f50839a
foreach(pin term~>pins ; pin=car(term~>pins)
lpp=pin~>fig~>lpp;=> ("MET1" "pin")
; "pin" purpose why not drawing too
; buggy tech name used with function liIsValid... metal1 and not MET1 ...
; if( leIsLayerValid( vlpp=list("PIN" cadr(assoc(car(lpp) tab)))) ...)
if(and(
cadr(lpp)==purp  
purpose=cadr(assoc(car(lpp) tab))
leIsLayerValid( vlpp=list("PIN" purpose))
);and
then vlpp=list("PIN" purpose)
pin~>fig~>lpp=vlpp
else printf("No PIN %s layer found\n" car(lpp))
)
foreach(child pin~>fig~>children 
if(and(
cadr(child~>lpp)==purp 
purpose=cadr(assoc(car(child~>lpp) tab))
vlpp=list("PIN" purpose)
);and
then
child~>lpp=vlpp
else printf("No child of PIN %L for %s lpp%L?\n" vlpp||"nul" child~>theLabel child~>lpp)
))))))


;; leIsLayerValid(list("PIN" "metal2"));=> t
;; leIsLayerValid(list("PIN" "M2"));=> nil

printf("metalPin2pinDrawing()\n")
printf("metalPin2pinDrawing(geGetWindowCellView()) \n")
printf("metalPin2pinDrawing(nil \"drawing\")\n")
