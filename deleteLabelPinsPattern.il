;ineed('deleteLabelPinsPattern t)
;;; REMOVE PINS
;; pattern="GNDO_"
;; pattern="PSUB_"
;; pattern="VDDO_"
defun(deleteLabelPinsPattern (@optional (pattern "GNDO_") (cv nil) )
let((terms sterms fig labs slabs )
unless(cv cv=geGetWindowCellView())
terms=cv~>terminals
sterms=setof(te terms rexMatchp(pattern te~>name))

length(sterms);=> 2157
;s=car(sterms);=> db:0x8a1e2f32
foreach(mapcar term sterms 
;pin=car(term~>pins);=> db:0x7d7b79dc
foreach(mapcar pin term~>pins
fig=pin~>fig;=> db:0x7d4727b9
when(fig dbDeleteObject(fig))
when(pin dbDeleteObject(pin))
);pins
);term
;; Not sure i have to loop and terms and figs
;; REMOVE LABELS
labs=setof(c cv~>shapes c~>objType=="label")
;lab=car(labs)
slabs=setof(lab labs rexMatchp(pattern lab~>theLabel))
foreach(mapcar slab slabs dbDeleteObject(slab))
))


;; deleteLabelPinsPattern("^VDDO")
;; deleteLabelPinsPattern("VDDO")
; foreach(mapcar patt list("PSUB_" "VDDO" "GNDO") deleteLabelPinsPattern(patt))
