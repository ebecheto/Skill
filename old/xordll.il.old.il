

; data generated from simulation@27°C see "osc.il"
dlybRC='("18.76" "9.22" "5.026" "3.225" "2.523" "1.615" "1.234")
dlybR0='("83.15" "92.31" "153.7" "167.1" "179.5" "203.2" "219.8")
dlybFC='("4.392" "2.359" "2.236" "1.514" "1.159" "814.3m" "652.9m")
dlybF0='("79.52" "107.6" "141.6" "144.5" "147.6" "153.7" "159.9")
dlyiRC='("18.74" "9.228" "5.025" "3.225" "2.523" "1.615" "1.231")
dlyiR0='("39.34" "43.09" "107.8" "121.3" "134.2" "158.6" "175.7")
dlyiFC='("6.061" "3.085" "2.242" "1.521" "1.166" "822.8m" "662.1m")
dlyiF0='("15.02" "19.94" "76.31" "79.99" "83.89" "91.92" "99.47")


; falues from datasheet. Could be extracted or taken from simulation
XORcap='(3.6f 4.6f 3.6f 3.8f 3.8f 3.8f 3.8f)

;nth     0   1   2   3   4   5   6
elist='("L" "1" "2" "3" "4" "6" "8") 
xl=foreach(mapcar x elist strcat("XOR2X" x))
xl=foreach(mapcar x elist concat("OUT_" x))
xl=foreach(mapcar x elist concat("INA_" x))


cross(v("/fast" ?resultsDir rdir ?result "tran") 1 -2 "rising" nil nil)
cross(VT("OUT") 0.9 1 "rising"  t "time"  )

unless(fboundp('ocnPrint2) load("ocnPrint2list.il" ))

xl=foreach(mapcar x elist 
name=strcat("OUT_" x)
set(concat( 'data_ x)
ocnPrint2(cross(VT(name) 0.9 1 "rising"  t nil ))
))


foreach( x elist set(concat('dat_ x) foreach(mapcar elem eval(concat('data_ x))  car(elem))))




;; combi='((XOR2XL "INA_L" "INB_L")(XOR2X1 "INA_1" "INB_1")(XOR2X2 "INA_2" "INB_2")
;; ; (XOR2X3 "INA_3" "INB_3" "OUT_3") (XOR2X4 "INA_4" "INB_4" "OUT_4") (XOR2X6 "INA_6" "INB_6" "OUT_6") (XOR2X8 "INA_8" "INB_8" "OUT_8"))
;; combi='((XOR2XL "INA_L" "INB_L")(XOR2X1 "INA_1" "INB_1")(XOR2X2 "INA_2" "INB_2")(XOR2X3 "INA_3" "INB_3") (XOR2X4 "INA_4" "INB_4") (XOR2X6 "INA_6" "INB_6" ) (XOR2X8 "INA_8" "INB_8"))
;; combiToSch(combi "xorList" "ATEST_h18")


invp=VAR("sel")==1.8
edgeis='("rising" "falling") ;input edge list
edgeos=if(invp reverse(edge) edge)

rorf=1
edgei=nth(rorf edgeis)
edgeo=nth(rorf edgeos)


xlo=foreach(mapcar x elist 
name=strcat("OUT_" x)
set(concat( 'data_ x)
ocnPrint2(cross(VT(name) 0.9 1 edgeo  t nil ) 0)
))

donnee='input_
xli=foreach(mapcar x elist 
name=strcat("INA_" x)
set(concat( donnee x)
ocnPrint2(cross(VT(name) 0.9 1 edgei  t nil ) 0)
))

unless(length(xli)==length(xlo) printf("check out edges input output:%L\n" length(xli):length(xlo)))

xlio=mapcar('list xli xlo)

i=-1 diff_io=foreach(mapcar x elist i++
xi=nth(i xli) xo=nth(i xlo)
xio=mapcar('list xo xi)
foreach(mapcar cross xio car(cross)-cadr(cross))
)

dropFirst=t
when(dropFirst 
diff_ios=foreach(mapcar d diff_io cdr(d))

;df=car(diff_io)
i=-1 foreach(mapcar df diff_ios i++
sum=apply('plus df)/length(df)
sigma=sqrt(apply('plus foreach(mapcar x df (sum-x)**2)))
;printf("XOR2X%s delay=%L +/-%L;%s in %s out\n" nth(i elist) sum sigma edgei edgeo)
printf("XOR2X%s delay=%s +/-%s;%s in %s out\n" nth(i elist) aelSuffixNotation(sum) aelSuffixNotation(sigma) edgei edgeo)
)

