;; copyleft ebecheto

unless(fboundp('whereExistCell3) load("whereExistCell3.il"))
ineed('getInstTermPoint)
ineed('angleBox)
ineed('(getMaxPoints ibBox mbBox))

;cv= geGetWindowCellView()
defun( addCell (@optional (cells '("vdd" "gnd" "vdc" "noConn")) (cv t)(xy nil)(simp t)(lib nil))
(let (i rot grid xup insts inst box yup tb)
when(cv==t cv=geGetWindowCellView())
i=0 j=0 rot="R0" grid=schGetEnv("symSnapSpacing")
xup=0.5; step it when list of list of cells
unless(xy xy=foreach(mapcar a car(cv~>bBox) round(a-xup/grid)*grid))
cellss=if(listp(cells) cells list(cells))
libs=if(listp(lib) lib list(lib)) printf("libs='%L\n" libs)
if(simp&&rexMatchp("_sim$" cv~>cellName) then rexCompile("_sim$") tb=rexReplace(cv~>cellName "" 1) 
unless(member(tb cv~>instances~>cellName) cellss=append(cellss list(tb))))
insts=foreach(mapcar cell cellss
unless(lib=nth(j libs) lib=car(whereExistCell3(cell nil "symbol")))
when(lib
while(member(sprintf(nil "I%d" i) foreach(mapcar n cv~>instances~>name car(parseString(n "<")))) i++)
;while(member(sprintf(nil "I%d" i) cv~>instances~>name) i++) 
nocName=sprintf(nil "I%d" i)
printf("add in %L %L\n" xy list(cell lib nocName))
inst=dbCreateInstByMasterName(cv lib cell "symbol" nocName xy rot)
;inst=css()
box=inst~>bBox
yup=cadadr(box)-cadar(box)
yup=round(yup/grid)*grid
xy=list(car(xy)+xup cadr(xy)+yup)
) j++ inst)))

;; grid=schGetEnv("schSnapSpacing")=>0.0325
;; schGetEnv("symSnapSpacing");=> 0.0625
;; xy='(2.30625 6.925)
;; inst=css()
;; xyok=foreach(mapcar a xy round(a/grid)*grid)
;; inst~>xy=xyok

;; xy='(0.0 0.1875)
;; xyd=foreach(mapcar a xy a/grid)
;; xyr=foreach(mapcar a xyd round(a)*grid)


;; addCell()

;; ibmpat='("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L")
;; cells=foreach(mapcar pat ibmpat strcat("XOR2_" pat))

;; addCell(cells)
printf("addCell('(%L %L %L %L))\n" "gnd" "vdc" "vdd" "noConn")
printf("addCell('(%L %L %L))\n" "DFF_E" "DFF_H" "DFF_K")
printf("addCell%L\n" '("XOR2_A" "XOR2_B" "XOR2_C" "XOR2_D" "XOR2_E" "XOR2_F" "XOR2_H" "XOR2_I" "XOR2_J" "XOR2_K" "XOR2_L"))


;; ; assoc("A" getInstTermPoint()) ;=> ("A" (0.0 0.125))
;; (setq nets '(("B" "Q7")("A" "A1")("Q" "Q1")))
;; (setq nets1 '("Q7" "A1" "Q1" "HOHO") )
;; (setq nets '("Q7" "A1" "Q1") )

defun( addCells (@optional (cells '("XOR2_A" "XOR2_B")) (cv nil)(nets '(("A" "A1")("Q" "Q1")("B" "Q7") ))(dx 0.1)(xyext nil))
(let (i rot grid xup xy insts lib inst box yup yext xext)
xext=car(xyext) yext=cadr(xyext)
unless(cv cv=geGetWindowCellView())
i=0  rot="R0" grid=schGetEnv("symSnapSpacing")
xup=if(xext xext 0); step it when list of list of cells
xy=foreach(mapcar a car(cv~>bBox) round(a/grid)*grid)
when(yext!=nil xy=list(car(x) yext))
cellss=if(listp(cells) cells list(cells))
insts=foreach(mapcar cell cellss
lib=car(whereExistCell3(cell nil "symbol"))
when(lib
while(member(sprintf(nil "I%d" i) cv~>instances~>name) i++) nocName=sprintf(nil "I%d" i)
printf("add in %L %L\n" xy list(cell lib nocName))
inst=dbCreateInstByMasterName(cv lib cell "symbol" nocName xy rot)
termpts=getInstTermPoint(inst)
;terma=foreach(mapcar tp termpts car(tp))
; apply('mapcar 'list list(nets terma))
;printf("supposed order : %s\n" apply('strcat foreach(mapcan tp termpts list("_" car(tp)))))
netr=nets
bBox=ibBox(inst)
foreach(mapcar tp termpts name=car(tp)
cond(
(null(netr) name=car(tp))
(listp(car(netr)) name=car(assoc(car(tp) nets)))
(listp(netr) name=car(netr) netr=cdr(netr))
)
printf("labelAtPt%L\n" list(list(name cadr(tp)) bBox))
labelAtPt(list(name cadr(tp)) bBox 0.1 cv)
)
;inst=css()
box=inst~>bBox
printf("cadar %L_%L_\n" cadadr(box) cadar(box))
yup=cadadr(box)-cadar(box)
yup=round(yup/grid)*grid
xy=list(car(xy)+xup cadr(xy)+yup)
) inst)))

; addCells("XOR2X1")
; addCells("XOR2X1" nil nil)

defun(labelAtPt (termpt bBox @optional (dx 0.1)(cv geGetWindowCellView())(font "euroStyle")) let((os x y orient wid label point)
;(setq font "euroStyle")
label=car(termpt) point=cadr(termpt)
os=angleBox(point bBox)
;os=angleSection(rodSubPoints(point centerBox(bBox)))
;printf("%L %L os=%L\n" label point os)
x=car(point) y=cadr(point)
cond((os==0 y=y-dx)(os==1 x=x+dx)(os==2 y=y+dx)(os==3 x=x-dx))
orient=sprintf(nil "R%d" mod(90*(os+1) 360))
wid=schCreateWire( cv "draw" "direct" list(point x:y) 0.0625 0.0625 0  ); <== creat wire line
schCreateWireLabel(cv car(wid) point label "lowerRight" orient font 0.0625 nil)
))

;; inst=css()
;; tps=getInstTermPoint(inst) ;; tp=car(tps)
;; symselbox=car(setof(x inst~>master~>shapes x~>layerName=="instance" && x~>objType=="rect")~>bBox)
;; bBox=dbTransformBBox(symselbox inst~>transform)
;; ;!= inst~>bBox why ?
;; foreach(mapcar tp tps labelAtPt(tp bBox))





(setq cell "XOR2X2")
(setq ios '("B1" "A1" "Q1"))
(setq xy 0:0)
(setq cv geGetWindowCellView())

defun(addCellg (@optional (g getPropList())(xyg 0:0) (cv geGetWindowCellView()) (rot css()~>orient)(fixg nil))
unless(rot rot="R0")
when(listp(g) 
addCellw(car(g) cadr(g) xyg cv 0.1 rot caddr(g) nil fixg)
))

defun(addCellw (@optional (cell "XOR2X2")(ios '("B1" "A1" "Q1"))(xyg 0:0)(cv geGetWindowCellView())(dx 0.1)(rot "R0")(pp nil)(verb nil)(fixg t))
(let (i grid io xy inst lib inst box yup gtp os nocName tmp)
i=0  ;rot="R0" 
grid=schGetEnv("symSnapSpacing")
io=ios
when(verb printf("In %L\n" list(cv~>cellName cell)))
xy=if(fixg foreach(mapcar a xyg round(a/grid)*grid) xyg)
lib=car(whereExistCell3(cell nil "symbol"))
if(lib then
while(member(sprintf(nil "I%d" i) cv~>instances~>name) i++) 
nocName=sprintf(nil "I%d" i)
when(verb printf("add @%L %L\n" xy list(cv cell lib nocName)))
;inst=dbCreateInstByMasterName(cv lib cell "symbol" nocName xy rot)
if(pp
inst=dbCreateParamInstByMasterName(cv lib cell "symbol" nocName xy rot 1 pp)
inst=dbCreateInstByMasterName(cv lib cell "symbol" nocName xy rot 1)
)
gtp=getInstTermPoint(inst)
cond(
(io==t io=foreach(mapcar g gtp car(g)))
(type(io)=='string io=foreach(mapcar g gtp sprintf(nil "%s_%s" io car(g))))
)
;tp=cadr(gtp)
foreach(tp gtp
cond(
(car(io)==t  ;os=angleSection(rodSubPoints(cadr(tp) centerBox(ibBox(inst))))
os=angleBox(cadr(tp) ibBox(inst))
tmp=tp addCellw("noConn" nil cadr(tp) cv dx sprintf(nil "R%d" os*90)) tp=tmp io=cdr(io))
(car(io)==nil t);skip when less ionames
(t labelAtPt(list(car(io) cadr(tp)) ibBox(inst) dx cv) io=cdr(io))
); printf("tp%L from %L\n" tp gtp)
) when(verb printf("Reminder choice for %s ios :%L\n" cell mapcar('car gtp)))
inst
else printf("%s NOT FOUND\n" cell) nil)))

;  addCellw()
;; addCellw("INVX1" '("AA" t) 0:-1)
;; addCellw("DFX1" '("AA" "Qnn" "Qq" "DD") 0:-1.1)
;; addCellw("DFX1" '("AA" t t "DD") 0:-1.4)
;; addCellw("DFX1" '("AA" t t "DD") 0:-1.8)
;; line='("DFX1" ("AA" t t "DD") (0 -1.8))
;; apply('addCellw line);oki !


;; libList='("analogLib" "CORELIB")
;; dds=setof(dd ddGetLibList() member(dd~>name libList))
;; assocLib=foreach(mapcan d dds foreach(mapcan c d~>cells list(list(d~>name c~>name))))
;or assocLib=foreach(mapcan d ddGetLibList() foreach(mapcan c d~>cells list(list(c~>name d~>name))))
;; assocLib should be define before using addCellw1

defun(addCellw1 (@optional (cell "XOR2X2")(ios '("B1" "A1" "Q1"))(xyg 0:0)(cv geGetWindowCellView())(dx 0.1)(rot "R0")(pp nil))
(let (i grid io xy inst lib inst box yup gtp os nocName tmp)
i=0  ;rot="R0" 
unless(assocLib assocLib=foreach(mapcan d ddGetLibList() foreach(mapcan c d~>cells list(list(c~>name d~>name)))))
grid=0.0625;schGetEnv("symSnapSpacing")
io=ios
xy=foreach(mapcar a xyg round(a/grid)*grid)
lib=cadr(assoc(cell assocLib))
when(lib
while(member(sprintf(nil "I%d" i) cv~>instances~>name) i++) nocName=sprintf(nil "I%d" i)
if(pp
inst=dbCreateParamInstByMasterName(cv lib cell "symbol" nocName xy rot 1 pp)
inst=dbCreateInstByMasterName(cv lib cell "symbol" nocName xy rot 1)
)
gtp=getInstTermPoint(inst)
cond(
(io==t io=foreach(mapcar g gtp car(g)))
(type(io)=='string io=foreach(mapcar g gtp sprintf(nil "%s_%s" io car(g))))
)
foreach(tp gtp
cond(
(car(io)==t os=angleBox(cadr(tp) ibBox(inst))
tmp=tp addCellw("noConn" nil cadr(tp) cv dx sprintf(nil "R%d" os*90)) tp=tmp io=cdr(io))
(car(io)==nil t);skip when less ionames
(t labelAtPt(list(car(io) cadr(tp)) ibBox(inst) dx cv) io=cdr(io))
); printf("tp%L from %L\n" tp gtp)
) when(verb printf("Reminder choice for %s ios :%L\n" cell mapcar('car gtp)))
inst
)))


defun(addCellw2 (@optional (netline '(("DFX1" ("AA" t t "DD")) ("vdc") ("switch" nil))) (xyg 0:0)(cv geGetWindowCellView())(dxl 0.1)(rot "R0")(verb nil)(dx 0.4))
let((xy yup yupm x0 inst box xup)
yup=0 yupm=0
xy=xyg
foreach(line netline 
printf("xy=%L\n" xy)
x0=car(xy) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;; dx pour emplacement du label
inst=addCellw(car(line) cadr(line)  xy cv dxl nth(3 line)||"R0" caddr(line) verb)
box=mbBox(inst);box=inst~>bBox
yup=cadadr(box)-cadar(box)
xup=caadr(box)-caar(box)
;yupm=max(yupm ceiling(yup/grid)*grid)
yupm=max(yupm round(yup/grid)*grid)
xy=list(car(xy)+xup+dx cadr(xy))
)
xy=list(x0 cadr(xy)+yupm);+dy
when(cv!=geGetWindowCellView() geOpen(?lib cv~>libName ?cell cv~>cellName ?view "schematic"))
dbCheck(cv)  dbSave(cv); dbClose(cv)
list(cv xy)
))

;; addCellw2('(("DFX1" ("AA" t t "DD")) ("vdc") ("switch" ("O" "i" "a"))))
;; addCellw2('(("DFX1" ("AA" t t "DD")) ("vdc") ("switch" "AA")))
;; addCellw2('(("DFX1" ("AA" t t "DD")) ("vdc") ("switch" t)))


;; assocLib=foreach(mapcan d ddGetLibList() foreach(mapcan c d~>cells list(list(c~>name d~>name))))
;; cadr(assoc("DFX1" assocLib));=>"CORELIB"

;; libList='("analogLib" "CORELIB")
;; dds=setof(dd ddGetLibList() member(dd~>name libList))
;; assocLib=foreach(mapcan d dds foreach(mapcan c d~>cells list(list(c~>name d~>name))))



defun(addCellw3 (@optional (netlines '((("vdc" ("gnd!" "vdd!")))(("DFX1" ("AA" t t "DD")) ("vdc") ("switch" nil)))) (xyg 0:0)(cv geGetWindowCellView())(dxl 0.1)(rot "R0")(verb nil)(dx 0.4)(dy 0.0))
let((xy yup yupm x0 inst box xup)
xy=xyg x0=car(xy)
foreach(netline netlines yup=0 yupm=0
foreach(line netline 
inst=addCellw1(car(line) cadr(line) xy cv dxl nth(3 line)||"R0" caddr(line))
box=mbBox(inst);box=inst~>bBox
yup=cadadr(box)-cadar(box)
xup=caadr(box)-caar(box)
;yupm=max(yupm ceiling(yup/grid)*grid)
yupm=max(yupm round(yup/grid)*grid)
xy=list(car(xy)+xup+dx cadr(xy))
)
xy=list(x0 cadr(xy)+yupm+dy)
)
when(cv!=geGetWindowCellView() geOpen(?lib cv~>libName ?cell cv~>cellName ?view "schematic"))
dbCheck(cv)  dbSave(cv); dbClose(cv)
list(cv xy)
))

;addCellw3()




