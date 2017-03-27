;; copyleft : ebecheto
;; trick to put pack correctly the surounding nets of the selected instance
;; Warning, sometimes, it puts the nets not like we would have wanted
defun( moveBackAndForth (@optional (insts geGetSelectedSet()))
let( (cv P0 P1)
unless(listp(insts) insts=list(insts))
foreach(inst insts
cv=inst~>cellView
P1=rodSubPoints(inst~>xy upperRight(cv~>bBox)) ;=> (-4.0625 -0.6875)
P0=rodSubPoints(upperRight(cv~>bBox) inst~>xy) ;=> (4.0625 0.6875)
schStretch(list(inst) list(P1 "R0" 1))
schStretch(list(inst) list(P0 "R0" 1))
)))
