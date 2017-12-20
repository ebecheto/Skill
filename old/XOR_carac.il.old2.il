;; unless(fboundp('interceptime) load("/home/validmgr/ebecheto/Skill/XOR_carac.proc.il"))

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
printf(" => H18 XOR2 as %s on pin B\n" caddr(leaf))
dlys=nth(nf++ allDly)
i=-1
foreach(dly dlys i++ ;dly=car(dlys)
printf("XOR2X%s %s%s delay=%s\t[s]+/- %g*CLoad[F]\n" nth(i elist) car(parseString(car(cadr(leaf)) "")) car(parseString(cadr(cadr(leaf)) "")) aelSuffixNotation(car(dly)) cadr(dly))
))


nf=0
Cins=foreach(mapcar leaf AST ;leaf=car(AST)
printf(" => H18 XOR2 as %s on pin B\n" caddr(leaf))
dlys=nth(nf allDly)
dlys3=nth(nf allDly3)
i=-1 nf++
foreach(mapcar dly dlys i++ ;dly=car(dlys)
dly3=nth(i dlys3)
Q1=car(dly)
Q3=car(dly3)
k3=cadr(dly3); on pourrait faire la moyenne de k3 et k1 qui sont tt de meme tres proche.
Cin=(Q3-Q1)/k3
printf("Cin=%s=(%g-%g)/%g\n" aelSuffixNotation(Cin) Q3 Q1 k3)
Cin
))


nf=0
foreach(mapcar leaf Cins ;leaf=car(AST)
dlys=nth(nf allDly)
dlys3=nth(nf allDly3)
i=-1 nf++
foreach(mapcar dly dlys i++ ;dly=car(dlys)
dly3=nth(i dlys3)
Q1=car(dly)
Q3=car(dly3)
k3=cadr(dly3); on pourrait faire la moyenne de k3 et k1 qui sont tt de meme tres proche.
Cin=(Q3-Q1)/k3
printf("Cin=%s=(%g-%g)/%g\n" Cin) Q3 Q1 k3)
Cin
))

Cints=apply('mapcar 'list Cins)
;length(Cints);=>
xorcin=foreach(mapcar cin  Cints apply('plus cin));somme des 4 essais rr rf fr ff

i=-1 foreach(e elist i++ printf("XOR2X%s Cin=%s\n" e aelSuffixNotation(nth(i xorcin)/4)))



AST='(
(("Bi_" "Qi_") ("falling" "rising") )
(("Bi_" "Qi_") ("rising" "falling") )
(("B" "Q")     ("rising" "rising")  )
(("B" "Q")     ("falling" "falling"))
)

elist='("L" "1" "2" "3" "4" "6" "8") 
curbs=foreach(mapcar leaf AST interceptx(car(leaf) elist cadr(leaf) t nil))
;curbs=foreach(mapcar leaf AST interceptx(car(leaf) elist cadr(leaf) t t))




curbt=apply('mapcar 'list curbs)

waves=foreach(mapcar c curbt list(eval(nth(0 c))+eval(nth(1 c)) eval(nth(2 c))+eval(nth(3 c))))
;					inv_fr		inv_rf		bu_rr		bu_ff
waved=foreach(mapcar c curbt wav=eval(nth(0 c))+eval(nth(1 c))-(eval(nth(2 c))+eval(nth(3 c)))
set(concat('bi_ car(last(parseString(car(c) "_")))) wav)
printf("set wave bi_%s\n" car(last(parseString(car(c) "_"))))
)


foreach(e elist plot(eval(concat('bi_ e)) ?expr list(strcat("fr+rf-rr-ff_" e))))

srcurbs=mapcar('lambda( (x) eval(x)) car(curbs));=> srrwaves au lieux de leurs noms

foreach(mapcar c curbt 
cs=mapcar('lambda( (x) eval(x)) car(c))
set(concat('ib_ car(last(parseString(caar(curbs) "_"))) )
nth(0 c)+nth(1 c)-(nth(2 c)+nth(3 c)))
)

apply('plus car(curbs))
apply('plus mapcar('lambda( (x) eval(x)) car(curbs)))



difs=foreach(mapcar row waved
foreach(mapcar col  waved
dif=row-col
plot(dif) 
dif
));;OK



drGetWaveformYVec(caar(difs))~>expression
drGetWaveformYVec(dif)~>expression;=>((cross(VT("Qi_8") 0.9 -1 "rising" time) - cross...))






wavet=apply('mapcar 'list waves)

inverts=car(wavet)
buffers=cadr(wavet)

difMat=foreach(mapcar inv inverts
foreach(mapcar buf buffers
dif=buf-inv
plot(dif)
dif
));;OK



val=11f
printf("delay diff for Cload=%s\n" aelSuffixNotation(val))
foreach(mapcar row difWaves
foreach(mapcar column row
;value(wave0 10f)
printf("%s\t " aelSuffixNotation(value(column val)))
)
printf("\n") 
)


difWaves=foreach(mapcar inv inverts
foreach(mapcar buf buffers
dif=buf-inv
;plot(dif)
;dif
))

wave0=caar(difWaves)
value(wave0 10f)


nthcadr(0 0 inverts)
is=nthcadr(2 2 inverts)
bs=nthcadr(2 2 buffers)

foreach(mapcar i is drGetWaveformYVec(i)~>expression)
foreach(mapcar i bs drGetWaveformYVec(i)~>expression)

difMat=foreach(mapcar inv is
foreach(mapcar buf ib
dif=buf-inv
plot(dif)
dif
))


foreach(mapcar inv is
foreach(mapcar buf ib
dif=buf-inv
;value(dif 10f)
)
ocnPrint(value(dif 10f))
)

yvec=drGetWaveformYVec(dif)
yvec~>expression