; load("osc.il")
; bug counter @909ps => simuler a part.
; quand 1 seul enable, freqDiff=2.3521p Fslow=


;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf0"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf1"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf2"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf3"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf4"
simulator('UltraSim)
when(rdir resultsDir(openResults(rdir)))

logFile=sprintf(nil "%s/osc.log" pwd())
system(sprintf(nil "echo -n -e _________ >> %s; date >>%s" logFile logFile)) 

pf = outfile(logFile "a")
; UltraSim results();=> (variables tran); et non tran-tran 
;! => utiliser plutot VT

; frequency(v("/slow" ?resultsDir rdir ?result "tran"))

Fslow=frequency(v("/slow" ?resultsDir rdir ?result "tran"))
Ffast=frequency(v("/fast"  ?resultsDir rdir ?result "tran"))
freqDiff = ((1 / frequency(v("/fast"  ?resultsDir rdir ?result "tran"))) - (1 / frequency(v("/slow"  ?resultsDir rdir ?result "tran"))))
fprintf(pf "Fslow=%s\nFfast=%s\nfreqDiff=%s\n" aelSuffixNotation(Fslow) aelSuffixNotation(Ffast) aelSuffixNotation(freqDiff))

ocnPrint(?output pf cross(v("/sync" ?resultsDir rdir ?result "tran") 1 1 "falling"  t "time"  ))
close(pf)
pf=nil


last2=cross(v("/fast" ?resultsDir rdir ?result "tran") 1 -2 "rising" nil nil)
last1=cross(v("/fast" ?resultsDir rdir ?result "tran") 1 -1 "rising" nil nil)
slow2=cross(v("/slow" ?resultsDir rdir ?result "tran") 1 -2 "rising" nil nil)
slow1=cross(v("/slow" ?resultsDir rdir ?result "tran") 1 -1 "rising" nil nil)
per=last1-last2
tset=last2+per/4

; v("/S<1>" "tran")
cntS=0 cntF=0
foreach(mapcar i linRg(1 10 1) cntS=cntS+2**(i-1)*round(value(evalstring(sprintf(nil "v(\"/S<%d>\" ?resultsDir rdir ?result \"tran\")" i)) tset)/1.8))
foreach(mapcar i linRg(1 10 1) cntF=cntF+2**(i-1)*round(value(evalstring(sprintf(nil "v(\"/F<%d>\" ?resultsDir rdir ?result \"tran\")" i)) tset)/1.8))

printf("At %s\n
cntS=%d t1=%s t2=%s\n
cnfF=%d t1=%s t2=%s\n
" aelSuffixNotation(tset) cntS aelSuffixNotation(slow1) aelSuffixNotation(slow2) cntF aelSuffixNotation(last1) aelSuffixNotation(last2))
pf = outfile(logFile "a")
fprintf(pf "At %s\n
cntS=%d t1=%s t2=%s\n
cnfF=%d t1=%s t2=%s\n
" aelSuffixNotation(tset) cntS aelSuffixNotation(slow1) aelSuffixNotation(slow2) cntF aelSuffixNotation(last1) aelSuffixNotation(last2))
close(pf)

printf("CHECK LOG FILE : %s\n" logFile)
printf("edit(%L)\n" logFile)
;; sprintf(cmd "cat %s|sed '/^$/d' >.tmp;mv .tmp %s" logFile logFile)
;; system(cmd)

;; unless(fboundp('dateStamp) load("dateStamp.il"))
;; nlistName=asiGetSimInputFileName(asiGetCurrentSession())
;; nlist=strcat(asiGetNetlistDir(asiGetCurrentSession()) "/" nlistName)
;; saveNetlist=strcat(pwd() "/" dateStamp() "_"  nlistName)
;; system(sprintf(nil "echo cp %s %s" nlist saveNetlist))
;; system(sprintf(nil "cp %s %s" nlist saveNetlist))
;; printf("edit(%L)\n" saveNetlist)


1 / (freq VT("/fast") "rising" ?xName "cycle" ?mode "auto" ?threshold 0.0)-1 / (freq VT("/slow") "rising" ?xName "cycle" ?mode "auto" ?threshold 0.0)


1 / (freq VT("/fast") "rising" ?xName "time" ?mode "auto" ?threshold 0.0)-1 / (freq VT("/slow") "rising" ?xName "time" ?mode "auto" ?threshold 0.0)

elist='("L" "1" "2" "3" "4" "6" "8") 
foreach(mapcar e elist 
net=strcat("Q" e)
curve=VT(net)
;ocnPrint(curve);<= error ...
printf("ocnPrint(VT%L)\n" list(strcat("Q" e)))
printf("plot(VT%L)\n" list(strcat("Q" e)))
printf("ocnPrint(v(%L ?result \"tran-tran\"))\n" strcat("/Q" e)))

;____________________________________________________________________________
unless(fboundp('ocnPrint) load("ocnPrint2list.il"))

elist='("L" "1" "2" "3" "4" "6" "8") 
rw=foreach(mapcar e elist 
net=strcat("Q" e)
riseTime(VT(net) 0 nil 1.8 nil 10 90 nil "time" )
)
; ocnPrint(rw)
apply(' ocnPrint rw)

fw=foreach(mapcar e elist 
net=strcat("Q" e)
riseTime(VT(net) 1.8 nil 0 nil 10 90 nil "time" ))
apply(' ocnPrint fw)

elist='("L" "1" "2" "3" "4" "6" "8") 
foreach(mapcar e elist 
printf("\t XOR2X%s"  e))


@CL=1f        	 	 XOR2XL	 	 XOR2X1	 	 XOR2X2	 	 XOR2X3	 	 XOR2X4	 	 XOR2X6	 	 XOR2X8
sel               riseTime VT(Q    riseTime VT(Q    riseTime VT(Q    riseTime VT(Q    riseTime VT(Q    riseTime VT(Q    riseTime VT(Q
    0               139.75p           117.066p           33.7081p          31.7523p          32.2766p          32.8574p          34.4028p       
    1.8             108.556p           87.2884p          32.7292p          30.61p            31.0362p          31.5514p          33.1167p       

sel               fallTime VT(Q    fallTime VT(Q    fallTime VT(Q    fallTime VT(Q    fallTime VT(Q    fallTime VT(Q    fallTime VT(Q
    0                49.2111p          56.9242p          25.0124p          23.8483p          22.9905p          22.3272p          23.4192p       
    1.8              33.0021p          29.3546p          25.1668p          24.1799p          23.5464p          23.3395p          24.6252p       



r=riseTime(VT("/Q3" ) 0 nil 1.8 nil 10 90 nil "time" )
;ocnPrint(a)
f=riseTime(VT("/Q3" ) 1.8 nil 0 nil 10 90 nil "time" )
ocnPrint(r f)

elist='("L" "1" "2" "3" "4" "6" "8") 
rw=foreach(mapcar e elist 
net=strcat("Q" e)
plot(riseTime(VT(net) 0 nil 1.8 nil 10 90 nil "time" )))

rw=foreach(mapcar e elist 
net=strcat("Q" e)
plot(deriv(riseTime(VT(net) 0 nil 1.8 nil 10 90 nil "time" ))))


rw=foreach(mapcar e elist 
net=strcat("Q" e)
plot(deriv(riseTime(VT(net) 0 nil 1.8 nil 10 90 nil "time" ))))

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1.44/value(deriv(riseTime(VT(net) 0 nil 1.8 nil 10 90 nil "time" )) 40e-15))

foreach(mapcar r rw aelSuffixNotation(r))
("36.1u" "73.05u" "133.6u" "207.3u" "267.8u" "423.8u" "570.8u");<= sel=1.8 => inverseur RISETIME
("36.22u" "73.08u" "133.6u" "207.9u" "267.9u" "425.7u" "571.4u");<= sel=0 => suiveur RISETIME
("184.6u" "376.9u" "364.7u" "555.7u" "752.4u" "1.153m" "1.558m");<= sel=0 =>suiveur FALLTIME


rw=foreach(mapcar e elist 
net=strcat("Q" e)
1.44/value(deriv(riseTime(VT(net) 1.8 nil 0 nil 10 90 nil "time" )) 40e-15))

foreach(mapcar r rw aelSuffixNotation(r))



rw=foreach(mapcar e elist 
net=strcat("Q" e)
1f/1p*value(deriv(riseTime(VT(net) 0 nil 1.8 nil 10 90 nil "time" )) 40e-15))
foreach(mapcar r rw aelSuffixNotation(r))

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1/1p*value(riseTime(VT(net) 0 nil 1.8 nil 10 90 nil "time" ) 0))
foreach(mapcar r rw aelSuffixNotation(r))

k1='("67.29" "67.11" "23.36" "24.72" "26.48" "28.55" "30.83")
k2='("39.92" "19.75" "10.78" "6.941" "5.38" "3.392" "2.522")

k3='("97.45" "96.52" "24.5" "25.93" "27.74" "29.83" "32.07")
k4='("39.76" "19.73" "10.79" "6.924" "5.368" "3.374" "2.506")

Delay[ps]=k1+k2*Cload

cross(VT("/B") 0.9 1 "rising" nil nil  )
Bt=average(cross(VT("/B") 0.9 1 "rising" nil nil  ));=> 1.065E-9

rw=foreach(mapcar e elist 
net=strcat("Q" e)
plot(cross(VT(net) 0.9 1 "rising" nil nil  )-Bt))
;foreach(mapcar r rw aelSuffixNotation(r))

;BUFFER
;INTERCEPT
rw=foreach(mapcar e elist 
net=strcat("Q" e)
1f/1p*value(deriv(cross(VT(net) 0.9 1 "rising" nil nil  )-Bt) 40e-15))
println(foreach(mapcar r rw aelSuffixNotation(r)))
dlybRC='("18.76" "9.22" "5.026" "3.225" "2.523" "1.615" "1.234")
; delayBufferRiseCload

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1/1p*value(cross(VT(net) 0.9 1 "rising" nil nil  )-Bt 0)) t
println(foreach(mapcar r rw aelSuffixNotation(r)))
dlybR0='("83.15" "92.31" "153.7" "167.1" "179.5" "203.2" "219.8")
; delayBufferRiseCload

; FALLING
Bt=average(cross(VT("/B") 0.9 1 "falling" nil nil  ));=> 1.065E-9

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1f/1p*value(deriv(cross(VT(net) 0.9 1 "falling" nil nil  )-Bt) 40e-15)) t
println(foreach(mapcar r rw aelSuffixNotation(r)))
dlybFC='("4.392" "2.359" "2.236" "1.514" "1.159" "814.3m" "652.9m")

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1/1p*value(cross(VT(net) 0.9 1 "falling" nil nil  )-Bt 0)) t
println(foreach(mapcar r rw aelSuffixNotation(r)))
dlybF0='("79.52" "107.6" "141.6" "144.5" "147.6" "153.7" "159.9")


;INVERTER
; RISING INTERCEPT
Bt=average(cross(VT("/B") 0.9 1 "falling" nil nil  ));=> 1.065E-9

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1f/1p*value(deriv(cross(VT(net) 0.9 1 "rising" nil nil  )-Bt) 40e-15))
dlyiRC=foreach(mapcar r rw aelSuffixNotation(r)) t
println(dlyiRC)
; dlyiRC='("18.74" "9.228" "5.025" "3.225" "2.523" "1.615" "1.231")
; delayInvertererRiseCload

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1/1p*value(cross(VT(net) 0.9 1 "rising" nil nil  )-Bt 0)) t
dlyiR0=foreach(mapcar r rw aelSuffixNotation(r))
println(dlyiR0)
; dlyiR0='("39.34" "43.09" "107.8" "121.3" "134.2" "158.6" "175.7")
; delayBufferRiseCload

; FALLING
Bt=average(cross(VT("/B") 0.9 1 "rising" nil nil  ));=> 1.065E-9

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1f/1p*value(deriv(cross(VT(net) 0.9 1 "falling" nil nil  )-Bt) 40e-15)) t
dlyiFC=foreach(mapcar r rw aelSuffixNotation(r)) t
println(dlyiFC)
; dlyiFC='("6.061" "3.085" "2.242" "1.521" "1.166" "822.8m" "662.1m")

rw=foreach(mapcar e elist 
net=strcat("Q" e)
1/1p*value(cross(VT(net) 0.9 1 "falling" nil nil  )-Bt 0)) t
dlyiF0=foreach(mapcar r rw aelSuffixNotation(r)) t
println(dlyiF0)
;dlyiF0='("15.02" "19.94" "76.31" "79.99" "83.89" "91.92" "99.47")


XORcap='(3.6f 4.6f 3.6f 3.8f 3.8f 3.8f 3.8f) ; (from datasheet.. i cannot remember)

;; dlybRC='("18.76" "9.22" "5.026" "3.225" "2.523" "1.615" "1.234")
;; dlybR0='("83.15" "92.31" "153.7" "167.1" "179.5" "203.2" "219.8")
;; dlybFC='("4.392" "2.359" "2.236" "1.514" "1.159" "814.3m" "652.9m")
;; dlybF0='("79.52" "107.6" "141.6" "144.5" "147.6" "153.7" "159.9")
;; dlyiRC='("18.74" "9.228" "5.025" "3.225" "2.523" "1.615" "1.231")
;; dlyiR0='("39.34" "43.09" "107.8" "121.3" "134.2" "158.6" "175.7")
;; dlyiFC='("6.061" "3.085" "2.242" "1.521" "1.166" "822.8m" "662.1m")
;; dlyiF0='("15.02" "19.94" "76.31" "79.99" "83.89" "91.92" "99.47")

i=-1
;; creation de l'AST pour le traitement des delay '(name (list inverterDelay) (list bufferDelay) capaInput)
XORdly=foreach(mapcar e elist i=i+1
list(strcat("XOR2X" e )
list(nth(i dlyiR0) nth(i dlyiRC) nth(i dlyiF0) nth(i dlyiFC))
list(nth(i dlybR0) nth(i dlybRC) nth(i dlybF0) nth(i dlybFC))
nth(i XORcap)))


i=-1
XORdly=foreach(mapcar e elist i=i+1
list(strcat("XOR2X" e )
list(aelNumber(nth(i dlyiR0)) aelNumber(nth(i dlyiRC)) aelNumber(nth(i dlyiF0)) aelNumber(nth(i dlyiFC)))
list(aelNumber(nth(i dlybR0)) aelNumber(nth(i dlybRC)) aelNumber(nth(i dlybF0)) aelNumber(nth(i dlybFC)))
nth(i XORcap)))

;temps de propag en picosecondes.
XORdly='(
    ("XOR2XL" 
	(39.34 18.74 15.02 6.061) 
	(83.15 18.76 79.52 4.392) 3.6e-15
    ) 
    ("XOR2X1" 
	(43.09 9.228 19.94 3.085) 
	(92.31 9.22 107.6 2.359) 4.6e-15
    ) 
    ("XOR2X2" 
	(107.8 5.025 76.31 2.242) 
	(153.7 5.026 141.6 2.236) 3.6e-15
    ) 
    ("XOR2X3" 
	(121.3 3.225 79.99 1.521) 
	(167.1 3.225 144.5 1.514) 3.8e-15
    ) 
    ("XOR2X4" 
	(134.2 2.523 83.89 1.166) 
	(179.5 2.523 147.6 1.159) 3.8e-15
    )
    ("XOR2X6" 
	(158.6 1.615 91.92 0.8228) 
	(203.2 1.615 153.7 0.8143) 3.8e-15
    ) 
    ("XOR2X8" 
	(175.7 1.231 99.47 0.6621) 
	(219.8 1.234 159.9 0.6529) 3.8e-15
    )
)


;nth     0   1   2   3   4   5   6
elist='("L" "1" "2" "3" "4" "6" "8") 
line='((5 1 )(5 1)(5 0)(5 0)(5 0)(5 0)(5 1)(5 1)(5 0)(5 1 0.6))
xorline='((5 1)(5 1)(5 0)(5 0)(5 0)(5 0)(5 1)(5 1)(5 0)(5 1 0.1))
xorline='((5 1)(5 1)(5 0)(5 0)(5 0)(5 0)(5 0)(5 0)(5 0)(5 1))
;=> 1=inverter, 0=buffer => ubove line = 5 inverters, 5 buffers  elements overall
; third param=additinonal load cap (ie  : 2xDflipflip for the phase detector, inverter for the counter ...additional charges)

defun(line2freq (@optional (xorline '((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1))) (CLall 0.5) (verb nil))
;(setq CLall 0.5)
nbInv=apply('plus foreach(mapcar x xorline cadr(x)||1))
nbAll=length(xorline)
nbBuf=nbAll-nbInv
when(verb printf("%L | " xorline) printf("%d Elements, %d-inv, %d-buf\n" nbAll nbInv nbBuf))
i=-1
dlys=foreach(mapcar x xorline i=i+1
;; x='(4 0)
;; i=4
x_next=nth(mod(i+1 nbAll) xorline)
xor=strcat("XOR2X" nth(car(x) elist))
xor_next=strcat("XOR2X" nth(car(x_next) elist))
;; xor="XOR2X4"; ie
;; xor_next="XOR2X6"; ie
elem=assoc(xor XORdly)
invOrBuf=cadr(x)||1 ;<= par defaut, inverseur
dlyRF=nth(invOrBuf+1 elem);delay rise(d0 slope) fall(d0 slope) table
d0r=nth(0 dlyRF)
dCr=nth(1 dlyRF)
d0f=nth(2 dlyRF)
dCf=nth(3 dlyRF)

elem_next=assoc(xor_next XORdly)
Cin_next=nth(3 elem_next)/1f;=> enregistre en femto Farad...ou pas?
CL2=nth(2 x)||0
CLt=CLall+Cin_next+CL2
dlySum=d0r+d0f+CLt*(dCr+dCf)
when(verb printf("d0r+d0f+CLt*(dCr+dCf)\t %g %g %g %g %g\n" d0r d0f CLt dCr dCf))
dlySum)
when(verb 
dlyt=apply('plus dlys)
freq=1.0/dlyt/1p
printf("freq=%g\n" freq))
dlys)

d=line2freq(xorline 0.1 )
aelSuffixNotation(1.0/apply('plus d)/1p);=>272.9M __ Mega Hertz
line2freq(xorline 0.1 t)

defun(gencomb (@optional (x '(nil nil nil nil nil)) (abc '(1 2 3)))
cond(
(car(x) list(x))
(car(x)==nil foreach(mapcan a abc gencomb(append(cdr(x) list(a)) abc)))))
; default => 243 cominaisons
; length(gencomb())

procedure( factorial( n ) if( zerop( n ) then  1 else   n*factorial( n-1)  ))


defun(gencomb1 (@optional (x 10) (abc '(1 2 3)))
let((void)
for(i 1 x void=append(void list(nil)))
gencomb(void abc)))

x345=gencomb1(10 '(3 4 5))
length(x345);=>59049 = 3**10
x45=gencomb1(10 '(4 5))
length(x45);=>1024 = 2**10

x45=gencomb1(5 '(1 2 3))

;=> length(abc)**length(x) combinaison
;=> default => 3**5
;=> cas 10 xor
gencomb()
;; ==> ...
;;     (3 3 3 2 3)
;;     (3 3 3 3 1) 
;;     (3 3 3 3 2) 
;;     (3 3 3 3 3)
;; )

defun(xorListGen (@optional (xorList '(4 5)) (nbRank 10))
(setq xorList '(4 5))
(setq nbRank 10)
empty='()
for(i 1 nbRank empty=append(empty list(nil)))
comb=gencomb(empty xorList)
length(comb)
comb
)

empty='(nil nil nil nil nil nil nil nil nil nil)
; println(empty)
comb=gencomb(empty '(4 5))

defun(gencomb2 (@optional (x '(4 5 4 5 5 5 4 5 4 4)) (ab '(0 1)))
cond(
(listp(car(x)) list(x))
(!listp(car(x)) foreach(mapcan a ab gencomb2(append(cdr(x) list(list(car(x) a))) ab)))))

gencomb2()
length(gencomb2())

apply('plus '(0 1 1 1 nil))
foreach(mapcar i '(0 1 1 1 nil) i||0)
apply('plus foreach(mapcar i '(0 1 1 1 nil) i||0))
apply('plus remove(nil '(0 1 1 1 nil)))


;; defun(gencomb01 (@optional (x '(0 0 0 0 0 0 0)) (n 3))
;; cond(
;; (n=0 x)
;; (length(x)<n nil)
;; (apply('plus x)>=n list(x))
;; (t printf("x:%L\n" x)
;; foreach(mapcar i '(1 0) gencomb01(append(cdr(x) list(i)) n-i)))))

defun(cnpbin (@optional (nbit 4) (nrack 8) (verb nil))
let((sum res)
for(i 1 2**nrack sum=0
for(j 0 nrack-1 sum=sum+((i>>j)&1))
when(sum==nbit res=append(res list(i))
when(verb printf("%d \t= %s\n" i abIntToBinaryStr(i nrack)))
)
)
res))

ib=cnpbin(3 10)

nbRank=8
ib=cnpbin(3 nbRank)

bins=foreach(mapcar x ib
ibb='()
for(i 0 nbRank-1 ibb=append(ibb list(x>>i&1)))
ibb)

length(bins);=> 56
length(x45);=>1024

invs='()
foreach( x x45
tmp=foreach(mapcar b bins
mapcar('list x append(list(1) append(b list(1))))
)
invs=append(invs tmp)) t


length(invs);=>57344

fp = outfile("~/xor45.txt")
foreach(in invs
dlys=line2freq(in)
fr=1.0/apply('plus dlys)/1p
frs=aelSuffixNotation(fr);=>272.9M __ Mega Hertz
fprintf(fp "%g\t%s\t%L\t:IN=%L\n" fr frs dlys in)
)
close(fp)

;; a='((4 1)(4 0)(4 0)(4 0)(4 0)(4 0)(4 1)(4 1)(4 1)(4 1))
;; line2freq(a 0.1 t)


;; COMMENT : il vaut mieux grouper par famille 'choisi' (cad figee en dur)

x45_01=foreach(mapcar x x45
foreach(mapcar b bins
mapcar('list x append(list(1) append(b list(1))))
)) t

fixor=nth(27 x45_01)
length(nth(27 x45_01))

fx=car(fixor)
n10=foreach(mapcan f fx cdr(f))

fixordly=foreach(mapcar fx fixor list(
line2freq(fx)
foreach(mapcan f fx cdr(f))
))

;=> loop ?
