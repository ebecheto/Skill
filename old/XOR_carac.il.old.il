;nth     0   1   2   3   4   5   6
elist='("L" "1" "2" "3" "4" "6" "8") 
itit=foreach(mapcar x elist strcat("_" x))
; invp=VAR("sel")==1.8

edgeis='("rising" "falling") ;input edge list
edgeos=if(invp reverse(edge) edge)


defun(interceptime (@optional (io '("B" "Q")) (itit '("_L" "_1" "_2" "_3" "_4" "_6" "_8")) (ioedge '("rising" "falling")) (verb t) (der -1) (plotit t))
;der : le dernier front. si -2 => avant dernier etc.
when(verb printf("io:%L, pattern=%L, edges=%L\n" io itit ioedge))
ioi=car(io)
ioo=cadr(io)
iedge=car(ioedge)
oedge=cadr(ioedge)
rorfs=strcat(car(parseString(iedge "")) car(parseString(oedge "")))
foreach(mapcar e itit
oname=strcat(ioo e);=> Qi_1 ...
iname=strcat(ioi e);=> Bi_1
when(verb printf("cross(VT(%L) 0.9 -1 %L)-cross(VT(%L) 0.9 -1 %L)\n" oname edgeo iname edgei))
set(concat('curv_ e) cross(VT(oname) 0.9 der oedge)-cross(VT(iname) 0.9 der iedge))
when(plotit plot(courbe ?expr list(strcat(oname "-" iname rorfs))))
pente=average(deriv(eval(concat('curv_ e))))
when(plotit plot(pente ?expr list(strcat("deriv_" e rorfs))))
;revoie list(intercept [ns] pente [s/F]); pour une simu parametrique sur CLoad.
list(value(eval(concat('curv_ e)) 0) pente)
))
;interceptime()



; me suis gourrer dans la simu : les noms en i NE SONT pas les inverseur a corriger a la prochaine simu
ioedge='("rising" "falling")
ioedge='("rising" "rising")
dly_irr=interceptime('("Bi" "Qi") itit ioedge)

AST='(; in out ()
(("Bi" "Qi") ("rising" "rising")   "Inverter" itit)
(("Bi" "Qi") ("falling" "falling") "Inverter" itit)
(("B" "Q") ("falling" "rising")    "Buffer"  elist)
(("B" "Q") ("rising" "falling")    "Buffer"  elist)
)

allDly=foreach(mapcar leaf AST
dlys=interceptime(car(leaf) eval(nth(3 leaf)) cadr(leaf))
)

;; leaf=nth(3 AST)
;; dlys=interceptime(car(leaf) eval(nth(3 leaf)) cadr(leaf))

nf=0
foreach(mapcar leaf AST ;leaf=car(AST)
printf("H18 XOR2 as %s on pin B\n" caddr(leaf))
dly=nth(nf++ dlys)
i=-1
foreach(dly dlys i++ ;dly=car(dlys)
printf("XOR2X%s %s%s delay=%s\t[s]+/- %g*CLoad[F]\n" nth(i elist) car(parseString(car(cadr(leaf)) "")) car(parseString(cadr(cadr(leaf)) "")) aelSuffixNotation(car(dly)) cadr(dly))
)
)
