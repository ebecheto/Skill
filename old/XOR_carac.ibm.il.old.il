unless(fboundp('interceptime) load("/home/validmgr/ebecheto/Skill/XOR_carac.proc.il"))

;; ibmpat='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")
;; cells=foreach(mapcar pat ibmpat strcat("XOR2_" pat))

;nth     0   1   2   3   4   5   6   7   8   9   10
elist='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")
itit=foreach(mapcar x elist strcat("_" x))
foreach(mapcar x elist strcat("Ai_" x))
foreach(mapcar x elist strcat("Zi_" x));for label text purpose
; invp=VAR("sel")==1.8

edgeis='("rising" "falling") ;input edge list
edgeos=if(invp reverse(edge) edge)


; me suis gourrer dans la simu : les noms en i NE SONT pas les inverseur a corriger a la prochaine simu
ioedge='("rising" "falling")
ioedge='("rising" "rising")
dly_irr=interceptime('("Ai" "Zi") itit ioedge)
dly_irr=interceptime('("A" "Z") itit ioedge)



AST='(; in out ()
(("Ai" "Zi") ("falling" "rising")   "Inverter" itit)
(("Ai" "Zi") ("rising" "falling")   "Inverter" itit)
(("A" "Z")   ("rising" "rising")     "Buffer"  itit)
(("A" "Z")   ("falling" "falling")   "Buffer"  itit)
)

allDly=foreach(mapcar leaf AST
dlys=interceptime(car(leaf) eval(nth(3 leaf)) cadr(leaf))
)

;; leaf=nth(3 AST)
;; dlys=interceptime(car(leaf) eval(nth(3 leaf)) cadr(leaf))

nf=0
foreach(mapcar leaf AST ;leaf=car(AST)
printf("IBM XOR2X as %s on pin B\n" caddr(leaf))
dlys=nth(nf++ allDly)
i=-1
foreach(dly dlys i++ ;dly=car(dlys)
printf("XOR2X%s %s%s delay=%s\t[s]+/- %g*CLoad[F]\n" nth(i elist) car(parseString(car(cadr(leaf)) "")) car(parseString(cadr(cadr(leaf)) "")) aelSuffixNotation(car(dly)) cadr(dly))
)
)
