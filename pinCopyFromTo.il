; load("~/Skill/pinCopyFromTo.il")
;; copyleft ebecheto
;; Select RECTANGLE PIN
; LABEL     = got a PARENT which is the RECTANGLE
; RECTANGLE = got a CHILDREN which is the LABEL    is the PIN
; REC2=dbCopyFig(REC cv);=> db:0x6d5cad9b ;<== does not copy label :(
; LAB2=dbCopyFig(LAB cv);=> nil  ;<== Why nil ? dbCopyFig does not copy Label ?
; REC=css()
;; Why not looping on the pins of the CV by default?

defun(pinCopyFromTo  (@optional (cv0 nil) (cv nil) (REC css()) (addPoint 0:0) (ouvre nil) (motif ""))
let((LAB height xy justify font lpp name box dir accessDir rot pin term disp abox)
unless(cv0 cv0=geGetWindowCellView())
unless(cv cv=(dbOpenCellViewByType cv0~>libName cv0~>cellName strcat(cv0~>viewName "_pin") "maskLayout" "a"))
LAB=car(REC~>children);<= label
height=LAB~>height
xy=mapcar('plus LAB~>xy addPoint)
justify=LAB~>justify;=> "centerCenter"
font=LAB~>font; but i prefer roman rather than stick
lpp=REC~>lpp
name=REC~>net~>name;=> "A_599"
name=strcat(motif name)
box=REC~>bBox;=> ((-1.84 1.725) (2.275 5.515))
abox=foreach(mapcar b box mapcar('plus b addPoint));=> ((3638.16 3201.725) (3642.275 3205.515))
dir=REC~>pin~>term~>direction;=> "inputOutput"
accessDir=list("top" "bottom" "left" "right")
rot="R0"
;printf(name)
;RREC=REC

pin=leCreatePin(cv lpp "rectangle"  abox name dir accessDir)
term=pin~>term
;pos=centerBox(box);=> (0.2175 3.62)
; when(tj lpp=list(car(lpp) "label"))
disp=dbCreateTextDisplay( term term LAB~>lpp t xy justify rot font 0.5)
disp~>isNameVisible=nil ;makes the 'name=' invisible
disp~>parent=pin~>fig    ;makes the text moving with the rect pin
when(ouvre geOpen( ?lib cv~>libName ?cell cv~>cellName  ?view cv~>viewName )) ;; <== check results
disp
))

;; xy=inst~>xy;=> (3640.0 3200.0)
;; box='((-1.84 1.725) (2.275 5.515))
;; foreach(mapcar b box mapcar('plus b xy));=> ((3638.16 3201.725) (3642.275 3205.515))

;inst=css()
defun( pinCopyFromToAll (@optional (inst nil) (here t))
let((figs)
unless(inst inst=css())
;figs=inst~>master~>terminals~>pins~>figs
figs=foreach(mapcan terms inst~>master~>terminals foreach(mapcan pins terms~>pins foreach(mapcan fig pins~>figs list(fig))));<= flatten figs
;inst~>cellView
; inst~>xy;=> (3640.0 3200.0)
foreach(mapcar fig figs pinCopyFromTo(inst~>cellView when(here inst~>cellView) fig inst~>xy))
;foreach(mapcar fig figs pinCopyFromTo(inst~>cellView when(here inst~>cellView) fig 0:0 ))
))


defun( pinCopyFromToLayer (@optional (inst nil) (here t)(layer "M1")(motif ""))
let((figs sopins)
unless(inst inst=css())
;figs=inst~>master~>terminals~>pins~>figs
figs=foreach(mapcan terms inst~>master~>terminals 
sopins=setof(pin terms~>pins pin~>fig~>layerName==layer)
foreach(mapcan pins sopins  foreach(mapcan fig pins~>figs list(fig))));<= flatten figs
;figs=foreach(mapcan terms inst~>master~>terminals foreach(mapcan pins terms~>pins foreach(mapcan fig pins~>figs list(fig))));<= flatten figs
;inst~>cellView
; inst~>xy;=> (3640.0 3200.0)
foreach(mapcar fig figs pinCopyFromTo(inst~>cellView if(here==t inst~>cellView here) fig inst~>xy nil motif ))
;foreach(mapcar fig figs pinCopyFromTo(inst~>cellView when(here inst~>cellView) fig 0:0 ))
))

; pinCopyFromToLayer(inst t "M1" "") ;=> generates pins ontop of the cell, only M1 layer
; pinCopyFromToLayer(inst t "M3" "M") ;=> generates pins ontop of the cell, only M1 layer, add "M" to pin label. ie pinA became MpinA.

; pinCopyFromToAll(nil t) ;=> copy instance pins un layout_pin
; pinCopyFromToAll() ;=> copy selectid instance pins on top of it

;; ;; [OK]
;; cv0 = (dbOpenCellViewByType "picmic0_ebecheto" "pinn_600-300" "layout" "maskLayout")
;; cv = (dbOpenCellViewByType "picmic0_ebecheto" "BLOCED5" "layout" "maskLayout" "a")
;; foreach(mapcar term cv0~>terminals
;; pin=car(term~>pins);<== take only one pin if multiple of the same name exists
;; fig=car(pin~>figs)
;; printf(pin~>term~>name) ;=> "A_0"
;; pinCopyFromTo(cv0 cv fig)
;; )
