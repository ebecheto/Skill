; load("/home/validmgr/ebecheto/Skill/XOR_carac.proc.il")
unless(fboundp('addCell) load("addCell.il"))
;unless(fboundp('angleSection) load("padRing.proc.il"))
ineed('dllCombGen2 t)
ineed('(cnpbin getPropList list2wave))


defun(interceptime (@optional (io '("B" "Q")) (itit '("_L" "_1" "_2" "_3" "_4" "_6" "_8")) (ioedge '("rising" "falling")) (verb t) (der -1) (plotit t))
let((ioi ioo iedge oedge rorfs oname iname pente)
when(verb printf("io:%L, pattern=%L, edges=%L\n" io itit ioedge))
ioi=car(io)
ioo=cadr(io)
iedge=car(ioedge)
oedge=cadr(ioedge)
rorfs=strcat(car(parseString(iedge "")) car(parseString(oedge "")))
foreach(mapcar e itit
oname=strcat(ioo e);=> Qi_1 ...
iname=strcat(ioi e);=> Bi_1
when(verb printf("cross(VT(%L) 0.9 -1 %L)-cross(VT(%L) 0.9 -1 %L)\n" oname oedge iname iedge))
set(concat('curv_ e) cross(VT(oname) 0.9 der oedge)-cross(VT(iname) 0.9 der iedge))
when(plotit plot(concat('curv_ e) ?expr list(strcat(oname "-" iname rorfs))))
pente=average(deriv(eval(concat('curv_ e))))
when(plotit plot(pente ?expr list(strcat("deriv_" e rorfs))))
;revoie list(intercept [ns] pente [s/F]); pour une simu parametrique sur CLoad.
list(value(eval(concat('curv_ e)) 0) pente)
)))
;interceptime()




defun(interceptx (@optional (io '("B" "Q")) (pattern '("L" "1" "2" "3" "4" "6" "8")) (ioedge '("rising" "falling")) (verb t)  (plotit t)(plotd nil) (der -1))
let((ioi ioo iedge oedge rorfs oname iname pente)
when(verb printf("io:%L, pattern=%L, edges=%L\n" io pattern ioedge))
ioi=car(io)
ioo=cadr(io)
iedge=car(ioedge)
oedge=cadr(ioedge)
rorfs=strcat(car(parseString(iedge "")) car(parseString(oedge "")))
foreach(mapcar e pattern
oname=strcat(ioo e);=> Qi_1 ...
iname=strcat(ioi e);=> Bi_1
curb=concat('curv_ rorfs '_ e)
;when(verb printf("cross(VT(%L) 0.9 -1 %L)-cross(VT(%L) 0.9 -1 %L)\n" oname oedge iname iedge))
set(curb cross(VT(oname) 0.9 der oedge)-cross(VT(iname) 0.9 der iedge))
when(plotit plot(eval(curb) ?expr list(strcat(oname "-" iname rorfs))))
pente=average(deriv(eval(curb)))
when(plotd plot(eval(pente) ?expr list(strcat("deriv_" e rorfs))))
;revoie list(intercept [ns] pente [s/F]); pour une simu parametrique sur CLoad.
when(verb printf("X0=%s\t+ %s*Cload\n" aelSuffixNotation(value(eval(curb) 0))  aelSuffixNotation(pente)))
;list(value(eval(concat('curv_ e)) 0) pente)
curb
)))

;interceptx()


;; (setq io '("Q_0" "Q_1"))
;; (setq ioedge '("rising" "falling"))

;; cross(v("/Q_5" ?result "tran-tran") 0.6 1 "rising"  t "time"  );<= multiple
;; cross(v("/Q_5" ?result "tran-tran") 0.6 1 "rising"  nil nil  );<= single first edge
;; cross(v("/Q_5" ?result "tran-tran") 0.6 -1 "rising"  nil nil  );<= single last edge


defun(intercept2 (@optional (io '("Q_0" "Q_1")) (ioedge '("rising" "falling")) (verb t)  (plotit t)(plotd nil) (der -1))
let((ioi ioo iedge oedge rorfs oname iname pente)
iname=car(io)
oname=cadr(io)
iedge=car(ioedge)
oedge=cadr(ioedge)
rorfs=strcat(car(parseString(iedge "")) car(parseString(oedge "")))
curb=concat('curv_  iname '_ rorfs)
;printf("cross(VT(%L) 0.9 -1 %L)-cross(VT(%L) 0.9 -1 %L)\n" oname oedge iname iedge)
set(curb cross(VT(oname) 0.9 der oedge)-cross(VT(iname) 0.9 der iedge))
when(plotit plot(eval(curb) ?expr list(strcat(oname "-" iname rorfs))))
;; pente=average(deriv(eval(curb)))
; when(plotd plot(eval(pente) ?expr list(strcat("deriv_" e rorfs))))
;revoie list(intercept [ns] pente [s/F]); pour une simu parametrique sur CLoad.
; when(verb printf("X0=%s\t+ %s*Cload\n" aelSuffixNotation(value(eval(curb) 0))  aelSuffixNotation(pente)))
when(verb ocnPrint(eval(curb)))
curb
))

;int2=intercept2()


defun(intercept1 (@optional (io '("Q_0" "Q_1"))(verb t)(plotit t)(der -1))
let((oname iname rise fall wave curb)
iname=car(io)     oname=cadr(io)
rise="rising"
fall="falling"
curb=concat('d2_ oname)
;when(verb printf("cross(VT(%L) 0.9 -1 %L)-cross(VT(%L) 0.9 -1 %L)\n" oname oedge iname iedge))
setq(wave cross(VT(oname) 0.9 der rise)+cross(VT(oname) 0.9 der fall)-(cross(VT(iname) 0.9 der rise)+cross(VT(iname) 0.9 der fall)))
set(curb wave)
when(plotit plot(eval(curb) ?expr list(curb)))
when(verb ocnPrint(eval(curb)))
curb
))



defun( nthcadr (na nc alist) nthcdr(nc reverse(nthcdr(na reverse(alist)))))

defun(curb2val (@optional (difs difs) (val 10f))
printf("_delays for Cload=%s_\t_%s_" aelSuffixNotation(val) car(parseString(caar(difs) "_")))
printf("\n\t|%L" car(difs))
foreach(mapcar cl difs printf("\n%L|\t" car(cl))
foreach(mapcar c cl v=value(eval(c) val)   printf("%s\t" aelSuffixNotation(v)) v) ))

defun(plotCurbs (@optional (curbs curbs))
foreach(cl curbs
foreach(c cl when(c plot(eval(c) ?expr list(c))) )))

defun(curb2toDif (@optional (invbufL invbufL)) let((w wn)
foreach(mapcar i invbufL w=eval(car(i))-eval(cadr(i))
wn=concat('tdiff_ car(last(parseString(car(i) "_"))))
set(wn w) list(wn)
)))

defun(curb2toVal (@optional (invbufL invbufL) (val 0)) let((wi wb wni wnb)
foreach(mapcar i invbufL 
wi=value(eval(car(i)) val)
wb=value(eval(cadr(i)) val)
wni=concat('di_ car(last(parseString(car(i) "_"))))
wnb=concat('db_ car(last(parseString(cadr(i) "_"))))
set(wni wi) set(wnb wb) list(wni wnb)
)))

defun(val2save (@optional (dbi dbi) (file "dbi.txt"))
fn=strcat(pwd() "/" file) fp=outfile(fn)
foreach(ds dbi 
foreach(d ds
fprintf(fp "%s=%g \t" d eval(d)))
fprintf(fp "\n")
) close(fp) apply('edit list(fn))
)
;val2save(curb2toVal(invbuf() 0))

;ocnPrint2(invbufL)

defun(val2saved (@optional (dbi dbi) (file "dbi.txt"))
fn=strcat(pwd() "/" file); fp=outfile(fn)
load(fn));=>set di_x and db_x
;val2saved()

defun(didb2dbi (@optional (elist '("L" "1" "2" "3" "4" "6" "8")))
(set 'dbi foreach(mapcar e elist list(concat('di_ e) concat('db_ e)))))
;didb2dbi();=>dbi=((di_ db_)...)

defun(curb2minusX (@optional (invbufL invbufL)(skip t)) let((w wn invbufT)
invbufT=apply('mapcar 'list invbufL)
foreach(mapcar row car(invbufT)
foreach(mapcar col cadr(invbufT)
w=eval(row)-eval(col)
wn=concat('Td_ car(last(parseString(row "_"))) car(last(parseString(col "_"))))
set(wn w) if(skip&&row==col nil wn)
))))


defun(curb2minusX1 (@optional (difs difs)) let((w wn id idr)
id=car(apply('mapcar 'list difs))
idr=id
remove(nil foreach(mapcar row id
idr=cdr(idr)
foreach(mapcar col idr
w=eval(row)-eval(col)
wn=concat('Td_ car(last(parseString(row "_"))) car(last(parseString(col "_"))))
set(wn w) wn
)))))

;=> renvoie la difference d'un liste par elle meme => N(N-1)/2 elements
defun(list2minus (@optional (difs difs)) let((w wn id idr)
idr=difs
remove(nil foreach(mapcan row difs idr=cdr(idr)
foreach(mapcar col idr
eval(row)-eval(col)
)))))

defun(listNN12 (@optional (difs difs)) let((w wn id idr)
idr=difs
remove(nil foreach(mapcan row difs idr=cdr(idr)
foreach(mapcan col idr
list(row col)
)))))
;=> list de N(N-1) elements, car on les associe par pair => script shell tableau 1D seulement :pair impaire=2D

;; listNN12('(3 6 8))
;; (3 6 3 8 6 8)

defun(list2minus2 (@optional (difs difs)) let((w wn id idr)
idr=difs
remove(nil 
foreach(mapcan row difs idr=cdr(idr)
foreach(mapcar col idr
list(eval(car(row))-eval(car(col)) strcat(itos(cadr(row)) "-" itos(cadr(col))))
)))))


defun(invbuf (@optional (invs '("Bi_" "Qi_"))(bufs '("B" "Q"))(pattern '("L" "1" "2" "3" "4" "6" "8"))(verb t))
rise="rising"
fall="falling"
AST=list(list(invs list(rise fall)) list(invs list(fall rise)) list(bufs list(fall fall)) list(bufs list(rise rise)))
curbs=foreach(mapcar leaf AST interceptx(car(leaf) elist cadr(leaf) t nil))
curbt=apply('mapcar 'list curbs);=> transpose
waves=foreach(mapcar c curbt ;c=car(curbt)
Tdifrrf=eval(nth(0 c))+eval(nth(1 c))
Tdbffrr=eval(nth(2 c))+eval(nth(3 c))
tdiName=concat('tdi_ car(last(parseString(car(c) "_"))))
tdbName=concat('tdb_ car(last(parseString(car(c) "_"))))
(set tdiName Tdifrrf)
(set tdbName Tdbffrr)
list(tdiName tdbName);returned values
))

;; (setq xPin '("Q" "A" "Q"))
;; (setq xrPin '("B" "A" "Q"))
;; (setq cCells '("INVX2" "DFFX1"))
;; (setq xors '((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)))

;; defun(dbi2freq (@optional (xors '((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)))(pattern '("L" "1" "2" "3" "4" "6" "8"))(CLall 0.5) (xCell "XOR2X")(cCells '("INVX2" "DFFX1"))(xPin '("Q" "A" "Q"))(xrPin '("B" "A" "Q")) (cPin '(("A" "Q")("D" "Q")("CP" "Q")))(gensch t) (verb nil))
;; let((nb patt libname cellname i dlySum xnames inets snets inetx nets yup inst cnames)
;; nb=length(xors)
;; patt=apply('strcat foreach(mapcar x xors concat(car(x) )))
;; libname="ATEST_h18"
;; cellname=sprintf(nil "tdc_xor_%s_sim" patt)
;; printf("libname %L cellname %L\n" libname cellname)
;; when(gensch cvSch=dbOpenCellViewByType( libname cellname "schematic" "schematic" "a"))
;; i=0 dlySum=0
;; xnames=nil
;; foreach(mapcar xor xors i++
;; dlySum=dlySum+eval(nth(cadr(xor) nth(car(xor) dbi)))
;; xnames=append(xnames list(strcat(xCell nth(car(xor) pattern))))
;; ;iname=strcat(iCell nth(car(xor) pattern))
;; when(gensch 
;; inets=list(mod(i+1 nb) i i)
;; snets=foreach(mapcar in inets sprintf(nil "%d" in))
;; inetx=apply('mapcar 'strcat list(xPin snets))
;; nets=apply('mapcar 'list list(xrPin inetx))
;; yup=when(box=car(inst~>bBox) printf("box%L\n" box) yup=cadadr(box)-cadar(box) yup=round(yup/grid)*grid)
;; inst=addCells(xnames cvSch nets 0:yup)
;; ))
;; foreach(mapcar cl cCells ;cl=car(cCells)
;; cnames=foreach(mapcar xor xors cl)
;; addCells(cnames cvSch cPin))
;; printf("dlySum=%s\t freq=%s\n" aelSuffixNotation(dlySum) aelSuffixNotation(1.0/dlySum))
;; ; 1.0/dlySum;=>2.984575e+08
;; dbSave(cvSch) dbClose(cvSch) 
;; ))
;; geOpen(?lib "ATEST_h18" ?cell "tdc_xor_5554455555_sim" ?view "schematic")
;; ;dbi2freq() ;<= buggy... => separate calcul and schematic

(setq xname "XOR2X")
(setq patrn '("L" "1" "2" "3" "4" "6" "8"))

defun(dbi2freq (@optional (xors '((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)))(patrn '("L" "1" "2" "3" "4" "6" "8"))(CLall 0.5)(xnames '("XOR2X" (-1 ib 0)))(xload '(("INVX1" (0 t)) ("DFX1" (0 t t 0))))(OUT "Q")(SEL nil)(SET '("gnd!" "vdd!"))(verb t))
let((nb i dlySum res xname iorb nam xline) xname=car(xnames)
nb=length(xors) 
i=0 dlySum=0
res=foreach(mapcar xor xors i++ dlySum=dlySum+eval(nth(cadr(xor) nth(car(xor) dbi))))
printf("dlySum=%s\t freq=%s\n" aelSuffixNotation(dlySum) aelSuffixNotation(1.0/dlySum))
i=0
xline=foreach(mapcar xor xors i++ 
;((XOR...)(INV..)(DFF))
append( list(list(strcat(xname nth(car(xor) patrn))
foreach(mapcar iorb cadr(xnames) cond(
(iorb=='ib  if(SEL then sprintf(nil "%s_%d" SEL i) else nth(cadr(xor) SET)))
(t sprintf(nil "%s_%d" OUT mod(i+iorb nb)))
))));listXOR
foreach(mapcar xl xload nam=car(xl) pat=cadr(xl) list(nam foreach(mapcar p pat if(p==t t sprintf(nil "%s_%d" OUT mod(i nb))))))
;listINV and DFF
);append
);foreach xors
list(xline aelSuffixNotation(dlySum))
))
;; res=dbi2freq()
;; car(res)
;; length(car(res));=>10
;; xline=dbi2freq('((5 1)(5 0)(5 0)(4 1)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)))
;; xline=dbi2freq('((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)));<= default

;rajoute une liste d'element a mettre sur le schema en plus. ici seulement vdc, mais peut etre vdc = vpulse
defun(appendBegin1 (AST @optional (more '(("vdc" ("gnd!" "vdd!") (("vdc" "float" 1.8))))))
append(list(append(list(more) car(AST))) cdr(AST))
)

defun(appendBegin2 (AST @optional (nb 1)(more "start")) 
let((k rest nets new news) 
k=0 
rest=cddr(caaar(AST))
nets=cadr(caaar(AST))
new=foreach(mapcar n nets if(k++==nb more n))
news=append(list(new) rest)
append(list(append(list(append(list(append(list(car(caaar(AST))) news)) cdaar(AST))) cdar(AST))) cdr(AST))
))

;appendBegin2(xline)
;appendBegin2(xline 1 "start")


;; (setq more '(("vdc" ("gnd!" "vdd!") (("vdc" "float" 1.8))) ("vpwl" ("gnd!" "netpwl")(("t1" "string" "1n") ("vdc" "string" "0") ("v2" "string" "1.8") ("t2" "string" "1.001n"))) ("BUFTX2" ("netpwl" "start" t)) ))

;xlinedc=appendBegin1(xline)
;; xline2=appendBegin2(xline 1 "start");=> switch first element nets from ("Q_0" "vdd!" "Q_1") to ("Q_0" "start" "Q_1")
;; xlinedc=appendBegin1(xline2 more);=> length(car(xlinedc)) 
;; length(car(xline))
;; length(car(xlinedc))

;; cvs=xline2sch(xlinedc)
;; cvs~>cellName


defun(xline2sch (@optional (xlinef '(((("vdc" ("gnd!" "vdd!")))) 1e-9))(libname "ATEST_h18")(xors '((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)))(cn nil)(dx 0.4)(dy 0)(verb t)(open t)(aw "w"))
(let (xline x y x0 patt cellname cv inst box yup xup xy grid) ;xors list used only for naming cellName 
x=0 y=0 xy=x:y x0=x
xline=car(xlinef) fr=cadr(xlinef) unless(fr fr=1n)
frn=aelSuffixNotation(fr) frHz=aelSuffixNotation(1.0/fr)
grid=0.0625;schGetEnv("symSnapSpacing")
;patt=apply('strcat foreach(mapcar x xors concat(car(x) )))
when(xors
patt=apply('strcat foreach(mapcar x xors concat(car(x) cadr(x))))
cellname=sprintf(nil "tdcx_%s__sim" patt))
when(libname==t libname="ATEST_h18")
when(cn cellname=cn)
noteLabel=sprintf(nil "Generated by %s @ %s\nPredicted delay sum=%s [sf]=%s [Hz]" "xline2sch" getCurrentTime() frn frHz )
cv=dbOpenCellViewByType( libname cellname "schematic" "schematic" aw)
schCreateNoteLabel( cv 0:-1 noteLabel  "lowerLeft" "R0" "roman" 0.0625 "normalLabel" )
foreach(mapcar line xline yup=0 yupm=0
foreach(mapcar xl line
when(verb printf("Treats:%L\n" xl))
inst=addCellw(car(xl) cadr(xl)  xy cv 0.1 nth(3 xl)||"R0" caddr(xl))
;if(inst~>libName=="cmos8rf"
;box=ibBox(inst);box=inst~>bBox
box=mbBox(inst)
;)
when(verb printf("cadar %L_%L_\n" cadadr(box) cadar(box)))
yup=cadadr(box)-cadar(box)
xup=caadr(box)-caar(box)
;yupm=max(yupm ceiling(yup/grid)*grid)
yupm=max(yupm round(yup/grid)*grid)
xy=list(car(xy)+xup+dx cadr(xy))
)
xy=list(x0 cadr(xy)+yupm+dy)
)
schCheck(cv) dbCheck(cv)  dbSave(cv); dbClose(cv)
when(open geOpen(?lib libname ?cell cellname ?view "schematic"))
cv))



;xline2sch()

;; addCellw("vdc" '("gnd!" "vdd!"))
;; ; ou bien :
;; params='("vdc" ("gnd!" "vdd!"))
;; apply('addCellw params)



defun(dbi2Sum (@optional (xors '((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1)))(patrn '("L" "1" "2" "3" "4" "6" "8"))(CLall 0.5)(xname "XOR2X")(verb t))
let((i dlySum) i=0 dlySum=0
foreach(mapcar xor xors i++ dlySum=dlySum+eval(nth(cadr(xor) nth(car(xor) dbi))))
dlySum))

;; sum=dbi2Sum()
;; freq=aelSuffixNotation(1.0/sum)

;dbi2freq()

;; addCellw("XOR2X2")
;; addCellw("DFX1" '("AA" t t "DD") 0:-1.8)
;; addCellw("DFX1" '("AA" t t "DD") 0:-1.8 cv 0.1 "R0")
;; line='("DFX1" ("AA" t t "DD") (0 -1.8))
;; apply('addCellw line);oki !



;; foreach(mapcar e elist
;; name=strcat("Q_" e)
;; wname=concat('freq_ e)
;; wave=freq(VT(name) "rising" ?xName "time" ?mode "auto" ?threshold 0.0) 
;; set(wname wave)
;; plot(wave ?expr list(wname))
;; )


;; xnets='((
;; ;;00
;; ("BUFTX2" ("pulse" "BU_00" "gnd!"))
;; ("XOR2X6" ("BU_00" "sel" "Qm1_00"))
;; ("DFX1" ("Qm1_00" t t "Qm1_00"))
;; ("INVX1" ("Qm1_00" t))
;; ("XOR2X3" ("Qm1_00" "sel" "Q_00"))
;; ("DFX1" ("Q_00" t t "Q_00"))
;; ("INVX1" ("Q_00" t))
;; ("XOR2XL" ("Q_00" "sel" t))
;; )(
;; ;;01
;; ("BUFTX2" ("pulse" "BU_01" "gnd!"))
;; ("XOR2X6" ("BU_01" "sel" "Qm1_01"))
;; ("DFX1" ("Qm1_01" t t "Qm1_01"))
;; ("INVX1" ("Qm1_01" t))
;; ("XOR2X3" ("Qm1_01" "selb" "Q_01"))
;; ("DFX1" ("Q_01" t t "Q_01"))
;; ("INVX1" ("Q_01" t))
;; ("XOR2XL" ("Q_01" "sel" t))
;; )(
;; ;;10
;; ("BUFTX2" ("pulse" "BU_10" "gnd!"))
;; ("XOR2X6" ("BU_10" "selb" "Qm1_10"))
;; ("DFX1" ("Qm1_10" t t "Qm1_10"))
;; ("INVX1" ("Qm1_10" t))
;; ("XOR2X3" ("Qm1_10" "sel" "Q_10"))
;; ("DFX1" ("Q_10" t t "Q_10"))
;; ("INVX1" ("Q_10" t))
;; ("XOR2XL" ("Q_10" "sel" t))
;; )(
;; ;;11
;; ("BUFTX2" ("pulse" "BU_11" "gnd!"))
;; ("XOR2X6" ("BU_11" "selb" "Qm1_11"))
;; ("DFX1" ("Qm1_11" t t "Qm1_11"))
;; ("INVX1" ("Qm1_11" t))
;; ("XOR2X3" ("Qm1_11" "selb" "Q_11"))
;; ("DFX1" ("Q_11" t t "Q_11"))
;; ("INVX1" ("Q_11" t))
;; ("XOR2XL" ("Q_11" "sel" t))
;; ))

;; xline=list(xnets 3.12n)

;; ajout='(
;; ("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.8)))
;; ("vdc" ("gnd!" "sel")(("vdc" "float" 0)))
;; ("INVX2" ("sel" "selb"))
;; ("vpulse" ("gnd!" "pulse")(("v2" "string" "1.8")("tf" "string" "1p")("tr" "string" "1p")("per" "string" "20n")))
;; ;("vpwl" ("gnd!" "netpwl")(("t1" "string" "1n") ("vdc" "string" "0") ("v2" "string" "1.8") ("t2" "string" "1.001n")))
;; ;("BUFTX2" ("netpwl" "start" t))
;; )

;; xline1=appendBegin1(xline ajout);=> length(car(xlinedc)) 
;; ;xline2sch(xline1 t '((0 0)) "xor_DUT_sim" 0.4 0.0625) ;=> youhou it works. mais verifier fonction mesure des bbox ymax-ymin
;; xline2sch(xline1 t '((0 0)) "xor_DUT_sim" 0.4 0)


;; rf=foreach(mapcar edio list( 0:0 0:1 1:0 1:1) 
;; foreach(mapcar e edio cond(
;; (e==0 "rising")
;; (e==1 "falling"))))
;; println(rf)

; println(foreach(mapcar edio list( 0:0 0:1 1:0 1:1) foreach(mapcar e edio sprintf(nil "%d" e))))

;; foreach(mapcar xnet xnets nth(2 cadr(nth(4 xnet))));=>("Q_00" "Q_01" "Q_10" "Q_11")
;; foreach(mapcar xnet xnets list(nth(0 cadr(nth(4 xnet))) nth(2 cadr(nth(4 xnet)))))
;; ;=>(("Qm1_00" "Q_00") ("Qm1_01" "Q_01") ("Qm1_10" "Q_10") ("Qm1_11" "Q_11"))
;; ;xnet=car(xnets)

;; neto=foreach(mapcan xnet xnets 
;; ios=cadr(nth(4 xnet))
;; in=nth(0 ios)
;; out=nth(2 ios)
;; edges=parseString(car(last(parseString(in "_"))) "")
;; printf("edges:%L\n" edges)
;; ioedges=foreach(mapcar edge edges
;; ioedge=cond(
;; (edge=="0" '(("rising" "rising")("falling" "falling")));<= buffer
;; (edge=="1" '(("rising" "falling")("falling" "rising")));<= inverseur
;; (t printf("crotte"))
;; ))
;; list(list(list(in out) car(ioedge)) list(list(in out) cadr(ioedge)))
;; )


;; length(neto)
;; foreach(mapcar net neto
;; intercept2(car(net) cadr(net))
;; )

;; intercept1('("Qm1_01" "Q_01") );=>somme delai montant plus descendant
;; intercept1('("Qm1_01" "Q_01") nil nil );=>somme delai montant plus descendant

;; (setq yo "00")
;; (setq ijk '("XOR2X6" "XOR2X3" "XOR2XL"))
;; (setq pat "XOR2X")

defun(geneDUTline (@optional (ijk '("6" "3" "L")) (yo "00")(pat "XOR2X"))
let((ni nj nk yos s0 s1 name)
;name=apply('strcat foreach(mapcan p ijk append(parseString(p pat) list("_"))))
name=strcat("_" car(ijk) "_" cadr(ijk) "_" caddr(ijk) "_" yo)
ni=strcat(pat car(ijk))
nj=strcat(pat cadr(ijk))
nk=strcat(pat caddr(ijk))
yos=parseString(yo "")
s0=if(car(yos)=="0" "sel" "selb")
s1=if(cadr(yos)=="0" "sel" "selb")
list(
list("BUFTX2" list("pulse" strcat("BU_" name) "gnd!"))
list(ni list(strcat("BU_" name) s0 strcat("Qm1_" name)))
list("DFX1" list(strcat("Qm1_" name) t t strcat("Qm1_" name)))
list("INVX1" list(strcat("Qm1_" name) t))
list(nj list(strcat("Qm1_" name) s1 strcat("Q_" name)))
list("DFX1" list(strcat("Q_" name) t t strcat("Q_" name)))
list("INVX1" list(strcat("Q_" name) t))
list(nk list(strcat("Q_" name) "gnd!" t))
)))

; geneDUTline('("6" "3" "L") "01")


;(("BUFTX2" ("pulse" "BU_6_3_L_01" "gnd!")) ("XOR2X6" ("BU_6_3_L_01" "sel" "Qm1_6_3_L_01")) ("DFX1" ("Qm1_6_3_L_01" t t "Qm1_6_3_L_01")) ("INVX1" ("Qm1_6_3_L_01" t)) ("XOR2X3" ("Qm1_6_3_L_01" "selb" "Q_6_3_L_01")) ("DFX1" ("Q_6_3_L_01" t t "Q_6_3_L_01")) ("INVX1" ("Q_6_3_L_01" t)) ("XOR2XL" ("Q_6_3_L_01" "gnd!" t)))



defun(geneDUTline4 (@optional (eijk '("6" "3" "L"))(name "XOR2X"))
foreach(mapcan b0i1 '("00" "01" "10" "11")
geneDUTline(list(car(eijk) cadr(eijk) caddr(eijk)) b0i1 name)
))


;; defun(geneDUTline4 (@optional (eijk '("6" "3" "L"))(name "XOR2X"))
;; foreach(mapcan b0i1 '("00" "01" "10" "11")
;; list(list(list(car(eijk) cadr(eijk) caddr(eijk)) b0i1)))
;; )


;; line1=geneDUTline4( '("6" "3" "L") "XOR2X")
;; length(line1) ;=> 32
;xline2sch(list(line1 nil) t nil "xor_DUT_sim2" 0.4 0.0625)
;xline2sch(list(list(line1) nil) t nil "xor_DUT_sim2" 0.4 0)

;(setq elist '("L" "1" "2" "3" "4" "6" "8"))

defun(geneDUT_343 (@optional (elist '("L" "1" "2" "3" "4" "6" "8"))(xname "XOR2X"))
foreach(mapcan ni elist
foreach(mapcan nj elist
foreach(mapcar nk elist
geneDUTline4( list(ni nj nk) xname)
))))


defun(simXor (@optional (cell nil)(lib nil)(temps 40n))
;; SIMULATION
simulator('spectre)
unless(cell cell=geGetWindowCellView()~>cellName)
unless(lib lib=geGetWindowCellView()~>libName)
;; lib="ATEST_h18"
;; cell="tdc_xor_51515040405051515051_3.132n_sim"
design(lib cell "schematic")
createNetlist(?display nil)
analysis('dc ?saveOppoint t  )
analysis('tran ?stop temps  )
envOption('analysisOrder  list("dc" "tran"))
temp( 27 ) 
run()
resultsDir());=> renvoie le repetoire de la simu

; dir=simXor("xor_A0_B0_C1_D1_E0_F1_H0_I0_J1_K1_L0" "Ed_CMOS8")
; dir;=>"/home/validmgr/ebecheto/Work/IBMv18/Sim/xor_A0_B0_C1_D1_E0_F1_H0_I0_J1_K1_L0/spectre/schematic"

; (setq val '("S" 1077))
defun(simSetVar (@optional (cell nil)(lib nil)(val '("S" 1077))(stop 10n)(deg 27)(errpreset "moderate"))
;; SIMULATION
simulator('spectre)
unless(cell cell=geGetWindowCellView()~>cellName)
unless(lib lib=geGetWindowCellView()~>libName)
;; lib="ATEST_h18"
;; cell="tdc_xor_51515040405051515051_3.132n_sim"
design(lib cell "schematic")
option('dochecklimit "no" 'info "no");<= ibm trop verbeux
desVar(car(val) cadr(val))
converge( 'ic "/S_0" "0" )
converge( 'ic "/Q_1" "0" )
converge( 'ic "/Q_0" "0" )
;createNetlist(?display nil) ;<= netlist bouge pas normalement
analysis('dc ?saveOppoint t  )
analysis('tran ?stop stop  ?errpreset errpreset)
envOption('analysisOrder  list("dc" "tran"))
temp( deg ) 
run()
resultsDir());=> renvoie le repetoire de la simu


;; (setq ijk '("6" "3" "L")) 
;; (setq yo "00")
;; (setq pat "XOR2X")
;; (setq ends '("gndMARK" "subMARK" "vddMARK"))

defun(geneDUTnetlist (@optional (ijk '("6" "3" "L")) (yo "00")(pat "XOR2X")(nb 10)(ends '("0" "sub!" "vdd!")))
let((ni nj nk yos s0 s1 name)
ni=strcat(pat car(ijk))
dut=strcat(pat cadr(ijk))
nk=strcat(pat caddr(ijk))
name=strcat("_" car(ijk) "_" cadr(ijk) "_" caddr(ijk) "_" yo)
yos=parseString(yo "")
s0=if(car(yos)=="0" "sel" "selb")
s1=if(cadr(yos)=="0" "sel" "selb")
list(
append(list("BUFX2" "pulse" strcat("BU" name)) ends)
append(list(ni strcat("BU" name) s0 strcat("Qm" name)) ends)
append(list("DFX1" strcat("Qm" name) sprintf(nil "NC%d" nb++) sprintf(nil "NC%d" nb++) strcat("Qm" name)) ends)
append(list("INVX1" strcat("Qm" name) sprintf(nil "NC%d" nb++)) ends)
append(list(dut strcat("Qm" name) s1 strcat("Q" name)) ends)
append(list("DFX1" strcat("Q" name) sprintf(nil "NC%d" nb++) sprintf(nil "NC%d" nb++) strcat("Q" name)) ends)
append(list("INVX1" strcat("Q" name) sprintf(nil "NC%d" nb++)) ends)
append(list(nk strcat("Q" name) "0" sprintf(nil "NC%d" nb++)) ends)
)))


;; listNet=geneDUTnetlist()
;; file="~/myNetlist.txt"
;; fp=outfile(file)
;; i=10
;; cell='("BUFTX2" "pulse" "BU_6_3_L_00" "gnd!" "sub!" "vdd!")
;; foreach(cell listNet
;; nets=apply('strcat foreach(mapcan c cdr(cell) list(" " c)))
;; fprintf(fp "C%d (%s) %s\n" i++ nets car(cell))
;; )
;; close(fp)
;; edit(eval(file))

;=> renvoie la liste des courbes nommee par les intercept mesures. a evaluer; 
defun(geneVTX (@optional (elist '("6" "8")) (bits '("00" "01" "10" "11")))
;ioedges=foreach(mapcar rf parseString(io "") cond((rf="0" "rising")(rf="1" "falling")))
foreach(mapcan ni elist
foreach(mapcan nj elist
foreach(mapcan nk elist
foreach(mapcan io bits
DUT01=cadr(parseString(io ""))
ioedges=(cond 
(DUT01=="0" '(("rising" "rising")("falling" "falling")))
(DUT01=="1" '(("rising" "falling")("falling" "rising" )))
)
pat=sprintf(nil "%s_%s_%s_%s" ni nj nk io)
when(nil plot(VT(strcat("Qm_" pat))) plot(VT(strcat("Q_" pat))))
foreach(mapcar ioe ioedges 
rorfs=strcat(car(parseString(car(ioe) "")) car(parseString(cadr(ioe) "")))
list(curb=intercept2(list(strcat("Qm_" pat) strcat("Q_" pat)) ioe nil nil) value(eval(curb) 0) strcat(pat "_" rorfs))
)))))
)

;vals=foreach(mapcar c tcurbs=geneVTX() cdr(c))


;; dir="~/Work/h18/Sim/AAA/spectre/schematic/netlist/"
;; (setq elist '("L" "1" "6" "8"))

defun(geneRepList (@optional (elist '("L" "1" "6" "8")) (dir "~/Work/h18/Sim/AAA/spectre/schematic/netlist/") (ouvr t))
let((bits inc listNet listn filen file fp i nets)
bits='("00" "01" "10" "11")
inc=10
listNet=nil
foreach(ni elist foreach(nj elist foreach(nk elist foreach(bit bits
listNet=tconc(listNet geneDUTnetlist(list(ni nj nk) bit "XOR2X" inc))
inc=inc+7 ;<== this is netlist specific. TOCHANGE
))))
listn=car(listNet)
filen="netlistMy"
file=strcat(dir filen)
fp=outfile(file)
i=10
;cell='("BUFTX2" "pulse" "BU_6_3_L_00" "gnd!" "sub!" "vdd!")
foreach(line listn
foreach(cell line
nets=apply('strcat foreach(mapcan c cdr(cell) list(" " c)))
fprintf(fp "ED%d (%s) %s\n" i++ nets car(cell))
))
close(fp)
when(ouvr edit(eval(file)))
))

; geneRepList( '("L" "1" "6" "8") dir="~/Work/h18/Sim/AAA/spectre/schematic/netlist/" nil)

defun(geneRepSim (@optional (dir "~/Work/h18/Sim/AAA/spectre/schematic/netlist/"))
(let ()
;( filen cmd)
filen="netlistMy"
cmd="xterm -e \""
cmd=sprintf(nil "%s cd %s;cat netlistH %s netlistF > input.scs " cmd dir filen)
cmd=sprintf(nil "%s; ./runSimulation" cmd)
cmd=sprintf(nil "%s\"&" cmd)
(system cmd)
))
; RQ : netlistH et netlistF ont ete preparre 'on purpose'

;(system "xterm -e \"pwd;bash\"")

; (system "xterm -e \"pwd;bash\"&")


; cat input.scs |sed 's/\(dzi_in=.\)\([01]*\)\(.\)/\1TOTO\3/' |grep parameters




(setq xors '((L 1)(4 1)(6 0)(8 0)(4 0)(6 0)(3 1)(2 1)(L 0)(1 1)))
;(setq elist '("L" "1" "2" "3" "4" "6" "8"))
defun(dllPredictGen (@optional (xors '((5 1)(5 1)(5 0)(4 0)(4 0)(5 0)(5 1)(5 1)(5 0)(5 1))))
let((L pos)
L=length(xors) pos=-1
foreach(mapcar xor xors pos++
list(
car(nth(mod(pos-1+L L) xors))
car(nth(pos xors))
car(nth(mod(pos+1+L L) xors))
strcat(concat(cadr(nth(mod(pos-1+L L) xors)) cadr(nth(pos xors))))
))))

;xorList=dllPredictGen('(('L 1)('4 1)('6 0)('8 0)('4 0)('6 0)('3 1)('2 1)('L 0)('1 1)))
;; xorList=dllPredictGen('((L 1)(4 1)(6 0)(8 0)(4 0)(6 0)(3 1)(2 1)(L 0)(1 1)))

;=>((1 L 4 "11")(L 4 6 "11")(4 6 8 "10")...)
defun(dllPredictCurvs (@optional (xorList '((1 L 4 "11")(L 4 6 "11")(4 6 8 "10"))))
(let (DUT01 ioedges)
foreach(mapcan xs xorList 
DUT01=cadr(parseString(nth(3 xs) ""));=>"11"
ioedges=(cond 
(DUT01=="0" '(("rising" "rising")("falling" "falling")))
(DUT01=="1" '(("rising" "falling")("falling" "rising" )))
)
foreach(mapcar ioe ioedges
rorfs=strcat(car(parseString(car(ioe) "")) car(parseString(cadr(ioe) "")))
concat('curv_ apply('strcat cons("Q_" append(foreach(mapcar x xs strcat(a2s(x) "_")) list(rorfs)))))
))))


;; xorList=dllPredictGen('((L 1)(4 1)(6 0)(8 0)(4 0)(6 0)(3 1)(2 1)(L 0)(1 1)))
;; curvList=dllPredictCurvs(xorList)
; (mapcar 'eval curvList)


defun(geneCurvX (@optional (elist '("1" "8")) (io "01"))
;ioedges=foreach(mapcar rf parseString(io "") cond((rf="0" "rising")(rf="1" "falling")))
;; ni=car(nio) ;(nio '("Qm1" "Q_"))
;; no=cadr(nio)
DUT01=cadr(parseString(io ""))
ioedges=(cond 
(DUT01=="0" '(("rising" "rising")("falling" "falling")))
(DUT01=="1" '(("rising" "falling")("rising" "falling"))))
foreach(mapcan ni elist
foreach(mapcan nj elist
foreach(mapcar nk elist
pat=sprintf(nil "%s_%s_%s_%s" ni nj nk io)
when(t plot(VT(strcat("Qm1_" pat))) plot(VT(strcat("Q_" pat))))
intercept2(list(strcat("Qm1_" pat) strcat("Q_" pat)) ioedges nil nil)
))))

;curvX=geneCurvX('("1" "L") "11")


defun(myRms (alist) let((mean sigma) mean=0 sigma=0
foreach(a alist mean=mean+a)
;<= apply 'plus limited to 65535 elements!
;mean=apply('plus alist)/length(alist)
foreach(mapcar a alist sigma=sigma+(a-mean)**2)
sigma=sqrt(sigma)/length(alist)
list(mean sigma)
))

defun(myRmsf (alist @optional (histo t)(bin 20)(plot nil)(sub nil)(lab nil)(tri t)(deriv t)) 
(let (my mean sigma ymax ymin label trie tris courb)
unless(lab lab='("histo" "data"))
ymax=car(alist)  ymin=ymax
foreach(a alist 
when(a>ymax ymax=a)
when(a<ymin ymin=a)
)
;; ymax=apply('max alist) ;<= bug si il y a plus de 6e3 elements...=> loop
;; ymin=apply('min alist)
courb=list2wave2(alist)
my=list(average(courb) stddev(courb)) ; myRms(alist)
mean=car(my) sigma=cadr(my)
label=list(sprintf(nil "%L m=%s sdev=%s min=%s max=%s" car(lab) aelSuffixNotation(mean) aelSuffixNotation(sigma) aelSuffixNotation(ymin) aelSuffixNotation(ymax)))
printf("mean=%s sigma=%s ymin %s ymax %s\n" aelSuffixNotation(mean) aelSuffixNotation(sigma) aelSuffixNotation(ymin) aelSuffixNotation(ymax))
when(plot when(sub addSubwindow())  plot(courb ?expr cdr(lab)))
when(tri trie=foreach(mapcar a alist a) trie=(sort trie 'lessp) plot(tris=list2wave2(trie))); copie bidon (for(map)) sinon 'sort' ecrase alist...
when(deriv when(sub addSubwindow()) plot(deriv(tris)))
when(histo when(sub addSubwindow()) plot(histo(courb bin 0.8*ymin 1.2*ymax) ?expr label))
))

; myRmsf('(1 2 3 4 2 3 4 3 4 5)) ;=>
; myRmsf('(2 2 2 2 2 2 2 2 2 1) nil 0 nil nil nil nil nil) ;=>

;"./Sim/xor_A0_B1_C0_D1_E1_F1_H1_I1_J1_K1_L1/spectre/schematic/"

defun(dll2period (@optional (dir resultsDir())(net "Q_")(from 0) (to 10)(plot nil)(bus "_")) 
(let (name ame plt bud)
bud=if(bus=="<" ">" "")
foreach(mapcar i linRg(from to 1)
name=strcat(net bus a2s(i) bud)
ame=sprintf(nil "per_%d" i)
printf("name:%s to%d in %s\n" name to dir||"nil")
setq(plt 1/freq(VT(name dir) "rising" ?xName "time" ?mode "user" ?threshold 0.6))
when(plot plot(plt ?expr list(ame)))
plt)))


defun(dll2periodSave (perCurb @optional (cname "xor_A0_B0_C1_D1_E1_F1_H1_I1_J1_K1_L1")(dir pwd()))
let((fp mean20n means40n) mean20n=0 mean40n=0
fp=outfile(strcat(dir "/" cname))
foreach(mapcar per perCurb 
mean20n=mean20n+value(per 20n)
mean40n=mean40n+value(per 40n)
)
mean20n=mean20n/length(perCurb)
mean40n=mean40n/length(perCurb)
fprintf(fp "per%s=%g;@40n:+%s" cname mean20n aelSuffixNotation(mean40n-mean20n))
close(fp)
mean20n))


defun(dll2periodSim (@optional (fam '(("A" "0") ("B" "0") ("C" "1")("A" "0") ("B" "1") ("C" "0")) )(dir pwd())(lib "ABDCEEDCBA")(net "Q_")(resName "XOR_DLLs.txt")(verb t))
let((fo meanList cvname cv cname libName cellName perCurb mean20n simdir)
;resName="XOR_DLLs.txt"
fo=outfile(strcat(dir "/" resName ))
;; fami=caddr(fam)
;; fami=nth(6 fam)
meanList=foreach(mapcar fami fam
cvname=dllCombGen2(fami lib);=> "xor_A0_B1_C0_D1_E1_F1_H1_I1_J1_K1_L1"
cv=car(cvname)
cname=cadr(cvname) 
libName=cv~>libName 
cellName=cv~>cellName
schCheck(cv)   dbSave(cv) dbClose(cv)
simdir=simXor(cellName libName);<=simdir=resultsDir()
printf("simdir:%s/%d\n" simdir  length(fami)-1)
perCurb=dll2period(simdir net 0 length(fami)-1);<= rep ./Sim/lib/cell/schematic/ ;=> perCurb;=> (srrWave:0x1605a4c0 ...)
mean20n=dll2periodSave(perCurb cname dir)
fprintf(fo "%g ; %s\n" mean20n cname)
; une fois la donnee enregistree, on peut supprimer la base de donned de la simu
when(simdir system(sprintf(nil "rm -r %s" simdir))) simdir=nil
list(mean20n cname)
) close(fo) 
list(meanList simdir);<= returned value list
))


defun(dllGetResult (fam @optional (dir pwd()))
remove(nil foreach(mapcar fami fam
cname=sprintf(nil "xor%s" apply('strcat foreach(mapcar c fami strcat("_" car(c) cadr(c)))))
fi = infile(strcat(dir "/" cname))
if(fi then gets(line fi) if(line evalstring(cadr(parseString(line "=;"))) nil) else
printf(sprintf(nil "file %s existe pas ?\n" strcat(dir "/" cname)))
nil)
)))

defun(dllGetResult2 (fam @optional (dir pwd())) let((cname motif fi)
remove(nil foreach(mapcar fami fam
cname=sprintf(nil "xor%s" motif=apply('strcat foreach(mapcar c fami strcat("_" car(c) cadr(c)))))
fi = infile(strcat(dir "/" cname))
if(fi then gets(line fi) if(line list(evalstring(cadr(parseString(line "=;"))) motif) nil) else
printf(sprintf(nil "file %s existe pas ?\n" strcat(dir "/" cname)))
nil)
))))


;ineed('cnpbin)

defun(cnpbin2fam (@optional (cnp '(7 11 t)) (ibmpat '("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")))
let((aa iostr) ;transform
aa=apply('cnpbin cnp); ie cnpbin(7 11 t)
iostr=foreach(mapcar a aa abIntToBinaryStr(a cadr(cnp)))
foreach(mapcar io iostr mapcar('list ibmpat parseString(io "")))
))

;; cnpbin2fam('(2 3 t) '("A" "B" "C")) ;=>((("A" "0") ("B" "1") ("C" "1")) (("A" "1") ("B" "0") ("C" "1")) (("A" "1") ("B" "1") ("C" "0")))
;; cnpbin2fam('(1 3 t) '("A" "B" "C")) ;=>((("A" "0") ("B" "0") ("C" "1")) (("A" "0") ("B" "1") ("C" "0")) (("A" "1") ("B" "0") ("C" "0")))


defun(inv2fam (@optional (nbInv 9)(ibmpat '("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")))
let((L fam fami cname)
L=length(ibmpat)
fam=cnpbin2fam(list(nbInv L) ibmpat)
printf("%d combi. Now launch dll2periodSim(fam) \nto get the following results files: in %s\n" length(fam) pwd())
toshow=append('(0 1 2) list(length(fam)-1))
foreach(show toshow fami=nth(show fam)
cname=sprintf(nil "xor%s" apply('strcat foreach(mapcar c fami strcat("_" car(c) cadr(c)))))
printf(strcat(cname "\n"))
when(show==cadr(reverse(toshow)) printf("...\n"))
) fam))

; inv2fam() t;<= mettre t apres la fonction pour voir le printf sinon, il est noye par l'echo de la liste fam


defun(fam2display (@optional (fam '((("A" "0") ("B" "0") ("C" "1")) (("A" "0") ("B" "1") ("C" "0")) (("A" "1") ("B" "0") ("C" "0")))) (dir pwd()))
let((motif nbInv  title L);perf perm
;motif=apply('strcat foreach(mapcar fa car(fam) car(fa)))
motif=foreach(mapcar fa car(fam) car(fa))
L=length(motif)
nbInv=length(remove("0" foreach(mapcar fa car(fam) cadr(fa))))
perf=dllGetResult(fam dir);<= recup les donnees
perm=list2minus(perf);<= fais le tableau des differences => N(N-1)/2 elements
title=sprintf(nil "[XOR %d Inverters %d Buffers : %s]   " nbInv L-nbInv apply('strcat motif))
myRmsf(perf t 20 t t '("period range" "period histo"))
myRmsf(perm t 20 t t '("delta t range" "delta t histo"))
awvDisplayTitle( awvGetCurrentWindow() title)
))


defun(famCheckFiles (@optional (fam '((("A" "0") ("B" "0") ("C" "1")) (("A" "0") ("B" "1") ("C" "0")) (("A" "1") ("B" "0") ("C" "0"))))(dir pwd()))
let((got i old old2) got=nil i=0 old="prems" old2="moinsUN"
foreach( fami fam i++ 
cname=sprintf(nil "xor%s" apply('strcat foreach(mapcar c fami strcat("_" car(c) cadr(c)))))
unless(got
when(not(isFile(cname))
printf("%s; does not exist [%d/%d]?!\n" cname i length(fam)) got=t
fi=infile(strcat(dir "/" old))
printf("%s ;<= previous(-1) file inside =\n" old)
while(gets(lines fi) printf("%s" lines)) close(fi)
printf("\n____END_PREVIOUS(-1)__________\n")
printf("Restart Simu:\ndll2periodSim(nthcdr(%d fam))\n" i-if(lines 1 2))
fi=infile(strcat(dir "/" old2))
printf("%s previous(-2) file inside =\n" old2)
while(gets(lines fi) printf("%s" lines)) close(fi)
printf("\n____END_PREVIOUS(-2)________\n")
))
old2=old
old=cname
)
unless(got printf("All %d files exists\n" length(fam)))
))

;famCheckFiles(fam)

;; marche pas ???
;; defun(saveList2 (@optional (alist '(1 2 3 (2 3 4))) (file "tmp.txt")(pwd nil))
;; unless(pwd pwd=pwd())
;; fil=strcat(pwd "/" file) 
;; fp=outfile(file "w")
;; foreach(mapcar a alist fprintf(fp "%L\n" a))
;; close(fp) fil
;; )

;; yo=saveList2(marge100f)
;; edit(eval(yo))


defun(fam2marge (fam @optional (marge 100f)) let((triDelta mar)
triDelta=sortcar(list2minus2(dllGetResult2(fam)) 'lessp)
mar=remove(nil foreach(mapcar tri triDelta when(-marge<car(tri)&&car(tri)<marge tri)))
printf("[%d elements in +/-%s]\n" length(mar) aelSuffixNotation(marge))
mar))



defun(motif2allFam (@optional (motif '("A" "B" "C" "D" "E" "E" "D" "C" "B" "A"))(combi '(1 5 7 9))(dir pwd()))
t0=cputime()
unless(combi combi=linRg(1 length(motif) 2))
unless(dir dir=apply('strcat motif))
foreach(mapcar c combi
fam=inv2fam(c) t
dllSim=dll2periodSim(fam dir)
simdir=cadr(dllSim)
when(simdir system(sprintf(nil "rm -r %s" simdir))) simdir=nil
)
t0=cputime()
printf("%g secondes cpu\n" 1.0/60*(t1-t0))
t1-t0)
;fam2display(fam dir)


defun(fam2displayAll (@optional (motif '("A" "B" "C" "D" "E" "E" "D" "C" "B" "A"))(disp t)(dir nil)) let((combis fam)
combis=linRg(1 length(motif) 2)
unless(dir dir=strcat(pwd() "/" apply('strcat motif)))
fam='() nb=foreach(mapcar c combis tmp=inv2fam(c motif)
fam=append(fam tmp)
printf("%d parmis 11 a %d combinaison\n" c length(tmp))
length(tmp))
printf("Total nb ol elementfs : %d" apply('plus nb));=> 512
when(disp 
fam2display(fam dir)
awvDisplayTitle(awvGetCurrentWindow() sprintf(nil "All Combinaison : %s" apply('strcat motif)))
)
list(fam dir)
))



ineed('singleList t)

defun(checkFileDir (@optional (motif "ABCDEFHIJKL" )(dir "~/Work/IBMv18/"))
unless(dir dir=pwd())
xorFiles=remove(nil foreach(mapcan file ls(strcat(dir "/" motif)) when(rexMatchp("xor_" file) list(file))))
unSum=foreach(mapcar file xorFiles  apply('plus  foreach(mapcar a parseString(file strcat("xor_" motif)) atoi(a) )))
singleList(unSum)
)
; checkFileDir();=>(1 3 5 7 9)


defun(fixPulseNet (@optional (names '("S_0" "Sf_0")) (pulses t)(cellName "vdc"))
let((pulse pulsef i inst xy)
pulse='("vpwl" nil (("vdc" "string" "0") ("td" "string" "300p") ("t1" "string" "1n") ("t2" "string" "1.1n") ("v2" "string" "1.2")))
pulsef='("vpwl" nil (("vdc" "string" "0") ("v2" "string" "1.2") ("t2" "string" "1.1n") ("t1" "string" "1n")))
when(pulses==t pulses=list(pulse pulsef))
i=-1 
foreach(mapcar name names i++
inst=carInstNetCell(name cellName);=> db:0x12739a62
xy=inst~>xy 
when(inst dbDeleteObject(inst))
addCellg(nth(i pulses) xy)
)))


defun(carInstNetCell (@optional (instName "Sf_0")(cellName "vdc")(cv geGetWindowCellView()))
car(setof(i car(setof(n cv~>nets n~>name==instName))~>instTerms~>inst i~>cellName==cellName))
)



defun(PDmklist (@optional (L 10) (phaseDetecList nil))
let((phaseDetecList mdl mde HAL cells cellName pins)
unless(phaseDetecList phaseDetecList='(
("DFF_E"  (("Q" 0) t ("D<" 0) ("C<" 0) ))
("DFF_E"  (t ("Qb" 0) ("Q" 0) ("C<" 0) ))
("NAND2_C" (("S<" 0) ("Qb" 0) ("Q" 0) ))
))
mdl='("gnd!" "sx!" "nw!" "vdd!")
mde='("sx!" "gnd!" "nw!" "vdd!")
HAL=foreach(mapcar h phaseDetecList cond(
(rexMatchp("DFF" car(h)) append(list(car(h)) list(append(mde cadr(h)))))
(t  append(list(car(h)) list(append(mdl cadr(h)))))
))
cells=dllGenMotifHA(L HAL '())
cellName=sprintf(nil "PhaseDet_%d-bit" L)
pins=list(append(netMakeBus("C" L) netMakeBus("D" L)) netMakeBus("S" L))
list(cells 'ibm cellName reverse(pins))
))

defun(DLLmklist (@optional (motif '("E" "F" "H" "I" "E" "F" "H" "I"))(libName 'ibm)(cellName nil))
let((L xors pins)
xors=dllGenMotif(motif 'ibm) L=length(motif)
unless(cellName cellName=strcat("d_" apply('strcat motif)))
pins=list(netMakeBus("S" L t "_") netMakeBus("Q" L t "_"))
list(list(xors) libName cellName reverse(pins))
))




;; (setq q list("Q" "Qf"))
;; bus="<"
defun(mixPDnets (@optional (L 9)(q list("Q" "Qf"))(bus "<")) let((ret bud)
bud=if(bus=="<" ">" "")
for(i -1 L-2
cond(
(i==-1 ret=list(list(L-1 L-1)))
(evenp(i) ret=cons(list(i/2 L-i/2-2) ret))
(oddp(i) ret=cons(reverse(car(ret)) ret))
))
ret=reverse(ret);=>((8 8) (0 7) (7 0) (1 6) (6 1) (2 5) (5 2) (3 4) (4 3))
ret=apply('mapcar 'list ret);=> ((4 5 3 6 2 7 1 8 0 9) (4 3 5 2 6 1 7 0 8 9))
append(
foreach(mapcar cr car(ret) strcat(car(q) bus a2s(cr) bud));=>("Q8" "Q0" "Q7" "Q1" "Q6" "Q2" "Q5" "Q3" "Q4")
foreach(mapcar cr cadr(ret) strcat(cadr(q) bus a2s(cr) bud))
)
))

; mixPDnets(10)
;=>("Q<9>" "Q<0>" "Q<8>" "Q<1>" "Q<7>" "Q<2>" "Q<6>" "Q<3>" "Q<5>" "Q<4>" "Qf<9>" "Qf<8>" "Qf<0>" "Qf<7>" "Qf<1>" "Qf<6>" "Qf<2>" "Qf<5>" "Qf<3>" "Qf<4>")


defun(vdcPWRgen (@optional (cv geGetWindowCellView())(dx 0.4)(dy 0.4) )
let((PWR V0 VA V2 V3 V4 pulse bBox yx)
PWR='(("vdc" ("gnd!" "vdd!") (("vdc" "string" "1.2")))("vdc" ("gnd!" "nw!") (("vdc" "string" "1.2")))("vdc" ("gnd!" "sx!") (("vdc" "string" "0"))))
V0='("vdc" ("gnd!" "vdd!")(("vdc" "float" 1.2)))  ;=> getPropList()
;; Vnw='("vdc" ("gnd!" "nw!")(("vdc" "float" 1.2)))
;; Vsx='("vdc" ("gnd!" "nx!")(("vdc" "float" 0.0)))
V1='("vpwl" ("gnd!" "vstart") (("v2" "string" "1.8") ("v6" "string" "1.8") ("t6" "string" "21.1n") ("t5" "string" "21n") ("t4" "string" "20.1n") ("v3" "string" "1.8") ("t3" "string" "20n") ("t2" "string" "1.1n") ("t1" "string" "1n")))
V2='("vpulse" ("gnd!" "vclk") (("v2" "string" "1.8") ("tf" "string" "100.0f") ("tr" "string" "100.0f") ("per" "string" "1n")))
V3='("BUFFER_C" ("gnd!" "sx!" "nw!" "vdd!" "clk" "vclk"))
V4='("BUFFER_C" ("gnd!" "sx!" "nw!" "vdd!" "C_0" "vstart"))
pulse=list(append(PWR list(V0 V1 V2 V3 V4) ))
bBox=cv~>bBox ;=> ((-0.9 -0.65) (1.3 -0.24375))
xy=mapcar('plus car(bBox) '(0 -1))
array2sch(pulse cv~>libName cv~>cellName  nil dx dy t nil "a" xy)
))


;;;;;;;;;;;;;;;;;;;;;;;; ????????linRg(0 2**L-1 1)
defun(vdcPWRcode (@optional (L 11)(ficelle nil)) let((res ones yo)
res=remove(nil foreach(mapcan nb linRg(1 2**L 1)  ;nb= 18 ;abIntToBinaryStr(11 4);=>"1011"
ones=remove( "0" str=parseString(bins=abIntToBinaryStr(nb L) "")) ;("1" "1")
list(when(car(reverse(str))=="1"&&oddp(length(ones)) 
;printf("lsb=1 et nb 1 impaire:%L\n" list(nb bins)) 
if(ficelle bins nb)
))
))
;yo=foreach(mapcar r res r);=> yo='("00000001" "00000111" ...)
))


;; apply('oddp list(2))
;; apply('evenp list(2))


defun(binaryStringCode (@optional (L 11)(ficelle nil)(pair 'oddp)) let((res ones yo)
res=remove(nil foreach(mapcan nb linRg(0 2**L-1 1)  ;nb= 18 ;abIntToBinaryStr(11 4);=>"1011"
ones=remove( "0" str=parseString(bins=abIntToBinaryStr(nb L) "")) ;("1" "1")
list(when(apply(pair list(length(ones)))
if(ficelle bins nb)
))))))

;; a=binaryStringCode(10 t 'evenp)
;; length(a);=>512



defun(dMotifSim (@optional (smotif 'IJKIJKIJKIJ)(deg 27)(cellName nil)(libName nil)(dit nil)(codes nil))
let((catmot motif file fo)
catmot=symbolToString(smotif)
motif=parseString(catmot "")
unless(codes codes=vdcPWRcode(length(motif)))
unless(dit dit="~/Work/IBMv18/TDC_RESULT")
unless(libName libName="Ed_CMOS8")
unless(cellName cellName=strcat("d_" catmot "_sim"))
printf("dMotifSim Running on cell: %s\n" cellName)
foreach(mapcar code codes
simSetVar(cellName libName list("S" code) 10n deg)
file=sprintf(nil "%s/%s_%0.3d.dat" dit cellName code)
fo=outfile(file)
fprintf(fo "%g" valueLast(car(dll2period(nil "Q" 0 0))))
close(fo)
)))


defun(getTDCresult (@optional (motif '("I" "J" "K" "I" "J" "K" "I" "J" "K" "I" "J"))(cellName nil)(dit "~/Work/IBMv18/TDC_RESULT"))
let((file fo line codes)
remove(nil foreach(mapcan code codes=vdcPWRcode(length(motif))
unless(cellName cellName=strcat("d_" apply('strcat motif) "_sim"));=>"d_IJKIJKIJKIJ_sim"
file=sprintf(nil "%s/%s_%0.3d.dat" dit cellName code)
when(isFile(file)
fo=infile(file);port:"~/Work/IBMv18/TDC_RESULT/d_IJKIJKIJKIJ_sim_047.dat"
gets(line fo)  ;"2.60249e-09"
unless(line=="" 
list(evalstring(line)))
)))
))




defun(getTDCresultCodes (@optional (motif '("I" "J" "K" "I" "J" "K" "I" "J" "K" "I" "J"))(cellName nil)(dit "~/Work/IBMv18/TDC_RESULT"))
let((file fo line codes)
remove(nil foreach(mapcan code codes=vdcPWRcode(length(motif))
unless(cellName cellName=strcat("d_" apply('strcat motif) "_sim"));=>"d_IJKIJKIJKIJ_sim"
file=sprintf(nil "%s/%s_%0.3d.dat" dit cellName code)
when(isFile(file)
fo=infile(file);port:"~/Work/IBMv18/TDC_RESULT/d_IJKIJKIJKIJ_sim_047.dat"
gets(line fo)  ;"2.60249e-09"
unless(line=="" 
list(list(evalstring(line) code)))
)))
))

;list2minus2(getTDCresultCodes())

;alist=getTDCresult()
defun(motmotif (@optional (motif 'FJHFJHFJHFJ))
motif=if(type(motif)=='symbol parseString(symbolToString(motif) "") motif))

;; motmotif();=>("F" "J" "H" "F" "J" "H" "F" "J" "H" "F" "J")



defun(genDziSim (@optional (dzin '("0110110101" "1010110110")) (dir "/home/validmgr/ebecheto/Work/IBMv18/Sim/Tdc_CH1r_sim/spectre/schematic/netlist/")(et "&"))
(let ()
;( filen cmd)
filen="netlistMy"
cmd="xterm -e \""
cmd=sprintf(nil "%s cd %s;cat %s |sed 's/TOCHANGE/%s/' > input.scs" cmd dir filen apply('strcat dzin))
cmd=sprintf(nil "%s; ./runSimulation" cmd)
cmd=sprintf(nil "%s\"%s" cmd et)
(system cmd)
))
