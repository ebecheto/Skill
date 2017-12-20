; GOTO preferably for now Fri Oct 11 13:44:02 CEST 2013
;; /afs/in2p3.fr/group/micrhau/CADENCE/Skill/

load("XOR_carac.proc.il")
ineed('(cnpbin array2sch transpose schematic2symbol netMakeBus vdcGen getHierName terminal2pin valueLast) t)


; load("cnpbin.il")

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


defun(dllCombGen2 (@optional (fami '(("A" "0") ("B" "0") ("C" "1") ("D" "1") ("E" "1") ("F" "1") ("H" "1") ("I" "1") ("J" "1") ("K" "1") ("L" "1"))))
let((i e sel net cname xline xline2 xline1 I0p pulse  DC0 DCr DC DL  ajout pat mdl)
I0p=cadar(fami)=="0" 
DC0='("0" "1.2") DCr=reverse(DC0)
DC=car(if(I0p DCr DC0))
DL=car(if(I0p DC0 DCr))
pulse='("vpwl" ("gnd!" "netpwl")(("t1" "string" "1n") ("v1" "string" DC)("vdc" "string" DC) ("v2" "string" DL) ("t2" "string" "1.001n")))
pulse=subst(DC 'DC pulse) pulse=subst(DL 'DL pulse)
ajout='(
("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.2)))
("vdc" ("gnd!" "SX")(("vdc" "float" 0)))
("vdc" ("gnd!" "GND")(("vdc" "float" 0)))
("vdc" ("gnd!" "NW")(("vdc" "float" 1.2)))
("vdc" ("gnd!" "VDD")(("vdc" "float" 1.2)))
pulse
("BUFFER_C" ("GND" "SX" "NW" "VDD" "start" "netpwl"))
)
ajout=subst(pulse 'pulse ajout)
pat="XOR2_" 
mdl='("GND" "SX" "NW" "VDD")
i=-1 
xline=foreach(mapcar fa fami i++
e=car(fa)
sel=cadr(fa)
net=cond((sel=="0" "gnd!")(sel=="1" "vdd!"))
list(strcat(pat e)
append(mdl list(sprintf(nil "Q_%d" mod(i L)) sprintf(nil "Q_%d" mod(i+1 L))  net))
))
cname=sprintf(nil "xor%s" apply('strcat foreach(mapcar c fami strcat("_" car(c) cadr(c)))))
xline2=appendBegin2(list(list(xline) nil) 6 "start")
xline1=appendBegin1(xline2 ajout)
list(xline2sch(xline1 "Ed_CMOS8" '((0 0)) cname 0.4 0 nil nil "w")
cname)))
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
cvname=dllCombGen2(cadr(fam));=> "xor_A0_B1_C0_D1_E1_F1_H1_I1_J1_K1_L1"
cv=car(cvname);~>cellView
cname=cadr(cvname)
libName=cv~>libName
cellName=cv~>cellName
;geOpen( ?lib libName ?cell cellName ?view "schematic")
schCheck(cv) dbCheck(cv)  dbSave(cv) ;dbClose(cv)
;dbOpenCellViewByType( libName cellName "schematic" "schematic" );=>ouvrir non "append"=delete
;simXor("xor_A0_B0_C1_D1_E1_F1_H1_I1_J1_K1_L1")
simXor(cellName libName)


perCurb=dll2period() ;=> perCurb;=> (srrWave:0x1605a4c0 ...)
dll2periodSave(perCurb cname)
edit(eval(strcat(pwd() "/" cname)))


; TODO RUN

length(aa=cnpbin(1 11 t)) ;=> 11
length(aa=cnpbin(3 11 t)) ;=> 165
length(aa=cnpbin(5 11 t)) ;=> 462 
length(aa=cnpbin(7 11 t)) ;=> 330
length(aa=cnpbin(9 11 t));=> 55
iostr=foreach(mapcar a aa abIntToBinaryStr(a 11))
fam=foreach(mapcar io iostr mapcar('list ibmpat parseString(io "")))
car(fam);=> aa= '(("A" "0") ("B" "0") ("C" "0") ("D" "0") ("E" "0") ("F" "0") ("H" "1") ("I" "1") ("J" "1") ("K" "1") ("L" "1"))


fams=nthcdr(10 fam) 
car(fams)
mList=dll2periodSim(fams)
edit(eval(strcat(pwd() "/" resName))) ;resName="XOR_DLLs.txt"


fami=car(fam)


ineed('list2wave)

;; get Result
perf=dllGetResult(fam) 
alist=foreach(mapcar p perf p);<= copie bidon sinon sort alist ecrase perf
perm=list2minus(perf)

myRmsf(perf t 20 t t '("period range" "period histo"))
myRmsf(perm t 20 t t '("delta t range" "delta t histo"))


;; cnpbin2fam('(2 3 t) '("A" "B" "C")) ;=>((("A" "0") ("B" "1") ("C" "1")) (("A" "1") ("B" "0") ("C" "1")) (("A" "1") ("B" "1") ("C" "0")))
;; cnpbin2fam('(1 3 t) '("A" "B" "C")) ;=>((("A" "0") ("B" "0") ("C" "1")) (("A" "0") ("B" "1") ("C" "0")) (("A" "1") ("B" "0") ("C" "0")))

; generate and run


ibmpat='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L");<= choix des posisions ;=> ABCDEFHIJKL
L=length(ibmpat);=> 11
parmis='(2 L t);=> 2 inverters parmis les 11 positions ;=> /!\ pas d'oscillation
parmis='(4 L t);=> 4 inverters parmis les 11 positions ;=> /!\ pas d'oscillation si nombre pair
parmis='(9 L t)
parmis='(7 L t)
parmis='(5 L t)
parmis='(3 L t)

parmis=subst(L 'L parmis);=> car la cote ' n'evalue pas L => on force la definition
fam=cnpbin2fam(parmis ibmpat) length(fam);=>330
mList=dll2periodSim(fam);<= lance les 300 simu

;; get Result
perf=dllGetResult(fam);<= recup les donnees
perm=list2minus(perf);<= fais le tableau des differences => N(N-1)/2 elements

myRmsf(perf t 20 t t '("period range" "period histo"))
myRmsf(perm t 20 t t '("delta t range" "delta t histo"))
awvDisplayTitle( awvGetCurrentWindow() sprintf(nil "[XOR %d Inverters %d Buffers : %s]   " car(parmis) L-car(parmis) apply('strcat ibmpat)))

fam=inv2fam(7) t
dll2periodSim(fam)
fam2display(fam)
famCheckFiles(fam)

fam=inv2fam(5) t
dll2periodSim(fam)
fam2display(fam)
famCheckFiles(fam)

fam=inv2fam(3) t
dll2periodSim(fam)
fam2display(fam)
famCheckFiles(fam)

fam=inv2fam(1) t
dll2periodSim(fam dir)
fam2display(fam dir)


triFreq=sortcar(dllGetResult2(fam) 'lessp)
printf("Motif le plus rapide: %L\n" car(triFreq))
printf("Motif le plus lent  : %L\n" car(last(triFreq)))

triDelta=sortcar(list2minus2(dllGetResult2(fam)) 'lessp)
marge=1p
marge1p=remove(nil foreach(mapcar tri triDelta when(-marge<car(tri)&&car(tri)<marge tri)))
length(marge1p);=> 147

marges=fam2marge(fam 30f)

combis='(1 3 5 7 9 )
fam='()
foreach(mapcar c combis
tmp=inv2fam(c)
fam=append(fam tmp)
printf("%d parmis 11 a %d combinaison\n" c length(tmp))
length(tmp))
apply('plus '(11 165 462 330 55))
;=>1023
length(fam)

fam2display(fam)
awvDisplayTitle( awvGetCurrentWindow() "All Combinaison : ABCDEFHIJKL")

marges=fam2marge(fam 10f)

means=foreach(mapcar c combis
fam=inv2fam(c)
list(
c
car(myRms(dllGetResult(fam)))
)
)
means;=>((1 2.666821e-08) (3 3.95451e-07) (5 1.09201e-06) (7 7.722239e-07) (9 1.271142e-07))

plot(list2wave(means))


motif='("A" "B" "C" "D" "E" "E" "D" "C" "B" "A")
length(motif);=> 10
; apply('strcat motif)
direp="ABCDEEDCBA"
dir=strcat(pwd() "/" direp)
unless(isDir(dir)  createDir(dir))
fam=inv2fam(3 motif) t
dll2periodSim(fam dir)
fam2display(fam dir)
fam2display(fam )



combis='(1 5 7 9 )
fam='()
c=5


motif2allFam('("A" "B" "C" "D" "E" "E" "D" "C" "B" "A") nil)

motif2='("F" "G" "H" "F" "G" "H" "F" "G" "H" "F")
dir2=strcat(pwd() "/" apply('strcat motif2))
motif2allFam(motif2 nil dir2)

motif3='("D" "J" "K" "F" "E" "L" "A" "D" "B" "E")
dir3=strcat(pwd() "/" apply('strcat motif3))
motif2allFam(motif3 nil dir3)


combis='(1 3 5 7 9 )
motif='("A" "B" "C" "D" "E" "E" "D" "C" "B" "A")


fam2displayAll(motif3)
fam2displayAll(motif2)

dllGetResult2(fam dir2)

fd=fam2displayAll(motif nil)
length(car(fd))
;; pourkoi les sim de xor_A0_B1_C1_D1_E1_F0_H0_I1_J1_K0_L1 sont dans :
;; ~/Work/IBMv18/ABCDEEDCBA/ABDCEEDCBA/ et ses resultat das /Work/IBMv18 ll FGHFGHFGHF
;; j'ai du faire une fausse manip...

ibmpat='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")
dirbug=strcat(pwd() "/ABCDEEDCBA/ABDCEEDCBA")
fd=fam2displayAll(ibmpat t dirbug)


xorFiles=remove(nil foreach(mapcan file ls("~/Work/IBMv18/ABCDEEDCBA") when(rexMatchp("xor_" file) list(file))))
xorFiles=remove(nil foreach(mapcan file ls("~/Work/IBMv18/ABCDEFGHIJKL") when(rexMatchp("xor_" file) list(file))))

unzero=foreach(mapcar file xorFiles  apply('strcat parseString(file "xor_ABCDEFHIJK")))
singleList(unzero)

unSum=foreach(mapcar file xorFiles  apply('plus  foreach(mapcar a parseString(file "xor_ABCDEFHIJK") atoi(a) )))
um=singleList(unSum);=> only 3
um

awvDisplayTitle( awvGetCurrentWindow() "3 Inv 7 Buf : ABCDEEDCBA")


checkFileDir();=>(1 3 5 7 9)
checkFileDir("ABCDEEDCBA");=>(3)



terminalGen("Q" 9 0 t t nil nil geGetWindowCellView() )
terminalGen("S" 9 0 t t nil nil geGetWindowCellView() )
; schematic2symbol()


array2sch()
terminalGen('("pin1" "pin2" "pin3") 1 1 )



motif='("E" "F" "H" "I" "E" "F" "H" "I")
xors=dllGenMotif(motif)
pins=foreach(mapcar x xors nth(4 cadr(x)))
pinq=foreach(mapcar x xors nth(6 cadr(x)))
pin2=list(pins pinq)
cellName=strcat("dll_" apply('strcat motif))
; cv=array2sch(list(xors) 'ibm cellName pin2 0.4 0.4 t t "w");=>  ttw => openVerboseWrite
cv=array2sch(list(xors) 'ibm cellName pin2 0.4 0.4 nil t "w");=> superpose
; TODO : DLLmkList

schs=schematic2symbol(cv t nil);=> oki


cellSim=strcat("dll_" apply('strcat motif) "_sim")
cvSim=dbOpenCellViewByType( libName cellSim ...)
addCell(cellName cvSim)

getInstTermPoint()
wirePinName()
truc='f1rst; '1st marche pas : pas de digit en premier caracter


L=8
cells=dllGenMotifBuDff(L 'test  '("gnd!" "sx!" "nw!" "vdd!"))
pins=foreach(mapcar n linRg(0 L-1 1) sprintf(nil "Q_%d" n));=>("Q_0" "Q_1" "Q_2" "Q_3" "Q_4" "Q_5" "Q_6" "Q_7")
cellName=sprintf(nil "dll__load_%d" L)
; cv=array2sch(cells 'ibm cellName pins)
cv=array2sch(transpose(cells) 'ibm cellName list(pins))
schs=schematic2symbol(cv nil t)



;; make BUFFER LOAD
L=11
cells=dllGenMotifBuDff(L '(("BUFFER_C" ("Z_" "Q_")) ("DFF_E" (t t "Q_" "Q_")))  '("gnd!" "sx!" "nw!" "vdd!"))
pins=list(netMakeBus("Q" L t "_") netMakeBus("Z" L  t "_"))
cellName=sprintf(nil "dll__load_%d" L);=> "dll__load_11"
cv=array2sch(transpose(cells) 'ibm cellName pins)
schs=schematic2symbol(cv nil t)



aList='(("BUFFER_N" (("Z<" 0) ("Q<" 0))) ("DFF_E" (t t t ("Q<" 0))))
foreach(mapcar L linRg(8 11 1) 
pins=list(netMakeBus("Q" L) netMakeBus("Z" L))
generateHAList(L aList pins nil strcat("ch_BN_DE_" a2s(L)) t nil 't))


aList='(("BUFFER_N" (("Z<" 0) ("Q<" 0))) )
foreach(mapcar L linRg(8 11 1) 
pins=list(netMakeBus("Q" L) netMakeBus("Z" L))
generateHAList(L aList pins nil strcat("ch_BUN_" a2s(L)) t nil 't))


aList='(("DFF_E" (("Q<" 1 t) t ("Q<" 0) ("CLK" nil))))
foreach(mapcar L linRg(8 11 1)
pins=list(list("Q<0>" "CLK") netMakeBus("Q" list(1 L) t "<"))
generateHAList(L aList pins nil strcat("ch_DE_" a2s(L)) nil nil 't))






ineed('dllCombGen2 t);<== define here dllGenMotifBuDff


L=8
cells=dllGenMotifBuDff(L '(("BUFFER_C" ("Z_" "Qf_"))) '("gnd!" "sx!" "nw!" "vdd!"))

pins=foreach(mapcar n linRg(0 L-1 1) sprintf(nil "Qf_%d" n))
pinZ=foreach(mapcar n linRg(0 L-1 1) sprintf(nil "Z_%d" n))
cellName=sprintf(nil "dll__invsZ_%d" L)
; cv=array2sch(cells 'ibm cellName pins)
cv=array2sch(transpose(cells) 'ibm cellName list(pins pinZ))
schs=schematic2symbol(cv nil t)



whereExistCell3("dll__invsZ_8") ;=> ("Ed_CMOS8" "symbol" "Ed_CMOS8" "schematic")
whereExistCell3("dll__invsZ_7") ;=> nil


;; halfAdderList='(
;; ("AND2_C" (("C_" 0 t) ("C_" -1) "S<" ))
;; ("XOR2_C" (("C_" -1) "Sum_" "S<"))
;; ("DFF_E"  ("Q_" "Sb<" "Sum_" ("clk" nil) ))
;; ("AND2_C" ("S<" ("C_0" nil)  "Q_" ))
;; )

halfAdderList='(
("AND2_C" (("C_" 1 t) "C_" "S<" ))
("XOR2_C" ("C_"  "Sum_"  "S<"))
("DFF_E"  ("Q_" "Sb<" "Sum_" ("clk" nil) ))
("AND2_C" ("S<" ("C_0" nil)  "Q_" ))
)



;; STUDY THE CELLS YOU WANT TO LIST
yos=addCell( mapcar('car halfAdderList))
yo=foreach(mapcar inst yos cons(strcat(inst~>cellName ":") mapcar('car getInstTermPoint(inst))))
;foreach(y yo printf("%L\n" y))
;; ("AND2_C:" "GND" "SX"  "NW" "VDD" "Z" "A" "B")
;; ("XOR2_C:" "GND" "SX"  "NW" "VDD" "A" "Z" "B")
;; ("DFF_E:"  "SX"  "GND" "NW" "VDD" "Q" "QBAR" "D" "CLK")
;; ("AND2_C:" "GND" "SX"  "NW" "VDD" "Z" "A" "B")

;=> (("AND2_C:" "GND" "SX" "NW" "VDD" "Z" "A" "B") ("XOR2_C:" "GND" "SX" "NW" "VDD" "A" "Z" "B") ("DFF_E:" "SX" "GND" "NW" "VDD" "Q" "QBAR" "D" "CLK") ("AND2_C:" "GND" "SX" "NW" "VDD" "Z" "A" "B"))

mdl='("gnd!" "sx!" "nw!" "vdd!")
mde='("sx!" "gnd!" "nw!" "vdd!")
HAL=foreach(mapcar h halfAdderList cond(
(rexMatchp("DFF" car(h)) append(list(car(h)) list(append(mde cadr(h)))))
(t  append(list(car(h)) list(append(mdl cadr(h)))))
))

L=11
cells=dllGenMotifHA(L HAL '())
cellName=sprintf(nil "COUNT_%d-bit" L)
pins=cons('("C_0" "clk") list(list((sprintf nil "S<0:%d>" L-1) (sprintf nil "Sb<0:%d>" L-1) (sprintf nil "C_%d" L))))
cv=array2sch(cells 'ibm cellName reverse(pins))
;cv=array2sch(transpose(HAL) 'ibm cellName list(pins) )
schs=schematic2symbol(cv t t)
schs;=> ("COUNT_8-bit" "COUNT_8-bit_sim")
; addCell("COUNT_8-bit")
; tb should be test bench elements (vdd gnd vpulse vpwl etc...
; array2sch(tb 'cv 'cv)
;; pulse='("vpwl" ("gnd!" "netpwl")(("t1" "string" "1n") ("v1" "string" DC)("vdc" "string" DC) ("v2" "string" DL) ("t2" "string" "1.001n")))
;; DC="1.2" DL="0"
;; pulse=subst(DC 'DC pulse) pulse=subst(DL 'DL pulse)
;; array2sch(list(list(pulse)) cv~>libName cadr(schs) nil 0.4 0.4 t nil "a");< TODO

; getPropList()
V0='("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.2)))
Vnw='("vdc" ("gnd!" "nw!")(("vdc" "float" 1.2)))
Vsx='("vdc" ("gnd!" "nx!")(("vdc" "float" 0.0)))
V1='("vpwl" ("gnd!" "vstart") (("v2" "string" "1.8") ("v6" "string" "1.8") ("t6" "string" "21.1n") ("t5" "string" "21n") ("t4" "string" "20.1n") ("v3" "string" "1.8") ("t3" "string" "20n") ("t2" "string" "1.1n") ("t1" "string" "1n")))
V2='("vpulse" ("gnd!" "vclk") (("v2" "string" "1.8") ("tf" "string" "100.0f") ("tr" "string" "100.0f") ("per" "string" "1n")))
V3='("BUFFER_C" ("gnd!" "sx!" "nw!" "vdd!" "clk" "vclk"))
V4='("BUFFER_C" ("gnd!" "sx!" "nw!" "vdd!" "C_0" "vstart"))

pulse=list(list(V0 V1 V2 V3 V4))

bBox=caddr(schs)~>bBox
;=> ((-0.9 -0.65) (1.3 -0.24375))
xy=mapcar('plus car(bBox) '(0 -1))
;; array2sch(pulse cv~>libName cadr(schs) nil 0.4 0.4 t nil "a");< TODO
array2sch(pulse cv~>libName cadr(schs) nil 0.4 0.4 t nil "a" xy);< TODO


;vpwl=> start apres buffer
; vpulse =>clk apres buffer

ineed('dllCombGen2 t);<== define here dllGenCounter
dllGenCounter(10)

terminalGen('("Q_0" "Q_1" "Q_2" "Q_3" "Q_4" "Q_5" "Q_6" "Q_7"))



pins=foreach(mapcar n linRg(0 L-1 1) sprintf(nil "Sf_%d" n));=>("Q_0" "Q_1" "Q_2" "Q_3" "Q_4" "Q_5" "Q_6" "Q_7")
;=>> ("Sf_0" "Sf_1" "Sf_2" "Sf_3" "Sf_4" "Sf_5" "Sf_6" "Sf_7")
terminalGen1(pins)
pins=foreach(mapcar n linRg(0 L-1 1) sprintf(nil "S_%d" n));=>("Q_0" "Q_1" "Q_2" "Q_3" "Q_4" "Q_5" "Q_6" "Q_7")
terminalGen1(pins)
pins=foreach(mapcar n linRg(0 L-1 1) concat('Q '_ n));=>("Q_0" "Q_1" "Q_2" "Q_3" "Q_4" "Q_5" "Q_6" "Q_7")
; Q_0 Q_1 Q_2 Q_3 Q_4 Q_5 Q_6 Q_7



;; PHASE DETECTOR voir plus bas à : PDmklist
; Si un seul (L=1)
halfAdderList='(
("DFF_E"  (("Q") t ("D") ("C") ))
("DFF_E"  (t ("Qb") ("Q") ("C") ))
("NAND2_C" (("S") ("Qb") ("Q") ))
)
mdl='("gnd!" "sx!" "nw!" "vdd!")
mde='("sx!" "gnd!" "nw!" "vdd!")
HAL=foreach(mapcar h halfAdderList cond(
(rexMatchp("DFF" car(h)) append(list(car(h)) list(append(mde cadr(h)))))
(t  append(list(car(h)) list(append(mdl cadr(h)))))
))

;; Si plusieurs arguments => on increment
halfAdderList='(
("DFF_E"  (("Q" 0) t ("D<" 0) ("C<" 0) ))
("DFF_E"  (t ("Qb" 0) ("Q" 0) ("C<" 0) ))
("NAND2_C" (("S<" 0) ("Qb" 0) ("Q" 0) ))
)
mdl='("gnd!" "sx!" "nw!" "vdd!")
mde='("sx!" "gnd!" "nw!" "vdd!")
HAL=foreach(mapcar h halfAdderList cond(
(rexMatchp("DFF" car(h)) append(list(car(h)) list(append(mde cadr(h)))))
(t  append(list(car(h)) list(append(mdl cadr(h)))))
))

;; STUDY THE CELLS YOU WANT TO LIST
yos=addCell( mapcar('car halfAdderList))
yo=foreach(mapcar inst yos cons(strcat(inst~>cellName ":") mapcar('car getInstTermPoint(inst))))
foreach(dbObject yos dbDeleteObject(dbObject));=>on les supprime. C'est mieux de ne pas inserer dans un schema mais c'est plus rapide a ecrire que dbCreateInst...
;(("DFF_E:" "SX" "GND" "NW" "VDD" "Q" "QBAR" "D" "CLK") ("DFF_E:" "SX" "GND" "NW" "VDD" "Q" "QBAR" "D" "CLK") ("NAND2_C:" "GND" "SX" "NW" "VDD" "Z" "B" "A"))


L=8
cells=dllGenMotifHA(L HAL '())

cellName=sprintf(nil "PhaseDet_%d-bit" L)
;pins=cons('("C_0" "clk") list(list((sprintf nil "S<0:%d>" L-1) (sprintf nil "Sb<0:%d>" L-1) (sprintf nil "C_%d" L))))
pins='(("C" "D")("S"));<= choix L=1

pins=list(append(netMakeBus("C" L) netMakeBus("D" L)) netMakeBus("S" L))
cv=array2sch(cells 'ibm cellName reverse(pins))
; cv=array2sch(cells 'ibm cellName pins)

;<= NOT NECESSARY
schs=schematic2symbol(cv t t) ;=> ("COUNT_8-bit" "COUNT_8-bit_sim")
PWR='(("vdc" ("gnd!" "vdd!") (("vdc" "string" "1.2")))("vdc" ("gnd!" "nw!") (("vdc" "string" "1.2")))("vdc" ("gnd!" "sx!") (("vdc" "string" "0"))))
V0='("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.2)))  ;=> getPropList()
;; Vnw='("vdc" ("gnd!" "nw!")(("vdc" "float" 1.2)))
;; Vsx='("vdc" ("gnd!" "nx!")(("vdc" "float" 0.0)))
V1='("vpwl" ("gnd!" "vstart") (("v2" "string" "1.8") ("v6" "string" "1.8") ("t6" "string" "21.1n") ("t5" "string" "21n") ("t4" "string" "20.1n") ("v3" "string" "1.8") ("t3" "string" "20n") ("t2" "string" "1.1n") ("t1" "string" "1n")))
V2='("vpulse" ("gnd!" "vclk") (("v2" "string" "1.8") ("tf" "string" "100.0f") ("tr" "string" "100.0f") ("per" "string" "1n")))
V3='("BUFFER_C" ("gnd!" "sx!" "nw!" "vdd!" "clk" "vclk"))
V4='("BUFFER_C" ("gnd!" "sx!" "nw!" "vdd!" "C_0" "vstart"))
pulse=list(append(list(V0 V1 V2 V3 V4) list(PWR)))
bBox=caddr(schs)~>bBox ;=> ((-0.9 -0.65) (1.3 -0.24375))
xy=mapcar('plus car(bBox) '(0 -1))
array2sch(pulse cv~>libName cadr(schs) nil 0.4 0.4 t nil "a" xy)

; cv=geGetWindowCellView()

;; terminal2pin("Sync" t "S" );<= arf non pas ca, ca a mis toutes les pins sur SX aussi...
;; while(sx=setof(term cv~>terminals term~>name=="SX")
;; dbDeleteObject(car(sx)))
terminal2pin("Sync" nil "S");=> oki

pins=foreach(mapcar n linRg(0 7 1) sprintf(nil "Sync_%d" n));=> ("Sync_0" "Sync_1" "Sync_2" "Sync_3" "Sync_4" "Sync_5" "Sync_6" "Sync_7")
terminalGen1(pins)
foreach(mapcar n linRg(0 7 1) concat('Sync '_ n));=>("Q_0" "Q_1" "Q_2" "Q_3" "Q_4" "Q_5" "Q_6" "Q_7")
; Sync_0 Sync_1 Sync_2 Sync_3 Sync_4 Sync_5 Sync_6 Sync_7
schematic2symbol()



getPropList();=> ("vdc" ("gnd!" "Sf_3") (("vdc" "string" "Sf_3")))




;; PHASE DETECTOR TESTBENCH ;=> vdcGen
halfAdderList='(("vdc" ("gnd!" "Sf_") (("vdc" "string" "Sf_")))) ;=> pas encore pris en compte l'incrementation des parameter type string ou autre

printf("vdcGen(\"FDC\" t 3 8)\n"); vdcGen("FDC" t 3 8)
printf("vdcGen(\"SDC\" t 3 8)\n"); vdcGen("SDC" t 3 8)

; vdcGen("Sf" t 0 7);=> tableau de vdc => ...
vdcGen("S" t 2 8)
bus2_();<= of selected set


res=remove(nil foreach(mapcan nb linRg(1 2**8 1)  ;nb= 18 ;abIntToBinaryStr(11 4);=>"1011"
ones=remove( "0" str=parseString(bins=abIntToBinaryStr(nb 8) "")) ;("1" "1")
list(when(car(reverse(str))=="1"&&oddp(length(ones)) printf("lsb=1 et nb 1 impaire:%L\n" list(nb bins)) bins))
))
;^^ ces lignes font bugger mon virtuoso2emacs ... Non c'est moi, j'ai oublier que le retour ne marche que pr line

length(res)
yo=foreach(mapcar r res r)
yo='("00000001" "00000111" "00001011" "00001101" "00010011" "00010101" "00011001" "00011111" "00100011" "00100101" "00101001" "00101111" "00110001" "00110111" "00111011" "00111101" "01000011" "01000101" "01001001" "01001111" "01010001" "01010111" "01011011" "01011101" "01100001" "01100111" "01101011" "01101101" "01110011" "01110101" "01111001" "01111111" "10000011" "10000101" "10001001" "10001111" "10010001" "10010111" "10011011" "10011101" "10100001" "10100111" "10101011" "10101101" "10110011" "10110101" "10111001" "10111111" "11000001" "11000111" "11001011" "11001101" "11010011" "11010101" "11011001" "11011111" "11100011" "11100101" "11101001" "11101111" "11110001" "11110111" "11111011" "11111101")
;  ^^ le lsb a "1", c'est bien le bit le plus a droite
length(yo);=> 64

foreach(mapcar bin yo abBinaryStrToInt(bin));=> (1 7 11 13 19 21 25 31 35 37 41 47 49 55 59 61 67 69 73 79 81 87 91 93 97 103 107 109 115 117 121 127 131 133 137 143 145 151 155 157 161 167 171 173 179 181 185 191 193 199 203 205 211 213 217 223 227 229 233 239 241 247 251 253)

vdcGen("S" t 1 '(0 7) 'nil 1.2 0)
vdcGen("Sf" t 1 '(0 7) 'nil 1.2 0)

cv=geGetWindowCellView()
cv~>terminals
nil

terms=cv~>nets~>instTerms

term=car(terms)

insts~>??


insts=car(setof(n cv~>nets n~>name=="S_0"))~>instTerms~>inst
inst=car(setof(i insts i~>cellName=="vdc"))



; getPropList();=> ("vpwl" ("gnd!" "net01") (("vdc" "string" "0") ("td" "string" "300p") ("t1" "string" "1n") ("t2" "string" "1.1n") ("v2" "string" "1.2")))

xy=inst~>xy;=>(-2.375 1.15625)
xy='(-2.375 1.15625)
dbDeleteObject(inst)

Vena='("vpwl" () (("vdc" "string" "0") ("td" "string" "300p") ("t1" "string" "1n") ("t2" "string" "1.1n") ("v2" "string" "1.2")))
; array2sch1(list(list(Vena)) nil xy)


addCellg(Vena xy)

xy=css()~>xy;=>(-2.8125 -1.59375)

grid=schGetEnv("symSnapSpacing");=>0.0625

xy2=mapcar('plus xy -2:0);=>(-4.8125 -1.59375)
xy4=mapcar('plus xy -4:0);=>(-4.8125 -1.59375)
; foreach(mapcar a xy round(a/grid)*grid)

Vena='("vpwl" nil (("vdc" "string" "0") ("td" "string" "300p") ("t1" "string" "1n") ("t2" "string" "1.1n") ("v2" "string" "1.2")))

addCellg(Vena xy)


inst=carInstNetCell("Sf_0" "vdc");=> db:0x12739a62
ppp=getPropList() ;=> ("vpwl" ("gnd!" "net1") (("vdc" "string" "0") ("v2" "string" "1.2") ("t2" "string" "1.1n") ("t1" "string" "1n")))
ppp=append(list(car(ppp) nil) cddr(ppp))
xy=inst~>xy
dbDeleteObject(inst)
addCellg(Vena xy)



pulse='("vpwl" nil (("vdc" "string" "0") ("td" "string" "300p") ("t1" "string" "1n") ("t2" "string" "1.1n") ("v2" "string" "1.2")))
pulsef='("vpwl" nil (("vdc" "string" "0") ("v2" "string" "1.2") ("t2" "string" "1.1n") ("t1" "string" "1n")))

fixPulseNet()

;; ______epresente: msb>76543210<lsb
abIntToBinaryStr(19 8) "00010011";<= S
abIntToBinaryStr(155 8)"10011011";<= Sf
abIntToBinaryStr(277 11); "10011011";<= Sf


vdcGen("S" t 1 '(0 7) 'nil 1.2 0)
vdcGen("Sf" t 1 '(0 7) 'nil 1.2 0)
schCheck(geGetWindowCellView());<= sinon difPulseNet marche pas.
fixPulseNet()


VT("/I0/Qf_0")
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/dll_2ndGuess_sim/spectre/schematic"
; resultsDir()
freq1=dll2period(dir "/I0/Qf_" 0 7 t)
freq2=dll2period(dir "/I0/Q_" 0 7 t)

for(i 0 7 plot(VT(strcat("/I0/Q_" a2s(i)))))
for(i 0 7 plot(VT(strcat("/I0/Qf_" a2s(i)))))

plot(VT("/I0/Q_3"))
plot(VT("/I0/Qf_3"))
plot(VT("/Sync_7"))

ineed('getHierName t)

i=3
Snet=strcat("Sync_" a2s(i))
inst=carInstNetCell(Snet "PhaseDet_1-bit")
nets=inst~>conns~>net~>name ;=>("Qf_2" "Q_4" "Sync_6")
inst~>conns~>net~>signals~>??

syncs=foreach(mapcar i linRg(0 7 1)
Snet=strcat("Sync_" a2s(i))
inst=carInstNetCell(Snet "PhaseDet_1-bit")
nets=inst~>conns~>net~>name
)


defun(connInstNames (@optional (instName "Sf_0")(cellName "vdc"))
carInstNetCell(instName cellName)~>conns~>net~>name
)

connInstNames("Sync_2" "PhaseDet_1-bit")
;=> ("Q_6" "Qf_0" "Sync_2")

(setq idWin hiGetCurrentWindow())

;; CA DEPENDE QUELLE VUE DE LA HIERARCHIE ON REGARDE !!
cv=idWin~>cellView;=>db:0x1a85fb1a
cv=geGetWindowCellView();=>db:0x1a85fb1a

hiGetCurrentWindow()~>topCellView;=>db:0x1273231a
hiGetCurrentWindow()~>cellView;=>db:0x1273231a
cv=idWin~>cellView;=>;=>db:0x1a85fb1a
cv=geGetWindowCellView();=>db:0x1273231a

hiGetCurrentWindow()~>topCellView~>sigNames


defun(connInstNames2hier (@optional (nets '("Q_6" "Qf_0" "Sync_2") ) (idWin t)(sep ".")(sep1 "."))
let((hier cv) when(idWin==t idWin=hiGetCurrentWindow())
hier=getHierName(idWin sep);=>"I0/"
cv=idWin~>topCellView
foreach(mapcar net nets
printf("member(%s '%L);=> %L\n" net  cv~>sigNames member(net cv~>sigNames))
prepend=if(member(net cv~>sigNames) "" strcat(sep1 hier) )
strcat(prepend net))
))

connInstNames2hier();=> (".I0.Q_6" ".I0.Qf_0" "Sync_2")
connInstNames2hier('("Q_6" "Sync") t "/" "") ;=>("I0/Q_6" "I0/Sync")
connInstNames2hier('("Q_6" "Sync_6") t "/" "/");=> ("/I0/Q_6" "Sync_6") oki mais doit etre recursive si plus de sous instances

;; syncs='(("Qf_7" "Q_7" "Sync_0") 
;;     ("Q_0" "Qf_6" "Sync_1") 
;;     ("Qf_0" "Q_6" "Sync_2") 
;;     ("Q_1" "Qf_5" "Sync_3") 
;;     ("Qf_1" "Q_5" "Sync_4")
;;     ("Q_2" "Qf_4" "Sync_5") 
;;     ("Qf_2" "Q_4" "Sync_6") 
;;     ("Q_3" "Qf_3" "Sync_7")
;; )

insts~>cellName

hier=getHierName(t "/");=>"I0/"

cv~>sigNames

foreach(mapcar PD syncs
foreach(mapcar net PD
prepend=if(member(net cv~>sigNames) "" strcat("/" hier) )
srw=VT(strcat(prepend net))
plot(srw ?expr list(net))
)
addSubwindow()
)


defun(plotCellNets (@optional (instName "Sf_0")(cellName "vdc")(inc 1)(bus "_")(cv t)(sub nil))
let((hier syncs Snets inst nets prepend srw plot bud)
when(cv==t cv=hiGetCurrentWindow()~>topCellView)
bud=if(bus=="<" ">" "")
hier=getHierName(t "/");=>"I0/"
if(listp(inc) then from=car(inc) to=cadr(inc)||from
syncs=foreach(mapcar i linRg(from to 1)
Snet=strcat(instName bus a2s(i) bud)
inst=carInstNetCell(Snet cellName)
printf("inst:%L\n" inst~>name)
nets=inst~>conns~>net~>name
)
else
Snet=instName
syncs=list(carInstNetCell(Snet cellName)~>conns~>net~>name)
printf("syncs:%L\n" syncs)
)
foreach(mapcar PD syncs
foreach(mapcar net PD
prepend=if(member(net cv~>sigNames) "" strcat("/" hier) )
srw=VT(strcat(prepend net))
plot(srw ?expr list(net))
)
when(sub addSubwindow())
srw);=> renvoie la last srwave par bunch d'increment
))

cv~>nets


plot(VT("/I0/Q_1"))
plot(VT("/I0/Qf_5"))
plot(VT("/Sync_3"))

plotCellNets("Sync_" "PhaseDet_1-bit" 1)
plotCellNets("Sync_" "PhaseDet_1-bit" '(2 4))
plotCellNets("Sync" "PhaseDet_1-bit" 1 "_")
srwq=plotCellNets("Qf" "dll_EDBECHBECH" '(0 10) "<")

carInstNetCell("Qf<0>" "dll_EDBECHBECH" )

cv=apply('array2sch PDmklist(11))
schs=schematic2symbol(cv t t) ;=> 

fcv=apply('array2sch DLLmklist('("B" "E" "C" "H" "B" "E" "C" "H")))
schs=schematic2symbol(cv t t) ;=> 
cv=apply('array2sch DLLmklist('("E" "D" "B" "E" "C" "H" "B" "E" "C" "H")))
schs=schematic2symbol(cv t t) ;=> 
schematic2symbol()

motif='("E" "D" "B" "E" "C" "H" "B" "E" "C" "H")
motif='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")
cv=apply('array2sch DLLmklist(motif))
schs=schematic2symbol(cv nil nil) ;=> 
;dllMotifSch(motif)

L=length(motif)
DLL=apply('strcat cons("d_" motif))
PD=strcat("PhaseDet_" a2s(L) "-bit")
BD=strcat("dllch_BD_" a2s(L) )
B=strcat("dllch_B_" a2s(L) )
CNT=strcat("COUNT_" a2s(L) "-bit")
CNT=strcat("COUNT_" a2s(L) "-bit")

tdcList=list(
list(
list(DLL append( netMakeBus("Qf" L) netMakeBus("Sf" L)))
list(PD append(netMakeBus("Sync" L t "_") mixPDnets(L '("Q" "Qf"))  ) )
list(DLL append(netMakeBus("Q" L) netMakeBus("S" L) ))
) list(
list(B append(netMakeBus("BU" L) netMakeBus("Q" L) ))
list(BD append(netMakeBus("B" L) netMakeBus("Qf" L)))
list(CNT append(netMakeBus("CNT" L nil) append(netMakeBus("CNTb" L nil) list("CL" "S<0>" "BU<4>"))))
list(CNT append(netMakeBus("CNT2" L nil) append(netMakeBus("CNTb2" L nil) list("CL2" "Sf<0>" "B<4>"))))
))

; netMakePost("BU<4>" list(5 2*10))
pins=list(
append(netMakeBus("Sf" L) netMakeBus("S" L))
append(netMakeBus("Sync" L t "_") list(strcat("CNT<0:" a2s(L-1) ">") ))
)

cv=array2sch(tdcList 'ibm "tdc3" reverse(pins) 0.0 0.0)
;pins affterwards
foreach(mapcar pin pins terminalGen(pin 1 1 t t nil nil cv))
schs=schematic2symbol(cv t t t) ;=> generate power allready
schematic2symbol()

;; vdcGen("Q" t 1 '(0 7) 'nil 1.2 0)
;; vdcGen("Qf" t 1 '(0 7) 'nil 1.2 0)
vdcGen("S" t 1 list(0 L-1) t 1.2 0)
vdcGen("Sf" t 1 list(0 L-1) t 1.2 0)
; vdcPWRgen()
schCheck(geGetWindowCellView());<= sinon difPulseNet marche pas.
fixPulseNet('("S<0>" "Sf<0>") )
; schs=geGetWindowCellView()

fixPulseNet('("S_0"))

series=vdcPWRcode(L)
length(series);=> 512
nthcdr(512-200-64 reverse(nthcdr(200 series))) ;=> ne prends que 64 echantillons
nbs='(1053 1051 1047 1041 1039 1033 1029 1027 1021 1019 1015 1009 1007 1001 997 995 991 985 981 979 973 971 967 961 959 953 949 947 941 939 935 929 925 923 919 913 911 905 901 899 895 889 885 883 877 875 871 865 861 859 855 849 847 841 837 835 829 827 823 817 815 809 805 803)

listNN12(nbs)
1051
 
;; (1 7 11 13 19 21 25 31 35 37 41 47 49 55 59 61 67 69 73 79 81 87 91 93 97 103 107 109 115 117 121 127 131 133 137 143 145 151 155 157 161 167 171 173 179 181 185 191 193 199 203 205 211 213 217 223 227 229 233 239 241 247 251 253 259 261 265 271 273 279 283 285 289 295 299 301 307 309 313 319 321 327 331 333 339 341 345 351 355 357 361 367 369 375 379 381 385 391 395 397 403 405 409 415 419 421 425 431 433 439 443 445 451 453 457 463 465 471 475 477 481 487 491 493 499 501 505 511 515 517 521 527 529 535 539 541 545 551 555 557 563 565 569 575 577 583 587 589 595 597 601 607 611 613 617 623 625 631 635 637 641 647 651 653 659 661 665 671 675 677 681 687 689 695 699 701 707 709 713 719 721 727 731 733 737 743 747 749 755 757 761 767 769 775 779 781 787 789 793 799 803 805 809 815 817 823 827 829 835 837 841 847 849 855 859 861 865 871 875 877 883 885 889 895 899 901 905 911 913 919 923 925 929 935 939 941 947 949 953 959 961 967 971 973 979 981 985 991 995 997 1001 1007 1009 1015 1019 1021 1027 1029 1033 1039 1041 1047 1051 1053 1057 1063 1067 1069 1075 1077 1081 1087 1089 1095 1099 1101 1107 1109 1113 1119 1123 1125 1129 1135 1137 1143 1147 1149 1153 1159 1163 1165 1171 1173 1177 1183 1187 1189 1193 1199 1201 1207 1211 1213 1219 1221 1225 1231 1233 1239 1243 1245 1249 1255 1259 1261 1267 1269 1273 1279 1281 1287 1291 1293 1299 1301 1305 1311 1315 1317 1321 1327 1329 1335 1339 1341 1347 1349 1353 1359 1361 1367 1371 1373 1377 1383 1387 1389 1395 1397 1401 1407 1411 1413 1417 1423 1425 1431 1435 1437 1441 1447 1451 1453 1459 1461 1465 1471 1473 1479 1483 1485 1491 1493 1497 1503 1507 1509 1513 1519 1521 1527 1531 1533 1537 1543 1547 1549 1555 1557 1561 1567 1571 1573 1577 1583 1585 1591 1595 1597 1603 1605 1609 1615 1617 1623 1627 1629 1633 1639 1643 1645 1651 1653 1657 1663 1667 1669 1673 1679 1681 1687 1691 1693 1697 1703 1707 1709 1715 1717 1721 1727 1729 1735 1739 1741 1747 1749 1753 1759 1763 1765 1769 1775 1777 1783 1787 1789 1795 1797 1801 1807 1809 1815 1819 1821 1825 1831 1835 1837 1843 1845 1849 1855 1857 1863 1867 1869 1875 1877 1881 1887 1891 1893 1897 1903 1905 1911 1915 1917 1921 1927 1931 1933 1939 1941 1945 1951 1955 1957 1961 1967 1969 1975 1979 1981 1987 1989 1993 1999 2001 2007 2011 2013 2017 2023 2027 2029 2035 2037 2041 2047)

;; vdcPWRcode(L)
;; (1 7 11 13 19 21 25 31 35 37 41 47 49 55 59 61 67 69 73 79 81 87 91 93 97 103 107 109 115 117 121 127 131 133 137 143 145 151 155 157 161 167 171 173 179 181 185 191 193 199 203 205 211 213 217 223 227 229 233 239 241 247 251 253 259 261 265 271 273 279 283 285 289 295 299 301 307 309 313 319 321 327 331 333 339 341 345 351 355 357 361 367 369 375 379 381 385 391 395 397 403 405 409 415 419 421 425 431 433 439 443 445 451 453 457 463 465 471 475 477 481 487 491 493 499 501 505 511 515 517 521 527 529 535 539 541 545 551 555 557 563 565 569 575 577 583 587 589 595 597 601 607 611 613 617 623 625 631 635 637 641 647 651 653 659 661 665 671 675 677 681 687 689 695 699 701 707 709 713 719 721 727 731 733 737 743 747 749 755 757 761 767 769 775 779 781 787 789 793 799 803 805 809 815 817 823 827 829 835 837 841 847 849 855 859 861 865 871 875 877 883 885 889 895 899 901 905 9f11 913 919 923 925 929 935 939 941 947 949 953 959 961 967 971 973 979 981 985 991 995 997 1001 1007 1009 1015 1019 1021)

;; vdcPWRcode(L t)
;; length(vdcPWRcode(11) ;=> 512 (que les impaires : /2, moins le lsb a 1 (=> **10 au lieu de **11) => 2**10/2
;; (512+513)/2;=>131 328 ;=> nombre de soustractions possibles

;; ;=>( ... "1111100101" "1111101001" "1111101111" "1111110001" "1111110111" "1111111011" "1111111101")

dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/dll_2ndGuess_sim/spectre/schematic"
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc2_sim/spectre/schematic"
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc3_sim/spectre/schematic"
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc4_sim/spectre/schematic"
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc5_sim/spectre/schematic"
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc6_sim/spectre/schematic"
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc7_sim/spectre/schematic"

L=11
simulator('spectre)
lib="Ed_CMOS8"
cell="tdc7_sim"
design(lib cell "schematic")
resultsDir();=>"/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc6_sim/spectre/schematic"
openResults(resultsDir());<= equivalent de ADE->select Results
freq1=dll2period(dir "/I0/Qf" 0 L-1 t "<")
freq2=dll2period(dir "/I0/Q" 0 L-1 t "<")


foreach(mapcar nb linRg(0 11 1) plot(VT(strcat("Sync_" itos(nb))) ?expr list(strcat("Sync_" itos(nb)))))


plot(VT("/I0/Q<0>") dir)
plot(VT("/I0/Q<10>") dir)

abIntToBinaryStr(round(VAR("S")) 11);=> "10000011011"
abIntToBinaryStr(round(VAR("Sf")) 11)


;; TDC4
motif='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")

L=length(motif)
DLL=apply('strcat cons("d_" motif))
PD=strcat("PhaseDet_" a2s(L) "-bit")
BD=strcat("ch_BN_DE_" a2s(L) )
B=strcat("ch_BUN_" a2s(L) )
CNT=strcat("COUNT_" a2s(L) "-bit")
CNT=strcat("COUNT_" a2s(L) "-bit")

tdcList=list(
list(
list(DLL append( netMakeBus("Qf" L) netMakeBus("Sf" L)))
list(PD append(netMakeBus("Sync" L t "_") mixPDnets(L '("B" "Bf"))  ) )
list(DLL append(netMakeBus("Q" L) netMakeBus("S" L) ))
) list(
list(B append(netMakeBus("B" L) netMakeBus("Q" L) ))
list(B append(netMakeBus("Bf" L) netMakeBus("Qf" L) ))
list(BD append(netMakeBus("dumf" L) netMakeBus("Bf" L)))
list(CNT append(netMakeBus("CNT" L nil) append(netMakeBus("CNTb" L nil) list("CL" "S<0>" "B<4>"))))
list(CNT append(netMakeBus("CNT2" L nil) append(netMakeBus("CNTb2" L nil) list("CL2" "Sf<0>" "Bf<4>"))))
))

; netMakePost("BU<4>" list(5 2*10))
pins=list(
append(netMakeBus("Sf" L) netMakeBus("S" L))
append(netMakeBus("Sync" L t "_") list(strcat("CNT<0:" a2s(L-1) ">") ))
)

cv=array2sch(tdcList 'ibm "tdc4" reverse(pins) 0.0 0.0)
schs=schematic2symbol(cv t t t) ;=> generate power allready

;; INTO _sim view :
vdcGen("S" t 1 list(0 L-1) t 1.2 0)
vdcGen("Sf" t 1 list(0 L-1) t 1.2 0)
; vdcPWRgen()
schCheck(geGetWindowCellView());<= sinon difPulseNet marche pas.
fixPulseNet('("S<0>" "Sf<0>") )
; schs=geGetWindowCellView()


;; TDC5
motif='("B" "A" "D" "C" "F" "E" "I" "H" "K" "J" "L")
cv=apply('array2sch DLLmklist(motif))
schs=schematic2symbol(cv nil nil) ;=> genere la dll

vdcGen("S" t 1 list(0 L-1) nil 1.2 0)
fixPulseNet('("S_0"))
vdcPWRgen()


L=length(motif)
DLL=apply('strcat cons("d_" motif))
PD=strcat("PhaseDet_" a2s(L) "-bit")
BD=strcat("ch_BN_DE_" a2s(L) )
B=strcat("ch_BUN_" a2s(L) )
CNT=strcat("COUNT_" a2s(L) "-bit")
CNT=strcat("COUNT_" a2s(L) "-bit")

tdcList=list(
list(
list(DLL append( netMakeBus("Qf" L) netMakeBus("Sf" L)))
list(PD append(netMakeBus("Sync" L t "_") mixPDnets(L '("B" "Bf"))  ) )
list(DLL append(netMakeBus("Q" L) netMakeBus("S" L) ))
) list(
list(B append(netMakeBus("B" L) netMakeBus("Q" L) ))
list(B append(netMakeBus("Bf" L) netMakeBus("Qf" L) ))
list(BD append(netMakeBus("dumf" L) netMakeBus("Bf" L)))
list(CNT append(netMakeBus("CNT" L nil) append(netMakeBus("CNTb" L nil) list("CL" "S<0>" "B<4>"))))
list(CNT append(netMakeBus("CNT2" L nil) append(netMakeBus("CNTb2" L nil) list("CL2" "Sf<0>" "Bf<4>"))))
))

; netMakePost("BU<4>" list(5 2*10))
pins=list(
append(netMakeBus("Sf" L) netMakeBus("S" L))
append(netMakeBus("Sync" L t "_") list(strcat("CNT<0:" a2s(L-1) ">") ))
)

cv=array2sch(tdcList 'ibm "tdc5" reverse(pins) 0.0 0.0)
schs=schematic2symbol(cv t t t) ;=> generate power allready

;; INTO _sim view :
vdcGen("S" t 1 list(0 L-1) t 1.2 0)
vdcGen("Sf" t 1 list(0 L-1) t 1.2 0)
; vdcPWRgen()
schCheck(geGetWindowCellView());<= sinon difPulseNet marche pas.
fixPulseNet('("S<0>" "Sf<0>") )
; schs=geGetWindowCellView()


load("saveData.il")
; load("/group/validmgr/Sim/tdc/tdc_597_1479.dat")_________________________________ CNT ___________ CNTf
Sync_0='((3.023423e-08 9.731625e-08 1.6122e-07 2.282866e-07) 			(10 31 51 72))	;; (10 32 53 75)  
Sync_1='((2.396936e-08 9.104179e-08 1.581217e-07 2.252021e-07)	 		(8 29 50 71))	;; (8 30 52 74)	  
Sync_2='((2.82813e-09 3.797184e-08 1.050526e-07 1.721335e-07 2.39214e-07) 	(2 13 34 55 76));; (1 13 35 57 79)
Sync_3='((1.926902e-08 8.635005e-08 1.53431e-07 2.205116e-07 2.87592e-07) 	(7 28 49 70 91));; (7 29 51 73 95)
Sync_4='((9.11875e-09 7.619878e-08 1.432796e-07 2.103602e-07 2.774406e-07)     (4 25 46 67 88))	;; (3 25 47 69 91)
Sync_5='((4.51097e-08 1.121913e-07 1.761068e-07 2.431618e-07) 			(15 36 56 77))	;; (15 37 58 80)  
Sync_6='((2.57301e-09 5.05073e-08 1.175765e-07 1.84656e-07 2.517362e-07) 	(2 17 38 59 80));; (1 17 39 61 83)
Sync_7='((2.046943e-09 4.038905e-08 1.043765e-07 1.713653e-07 2.384396e-07)	 (1 13 33 54 75);; (1 14 35 57 79)
Sync_8='((5.521863e-08 1.191194e-07 1.861892e-07 2.532679e-07)			 (18 38 59 80))	;; (19 39 61 83)  
Sync_9='((3.413704e-08 9.808451e-08 1.651113e-07 2.321873e-07) 			(11 32 52 73))	;; (12 33 55 77)  
Sync_10='((6.144755e-08 1.253491e-07 1.924182e-07 2.594967e-07) 		(20 40 61 82))	;; (21 42 64 86)  
															  
(1.6122e-07-2.282866e-07)/21;=>-3.193648e-09m
syns='()
for(i 0 10 
syns=append(syns list(eval(concat('Sync_ i)))))

deltaCnt=foreach(mapcar sy syns 
x0=0 foreach(mapcar c cadr(sy)
d=c-x0 x0=c d))
deltaCnt
 ((10 21 20 21)
 (8 21 21 21)
 (2 11 21 21 21)
 (7 21 21 21 21)
 (4 21 21 21 21)
 (15 21 20 21)
 (2 15 21 21 21)
 (1 12 20 21 21)
 (18 20 21 21)
 (11 21 20 21)
 (20 20 21 21)
)

freq1=dll2period(dir "/I0/Qf" 0 L-1 t "<")
freq2=dll2period(dir "/I0/Q" 0 L-1 t "<")
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/d_ABCDEFHIJKL_sim/spectre/schematic/psf"
freqq=dll2period(dir "Q" 0 L-1 t "_")
freq1=dll2period(nil "Q" 0 L-1 t "_");=> de la simu en cours



defun(cntVal (@optional (xt 7.45547e-08)(wave VT("/CNT<0:10>" dir)) (Vth 0.6)) let((i sum cnts) sum=0
cnts=ocnPrint3(value(wave xt)) ;=>(("/CNT<0>" 5.364274e-06) ("/CNT<1>" 3.640595e-07) ("/CNT<2>" 3.640879e-07) ("/CNT<3>" 1.2) ("/CNT<4>" 1.2) ("/CNT<5>" 2.454006e-07) ("/CNT<6>" 2.454006e-07) ("/CNT<7>" 2.454007e-07) ("/CNT<8>" 2.454007e-07) ("/CNT<9>" 2.454009e-07) ("/CNT<10>" 2.454355e-07))
i=-1 sum=apply('plus foreach(mapcar c cnts i++ if(cadr(c)>Vth 1 0)*2**i))
sum
))

cntVal(2.282866e-07 VT("/I0/CNT2<0:10>" dir))
ycounts=foreach(mapcar xts syncs foreach(mapcar xt xts cntVal(xt VT("/I0/CNT2<0:10>"))))





;; TDC5
tdcName="tdc6"
m='IJKIJKIJKIJ
motif=parseString(symbolToString(m) "")
motif='("E" "E" "D" "H" "F" "E" "I" "H" "K" "J" "L")
cv=apply('array2sch DLLmklist(motif)) schCheck(cv)
schs=schematic2symbol(cv nil nil) ;=> genere la dll
; schs=schematic2symbol(nil t t t) ;=> genere la dll + la simu

vdcGen("S" t 1 list(0 L-1) nil 1.2 0)
;; fixPulseNet('("S_0"))

L=length(motif)
DLL=apply('strcat cons("d_" motif))
PD=strcat("PhaseDet_" a2s(L) "-bit")
BD=strcat("ch_BN_DE_" a2s(L) )
B=strcat("ch_BUN_" a2s(L) )
CNT=strcat("COUNT_" a2s(L) "-bit")
CNT=strcat("COUNT_" a2s(L) "-bit")

tdcList=list(
list(
list(DLL append( netMakeBus("Qf" L) netMakeBus("Sf" L)))
list(PD append(netMakeBus("Sync" L t "_") mixPDnets(L '("B" "Bf"))  ) )
list(DLL append(netMakeBus("Q" L) netMakeBus("S" L) ))
) list(
list(B append(netMakeBus("B" L) netMakeBus("Q" L) ))
list(B append(netMakeBus("Bf" L) netMakeBus("Qf" L) ))
list(BD append(netMakeBus("dumf" L) netMakeBus("Bf" L)))
list(CNT append(netMakeBus("CNT" L nil) append(netMakeBus("CNTb" L nil) list("CL" "S<0>" "B<4>"))))
list(CNT append(netMakeBus("CNT2" L nil) append(netMakeBus("CNTb2" L nil) list("CL2" "Sf<0>" "Bf<4>"))))
))

; netMakePost("BU<4>" list(5 2*10))
pins=list(
append(netMakeBus("Sf" L) netMakeBus("S" L))
append(netMakeBus("Sync" L t "_") list(strcat("CNT<0:" a2s(L-1) ">") ))
)

cv=array2sch(tdcList 'ibm tdcName reverse(pins) 0.0 0.0) schCheck(cv)
schs=schematic2symbol(cv t t t) ;=> generate power allready

;; INTO _sim view :
vdcGen("S" t 1 list(0 L-1) t 1.2 0)
vdcGen("Sf" t 1 list(0 L-1) t 1.2 0)
; vdcPWRgen()
schCheck(geGetWindowCellView());<= sinon difPulseNet marche pas.
fixPulseNet('("S<0>" "Sf<0>") )
; schs=geGetWindowCellView()



addCell("dll__load_11")

;; BACK TO SIMU SINGLE DLL :
unless(cell cell=geGetWindowCellView()~>cellName);=>geGetWindowCellView()~>cellName
unless(lib lib=geGetWindowCellView()~>libName) ;=>geGetWindowCellView()~>libName
freq1=dll2period(nil "Q" 0 L-1 t "_");=> de la simu en cours

value(car(dll2period(nil "Q" 0 0)) -1);=>2.786815e-09
value(car(dll2period(nil "Q" 0 0)) 5n);=>2.785868e-09
wave=car(dll2period(nil "Q" 0 0))
y=drGetWaveformYVec(wave)
L=drVectorLength(y)
drGetElem(y L-1);=>2.785856e-09 ;=> last plot value

defun(valueLast(wave) let((y) y=drGetWaveformYVec(wave)
drGetElem(y drVectorLength(y)-1);=>2.785856e-09 ;=> last plot value
))


valueLast(car(dll2period(nil "Q" 0 0)))

codes=vdcPWRcode(11)
length(codes);=> 512
code=car(codes) ;=> 1
cellName="d_EEDHFEIHKJL_sim"

foreach(mapcar code codes
simSetVar(cellName "Ed_CMOS8" list("S" code))
dit="~/Work/IBMv18/TDC_RESULT" file=sprintf(nil "%s/%s_%0.3d.dat" dit cellName code)
fo=outfile(file)
fprintf(fo "%g" valueLast(car(dll2period(nil "Q" 0 0))))
close(fo)
;edit(eval(file))
)


; dMotifSim('IJKIJKIJKIJ)
;dMotifSim() ;<= lance les simu et sauvegarde juste la periode de Q_0

motif='("I" "J" "K" "I" "J" "K" "I" "J" "K" "I" "J")


dit="~/Work/IBMv18/TDC_RESULT" 
code=nth(3 codes);=>13

alist=remove(nil foreach(mapcan code codes=vdcPWRcode(length(motif))
cellName=strcat("d_" apply('strcat motif) "_sim");=>"d_IJKIJKIJKIJ_sim"
file=sprintf(nil "%s/%s_%0.3d.dat" dit cellName code)
when(isFile(file)
fo=infile(file);port:"~/Work/IBMv18/TDC_RESULT/d_IJKIJKIJKIJ_sim_047.dat"
gets(line fo)  ;"2.60249e-09"
unless(line=="" 
list(evalstring(line)))
))) printf("Cell:%s, for %d values\n" cellName length(alist))


alist;=>
(2.61554e-09 2.60661e-09 2.62326e-09 2.6076e-09 2.61997e-09 2.60873e-09 2.62356e-09 2.61401e-09 2.59635e-09 2.61206e-09 2.60249e-09 2.60772e-09 2.5988e-09 2.61453e-09)

alist=getTDCresult(motmotif('MJKJLLKKLJJ) strcat("d_" symbolToString('MJKJLLKKLJJ) "_sim2" ))
myRmsf(alist)

defun(motmotif (@optional (motif 'FJHFJHFJHFJ))
motif=if(type(motif)=='symbol parseString(symbolToString(motif) "") motif))

motmotif();=>("F" "J" "H" "F" "J" "H" "F" "J" "H" "F" "J")
motif=motmotif('EEDHFEIHKJL)
; motif='FHFHFHFH
type(motif);=>list ou symbol
type(motif)=='symbol

awvDisplayTitle( awvGetCurrentWindow() "FJHFJHFJHFJ")

perf=alist
perm=list2minus(alist)

myRmsf(perf t 20 t t '("period range" "period histo"))
myRmsf(perm t 20 t t '("delta t range" "delta t histo"))
length(perm)

motif=motmotif('IJKIJKIJKIJ);=>("I" "J" "K" "I" "J" "K" "I" "J" "K" "I" "J")


pins='()
pins=append(pins netMakeBus("Sync" 11))
pins=append(pins netMakeTruePos(strcat("PD_" itos(nb)) '(11 11) nil))
pins=append(pins list("CNT<0:11>" ))
pins=append(pins netMakeBus("Sf" 11) )
pins=append(pins netMakeBus("S" 11) )
pins
("Sync<0>" "Sync<1>" "Sync<2>" "Sync<3>" "Sync<4>" "Sync<5>" "Sync<6>" "Sync<7>" "Sync<8>" "Sync<9>" "Sync<10>" "CNT<0:11>" "Sf<0>" "Sf<1>" "Sf<2>" "Sf<3>" "Sf<4>" "Sf<5>" "Sf<6>" "Sf<7>" "Sf<8>" "Sf<9>" "Sf<10>" "S<0>" "S<1>" "S<2>" "S<3>" "S<4>" "S<5>" "S<6>" "S<7>" "S<8>" "S<9>" "S<10>")



inst=car(setof(inst cv~>instances inst~>cellName=="tdc5"))
terminalPinsMap(pins inst) 


nb=5
foreach( nb '(3 4 5)
inst=car(setof(inst cv~>instances inst~>cellName==strcat("tdc" itos(nb))))
pins='()
if(nb==5
pins=append(pins netMakeBus("Sync" 11))
pins=append(pins netMakeTruePos(strcat("PD_" itos(nb)) '(11 11) nil))
)
pins=append(pins list("CNT<0:11>" ))
pins=append(pins netMakeBus("Sf" 11) )
pins=append(pins netMakeBus("S" 11) )
terminalPinsMap(pins inst) 
)


;______________________________________________________________________________
;; TDC7
tdcName="tdc7"
m='MHIJKLLKJIH
m='MJKJLLKKLJJ
dMotifSim(m 40 "d_MHIJKLLKJIH_sim2") ;<= lance les 512 simu ! a la temperature souhaitee
nthcdr(322 vdcPWRcode(11))


dMotifSim(m 60 "d_MHIJKLLKJIH_sim3") ;<= lance les 512 simu ! a 60 degree
dMotifSim(m 60 "d_MHIJKLLKJIH_sim3" nil nil nthcdr(322 vdcPWRcode(11)))
dMotifSim(m 40 ) ;<= lance les 512 simu !
motif=parseString(symbolToString(m) "")
cv=apply('array2sch DLLmklist(motif)) schCheck(cv)
schs=schematic2symbol(cv nil nil) ;=> genere la dll
; schs=schematic2symbol(nil t t t) ;=> genere la dll + la simu

;; vdcGen("S" t 1 list(0 L-1) nil 1.2 0)
;; fixPulseNet('("S_0"))

L=length(motif)
DLL=apply('strcat cons("d_" motif))
PD=strcat("PhaseDet_1-bit")
B=strcat("ch_BUN_" a2s(L) )
CNT=strcat("COUNT_" a2s(L) "-bit")
CNT=strcat("COUNT_" a2s(L) "-bit")

tdcList=list(
list(
list(DLL append( netMakeBus("Qf" L) netMakeBus("Sf" L)))
list(PD list("Sync_0" "B<0>" "Bf<0>"))
list(DLL append(netMakeBus("Q" L) netMakeBus("S" L) ))
) list(
list(B append(netMakeBus("B" L) netMakeBus("Q" L) ))
list(B append(netMakeBus("Bf" L) netMakeBus("Qf" L) ))
))

; netMakePost("BU<4>" list(5 2*10))
pins=list(append(netMakeBus("Sf" L) netMakeBus("S" L)) list("Sync_0"))

cv=array2sch(tdcList 'ibm tdcName reverse(pins) 0.0 0.0) schCheck(cv)
schs=schematic2symbol(cv t t t) ;=> generate power allready
cvSim=caddr(schs)


;; array2sch(buf_etc caddr(schs)~>libName caddr(schs)~>cellName nil 0.4 0.4 t nil "a" xy)
;; INTO _sim view :
vdcGen("S" t 1 list(0 L-1) t 1.2 0 cvSim)
vdcGen("Sf" t 1 list(0 L-1) t 1.2 0 cvSim)
; vdcPWRgen()
schCheck(cvSim);<= sinon difPulseNet marche pas.
fixPulseNet('("S<0>" "Sf<0>") )
; schs=geGetWindowCellView()

inst=carInstNetCell("S<0>" "vdc")

net=car(setof(i inst~>instTerms~>net i~>name=="S<0>"))
net~>figs~>??
length(net~>figs);=>4
car(net~>figs)~>??
net~>figs~>objType;=>("line" "label" "path" "label")



;; RECCUP les DONNEES ET LES PLOT
m='MJKJLLKKLJJ
perf=getTDCresult(motmotif(m) ) ;(strcat("d_" symbolToString(m) "_sim2" ))
perm=list2minus(perf)
myRmsf(perf t 20 t t '("period range" "period histo"))
myRmsf(perm t 20 t t '("delta t range" "delta t histo"))
awvDisplayTitle( awvGetCurrentWindow() symbolToString(m))

;; RECCUP les DONNEES ET LES PLOT
m='MHIJKLLKJIH
perf=getTDCresult(motmotif(m) ) ;(strcat("d_" symbolToString(m) "_sim2" ))
perm=list2minus(perf)
myRmsf(perf t 20 t t '("period range" "period histo"))
myRmsf(perm t 20 t t '("delta t range" "delta t histo"))
awvDisplayTitle( awvGetCurrentWindow() symbolToString(m))


;; RECCUP les DONNEES ET LES PLOT
m='MHIJKLLKJIH
perf=getTDCresult(motmotif(m) strcat("d_" symbolToString(m) "_sim2" ));<= 40 deg C
perm=list2minus(perf)
myRmsf(perf t 20 t t '("period range" "period histo"))
myRmsf(perm t 20 t t '("delta t range" "delta t histo"))
awvDisplayTitle( awvGetCurrentWindow() symbolToString(m))


;simu
m='MHIJKLLKJIH
simu60deg=getTDCresult(motmotif(m) strcat("d_" symbolToString(m) "_sim3" ))
simu40deg=getTDCresult(motmotif(m) strcat("d_" symbolToString(m) "_sim2" ))
;m='MHIJKLLKJIH
simu27deg=getTDCresult(motmotif(m) strcat("d_" symbolToString(m) "_sim" ))
s4027=mapcar('list simu40deg simu27deg)
d4027=foreach(mapcar s s4027 car(s)-cadr(s))
wave=list2wave2(d4027)
plot(wave)

i=0 deg40=foreach(mapcar dl simu40deg list(dl i++))
i=0 deg27=foreach(mapcar dl simu27deg list(dl i++ ))

i=0 deg60=foreach(mapcar dl list2minus(simu60deg) list(dl i++))
i=0 deg40=foreach(mapcar dl list2minus(simu40deg) list(dl i++))
i=0 deg27=foreach(mapcar dl list2minus(simu27deg) list(dl i++ ))

plot(mapcar('list2wave list(deg60 deg40 deg27)))

wdeg27=list2wave2(simu27deg)
wdeg40=list2wave2(simu40deg)
wdeg60=list2wave2(simu60deg)
plot(wdeg27)
plot(wdeg40)
plot(wdeg60)

tmp=foreach(mapcar d deg27 d)


tri27=sortcar(tmp 'lessp)
length(deg27);=>130816 => marche pas avec plotter ??!
plot(deg27)


;wave27tri=list2wave2(mapcar('car tmp))
wave27tri=list2wave2(mapcar('car tri27))
plot(wave27tri)

;mapcar('cdr tri27)
flip40=foreach(mapcar d deg40 list(cadr(d) car(d)))
flip60=foreach(mapcar d deg60 list(cadr(d) car(d)))
eqTri=foreach(mapcar deg tri27 cadr(assoc(cadr(deg) flip40)))
eqTri6=foreach(mapcar deg tri27 cadr(assoc(cadr(deg) flip60)))
weqTri=list2wave2(eqTri)
weqTri6=list2wave2(eqTri6)
plot(weqTri)
plot(weqTri6)




; TDC_BRICK CORE

;PD
mapcar('concat mapcar('car getInstTermPoint())); ("clk" "RN" "PN" "D" "QB" "Q")
;=>(clk RN PN D QB Q) (Sl P Fs Qout)

pdPins='("clk" "RN" "PN" "D" "QB" "Q")
terminalPinsMap(pdPins)
bascPins='("Sl" "P" "Fs" "Qout")
terminalPinsMap(bascPins)

"In_1" "Inf_1" "In_2" "Inf_2" "In_3" "Inf_3"
"Sync_1" "B_1" "Bf_1" "Sync_2" "B2" "Bf2" "Sync_3" "B3" "Bf3"

cv=geGetWindowCellView()
cv~>terminals~>name

netMakeBus("Sf" '(1 10))
netMakeBus("S" '(1 10))

"S<1>" "S<2>" "S<3>" "S<4>" "S<5>" "S<6>" "S<7>" "S<8>" "S<9>" "S<10>" 
"Sf<1>" "Sf<2>" "Sf<3>" "Sf<4>" "Sf<5>" "Sf<6>" "Sf<7>" "Sf<8>" "Sf<9>" "Sf<10>"
"In_1" "Inf_1" "In_2" 
"Inf_2" "In_3" "Inf_3" "clk" "RN"
"PN" "D" "Sl" "Q" "P"
"Fs" "Qout" "Sync_1" "B_1" "Bf_1"
"Sync_2" "Bf_2" "B_3" "Sync_3" "Bf_3"
"Reset" "Preset" "B_2"


cells=dllGenMotifBuDff('(2 3) '(("BUFFER_J" ("Ib_" "In_"))("BUFFER_J" ("Ibf_" "Inf_"))) '("gnd!" "sx!" "nw!" "vdd!") 1)
array2sch1(transpose(cells) nil '(("In_1" "Inf_1" "In_2" "Inf_2" "In_3" "Inf_3")) nil)
schematic2symbol(nil nil nil nil)

	
wave=VT("/Sync_0")
wave=cross(VT("/Sync_0") 0.6 2 "falling"  t "time"  )
y=drGetWaveformYVec(wave)
x=drGetWaveformXVec(wave)
NY=drCreateVec('double L-1)
NX=drCreateVec('double L-1)
L=drVectorLength(y);=>28
drGetElem(y 0);=>1.878459e-09
drGetElem(y 1);=>4.589183e-08
;skip first val for all value => skip=0
skip=1
yn=drGetElem(y skip)
intervals=foreach(mapcar i linRg(skip+1 L-1 1) ;=>(2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28)
yn1=yn
yn=drGetElem(y i)
ynp1=yn-yn1
drSetElem(NY i-skip-1 ynp1)
drSetElem(NX i-skip-1 drGetElem(x i-skip))
ynp1)
nwave=drCreateWaveform(NX NY)
; ^^ fonction equivalente a 1/freq ....

plot(nwave)

1/frequency(VT("/I0/Qf<0>");=>2.872319e-09
1/frequency(VT("/I0/Q<0>");=>2.764537e-09

plot(nwaveNorm=nwave*frequency(VT("/I0/Qf<0>")))

hasht=getTDCresultCodes(motmotif('EEDHFEIHKJL))
length(hasht);=>512

tdHashes=list2minus2(getTDCresultCodes(motmotif('EEDHFEIHKJL)))
length(tdHashes);=>130816=N*(N-1)/2


terr=10f
filterr=remove(nil foreach(mapcar tdh tdHashes
td=car(tdh)
when(td>=10p-terr && td<=10p+terr tdh)))
filterr;((1e-11 "61-661") (1e-11 "217-321") (1e-11 "251-659") (1e-11 "351-1831") (9.99e-12 "361-1491") (1e-11 "515-953") (1e-11 "575-1033") (1e-11 "623-855") (9.99e-12 "855-1727") (1e-11 "913-1451") (1e-11 "929-1721") (9.99e-12 "935-1279") (1e-11 "981-1461") (1e-11 "1173-1669") (1e-11 "1243-1347"))

; cross(VT("/Sync_0") 0.6 2 "falling"  t "time"  )
wave=cross(clip(VT("/Sync_0") 10n 800n) 0.6 2 "falling"  t "time"  )
plot(wave)

sweepNames(wave);=> ("delay" "temp" "time")
drIsParamWave(wave);=>t
drVectorLength(drGetWaveformXVec(wave));=>20
subWave=drGetElem(drGetWaveformYVec(wave) 0)
drIsParamWave(subWave);=>t
drVectorLength(drGetWaveformXVec(subWave));=>3


wa=wave
nom=car(sweepNames(wa));=> "delay"
L=drVectorLength(drGetWaveformXVec(wa));=>20

flat=foreach(mapcar i linRg(0 L-1 1) 
subWave=drGetElem(drGetWaveformYVec(wa) i)
subWavX=drGetElem(drGetWaveformXVec(wa) i)
list(subWave nom subWavX)
)

flattenVals=foreach(mapcan f flat
sub=car(f)
Ls=drVectorLength(drGetWaveformXVec(sub))
sN=car(sweepNames(sub))
foreach(mapcar j linRg(0 Ls-1 1) 
sw=drGetElem(drGetWaveformYVec(sub) j)
sX=drGetElem(drGetWaveformXVec(sub) j)
list(ymax(sw) cdr(f) list(sN sX))
))

length(flattenVals);=>60

flattenVals



vals=foreach(mapcar f flat
sub=car(f)
Ls=drVectorLength(drGetWaveformXVec(sub))
sN=car(sweepNames(sub))
foreach(mapcar j linRg(0 Ls-1 1) 
sw=drGetElem(drGetWaveformYVec(sub) j)
sX=drGetElem(drGetWaveformXVec(sub) j)
list(ymax(sw) cdr(f) list(sN sX))
))


for(tp 0 2
data1
drCreateWaveform(drCreateVec('double data1) drCreateVec('double data2))


sw=caar(flat); srrWave:0x19261098
sweepNames(sw);=> ("temp" "time")
drVectorLength(drGetWaveformXVec(sw));=>3
drVectorLength(drGetWaveformYVec(sw));=>3
ssw=drGetElem(drGetWaveformYVec(sw) 0)
sswX=drGetElem(drGetWaveformXVec(sw) 0);=>26.0

ocnPrint(ssw)
;; time (s)          value(value(cross(clip(VT("/Sync_0") 1e-08 8e-07) 0.6 2 "falling" t "time") "delay" 3.05e-10) "temp" 26.0) (s)
;;   706.972n          706.972n        



wave=cross(clip(VT("/Sync_0") 1e-08 8e-07) 0.6 2 "falling" t "time")
sweepNames(wave);=> ("delay" "temp" "time")
ocnPrint(wave)
drVectorLength(drGetWaveformXVec(sw));=>3


a=binaryStringCode(10 t 'evenp)
length(a);=>512

i=0 foreach(mapcar b a printf("%s   " b) i=i+1 if(i>=8  then printf("\n") i=0)) t
a=binaryStringCode(10 nil 'evenp)
i=0 foreach(mapcar b a printf("%03x " b) i=i+1 if(i>=16  then printf("\n") i=0)) t



abIntToBinaryStr(3 16) ;=> "0000000000000011"
abBinaryStrToInt("1101110010");=> 882
abBinaryStrToInt(strcat("000000" "1101110010"));=> 882

x739=abIntToBinaryStr(739 10);=> "1011100011"
sx6=strcat(x739 x739 x739 x739 x739 x739);=> "101110001110111000111011100011101110001110111000111011100011"
abBinaryStrToInt(sx6) ;=> *Error* Cannot convert more than 32 bits  BUG 
strcat(x739 x739 x739)
strlen(sx6);=> 60
nb=abBinaryStrToInt(sx6);=> 775655139
sprintf(nil "0x%08x" nb);=> "0x2e3b8ee3"
sprintf(nil "0x%08x" 739);=>"0x000002e3"
sprintf(nil "0x%08x" 739+2**10*739);=> "0x000b8ee3"
sprintf(nil "0x%08x" 739+2**10*739+2**20*739);=> "0x2e3b8ee3"
sprintf(nil "0x%016x" 739+739<<10+739<<20)


x739=abIntToBinaryStr(739<<10 20);=> "10111000110000000000"

sprintf(nil "0x%016x" 739)	  ;=> "0x00000000000002e3"
sprintf(nil "0x%016x" 739<<10)    ;=> "0x00000000000b8c00"
sprintf(nil "0x%016x" 739+739<<10);=> "0x0000000000171800"

sprintf(nil "0x%016x" 739<<20+739<<10+739);=> "0x0000000000000000" BUG
739<<20+739<<10+739;=> 0 BUG
leftshift(739 20)+leftshift(739 10)+739;=> 775655139 OK => PB de parentheses

sum=0 for(i 0 5 sum=sum+leftshift(739 i*10))
sum;=> -104173085 BUG !

linRg(5 0 -1) ;=> (5 4 3 2 1 0)
sum=0 foreach(i '(5 4 3 2 1 0) sum=sum+leftshift(739 i*10) printf("%d " sum ))

leftshift(739 50)+leftshift(739 20)+leftshift(739 10)+739

x739=abIntToBinaryStr(739 10);=> "1011100011"
s739=parseString(x739 "");=> ("1" "0" "1" "1" "1" "0" "0" "0" "1" "1")
length(s739) ;=> 10

r739=reverse(s739);=> ("1" "1" "0" "0" "0" "1" "1" "1" "0" "1")
;=> ("1" "1" "0" "0" "0" "1" "1" "1" "0" "1")
sprintf(nil "%x" abBinaryStrToInt(strcat(
car(r739) nth(1 r739)||"" nth(2 r739)||"" nth(3 r739)||""))
nth(4 r739)||"" nth(5 r739)||"" nth(6 r739)||"" nth(7 r739)||""
)


sprintf(nil "%x" abBinaryStrToInt(apply('strcat reverse(list(
car(r739) nth(1 r739)||"" nth(2 r739)||"" nth(3 r739)||""
nth(4 r739)||"" nth(5 r739)||"" nth(6 r739)||"" nth(7 r739)||""
)))))




r739=reverse(parseString(abIntToBinaryStr(739 10) ""));=> ("1" "1" "0" "0" "0" "1" "1" "1" "0" "1")
x739='()
while(r739 
x739=append(x739 list(
sprintf(nil "%x" abBinaryStrToInt(apply('strcat reverse(list(
car(r739) nth(1 r739)||"" nth(2 r739)||"" nth(3 r739)||""
nth(4 r739)||"" nth(5 r739)||"" nth(6 r739)||"" nth(7 r739)||""
)))))
))
r739=nthcdr(8 r739)
) 
reverse(x739) ;=> ("2" "e3")


abIntToBinaryStr(739 10) ;=> "1011100011"

defun( bitString2hexa (@optional (bitstr "10111000111011100011") (noquote nil))
let((r739 x739)
r739=reverse(parseString(bitstr ""));=> ("1" "1" "0" "0" "0" "1" "1" "1" "0" "1")
x739='()
while(r739 
x739=append(x739 list(
sprintf(nil "%x" abBinaryStrToInt(apply('strcat reverse(list(
car(r739) nth(1 r739)||"" nth(2 r739)||"" nth(3 r739)||""
nth(4 r739)||"" nth(5 r739)||"" nth(6 r739)||"" nth(7 r739)||""
)))))
))
r739=nthcdr(8 r739)
) 
when(noquote foreach(mapcar x reverse(x739) printf("%s " x)))
reverse(x739) ;=> ("2" "e3")
))

bitString2hexa("10111000111011100011" t) ;=> ("b" "8e" "e3")



a739=abIntToBinaryStr(739 10)
bitString2hexa(sx6=strcat(a739 a739 a739 a739 a739 a739))
bb=bitString2hexa(sx6=strcat(a739 a739 a739 a739 a739 a739) t)
bb= '("b" "8e" "e3" "b8" "ee" "3b" "8e" "e3")

buildString(bb " ");=> "b 8e e3 b8 ee 3b 8e e3"

bins=binaryStringCode(10 t 'evenp)
foreach(mapcar bin bins buildString(bitString2hexa(sx6=strcat(bin bin bin bin bin bin)) " "))

bin=car(bins)
foreach(mapcar bin bins sprintf(bitString2hexa(strcat(bin bin bin bin bin bin)) ",")))))

sprintf(nil "0x%x" 123)

hex=apply('strcat cons("0x" bb))

;sprintf(nil "%d" evalstring(hex));=> "-298086685"  BUG



;; REnvoye les memes codes.
foreach(mapcar v vdcPWRcode(11) v>>1)
bins=binaryStringCode(10 nil 'evenp)

dit="~/Work/IBMv18/TDC_RESULT"
dot="/home/validmgr/ebecheto/TDCEB/sim"
foreach(mapcar code vdcPWRcode(11)
file=sprintf(nil "%s/d_MJKJLLKKLJJ_sim_%0.3d.dat" dit code)
fil2=sprintf(nil "%s/d_MJKJLLKKLJJ_sim_%0.4d.dat" dot code>>1)
(sh sprintf(nil "cp %s %s" file fil2))
)


;; RING OSCILLATOR 1 2 3 4
ofile=sprintf(nil "%s/data_xy.dat" dot)
fp=outfile(ofile)
dit="~/Work/IBMv18/TDC_RESULT"
dot="/home/validmgr/ebecheto/TDCEB/sim"
rexCompile("\n")
foreach(mapcar code vdcPWRcode(11)
file=sprintf(nil "%s/d_MJKJLLKKLJJ_sim_%0.3d.dat" dit code)
inf=infile(file) gets(line inf) line=rexReplace( line "" 1)
fprintf(fp "%s %0.4d %s 0x%0.3x\n" line code>>1 abIntToBinaryStr(code>>1 10) code>>1)
)
close(fp)

edit(eval(ofile))

;; RING OSCILLATOR 5 6
; d_EEDHFEIHKJL_sim_001.dat

ofile=sprintf(nil "%s/data_xy_dll_56.dat" dot)
fp=outfile(ofile)
dit="~/Work/IBMv18/TDC_RESULT"
dot="/home/validmgr/ebecheto/TDCEB/sim"
rexCompile("\n")
foreach(mapcar code vdcPWRcode(11)
file=sprintf(nil "%s/d_EEDHFEIHKJL_sim_%0.3d.dat" dit code)
inf=infile(file) gets(line inf) line=rexReplace( line "" 1)
fprintf(fp "%s %0.4d %s 0x%0.3x\n" line code>>1 abIntToBinaryStr(code>>1 10) code>>1)
)
close(fp)

edit(eval(ofile))