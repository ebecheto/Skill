;; copyleft : ebecheto

ineed('io2dir)

defun( terminalGen (@optional (pinName t) (N2 20) (N1 1) (io t) (Ys t) (lbl t) (bus nil) (cv t)(XY nil)(Xs t)) let((dir aPin XY label labels grid) ; pinId
printf("generate %L\n" list(pinName N1 N2 io))
when(cv=='t cv=geGetWindowCellView()) grid=0.0625
when(pinName=='t pinName="OUT")
when(listp(pinName) labels=pinName)
when(Ys=='t Ys=0.125)
when(Xs=='t Xs=0.125*3)
when(not(listp(io)) dirs=list(io2dir(io)) printf("io:%L pas une list=> %L\n" io dirs)) ;inputoutput default
when(listp(io) dirs=foreach(mapcar d io io2dir(d)))
unless(XY XY=car(cv~>bBox))
XY=foreach(mapcar xy XY round(xy/grid)*grid)
XY=mapcar('plus XY cons(0 list(Ys)))
XY=mapcar('plus XY append(list(-Xs) list(0)))
; aPin = dbOpenCellViewByType("basic" io  "symbol")
unless(listp(labels) for(N N1 N2
label=if(!bus sprintf(nil "%s_%d" pinName N) sprintf(nil "%s<%d>" pinName N))
labels=append(labels list(label))))
na=length(labels)
ni=length(dirs)
cond(
(na>=ni printf("%L\n" dirs) for(n ni na-1 dirs=append(dirs list(io2dir()))) printf("%d>=%d =>%L\n" na ni dirs))
(na<ni dirs=reverse(nthcdr(ni-na reverse(dirs))) printf("<%L\n" dirs))
)

printf("labels dirs = %L ?= %L\n"  labels dirs)
labdir=mapcar('list labels dirs);=> '((pin1 "io")(pin2 "in")...)
foreach(mapcar ld labdir ;  label labels
label=car(ld) dir=cadr(ld) aPin=apply('dbOpenCellViewByType list("basic" dir2io(dir)  "symbol"))
pinId=schCreatePin( cv aPin label dir nil XY "R0")
pinId~>children~>justify="upperLeft"   ; regle orientation pin label
text=car(setof(child pinId~>children child~>objType=="textDisplay"))
xyp=centerBox(pinId~>bBox) 
text~>xy=list(caadr(pinId~>bBox) (cadr(xyp)+cadar(pinId~>bBox))/2)
when(lbl
wid=schCreateWire( cv "draw" "direct" list(rodAddPoints(XY 0.3:0) rodAddPoints(XY 0.5:0)) 0.0625 0.0625 0)
schCreateWireLabel(cv car(wid) rodAddPoints(XY 0.4:0.1) label "centerCenter" "R0" "euroStyle" 0.0625 nil )
)
XY=mapcar('plus XY cons(0 list(Ys)))
);forloop
))


printf("terminalGen() ;=> Generate OUT_1->OUT_20 pins\n")
printf("terminalGen(\"OUT\" 40) ;=> Generate OUT_1->OUT_40 pins\n")
printf("terminalGen(\"OUT\" 80 41) ;=> Generate OUT_1->OUT_40 pins\n")
printf("terminalGen(\"tata\" 39 0 \"ipin\") ;=> Generate tata_0->tata_39 input pins\n")
printf("terminalGen(t t t 0.5) ;=> Generate OUT_1->OUT_20 pins espacees de 0.5 au lieu de 0.125\n")
printf("terminalGen(\"IN\" 32 1 nil 0.25 t t) ;=> Generate IN<1>->IN<32> pins with wire label\n")
printf("terminalGen('%L 1 1 '%L t nil nil t nil t) ;=> ok\n" '("pin1" "pin2" "pin3") '("ipin" "ipin"))
printf("terminalGen (@optional (pinName t) (N2 20) (N1 1) (io t) (Ys t) (lbl t) (bus nil) (cv t)(XY nil)(Xs t))\n")
printf("ineed('netMakeBus)")
printf("terminalGen('(\"ONE\" \"TWO\" \"THREE\") 1 1 t 0.25 )\n")
printf("terminalGen(netMakeBus(\"Q\" 5 t \"_\") 1 1 t 0.25 )\n")
printf("terminalGen(netMakeBus(\"Q\" 5 t \"_\"))\n")
printf("terminalGen(netMakeBus(\"P\" 64 t \"_\") 1 1 t 0.125)\n")
