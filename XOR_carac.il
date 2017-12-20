unless(fboundp('interceptime) load("/home/validmgr/ebecheto/Skill/XOR_carac.proc.il"))
loadi("XOR_carac.proc.il")
ineed('list2wave)


;nth     0   1   2   3   4   5   6
elist='("L" "1" "2" "3" "4" "6" "8") 


AST='(
(("Bi_" "Qi_") ("falling" "rising") )
(("Bi_" "Qi_") ("rising" "falling") )
(("B" "Q")     ("rising" "rising")  )
(("B" "Q")     ("falling" "falling"))
)

elist='("L" "1" "2" "3" "4" "6" "8") 
;curbs=foreach(mapcar leaf AST interceptx(car(leaf) elist cadr(leaf) t nil))
;curbs=foreach(mapcar leaf AST interceptx(car(leaf) elist cadr(leaf) t t))

; (setq invs '("Bi_" "Qi_"))(setq bufs '("B" "Q"))


invbufL=invbuf( '("Bi_" "Qi_") '("B" "Q") '("L" "1" "2" "3" "4" "6" "8"))
; invbufL=invbuf() ;=> ((tdi_L tdb_L)(tdi_1 tdb_1) ...)
difs=curb2toDif(invbufL)
TDs=curb2minusX1(difs)

plotCurbs(TDs)
addSubwindow()
plotCurbs(difs)
addSubwindow()
plotCurbs(invbufL)
saveRowColWaves(invbufL)
;saveRowColWaves(invbufL pwd())
; recallRowColWaves('(tdi_ tdb_) '("L" "1" "2" "3" "4" "6" "8"))
; recallRowColWaves();=> invbufL=((tdi_L tdb_L) ...)


curb2val(curbs);@10fF
curb2val(difs 20f)
curb2val(difs 30f)
vals=curb2val(invbufL 0)
dbi=curb2toVal(invbufL 0)

;; a=nil for(i 0 6 a=append(a list("INVX1")))
;; a=nil for(i 0 6 a=append(a list("noConn")))
;; a=nil for(i 0 6 a=append(a list("DFX1")))
;; addCell(a)

; createInstPinsch(geGetSelectedSet() geGetWindowCellView() '(("A" "Zi") ("CLK" "Zi")))
createInstPinsch(geGetSelectedSet() geGetWindowCellView() '(("A" "Q")("D" "Q")("CP" "Q")) -1 nil t '("L" "1" "2" "3" "4" "6" "8"))
createInstPinsch(geGetSelectedSet() geGetWindowCellView() '(("A" "Qi_")("D" "Qi_")("CP" "Qi_")) -1 nil t '("L" "1" "2" "3" "4" "6" "8"))

;; point='(-2.03125 3.21875) bBox='((-2.03125 3.15625) (-1.59375 3.53125))
;; angleBox(point bBox)

;; GENERATE DLL CELLS function steps
load("/home/validmgr/ebecheto/Skill/XOR_carac.proc.il")
xline=dbi2freq('((5 1)(5 0)(5 0)(4 1)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)))
xline=dbi2freq('((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)));<= default
;load presimulated values :
val2saved()
didb2dbi()

(setq more '(("vdc" ("gnd!" "vdd!") (("vdc" "float" 1.8))) ("vpwl" ("gnd!" "netpwl")(("t1" "string" "1n") ("vdc" "string" "0") ("v2" "string" "1.8") ("t2" "string" "1.001n"))) ("BUFTX2" ("netpwl" "start" "gnd!" )) ))
xline2=appendBegin2(xline 1 "start");=> switch first element nets from ("Q_0" "vdd!" "Q_1") to ("Q_0" "start" "Q_1")
xlinedc=appendBegin1(xline2 more);=> length(car(xlinedc)) 
length(car(xline))
length(car(xlinedc))

;cvs=xline2sch(xlinedc)
cvs~>cellName


;; SIMULATION
simulator('spectre)
lib="ATEST_h18"
cell=cvs~>cellName
;cell="tdc_xor_51515040405051515051_3.132n_sim"
design(lib cell "schematic")
createNetlist()
analysis('dc ?saveOppoint t  )
analysis('tran ?stop "40n"  )
envOption('analysisOrder  list("dc" "tran"))
temp( 27 ) 
run()


;intercept2()

;; TODO RESULTAT INFINE : mean sigma min max


ajout='(
("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.8)))
("vdc" ("gnd!" "sel")(("vdc" "float" 0)))
("INVX2" ("sel" "selb"))
("vpulse" ("gnd!" "pulse") (("v2" "string" "1.8")("tf" "string" "1p")("tr" "string" "1p")("per" "string" "20n")))
;("vpwl" ("gnd!" "netpwl")(("t1" "string" "1n") ("vdc" "string" "0") ("v2" "string" "1.8") ("t2" "string" "1.001n")))
;("BUFTX2" ("netpwl" "start" t))
)


alls=geneDUT_343()
only2=geneDUT_343('("1" "8") "XOR2X")
pltAck=geneDUT_343('("1" "8") "XOR2X")
length(only2);=> 343
length(alls);=> 343
nth(0 alls)
length(nth(0 alls))

bench=appendBegin1(alls ajout);=> length(car(xlinedc)) 
bench=appendBegin1(only2 ajout)
length(bench) 
xline2sch(list(bench nil) t nil "xor_DUT_sim18" 0.4 0)

addCellw2(car(only2)) ;=> ok


;bench=appendBegin1(only2 ajout)

t0=cputime()
cvXy=addCellw3(cons(ajout only2)) ;=> ok
t1=cputime()
printf("%d secondes cpu\n" t1-t0);=> 3141 ;=> 3127 secondes cpu avec assocLib


;simXor() ;=> lance la simu

intercept2('("Qm1_1_8_1_00"  "Q_1_8_1_00") '("rising" "rising"));=> 238.8p
intercept2('("Qm1_1_8_1_00"  "Q_1_8_1_00") '("falling" "falling"));=> 176.3p

length(bench); =>3127/8*343/60/60

; pltAck='(((("1" "1" "1") "00") (("1" "1" "1") "01") (("1" "1" "1") "10") (("1" "1" "1") "11")) ((("1" "1" "8") "00") (("1" "1" "8") "01") (("1" "1" "8") "10") (("1" "1" "8") "11")) ((("1" "8" "1") "00") (("1" "8" "1") "01") (("1" "8" "1") "10") (("1" "8" "1") "11")) ((("1" "8" "8") "00") (("1" "8" "8") "01") (("1" "8" "8") "10") (("1" "8" "8") "11")) ((("8" "1" "1") "00") (("8" "1" "1") "01") (("8" "1" "1") "10") (("8" "1" "1") "11")) ((("8" "1" "8") "00") (("8" "1" "8") "01") (("8" "1" "8") "10") (("8" "1" "8") "11")) ((("8" "8" "1") "00") (("8" "8" "1") "01") (("8" "8" "1") "10") (("8" "8" "1") "11")) ((("8" "8" "8") "00") (("8" "8" "8") "01") (("8" "8" "8") "10") (("8" "8" "8") "11")))


pltAck
; list2wave

curvX=geneCurvX()
curvX=geneCurvX('("1" "8") "00")
length(curvX)

ineed('list2wave)
i=0 
curvL=foreach(mapcar Y curvX list(i++ eval(Y)))
;apply('mapcar 'list curvL)
;srCurv=list2wave(apply('mapcar 'list curvL))
srCurv=list2wave(curvL)

plot(srCurv)

only3=geneDUT_343('("2"  "4" "8") "XOR2X")
length(only3);=> 125
cv=dbOpenCellViewByType( "ATEST_h18" "xor_DUT_sim248" "schematic" "schematic" "w")

t0=cputime()
cvXy=addCellw3(cons(ajout only3) '(0 0) cv) ;=> ok
t1=cputime()
printf("%d 1/60 secondes cpu\n" t1-t0);=> ?? 131748[60ths of a sec]=52mins? pour only3 wo/Param  ;=> 3141 pour only2
printf("%g secondes cpu\n" 1.0/60*(t1-t0));=> ?? 131748[60ths of a sec]=52mins? pour only3 wo/Param  ;=> 3141 pour only2


listNet=geneDUTnetlist('("3" "6" "L") "00" "XORX2" 10)
file="~/myNetlist.txt"
fp=outfile(file)
i=10
;cell='("BUFTX2" "pulse" "BU_6_3_L_00" "gnd!" "sub!" "vdd!")
foreach(cell listNet
nets=apply('strcat foreach(mapcan c cdr(cell) list(" " c)))
fprintf(fp "C%d (%s) %s\n" i++ nets car(cell))
)
close(fp)
edit(eval(file))

elist='("L" "1" "2" "3" "4" "6" "8") 
elist='("6" "8") 
elist='("6" "1") 
bits='("00" "01" "10" "11")
inc=10
listNet=nil
foreach(ni elist
foreach(nj elist
foreach(nk elist
foreach(bit bits
listNet=tconc(listNet geneDUTnetlist(list(ni nj nk) bit "XOR2X" inc))
inc=inc+7
))))

grafList=nil
foreach(ni elist
foreach(nj elist
foreach(nk elist
foreach(bit bits
grafList=tconc(grafList sprintf(nil "_%s_%s_%s_%s" ni nj nk bit))
))))
glist=car(grafList)

for(i 0 5 printf("VT(%L)\n" strcat("Q" nth(i glist))))
for(i 0 5 printf("plot(VT(%L))\n" strcat("Q" nth(i glist))))



listn=car(listNet)
length(listn)
car(listn)
length(car(listn));=> 8
car(last(listn))
apply('strcat elist)

file="~/myNetlist.txt"
fp=outfile(file)
i=10
;cell='("BUFTX2" "pulse" "BU_6_3_L_00" "gnd!" "sub!" "vdd!")
foreach(line listn
foreach(cell line
nets=apply('strcat foreach(mapcan c cdr(cell) list(" " c)))
fprintf(fp "C%d (%s) %s\n" i++ nets car(cell))
))
close(fp)
edit(eval(file))


elist='("L" "1" "2" "3" "4" "6" "8") 
addCell(foreach(mapcar e elist strcat("XOR2X" e)))




;; ioedge=car(ioedges)
;; intercept2(list(strcat("Qm_" pat) strcat("Q_" pat)) ioedge nil nil)

;tcurbs=geneVTX('("6" "8"))
tcurbs=geneVTX('("6" "1"))
curbs=foreach(mapcar c tcurbs car(c))
vals=foreach(mapcar c tcurbs cdr(c))
length(vals)/4
;curbs=geneVTX()
foreach( c curbs plot(eval(c)))
foreach(mapcar c curbs value(eval(c) 0))

ineed('list2wave)
i=0 
curvL=foreach(mapcar Y curbs list(i++ eval(Y)))
srCurv=list2wave(curvL)
plot(srCurv)

;; foreach(v vals printf("%s => %s\n" cadr(v) aelSuffixNotation(car(v)) ))

als=vals while(als
for(i 0 3 i++ v=car(als) als=cdr(als)
printf("%s => %s\t" cadr(v) aelSuffixNotation(car(v)))) printf("\n"))



dir="~/Work/h18/Sim/AAA/spectre/schematic/netlist/"
geneRepList( '("L" "1" "2" "3" "4" "6" "8") dir t)
;<= ^^ too much, 4.2G tran.tran file pour seulement 385.1 ps de simu au lieu de 40ns
geneRepList( '("L" "1" "2" "3" "4") dir t)
geneRepSim(dir)
; Une fois la simu terminer => cross(...)
tcurbs=geneVTX('("L" "1" "2" "3" "4" "6" "8")) ;=> liste de curv_Q_i_j_k_00_ff value(0) "i_j_k_00_ff"
elist='("L" "1" "2" "3" "4")
geneRepList( elist dir t);=> fail quota exceeded ?
; goto ADE -> result selection, sinon il faut utiliser v("net" ?resultdir "pwd...")
tcurbs=geneVTX(elist)
length(tcurbs)
fileSave=strcat("save" apply('strcat foreach(mapcar e elist strcat("_" e))))
;; sauvegarde ie : "save_L_1_2_3_4"
edit(eval(fileSave))
val2save(foreach(mapcar cr tcurbs list(car(cr))) fileSave)
;Pour restaurer les valeures : load(strcat(pwd() "/" fileSave)) ;=> redefinie curv_
curbs=foreach(mapcar cr tcurbs cadr(cr))
i=0 
curvL=foreach(mapcar Y curbs list(i++ eval(Y)))
srCurv=list2wave(curvL)
plot(srCurv)

printf("delay mean = %s sigma=%s\n" aelSuffixNotation(average(srCurv)) aelSuffixNotation(rms(srCurv)))


elist='("L" "1" "2" "3" "4")
bit='("0" "1")
ni="4" nj="2" nk="L" bi="0"

(setq dlys
foreach(mapcan ni elist
foreach(mapcan nj elist
foreach(mapcan nk elist
foreach(mapcar bi bit
set(concat('ibm_ strcat(ni "_" nj "_" nk "_" bi))
eval(concat('curv_Qm_ strcat(ni "_" nj "_" nk "_" bi "0_ff")))+
eval(concat('curv_Qm_ strcat(ni "_" nj "_" nk "_" bi "0_rr")))-
eval(concat('curv_Qm_ strcat(ni "_" nj "_" nk "_" bi "1_fr")))-
eval(concat('curv_Qm_ strcat(ni "_" nj "_" nk "_" bi "1_rf")))
))))))

dlym=list2minus(dlys)
;; length(dlym);=>31125
;; 250*249/2;=>31125
i=0 
dlyw=foreach(mapcar dl dlym list(i++ dl))
dlyc=list2wave(dlyw)
plot(dlyc ?expr list("ff+rr-fr-rf"))

printf("delay mean = %s sigma=%s\n" aelSuffixNotation(average(dlyc)) aelSuffixNotation(rms(dlyc)))


;; IBM
;; fam=inv2fam(1) t
;; dll2periodSim(fam)
;; fam2display(fam)

inv2fam(9)

;; ;Dzi data
;; 0001100011 0001100110
;; 0011000011 0011000110
;; 0110000011 0110000110
;; ;Dzi data
;; 000110001100011001100011000011001100011001100000110110000110
;; ;clk_Dzi;
;; 010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101



binaryStringCode(10 t 'evenp)

0110110101
00100100110001010011

dzin='("0110110101" "1010110110")

apply('strcat dzin)  ;=> "01101101011010110110"

;cat input.scs |sed 's/\(dzi_in=.\)\([01]*\)\(.\)/\1TOTO\3/' |grep parameters




;; hum hum, ca ouvre 512 xterm... pas bon, on va plustot faire en serie avec run() dans icfb..
(setq dir "/home/validmgr/ebecheto/Work/IBMv18/Sim/Tdc_CH1r_sim/spectre/schematic/netlist/")
(setq dir "/home/validmgr/ebecheto/Work/IBMv18/Sim/Tdc_CH2_sim/spectre/schematic/netlist/")
bincodes=binaryStringCode(10 t 'evenp)
bincode=car(bincodes);=>"0000000011"
bincode=car(nthcdr(2 bincodes));=>"0000000011"

; si j'ai deja fait 11 simu => mettre nthcdr a 11
foreach( bincode nthcdr(126 bincodes)
; dzin=list(bincode buildString(reverse(parseString(bincode "")) ""));=>("0000000011" "1100000000")
dzin=list(bincode bincode)
;dzin='("0110110101" "1010110110")
; apply('strcat dzin) ;=>"00000001010000000101"
; "00000000110000000011"
genDziSim(dzin dir "")
; take needed data
; sync=cross(v("/Sync_0" ?result "tran") 0.6 1 "rising" nil nil);<= simu stoppe a 2?05 pour limiter la simu => pas de hit de synchro
per1=1/frequency(clip(VT("/Z1") 2u 2.2u ))
per2=1/frequency(clip(VT("/Z2") 2u 2.2u ))
file=strcat(pwd() "/Tdc2_rcx_" car(dzin) "_" cadr(dzin) ".dat");=>"/home/validmgr/ebecheto/Work/IBMv18/Tdc1_rcx_0110110101_1010110110.dat"
ptf=outfile(file)
fprintf(ptf "%g\n%g\n%s\n" per1 per2 aelSuffixNotation(per1-per2))
close(ptf)
;; apply('edit list(file))
;; printf("%L\n" list(sync per1 per2))
;; printf("%g\n%g\n%s\n" per1 per2 aelSuffixNotation(per1-per2))
)

file=strcat(pwd() "/Tdc2_rcx_" car(dzin) "_" cadr(dzin) ".dat");=>"/home/validmgr/ebecheto/Work/IBMv18/Tdc1_rcx_0110110101_1010110110.dat"




;; simulator('spectre)
;; design("afs_TDC_BRICK" "Tdc_CH1r_sim" "schematic")
;; design("/home/validmgr/ebecheto/Work/IBMv18/Sim/Tdc_CH1r_sim/spectre/schematic")
;; design(strcat(dir "netlist"))
;; run()
;; resultsDir()
;; "/home/validmgr/ebecheto/Work/IBMv18/Sim/Tdc_CH1r_sim/spectre/schematic"

;; 1/frequency(clip(VT("/Z1") 2u 2.2u )); 2.871909e-09
;; 1/frequency(clip(VT("/Z1") 2u 2.1u )); 2.871828e-09
;; 1/frequency(clip(VT("/Z1") 2.01u 2.2u )); 2.871912e-09
;; 1/frequency(clip(VT("/Z1") 2.01u 2.1u )); 2.87183e-09
;; 1/frequency(clip(VT("/Z1") 2.01u 2.05u ));2.871844e-09




dzin='("0110110101" "1010110110")
dzin='("123456789A" "0001100011")
dz=car(dzin)

defun(dzin2register (@optional (dzin '("123456789A" "1010110110")))
foreach(mapcar dz dzin
d=parseString(dz "")
buildString(list(
nthelem(10 d)
nthelem(1 d)
nthelem(9 d)
nthelem(2 d)
nthelem(8 d)
nthelem(3 d)
nthelem(7 d)
nthelem(4 d)
nthelem(6 d)
nthelem(5 d)
)
"")
))


mapcar(if(rev==t 'reverse 'list) '(1 2 3 4))

defun(dzin2register (@optional (dzin nil)(swList t)(rev nil))
let((revs)
unless(dzin dzin='("123456789A" "1010110110"))
cond((swList==nil swList='(2 4 6 8 10 9 7 5 3 1)) (t '(10 1 9 2 8 3 7 4 6 5)))
foreach(mapcar dz dzin
d=parseString(dz "")
revs=foreach(mapcar nb swList apply('nthelem list(nb d)))
buildString(if(rev reverse(revs) revs) "")
)))




defun(dzin2register (@optional (dzin nil)(swList t)(rev nil))
let((revs)
unless(dzin dzin='("123456789A" "1010110110"))
cond((swList==nil swList='(2 4 6 8 10 9 7 5 3 1)) (t '(10 1 9 2 8 3 7 4 6 5)))
foreach(mapcar dz dzin
d=parseString(dz "")
revs=foreach(mapcar nb swList apply('nthelem list(nb d)))
buildString(if(rev reverse(revs) revs) "")
)))


;; apply('nthelem list(5 parseString("123456789A" "")))
;; nthelem(5 parseString("123456789A" ""))







dzin2register()
("A192837465" "0110110011")
dzin2register(nil nil)
dzin2register(nil nil t)
("13579A8642" "1110101100")
("2468A97531" "0011010111")
("A192837465" "0110110011")

;; ;Dzi data
dzins='(
("0001100011" "0001100110")
("0011000011" "0011000110")
("0110000011" "0110000110")
)

foreach(mapcar dzin dzins dzin2register(dzin))

(
("1010000101" "0010100101")
("1010010100" "0010110100")
("1011010000" "0011110000"))


value(VT("/I0/I3/I0/I0/Q<1:10>") 1.8u)
ocnPrint(value(VT("/I0/I3/I14/I0/Q<1:10>") 1.8u))
value(VT("/I0/I3/I15/I0/Q<1:10>") 1.8u)

wave=v("/I0/I3/I14/I0/Q<1:10>" ?result "tran-tran" ?resultsDir "./Sim/TDC_BRICK_sim/spectre/schematic/psf")

ocnPrint(value(wave 1.9u))

ocnPrint(value(v("/I0/I3/I14/I0/Q<1:10>" ?result "tran-tran") 1.8u))


dzS1=apply('strcat 
bits=foreach(mapcar i linRg(1 10 1)
bit=value(v(sprintf(nil "/I0/I3/I14/I0/S<%d>" i) ?result "tran-tran" ?resultsDir "./Sim/TDC_BRICK_sim/spectre/schematic/psf") 1.5u)
if(bit > 0.6 "1" "0"))
)

dzS2=apply('strcat 
bits=foreach(mapcar i linRg(1 10 1)
bit=value(v(sprintf(nil "/I0/I3/I14/I1/S<%d>" i) ?result "tran-tran" ?resultsDir "./Sim/TDC_BRICK_sim/spectre/schematic/psf") 1.5u)
if(bit > 0.6 "1" "0"))
)


; dzS1="1001001010"
dzset=list(dzS1 dzS2)

dzin2register(dzset nil t)
("1001100010" "1001010010")
dzin2register(dzset nil)
("0100011001" "0100101001")
dzin2register(dzset)
("0110001100" "1100001100")
dzin2register(dzset t nil)
("1001100010" "1001010010")
("0110001100" "1100001100")

0110001100

apply('strcat bits)

; value clk rising edge :
20*25n-12.5n ;=>4.875e-07

;value should start for Tdc2 ...
20*25n ;= >500n
60*25n ;= >500n

fft=dft(v("/I0/I3/I14/I0/Q<1:10>" ?result "tran-tran") 2u 2.5u 64*1024 "Rectangular" 1 "default" )

ocnPrint(clip(fft 300M 500M)



plot(lshift(VT("/Dziout") 1.49u ))
plot(v("/I0/I3/I14/I0/Q<3>" ?result "tran-tran"))

VT("/I0/I3/I14/I0/S<1:10>")


0001100011
0001100110
0011000011
0011000110
0110000011
0110000110


;;schematic TOP	 Mon Feb 10 17:27:26 CET 2014
1/frequency(clip(VT("/B_1c") 	2.01u 2.05u ));=>2.810515e-09
1/frequency(clip(VT("/Bf_1c") 	2.01u 2.05u ));=>2.804682e-09
1/frequency(clip(VT("/B_2c") 	2.01u 2.05u ));=>2.784584e-09
1/frequency(clip(VT("/Bf_2c") 	2.01u 2.05u ));=>2.778884e-09
1/frequency(clip(VT("/B_3c") 	2.01u 2.05u ));=>2.993663e-09
1/frequency(clip(VT("/Bf_3c") 	2.01u 2.05u ));=>2.96551e-09



cross(clip(VT("/B_1c") 2.00u 2.05u )  0.6 1 "falling" nil nil);=>2.004838e-06
cross(clip(VT("/Bf_1c") 2.00u 2.05u ) 0.6 1 "falling" nil nil);=>2.005782e-06
cross(clip(VT("/B_2c") 2.00u 2.05u )  0.6 1 "falling" nil nil);=>2.004765e-06
cross(clip(VT("/Bf_2c") 2.00u 2.05u ) 0.6 1 "falling" nil nil);=>2.005709e-06
cross(clip(VT("/B_3c") 2.00u 2.05u )  0.6 1 "falling" nil nil);=>2.004821e-06
cross(clip(VT("/Bf_3c") 2.00u 2.05u ) 0.6 1 "falling" nil nil);=>2.005743e-06




;; extracted_TDC Wed Feb 12 15:05:43 CET 2014
1/frequency(clip(VT("/B_1c") 	2.01u 2.05u ));=> 2.925812e-09
1/frequency(clip(VT("/Bf_1c") 	2.01u 2.05u ));=> 2.917189e-09
1/frequency(clip(VT("/B_2c") 	2.01u 2.05u ));=> 2.880032e-09
1/frequency(clip(VT("/Bf_2c") 	2.01u 2.05u ));=> 2.875038e-09
1/frequency(clip(VT("/B_3c") 	2.01u 2.05u ));=> 3.212998e-09
1/frequency(clip(VT("/Bf_3c") 	2.01u 2.05u ));=> 3.189245e-09


cross(clip(VT("/B_1c") 2.00u 2.05u )  0.6 1 "falling" nil nil);=> 2.005065e-06
cross(clip(VT("/Bf_1c") 2.00u 2.05u ) 0.6 1 "falling" nil nil);=> 2.006e-06
cross(clip(VT("/B_2c") 2.00u 2.05u )  0.6 1 "falling" nil nil);=> 2.00497e-06
cross(clip(VT("/Bf_2c") 2.00u 2.05u ) 0.6 1 "falling" nil nil);=> 2.005905e-06
cross(clip(VT("/B_3c") 2.00u 2.05u )  0.6 1 "falling" nil nil);=> 2.005077e-06
cross(clip(VT("/Bf_3c") 2.00u 2.05u ) 0.6 1 "falling" nil nil);=> 2.005992e-06


;; extracted_GDSPIN Wed Feb 12 21:24:38 CET 2014
; charge de 5pf
1/frequency(clip(VT("/B_1c") 	2.01u 2.05u ));=> 2.672156e-09
1/frequency(clip(VT("/Bf_1c") 	2.01u 2.05u ));=> 2.665306e-09
1/frequency(clip(VT("/B_2c") 	2.01u 2.05u ));=> 2.640275e-09
1/frequency(clip(VT("/Bf_2c") 	2.01u 2.05u ));=> 2.633434e-09
1/frequency(clip(VT("/B_3c") 	2.01u 2.05u ));=> 2.823301e-09
1/frequency(clip(VT("/Bf_3c") 	2.01u 2.05u ));=> 2.788384e-09



 