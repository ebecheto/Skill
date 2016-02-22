;; copyleft ebecheto

procedure(getInstTermPoint(@optional (inst css()) )
let((point master pointList) 
master=inst~>master ;printf("INST:%L\n" list(inst master~>terminals) )
foreach( conn master~>terminals 
point=centerBox(caar(conn~>pins~>figs)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
pointList=append(pointList list(list(conn~>name dbTransformPoint(point inst~>transform))))
) pointList ));let proc


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
