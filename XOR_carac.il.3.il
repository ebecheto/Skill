unless(fboundp('interceptime) load("/home/validmgr/ebecheto/Skill/XOR_carac.proc.il"))
;ADE->Tools->parametric->CL[0:100f] 10 step
; XOR_carac_sim3 => same xor as load => calcul de Cin. Cout on s'en fout car il est inclu dans le delay

;nth     0   1   2   3   4   5   6
elist='("L" "1" "2" "3" "4" "6" "8") 
itit=foreach(mapcar x elist strcat("_" x))


; me suis gourrer dans la simu : les noms en i NE SONT pas les inverseur a corriger a la prochaine simu
;; ioedge='("rising" "falling")
;; ioedge='("rising" "rising")
;; dly_irr=interceptime('("Bi" "Qi") itit ioedge)

AST='(; in out ()
(("Bi" "Qi") ("rising" "rising")   "Buffer" itit)
(("Bi" "Qi") ("falling" "falling") "Buffer" itit)
(("B" "Q") ("falling" "rising")    "Inverter"  elist)
(("B" "Q") ("rising" "falling")    "Inverter"  elist)
)

allDly3=foreach(mapcar leaf AST
dlys=interceptime(car(leaf) eval(nth(3 leaf)) cadr(leaf))
)

leaf=nth(3 AST)
dlys=interceptime(car(leaf) eval(nth(3 leaf)) cadr(leaf))

nf=0
foreach(mapcar leaf AST ;leaf=car(AST)
printf("H18 XOR2 as %s on pin B\n" caddr(leaf))
dlys=nth(nf++ allDly3)
i=-1
foreach(dly dlys i++ ;dly=car(dlys)
printf("XOR2X%s %s%s delay=%s\t[s]+/- %g*CLoad[F]\n" nth(i elist) car(parseString(car(cadr(leaf)) "")) car(parseString(cadr(cadr(leaf)) "")) aelSuffixNotation(car(dly)) cadr(dly))
)
)



defun(delaySum (@optional (allDly allDly3)(AST AST) )

)