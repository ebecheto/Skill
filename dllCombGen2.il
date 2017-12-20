ineed('(itos netMakeBus)) 

defun(dllCombGen2 (@optional (fami '(("A" "0") ("B" "0") ("C" "1") ("D" "1") ("E" "1") ("F" "1") ("H" "1") ("I" "1") ("J" "1") ("K" "1") ("L" "1"))) (lib "Ed_CMOS8"))
let((i e sel net cname xline xline2 xline1 I0p pulse  DC0 DCr DC DL  ajout pat mdl L)
L=length(fami)
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
list(xline2sch(xline1 lib '((0 0)) cname 0.4 0 nil nil "w")
cname)))

; dllCombGen2()

defun(dllCombGen (@optional (fami '(("A" "0") ("B" "0") ("C" "1") ("D" "1") ("E" "1") ("F" "1") ("H" "1") ("I" "1") ("J" "1") ("K" "1") ("L" "1"))))
let((i e sel net cname xline xline2 xline1 pat mdl L)
L=length(fami)
pat="XOR2_" 
mdl='("GND" "SX" "NW" "VDD")
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


;; fonction='dllCombGen2
;; fami=car(fam)
;; fami='(("A" "0") ("B" "0") ("C" "1") ("D" "1") ("E" "1") ("F" "1") ("H" "1") ("I" "1") ("J" "1") ("K" "1") ("L" "1"))
;; apply(fonction fami)
;; apply(fonction list(fami));=> oki !


defun(dllGenMotif (@optional (motif '("A" "B" "C" "D" "D" "D")) (xorp 'ibm)(mdl 'ibm)(bus "_"))
;when(charge=='ibm||nil charge='("BUFFER_C" "DFF_E"))
let((bud nandp)
when(mdl=='ibm mdl='("gnd!" "sx!" "nw!" "vdd!"))
when(xorp=='ibm||nil xorp="XOR2_")               ;=> A Z B
when(xorp=='ibm||nil||"XOR2_" nandp="NAND2_")    ;=> Z B A
bud=if(bus=="<" ">" "")
L=length(motif)
i=-1 foreach(mapcar mot motif i++
if(i==0  
list(strcat(nandp mot)
append(mdl list(strcat("Q" bus a2s(mod(i+1 L)) bud) strcat("S" bus a2s(mod(i L)) bud) strcat("Q" bus a2s(mod(i L)) bud)))
);; end first nand list
list(strcat(xorp mot) 
append(mdl list(strcat("Q" bus a2s(mod(i L)) bud) strcat("Q" bus a2s(mod(i+1 L)) bud) strcat("S" bus a2s(mod(i L)) bud)))
);;end others xors list if
))
))

;; xors=dllGenMotif()
;; pins=foreach(mapcar x xors nth(4 cadr(x)))
;; pinq=foreach(mapcar x xors nth(6 cadr(x)))
;; pin2=list(pins pinq)
;; array2sch(list(xors) 'ibm "AmotifTest" pins 0 0 t t "w");=> superpose
;; array2sch(list(xors) 'ibm "AmotifTest" pins 0.4 0.4 t t "w");=> superpose
;; cv=array2sch(list(xors) 'ibm "AmotifTest" pin2 0.4 0.4 t t "w");=> superpose
;; ineed('schematic2symbol)
;; schematic2symbol(cv t);=> oki


defun(dllGenMotifBuDff (@optional (L 8)(charge nil)(mdl nil)(modp1 0))
let((from to)
if(listp(L) then to=cadr(L) from=car(L) L=to else from=0 to=L)
unless(mdl mdl='("gnd!" "sx!" "nw!" "vdd!"))
unless(charge charge='(("BUFFER_C" (t "Q_")) ("DFF_E" (t t "Q_" "Q_"))))
foreach(mapcar i linRg(from to 1) 
foreach(mapcar ch charge
list(car(ch)
append(mdl 
foreach(mapcar p cadr(ch)
if(p=='t then t else 
sprintf(nil "%s%d" p mod(i L+modp1))
))))))))

; dllGenMotifBuDff(2 '(("NAND2_A") ("XOR2_A")));=> ((("NAND2_A" ("GND" "SX" "NW" "VDD")) ("XOR2_A" ("GND" "SX" "NW" "VDD"))) (("NAND2_A" ("GND" "SX" "NW" "VDD")) ("XOR2_A" ("GND" "SX" "NW" "VDD"))));<= useless

; dllGenMotifBuDff(2);=>((("BUFFER_C" ("GND" "SX" "NW" "VDD" t "Q_0")) ("DFF_E" ("GND" "SX" "NW" "VDD" t t "Q_0" "Q_0"))) (("BUFFER_C" ("GND" "SX" "NW" "VDD" t "Q_1")) ("DFF_E" ("GND" "SX" "NW" "VDD" t t "Q_1" "Q_1"))))

; dllGenMotifBuDff(2 '(("NAND2_A" (t "Q")) ("XOR2_A" ("Z" "I"))));=> ((("NAND2_A" ("GND" "SX" "NW" "VDD" t "Q0")) ("XOR2_A" ("GND" "SX" "NW" "VDD" "Z0" "I0"))) (("NAND2_A" ("GND" "SX" "NW" "VDD" t "Q1")) ("XOR2_A" ("GND" "SX" "NW" "VDD" "Z1" "I1"))))



defun(dllGenMotifHA (@optional (L 8)(charge 'test)(mdl 'ibmg))
let((i ni)
when(mdl=='ibm mdl='("GND" "SX" "NW" "VDD"))
when(mdl=='ibmg mdl='("gnd!" "sx!" "nw!" "vdd!"))
when(charge=='test charge='(("BUFFER_C" (t "Q_")) ("DFF_E" (t t "Q_" "Q_"))))
i=-1 foreach(mapcar mot linRg(0 L-1 1) i++
foreach(mapcar ch charge
list(car(ch)
append(mdl 
foreach(mapcar ph cadr(ch) ;inc=t
if(ph=='t then t else 
p=if(listp(ph) car(ph) ph)
inc=if(listp(ph) cadr(ph) t)
ni=cond(
(listp(ph)&&not(cadr(ph)) "") ;=> si un seul arg ou deuxieme arg = nil => pas d'incrementation
(car(last(parseString(p "")))=="!" ""); idem pour les vdd! etc. pour eviter ("vdd!" nil)("gnd!" nil) ...
(listp(ph)&&(nth(2 ph)=='t) itos(i+cadr(ph)));=> si un 3eme argument 't => pas de modulo
(t itos(mod(L+i+if(listp(ph) cadr(ph) 0) L)) ) ;=> default mode : increment plus modulo
;(listp(ph)&&cadr(ph) itos(mod(L+i+cadr(ph) L)) )
)
printf("")
bus=if(car(last(parseString(p "")))=="<" ">" "")
;printf("i %d ni %d p %s ph %L mods :%L : mod(%d %d)\n" i ni p ph list(L mod(L+ni L)  mod(ni+L L) mod(ni+L+1 L)) ni+L L);=> logique qd n=1 => mords sa queue 
strcat(p ni bus)
; sprintf(nil "%s%d%s" p mod(L+ni L) bus||"")
))))))))

;; dllGenMotifHA(2 '(("BUFFER_C" (t ("Q_" -1))) ("DFF_E" (t t "Q_" ("Q_" 1)))))
;; ;=> ((("BUFFER_C" ("GND" "SX" "NW" "VDD" t "Q_-1")) ("DFF_E" ("GND" "SX" "NW" "VDD" t t "Q_0" "Q_1"))) (("BUFFER_C" ("GND" "SX" "NW" "VDD" t "Q_0")) ("DFF_E" ("GND" "SX" "NW" "VDD" t t "Q_1" "Q_0"))))
;; dllGenMotifHA(1 '(("BUFFER_C" (t ("Q_" -1))) ("DFF_E" (t t "Q_" ("Q_" 1))))) ;=> logique qd n=1 => mords sa queue 
;; dllGenMotifHA(3 '(("BUFFER_C" (t ("Q_" -1))) ("DFF_E" (t t "Q_" ("Q_" 1)))))
;; ;=> ((("BUFFER_C" ("GND" "SX" "NW" "VDD" t "Q_0")) ("DFF_E" ("GND" "SX" "NW" "VDD" t t "Q_1" "Q_2"))) (("BUFFER_C" ("GND" "SX" "NW" "VDD" t "Q_1")) ("DFF_E" ("GND" "SX" "NW" "VDD" t t "Q_2" "Q_0"))) (("BUFFER_C" ("GND" "SX" "NW" "VDD" t "Q_2")) ("DFF_E" ("GND" "SX" "NW" "VDD" t t "Q_0" "Q_1"))))


;; car(last(parseString("S<" "")))=="<"

;; nb=3 strcat("A<" if(nb sprintf(nil "%d" nb) "") ">") ;=> "A<3>"


;; halfAdderList='(
;; ("AND2_C" ("C_" ("C_" -1) "S<" ))
;; ("XOR2_C" (("C_" -1) "Sum_" "S<"))
;; ("DFF_E" (t t "Q_" ("Q_" 1)))
;; )


;; mdl='("gnd!" "sx!" "nw!" "vdd!")
;; mde='("sx!" "gnd!" "nw!" "vdd!")

;; halfAdderList='(
;; ("AND2_C" ("C_" ("C_" -1) "S<" ))
;; ("XOR2_C" (("C_" -1) "Sum_" "S<"))
;; ("DFF_E"  ("Q_" "Sb<" "Sum_" ("clk" nil) ))
;; )

;; HAL=foreach(mapcar h halfAdderList cond(
;; (rexMatchp("DFF" car(h)) append(list(car(h)) list(append(mde cadr(h)))))
;; (t  append(list(car(h)) list(append(mdl cadr(h)))))
;; ))

; HAL ;=> (("AND2_C" ("gnd!" "sx!" "nw!" "vdd!" "C_" ("C_" -1) "S<")) ("XOR2_C" ("gnd!" "sx!" "nw!" "vdd!" ("C_" -1) "Sum_" "S<")) ("DFF_E" ("sx!" "gnd!" "nw!" "vdd!" "Q" "Sb<" ("clk" nil) "Q_" ("Q_" 1))))

;pt1 font chier, ils ont changez l'ordre de gnd sx nw vdd pour la dff seulement... => '() au lieu de 'ibmg et append dans la construction de la liste
;; mapcar('car halfAdderList);=>("AND2_C" "BUFFER_C" "DFF_E")

;; ;; STUDY THE CELLS YOU WANT TO LIST
;; yos=addCell( mapcar('car halfAdderList))
;; foreach(mapcar inst yos mapcar('car getInstTermPoint(inst)))
;; ;=>(("GND" "SX" "NW" "VDD" "Z" "A" "B") ("GND" "SX" "NW" "VDD" "A" "Z" "B") ("GND" "SX" "NW" "VDD" "Z" "A") ("SX" "GND" "NW" "VDD" "Q" "QBAR" "D" "CLK"))
;; ;=>(("GND" "SX" "NW" "VDD" "Z" "A" "B") ("GND" "SX" "NW" "VDD" "Z" "A") ("SX" "GND" "NW" "VDD" "Q" "QBAR" "D" "CLK"))

;; dllGenMotifHA(8 halfAdderList 'ibmg)
; dllGenMotifHA(8 HAL '())



defun(dllGenCounter (@optional (L 8))
let((halfAdderList mdl mde HAL cells cellName pins cv schs V0 Vnw Vsx V1 V2 V3 V4 pulse bBox xy)
halfAdderList='(
("AND2_C" (("C_" 1 t) "C_" "S<" ))
("XOR2_C" ("C_"  "Sum_"  "S<"))
("DFF_E"  ("Q_" "Sb<" "Sum_" ("clk" nil) ))
("AND2_C" ("S<" ("C_0" nil)  "Q_" ))
)
mdl='("gnd!" "sx!" "nw!" "vdd!")
mde='("sx!" "gnd!" "nw!" "vdd!")
HAL=foreach(mapcar h halfAdderList cond(
(rexMatchp("DFF" car(h)) append(list(car(h)) list(append(mde cadr(h)))))
(t  append(list(car(h)) list(append(mdl cadr(h)))))
))
; L=8
cells=dllGenMotifHA(L HAL '())
cellName=sprintf(nil "COUNT_%d-bit" L)
pins=cons('("C_0" "clk") list(list((sprintf nil "S<0:%d>" L-1) (sprintf nil "Sb<0:%d>" L-1) (sprintf nil "C_%d" L))))
cv=array2sch(cells 'ibm cellName reverse(pins))
schs=schematic2symbol(cv t t) ;=> ("COUNT_8-bit" "COUNT_8-bit_sim")
V0='("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.2)))  ;=> getPropList()
Vnw='("vdc" ("gnd!" "nw!")(("vdc" "float" 1.2)))
Vsx='("vdc" ("gnd!" "nx!")(("vdc" "float" 0.0)))
V1='("vpwl" ("gnd!" "vstart") (("v2" "string" "1.8") ("v6" "string" "1.8") ("t6" "string" "21.1n") ("t5" "string" "21n") ("t4" "string" "20.1n") ("v3" "string" "1.8") ("t3" "string" "20n") ("t2" "string" "1.1n") ("t1" "string" "1n")))
V2='("vpulse" ("gnd!" "vclk") (("v2" "string" "1.8") ("tf" "string" "100.0f") ("tr" "string" "100.0f") ("per" "string" "1n")))
V3='("BUFFER_C" ("gnd!" "sx!" "nw!" "vdd!" "clk" "vclk"))
V4='("BUFFER_C" ("gnd!" "sx!" "nw!" "vdd!" "C_0" "vstart"))
pulse=list(list(V0 V1 V2 V3 V4))
bBox=caddr(schs)~>bBox ;=> ((-0.9 -0.65) (1.3 -0.24375))
xy=mapcar('plus car(bBox) '(0 -1))
array2sch(pulse cv~>libName cadr(schs) nil 0.4 0.4 t nil "a" xy)
))


defun(dllMotifSch (@optional (motif '("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L"))(libName 'ibm)(cellName nil)(sim t)(flat t))
let((xors pins cellName cv schs L) L=length(motif)
xors=dllGenMotif(motif "XOR2_" '("gnd!" "sx!" "nw!" "vdd!") "<") ;=> (("XOR2_E" ("gnd!" "sx!" "nw!" "vdd!" "Q<0>" "Q<1>" "S<0>")) ...)
pins=list(netMakeBus("S" L flat) netMakeBus("Q" L flat))
unless(cellName cellName=strcat("dll_" apply('strcat motif)));=> "dll_ABCDEFHIJKL"
; cv=array2sch(list(xors) 'ibm cellName pin2 0.4 0.4 t t "w");=>  ttw => openVerboseWrite
cv=array2sch(list(xors) libName cellName reverse(pins) 0.4 0.4 nil t "w");=> superpose
schs=schematic2symbol(cv sim t)
list(cv schs)
))





; _____________charge or general purpuse example________________________________

;; aList='(
;; ("BUFFER_C" (("Z<" 0) ("Q<" 0) ))
;; ("DFF_E"  (t t ("Q<" 0) ("Q<" 0) ))
;; )
;; HALi=aList
;; aList;=> (("BUFFER_C" (("Z<" 0) ("Q<" 0))) ("DFF_E" (t t ("Q<" 0) ("Q<" 0))))


;; prevoir de creer la pins list avant d'appeler la fonction
defun(generateHAList (@optional (L 10) (HALi '(("BUFFER_C" (("Z<" 0) ("Q<" 0))) ("DFF_E" (t t ("Q<" 0) ("Q<" 0)))))(pins '(("Q<0:9>")("Z<0:9>")))(libName nil)(cellName nil)(trans t)(sim nil)(over t)(open t))
let((mdl mde HAL cells cv schs)
;; ;; STUDY THE CELLS YOU WANT TO LIST : getInstTermPoint(css())
;; yos=addCell( mapcar('car halfAdderList))
;; yo=foreach(mapcar inst yos cons(strcat(inst~>cellName ":") mapcar('car getInstTermPoint(inst))))
;; ;foreach(y yo printf("%L\n" y))
;; ;; ("AND2_C:" "GND" "SX"  "NW" "VDD" "Z" "A" "B")
;; ;; ("XOR2_C:" "GND" "SX"  "NW" "VDD" "A" "Z" "B")
;; ;; ("DFF_E:"  "SX"  "GND" "NW" "VDD" "Q" "QBAR" "D" "CLK")
;; ;; ("AND2_C:" "GND" "SX"  "NW" "VDD" "Z" "A" "B")
;; to update when i see other 'mixings'
mdl='("gnd!" "sx!" "nw!" "vdd!")
mde='("sx!" "gnd!" "nw!" "vdd!")
HAL=foreach(mapcar h HALi 
cond(
(rexMatchp("DFF" car(h)) append(list(car(h)) list(append(mde cadr(h)))))
(t  append(list(car(h)) list(append(mdl cadr(h)))))
))
; L=8
cells=dllGenMotifHA(L HAL '())
when(trans cells=transpose(cells))
unless(cellName cellName=sprintf(nil "HAL_%d-bit" L))
unless(libName libName='ibm)
when(whereExistCell3(cellName) printf("WARNING : WANNA ERASE :%s? => put over=t:!%L\n" cellName over) )
when(not(whereExistCell3(cellName))||over==t
cv=array2sch(cells libName cellName reverse(pins))
printf("cv sim open: %L\n" list(cv sim open))
schs=schematic2symbol(cv sim open)
list(cv schs)
)))

;; generateHAList(10 '(("BUFFER_C" (("Z<" 0) ("Q<" 0))) ("DFF_E" (t t ("Q<" 0) ("Q<" 0)))) '(("Q<0:9>")("Z<0:9>")) nil "dll__laod_10" t t nil)

;; aList='(("BUFFER_C" (("Z<" 0) ("Q<" 0))) ("DFF_E" (t t ("Q<" 0) ("Q<" 0))))
;; pins=list(list(strcat("Q<0:" a2s(L-1) ">")) list(strcat("Z<0:" a2s(L-1) ">")))
;; foreach(mapcar L linRg(8 11 1) generateHAList(L aList pins nil strcat("dllch_BD_" a2s(L)) t nil nil))


;; aList='(("BUFFER_C" (("Z<" 0) ("Q<" 0))) ("DFF_E" (t t ("Q<" 0) ("Q<" 0))))
;; foreach(mapcar L linRg(8 11 1) 
;; pins=list(netMakeBus("Q" L) netMakeBus("Z" L))
;; generateHAList(L aList pins nil strcat("dllch_BD_" a2s(L)) t nil 't))


;; aList='(("BUFFER_C" (("Z<" 0) ("Q<" 0))) )
;; foreach(mapcar L linRg(8 11 1) 
;; pins=list(netMakeBus("Q" L) netMakeBus("Z" L))
;; generateHAList(L aList pins nil strcat("dllch_B_" a2s(L)) t nil 't))

