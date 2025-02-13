;; copyleft ebecheto
;; see also createInstPins in  pinAddText.il
;; /!\ cv not more global !: CHANGEED  :!
; ineed('createPinLPPcv t)
ineed('(xy2bBox bBoxHeight))
defun(createPinLPPcv (@optional (name "GND")(bBox list(0:0 0.2:0.2))(lpp '("M1" "pin"))(dir nil)
(cv geGetWindowCellView()) (tj nil) (justify nil)(height nil)(orient nil)(font nil)(accessDir nil))
let((pin term disp )
unless(listp(lpp) lpp=list(lpp "drawing"))
unless(listp(car(bBox)) bBox=xy2bBox(bBox))
unless(orient orient="R0")
unless(font font="roman")
unless(dir dir="inputOutput"); "input" or "output"
unless(justify justify="centerLeft")
unless(height height=bBoxHeight(bBox))
unless(accessDir accessDir='("top" "bottom" "left" "right"))
;printf("bBox:%L, center %L \n" bBox centerBox(bBox))
pin=leCreatePin(cv lpp "rectangle" bBox name dir accessDir)
term=pin~>term
when(tj lpp=list(car(lpp) "label"))
; TODO : chose between LABEL and TEXTDISPLAY :
;disp=dbCreateTextDisplay(term term lpp t centerBox(bBox) justify orient font height)
disp=dbCreateLabel(cv lpp centerBox(bBox) name justify orient font height)
disp~>isNameVisible=nil ;makes the 'name=' invisible
disp~>parent=pin~>fig   ;makes the text moving with the rect pin
pin))



; createPinLPPcv(name bBox lpp dir cv)
; createPinLPPcv(name bBox "M1" nil cv t) ;=>create label as label for towerJ

; textDisplay oki for IBM but not for AMS : label !


; createPinLPPcv("GND" list(0:0 1:1) '("M1" "drawing") nil geGetWindowCellView() nil )
; createPinLPPcv("GND" list(0:0 1:1.0) '("M1" "drawing") nil geGetWindowCellView() t )
;createPinLPPcv(name "GND")(bBox list(0:0 0.2:0.2))(lpp '("M1" "pin"))(dir nil) (cv geGetWindowCellView()) (tj nil) (justify nil)(height nil)(orient nil)(font nil)(accessDir nil))
;createPinLPPcv(name bBox lpp dir cv tj justify height orient font accessDir)
;createPinLPPcv( "GND" list(0:0 0.2:0.2) '("M1" "pin")  nil  geGetWindowCellView()  nil  nil  nil nil  nil nil)
