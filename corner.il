; load  "~/corner.il"

; inst=car(corn)
; inst=css()
; list(rodSubPoints(dbTransformPoint(rodAddPoints('(-0.0625 0.0)  inst~>xy)
; rot=inst~>orient
; roti=evalstring(car(parseString( rot "R")))
; norient=sprintf(nil "R%d" mod(roti+270 360))
; inst~>orient=norient
; tran=inst~>transform
; ntran=dbTransformPoint( -250:0 tran )
; inst~>xy=ntran


cv=geGetWindowCellView()
corn=setof(inst cv~>instances inst~>cellName=="pfrelr")

foreach(inst corn
rot=inst~>orient
roti=evalstring(car(parseString( rot "R")))
norient=sprintf(nil "R%d" mod(roti+270 360))
inst~>orient=norient
tran=inst~>transform
ntran=dbTransformPoint( -250:0 tran )
inst~>xy=ntran
)
