ineed('instBusMatch)
;; setq(bm '("31" "16" 1 -15 "MULT"))
;; (setq bus "MULT<31:16>")

defun(bus2list (@optional (bus "MULT<31:16>"))
let((bm gt lt res)
bm=instBusMatch(bus);=> ("31" "16" 1 -16 "MULT")
gt=1 lt=0 res='()
if(car(bm)==nil then last(bm) else
when(nth(3 bm)<0 gt=0 lt=1)
for(i atoi(nth(lt bm))  atoi(nth(gt bm)) 
res=append(res list(sprintf(nil "%s<%d>" nth(4 bm) i)))
)
res=if(nth(3 bm)<0 reverse(res) res)
res)))

; bus2list()

;; bus2list("MULT<15:18>");=> ("MULT<15>" "MULT<16>" "MULT<17>" "MULT<18>")
;; bus2list("MULT<31:28>");=> ("MULT<31>" "MULT<30>" "MULT<29>" "MULT<28>")
;; bus2list("MULT<31>");=> ("MULT<31>")
; bus2list("MULT");<= --failed, not needed-- SOLVED
; foreach(mapcan name geGetWindowCellView()~>terminals~>name bus2list(name))

