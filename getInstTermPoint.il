;; copyleft ebecheto
;; inst=css()
;; pointList='()
;; add lpp in 3rd position of the output list
procedure(getInstTermPoint(@optional (inst css()) )
let((point master pointList itrans relBBox)  
pointList='()
master=inst~>master printf("INST:%L\n" list(inst master~>terminals setof(shape master~>shapes shape~>objType=="label")) )
itrans=inst~>transform||list(inst~>xy car(inst~>tileArray) 1.0);<= mosaic patch
;conn=car(master~>terminals)
foreach( conn master~>terminals
point=centerBox(caar(conn~>pins~>figs)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
relBBox =dbTransformBBox(caar(conn~>pins~>figs)~>bBox||list(0:0 0:0) itrans)
pointList=append(pointList list(list(conn~>name dbTransformPoint(point itrans) car(conn~>pins)~>fig~>lpp relBBox)))
)
unless(master~>terminals 
if(
LABs=setof(shape master~>shapes shape~>objType=="label") then ;printf("LABEL PATH\n")
LAB=car(LABs)
foreach(LAB LABs point=LAB~>xy
relBBox =dbTransformBBox(LAB~>bBox||list(0:0 0:0) itrans)
pointList=append(pointList list(list(LAB~>theLabel dbTransformPoint(point itrans) LAB~>lpp relBBox)))
))) pointList ));let proc


procedure(getInstTermPoint1(@optional (inst css()) )
let((point master pointList) 
master=inst~>master ;printf("INST:%L\n" list(inst master~>terminals) )
foreach( conn master~>terminals 
point=centerBox(caar(conn~>pins~>figs)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
pointList=append(pointList list(conn~>name))
) pointList ));let proc





defun(letInstTermPoint1 (@optional (inst nil)(ar "")(dr "")(dx nil)(cv nil))
unless(inst inst=css())
unless(dx dx=0.1)
unless(cv cv=geGetWindowCellView())
foreach(tp getInstTermPoint(inst)
labelAtPt(list(strcat(ar car(tp) dr) cadr(tp)) ibBox(inst) dx cv)
)
)


; letInstTermPoint1(nil "T2_" "" nil nil)
; foreach(mapcar i inst~>instTerms list(i~>name i~>net~>figs))
;; inst~>master~>terminals~>??
;; inst~>instTerms~>??

; marche pour schema par layout css()~>transform ;<= d'une instance layout ?

;; css()~>??
;=> (db:0x691e731b cellView db:0x34744a1a objType "mosaic" prop (db:0x3fc8c89c db:0x3fc8c8a6 db:0x3fc8c8a5 db:0x3fc8c8a4 db:0x3fc8c8a3 db:0x3fc8c8a2 db:0x3fc8c8a1 db:0x3fc8c8a0 db:0x3fc8c89f db:0x3fc8c89e db:0x3fc8c89d db:0x44008f98 db:0x44008c98 db:0x440095b0 db:0x44009be0 db:0x44008998) bBox ((29.82 24.65) (32.4 35.52)) children nil groupMembers nil isAnyInst t isShape nil matchPoints nil net nil parent nil pin nil purpose "cell" textDisplays nil assocTextDisplays nil markers nil figGroup nil instanceList (db:0x691e731b) name "I1" numInstances 1 mosaicType "simple" libName "ts018_prim" cellName "nmos_18" viewName "layout" master db:0x691ea79a instHeader db:0x691e721c instTerms nil rows 1 columns 1 status nil tileArray ("R0") uX 1.5 uY 1.12 xy (30.0 25.0))

; list(inst~>xy car(inst~>tileArray) 1);=> ((30.0 25.0) "R0" 1)