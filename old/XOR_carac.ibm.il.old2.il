unless(fboundp('interceptime) load("/home/validmgr/ebecheto/Skill/XOR_carac.proc.il"))
load("XOR_carac.proc.il")
ineed('cnpbin)
load("cnpbin.il")

;nth     0   1   2   3   4   5   6   7   8   9   10
elist='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")



invbufL=invbuf( '("Ai_" "Zi_") '("A_" "Z_") '("L" "1" "2" "3" "4" "6" "8"))
; invbufL=invbuf() ;=> ((tdi_L tdb_L)(tdi_1 tdb_1) ...)

difs=curb2toDif(invbufL)

TDs=curb2minusX1(difs)


plotCurbs(TDs)
addSubwindow()
plotCurbs(difs)
addSubwindow()
plotCurbs(invbufL)

curb2val(curbs);@10fF
curb2val(difs 20f)
curb2val(difs 30f)

;________________________________________________________________________________


unless(fboundp('interceptime) load("/home/validmgr/ebecheto/Skill/XOR_carac.proc.il"))

;; ibmpat='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")
;; cells=foreach(mapcar pat ibmpat strcat("XOR2_" pat))

;nth     0   1   2   3   4   5   6   7   8   9   10

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


;_____________________________________________________________________________
ibmpat='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")

foreach(mapcar i ibmpat strcat("XOR2_" i)) ;=> ("XOR2_A" "XOR2_B" "XOR2_C" "XOR2_D" "XOR2_E" "XOR2_F" "XOR2_H" "XOR2_I" "XOR2_J" "XOR2_K" "XOR2_L")
foreach(mapcar i ibmpat concat("XOR2_" i))
;(XOR2_A XOR2_B XOR2_C XOR2_D XOR2_E XOR2_F XOR2_H XOR2_I XOR2_J XOR2_K XOR2_L)

ajout='(
("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.2)))
("vdc" ("gnd!" "SX")(("vdc" "float" 0)))
("vdc" ("gnd!" "GND")(("vdc" "float" 0)))
("vdc" ("vdd!" "NW")(("vdc" "float" 0)))
("vdc" ("vdd!" "VDD")(("vdc" "float" 0)))
; ("vdc" ("gnd!" "sel")(("vdc" "float" 0)))
;("INVERT_A" ("GND" "SX" "NW" "VDD" "selb" "sel"))
;("vpulse" ("gnd!" "pulse")(("v2" "string" "1.2")("tf" "string" "1p")("tr" "string" "1p")("per" "string" "20n")))
;("vdc" ("pulse" "Q_1")(("vdc" "float" 0)))
("vpwl" ("gnd!" "netpwl")(("t1" "string" "1n") ("vdc" "string" "0") ("v2" "string" "1.2") ("t2" "string" "1.001n")))
("BUFFER_C" ("GND" "SX" "NW" "VDD" "start" "netpwl"))
)

pat="XOR2_"
mdl='("GND" "SX" "NW" "VDD")
i=-1
xi=10
L=length(ibmpat) ;=> 11
xline=foreach(mapcar e ibmpat i++
list(strcat(pat e) 
append(mdl list(sprintf(nil "Q_%d" mod(i L)) sprintf(nil "Q_%d" mod(i+1 L))  "vdd!"))
))

;;             (_________mdl________
;; XOR2_L ios :("GND" "SX" "NW" "VDD" "A" "Z" "B")
mapcar('car getInstTermPoint(css()));=>("GND" "SX" "NW" "VDD" "Z" "A")

;addCells("BUFFER_C");=>("GND" "SX" "NW" "VDD" "Z" "A")

;xline1=appendBegin1(list(list(xline) nil) ajout);=> length(car(xlinedc)) 
caaar(xline1)
xline2=appendBegin2(list(list(xline) nil) 6 "start")
xline1=appendBegin1(xline2 ajout);=> length(car(xlinedc)) 
;xline2=appendBegin2(xline1 4 "start")
caaar(xline2)
xline2sch(xline1 "Ed_CMOS8" '((0 0)) "xor_DUT_sim" 0.4 0)

simXor(nil nil 100n)


curbs=foreach(mapcar i linRg(0 10 1)
name=sprintf(nil "Q_%d" i)
ame=sprintf(nil "frq_%d" i)
setq(plt freq(VT(name) "rising" ?xName "time" ?mode "user" ?threshold 0.6))
plot(plt ?expr list(ame))
)



plotCurbs(curbs)
(freq VT("/Q_1") "rising" ?xName "time") ;=> *Info*    Threshold=0.592
freq(VT("/Q_1") "rising" ?xName "time" ?mode "user" ?threshold 0.6)

; 1/value(frq 8n)-1/value(frq 88n) ;=> 6.036976e-14;=> 60f

intercept2('("Q_1" "Q_0") '("rising" "falling"))


;; cross(v("/Q_5" ?result "tran-tran") 0.6 1 "rising"  t "time"  );<= multiple
;; cross(v("/Q_5" ?result "tran-tran") 0.6 1 "rising"  nil nil  );<= single first edge
;; cross(v("/Q_5" ?result "tran-tran") 0.6 -1 "rising"  nil nil  );<= single last edge


plot(cross(VT("/Q_4") 0.6 1 "falling"  t "time"))
plot(cross(VT("/Q_5") 0.6 1 "rising"  t "time"))
plot(cross(VT("/Q_6") 0.6 1 "falling"  t "time"))
plot(cross(VT("/Q_7") 0.6 1 "rising"  t "time"))


ibmpat='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")
pat="XOR2_"

aa=cnpbin(5 11 t) ;=> 462 
length(aa=cnpbin(9 11 t));=> 55
iostr=foreach(mapcar a aa abIntToBinaryStr(a 11))

fam=foreach(mapcar io iostr mapcar('list ibmpat parseString(io "")))
car(fam);=> (("A" "0") ("B" "0") ("C" "0") ("D" "0") ("E" "0") ("F" "0") ("H" "1") ("I" "1") ("J" "1") ("K" "1") ("L" "1"))
length(fam)


;; c=caar(fam)
;; str=apply('strcat foreach(mapcar c car(fam) strcat("_" car(c) "_" cadr(c))))



ajout='(
("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.2)))
("vdc" ("gnd!" "SX")(("vdc" "float" 0)))
("vdc" ("gnd!" "GND")(("vdc" "float" 0)))
("vdc" ("gnd!" "NW")(("vdc" "float" 1.2)))
("vdc" ("gnd!" "VDD")(("vdc" "float" 1.2)))
; ("vdc" ("gnd!" "sel")(("vdc" "float" 0)))
;("INVERT_A" ("GND" "SX" "NW" "VDD" "selb" "sel"))
;("vpulse" ("gnd!" "pulse")(("v2" "string" "1.2")("tf" "string" "1p")("tr" "string" "1p")("per" "string" "20n")))
;("vdc" ("pulse" "Q_1")(("vdc" "float" 0)))
("vpwl" ("gnd!" "netpwl")(("t1" "string" "1n") ("vdc" "string" "0") ("v2" "string" "1.2") ("t2" "string" "1.001n")))
("BUFFER_C" ("GND" "SX" "NW" "VDD" "start" "netpwl"))
)

pat="XOR2_"
mdl='("GND" "SX" "NW" "VDD")
i=-1
xi=10
L=length(ibmpat) ;=> 11

xlines=
foreach(mapcar fami fam
fami=car(fam) ;=>(("A" "0") ("B" "0") ("C" "1") ("D" "1") ("E" "1") ("F" "1") ("H" "1") ("I" "1") ("J" "1") ("K" "1") ("L" "1"))
fa=car(fami)


defun(dllCombGen (@optional (fami '(("A" "0") ("B" "0") ("C" "1") ("D" "1") ("E" "1") ("F" "1") ("H" "1") ("I" "1") ("J" "1") ("K" "1") ("L" "1"))))
let((i e sel net cname xline xline2 xline1)
i=-1 xline=foreach(mapcar fa fami i++
e=car(fa)
sel=cadr(fa)
net=cond((sel=="0" "gnd!")(sel=="1" "vdd!"))
list(strcat(pat e)
append(mdl list(sprintf(nil "Q_%d" mod(i L)) sprintf(nil "Q_%d" mod(i+1 L))  net))
))
cname=sprintf(nil "xor%s" apply('strcat foreach(mapcar c fami strcat("_" car(c) cadr(c)))))
xline2=appendBegin2(list(list(xline) nil) 6 "start")
xline1=appendBegin1(xline2 ajout)
xline2sch(xline1 "Ed_CMOS8" '((0 0)) cname 0.4 0 nil nil)
cname))

cname=dllCombGen(fami)
;simXor("xor_A0_B0_C1_D1_E1_F1_H1_I1_J1_K1_L1")
simXor(cname)

foreach(mapcar fami fam
cname=dllCombGen(fami)
simXor(cname)
cname)


defun(dll2period (@optional (net "Q_")(from 0) (to 10)(plot nil)(bus "_")) let((bud)
bud=when(bus=="<" ">" "")
curbs=foreach(mapcar i linRg(from to 1)
name=strcat(net bus a2s(i) bud)
ame=sprintf(nil "per_%d" i)
setq(plt 1/freq(VT(name) "rising" ?xName "time" ?mode "user" ?threshold 0.6))
when(plot plot(plt ?expr list(ame)))
plt)))

perCurb=dll2period() ;=> perCurb;=> (srrWave:0x1605a4c0 ...)
dll2periodSave(perCurb cname)
edit(eval(strcat(pwd() "/" cname)))

defun(dll2periodSave (perCurb @optional (cname "xor_A0_B0_C1_D1_E1_F1_H1_I1_J1_K1_L1"))
fp=outfile(strcat(pwd() "/" cname))
mean20n=apply('plus foreach(mapcar per perCurb value(per 20n)))/length(perCurb)
mean40n=apply('plus foreach(mapcar per perCurb value(per 40n)))/length(perCurb)
fprintf(fp "per%s=%g;@40n:+%s" cname mean20n aelSuffixNotation(mean40n-mean20n))
close(fp)
mean20n)


