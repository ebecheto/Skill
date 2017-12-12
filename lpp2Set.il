;; copyleft ebecheto

; find all pin, rect, Return, select All, then common, chose layer, apply. 
; ^^ Not faster?
;______________________________________________________________________________
defun(lpp2Set (@optional (lpp '("METAL1" "pin"))(purp nil)(insts geGetSelectedSet()))
let((cv nlpp)
cv=geGetWindowCellView()
;; inst=css()
;; inst~>lpp;=> ("METAL1" "drawing")
; here inst is a pin objType
printf("INSTS : %L\n" insts)
unless(insts insts=setof(p cv~>shapes~>pin when(p p)))
printf("INSTS : %L\n" insts)
printf("%L !! " insts~>pin~>name)
ex=car(insts)
;; inst=car(insts)
foreach(mapcar inst insts
nlpp=if(purp list(inst~>fig~>layerName cadr(lpp)) lpp )
when(verb printf("%L into %L\n" inst~>net~>name nlpp) )
inst~>fig~>lpp=nlpp
foreach(mapcar child inst~>fig~>children
nlpp=if(purp list(child~>layerName cadr(lpp)) lpp)
child~>lpp=nlpp)
)))


printf("USAGE:\n")
printf("lpp2Set('(\"METAL1\" \"pin\")):\n")
printf("lpp2Set('(\"whatever\" \"pin\") t)<= remove all MET-draw )> MET-pin\n")
; lpp2Set('("METAL1" "pin"))
; lpp2Set('("METAL2" "pin"))
; lpp2Set('("whatever" "pin") t)
; lpp2Set('("whatever" "pin") t)


;; inst~>pin~>??;=> (db:0x3d29dc5c cellView db:0x3b924d1a objType "pin" prop nil accessDir ("top" "bottom" "left" "right") fig db:0x3b924e4f groupMembers nil name "P__66" net db:0x3d29e39d term db:0x3b924c21 connRoutes nil textDisplays nil assocTextDisplays nil markers nil figs (db:0x3b924e4f) status nil type nil)
;; inst~>pin~>fig~>??;=> (db:0x3b924e4f cellView db:0x3b924d1a objType "rect" prop nil bBox ((147.2 -0.31) (149.5 0.31)) children (db:0x3b924e32) groupMembers nil isAnyInst nil isShape t matchPoints nil net db:0x3d29e39d parent nil pin db:0x3d29dc5c purpose "drawing" textDisplays nil assocTextDisplays nil markers nil figGroup nil isUnshielded nil shieldedNet1 nil shieldedNet2 nil layerName "METAL1" layerNum 31 lpp ("METAL1" "drawing") connRoutes nil routeStatus "normal")


;; foreach(mapcar child inst~>children
;; chilp~>lpp=lpp

;; inst~>??