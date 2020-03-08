;; copyleft ebecheto

defun(CreateVias (via321 X Y @optional (cv nil) (xCon 0.5) (yCon 0.5))
unless(cv cv=geGetWindowCellView()) 
foreach(mapcar v via321 dbCreateVia(cv v (X:Y) "R0")) 
)

;; cv=geGetWindowCellView()
;; tech = techGetTechFile(cv)
;; viaNames=list("M4_M3_S" "M5_M4_S" "ML_M5_S")
;; vias=foreach(mapcar v viaNames techFindViaDefByName(tech v))
;; CreateVias(vias 0 0)



;; vias=list(viat1 viat2 viat3);=> (db:0x21fbc59c db:0x21fbc59b db:0x21fbc59a)
;; nthcdr(1 vias)                            ;=> (db:0x21fbc59b db:0x21fbc59a)
;; nthcdr(2 vias)                                          ;=> (db:0x21fbc59a)
