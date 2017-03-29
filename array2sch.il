;; copyleft ebecheto
ineed('(terminalPinsMap addCell terminal2pin) )

defun(array2sch (@optional (xline 'test)(libName nil)(cellName nil)(pinList nil)(dx 0.4)(dy 0.4)(verb nil)(open t)(aw "w")(xy '(0 0)))
(let (x y x0 patt cv inst box yup xup grid) ;xors list used only for naming cellName 
x=car(xy) y=cadr(xy)
x0=x
grid=0.0625;schGetEnv("symSnapSpacing")
when(pinList=='test pinList='(("row1a" "row1b")("row2a" "row2b")))
when(xline=='test xline='((("vdc" ("gnd!" "vdd!"))("gnd")("vdd"))(("vpwl")("idc"))) )
;; unless(libName libName="ATEST_h18")
cond(
(libName=='ibm libName="Ed_CMOS8")
;(libName=='h18 libName="ATEST_h18")
(libName=='cv libName=geGetWindowCellView()~>libName)
(libName==nil libName=geGetWindowCellView()~>libName)
)
printf("libName%L??\n" libName)
unless(cellName cellName=geGetWindowCellView()~>cellName)
unless(member(libName ddGetLibList()~>name) printf("Warning %s lib does not exist\n" libName))
unless(cellName cellName=strcat("gen_" caaar(xline)))
noteLabel=sprintf(nil "Generated @ %s by array2sch(.....)" getCurrentTime() )
printf("Creating %s %s\n "  libName cellName)
cv=dbOpenCellViewByType( libName cellName "schematic" "schematic" aw)
unless(aw=="a" schCreateNoteLabel( cv '(0 -1) noteLabel  "lowerLeft" "R0" "roman" 0.0625 "normalLabel" ))
foreach(mapcar line xline yup=0 yupm=0
foreach(mapcar xl line
when(verb printf("Treats:%L\n" xl))
inst=addCellw(car(xl) cadr(xl) xy cv 0.1 nth(3 xl)||"R0" caddr(xl));<= caddr(xl) sont les pins
box=mbBox(inst)
when(verb printf("cadar %L_%L_\n" cadadr(box) cadar(box)))
yup=cadadr(box)-cadar(box)
xup=caadr(box)-caar(box)
yupm=max(yupm round(yup/grid)*grid)
xy=list(car(xy)+xup+dx cadr(xy))
)
xy=list(x0 cadr(xy)+yupm+dy)
)
schCheck(cv) dbCheck(cv)  dbSave(cv); dbClose(cv)
cond(
(pinList==nil nil)
(listp(car(pinList)) foreach(mapcar pins pinList terminalGen(pins 1 1 t t nil nil cv)))
(listp(pinList) terminalGen(pinList 1 1 t t nil nil cv))
)
when(open geOpen(?lib libName ?cell cellName ?view "schematic"))
cv))


defun(array2sch1 (xline @optional (cv nil)(pins nil) (xy 0:0)) 
unless(cv cv=geGetWindowCellView())
unless(xy xy=cadr(cv~>bBox))
array2sch(xline cv~>libName cv~>cellName pins 0.4 0.4 nil nil "a" xy)
)

;; array2sch()
;; array2sch('test)
;; array2sch('test 'ibm "unNom" 'test 0.4 0.4 nil t "w" )

; ineed('terminal2pin)
; terminalGen('("pin1" "pin2" "pin3") 1 1 t t nil nil t nil t)
; terminalGen('("pin1" "pin2" "pin3") 1 1 t t nil nil cv)

;; cells=dllGenMotifBuDff(L)
;; pins=foreach(mapcar n linRg(0 L- 1) sprintf(nil "Q_%d" n));=>("Q_0" "Q_1" "Q_2" "Q_3" "Q_4" "Q_5" "Q_6" "Q_7")
;; cellName=sprintf(nil "dll__load_%d" L)
;; cv=array2sch(cells 'ibm cellName pins)
;; cv=array2sch(transpose(cells) 'ibm cellName pins)  ;<= c cool on peut facilement transposer la posision de l'array

;; type(geGetWindowCellView());=>dbobject
;; listp(geGetWindowCellView());=>nil


; getPropList();=> ("vpwl" ("gnd!" "net01") (("vdc" "string" "0") ("td" "string" "300p") ("t1" "string" "1n") ("t2" "string" "1.1n") ("v2" "string" "1.2")))

