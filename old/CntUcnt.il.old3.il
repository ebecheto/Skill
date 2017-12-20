; load("CntUcnt.il")
load("padRing.proc.il")
; define bBoxWidth getInstTermPoint bBoxHeight
grid=0.0325 ; X=float(round(X/grid))*grid

libname="LARZIC"
cellname="cntucnt"
(setq lay "symbol")
norient=0
rot=sprintf(nil "R%d" 90*norient)
Xscale=2
Yscale=1

unless( ddGetObj(libname) error("Couldn't open library %L. Please open any new layout.\n" libname)  )
cv=dbOpenCellViewByType( libname cellname "schematic" "schematic" "w")

Ai='NAND20(NAND20("CNT" "Qi-1") NAND40(INV0("CNT") "Qi-1" "Qi" "Qi+1")); string ou bien interdire les + et -


inst=(dbOpenCellViewByType "CORELIB" "NAND20" lay)
X=0 Y=0
iSch=(dbCreateInst cv inst nil X:Y rot)
xsLabel=0.1
iSchP=iSch;instance parente

; on veux connecter NAND20 a l'instance parente de pin A
pList='((("NAND20" "A") "CNT" "Qi-1")(("NAND40" "B") "CNTb" "Qi-1" "Qi" "Qi+1"))
xMax=0 ySum=0 yMin=bBoxHeight(inst~>bBox)
foreach(p pList cell=caar(p) inst=(dbOpenCellViewByType "CORELIB" cell lay) 
YW=bBoxHeight(inst~>bBox) ySum=ySum+YW when(YW<yMin yMin=YW)
XW=bBoxWidth(inst~>bBox) when(XW>xMax xMax=XW))
yMean=(ySum+Yscale*yMin*length(pList))/2 Xs0=xMax*Xscale Ys0=yMean
X=X-Xs0 X=float(round(X/grid)*grid);on recule a gauche
Y=Y+Ys0 Y=float(round(Y/grid)*grid)
foreach(p pList cell=caar(p) pin=cadar(p) inPin=cdr(p);=>cell=NAND20 pin="A" inPin='(CNT Qi-1)
inst=(dbOpenCellViewByType "CORELIB" cell lay)
Y=Y-yMin*Yscale-bBoxHeight(inst~>bBox);<= pour le premier on monte de length_pList/2, puis on descend
Y=float(round(Y/grid)*grid)
printf("creating inst %s on pin %s at place %L\n" cell pin X:Y)
iSch=(dbCreateInst cv inst nil X:Y rot);=> instance posé sur le schematic
pt=cadr(assoc(pin getInstTermPoint(iSchP)))
ptQ=cadr(assoc("Q" getInstTermPoint(iSch)))
;; schCreateWire(cv "draw" "full" list(pt ptQ)  0.0625 0.0625 0.0125)
schCreateWire(cv "route" "full" list(pt ptQ)  0.0625 0.0625 0.0125)
n=0 
foreach(in inPin ;; supposons que nth(0) est une output unique. ;; css()~>master~>terminals~>direction ;=> ("output" "input" "input")
n++ pin=nth(n iSch~>master~>terminals~>name)
printf("")
pt=cadr(assoc(pin getInstTermPoint(iSch)))
printf("Creacte wireLabel %L %s\n" rodAddPoints(pt -xsLabel:0) in)
wId=car(schCreateWire(cv "draw" "full" list(pt rodAddPoints(pt -xsLabel:0) )  0.0625 0.0625 0.0125))
when(wId schCreateWireLabel(cv wId centerBox(wId~>bBox) in "centerRight" "R0" "fixed" 0.0625 nil ))
))

dbSave(cv) dbClose(cv)
; geOpen(?lib libname ?cell cellname ?view "schematic" ?mode "r")
;; css()~>master~>terminals~>name ;=> ("Q" "B" "A")
;; css()~>terminals~>name         ;=> ("A" "B" "Q")
;; sont ils toujours en sens inverse ? TOCHECK
; setof( term css()~>master~>terminals term~>direction=="input") ;=> (db:0x16fb1393 db:0x16fb1394)


hPin=0.21875; bBoxHeight(css()~>bBox);=> 0.31875  Heigth of a pin hexagon. bBoxWidth(css()~>bBox);=>0.21875
iPin = dbOpenCellViewByType("basic" "ipin"  "symbol")
oPin = dbOpenCellViewByType("basic" "opin"  "symbol")
pxStep=0.2
verb=nil


; ________________________________________________________________________________
Ai='NAND20(NAND20("CNT" "Qi-1") NAND40(INV0("CNT2") "Qi-1" "Qi" "Qi+1")); string ou bien interdire les + et -
; Try a recursion loop
; foreach(mapcar a Ai printf(""))
X=0 Y=0 args=nil
libname="LARZIC"
cellname="parseCombi"
libStd="CORELIB"
unless( ddGetObj(libname) error("Couldn't open library %L. Please open any new layout.\n" libname)  )
cv=dbOpenCellViewByType( libname cellname "schematic" "schematic" "w")
; 
(defun parseCombi (lis @optional (args nil) (row nil))
(cond
((null lis) lis)   ;=> nothing in the list anymore = stop condition
((null (car lis)) (parseCombi (cdr lis) args row))     ;=> first element is nil => ignore it and go further
((atom (car lis)) ; le permier element n'est pas une liste=> symbol ou string (stdCell ou IO)
printf("Atom type : %s_:%L\n" type(car(lis)) lis)
parent=car(args)
(cond 
(type(car(lis))=='symbol cell=symbolToString(car(lis)) inst=(dbOpenCellViewByType libStd cell lay)
printf("STD:%L =>cell %s .ARGS:%L\n" car(lis) cell args)
terms=setof( term inst~>terminals term~>direction=="input")
unless(terms printf("NO input terminals in %s %s?!\n" libStd cell))
when(row  X=car(row) Y=cadr(row) )
iSch=(dbCreateInst cv inst nil X:Y rot);=> instance posé sur le schematic

pinName=car(setof( term iSch~>master~>terminals term~>direction=="output"))~>name
XY=cadr(assoc(pinName getInstTermPoint(iSch)))


if(row then;;construction nets entre iSch et le parent s'il y a un parent
when(pinNamep=cadr(parent) 
XYp=cadr(assoc(pinNamep getInstTermPoint(car(parent))))
printf("_/--\\_WIRE entre %s-%s :%L %L\n" pinName pinNamep XY XYp)
schCreateWire(cv "route" "full" list(XY XYp)  0.0625 0.0625 0.0125)
)
else ;first element => rajout d'une pin de sortie
iout=0 while(member(sprintf(nil "OUT_%d" iout) cv~>terminals~>name) iout++)
schCreatePin( cv oPin sprintf(nil "OUT_%d" iout) "output" nil XY rot)
)
; X=X-1
args=append(list(cons(iSch reverse(terms~>name))) args)
printf("STD::%L => insert pin.ARGS:%L\n" car(lis) args)

);end type symbol
(type(car(lis))=='string 
when(verb printf("IO::%L => insert pin.ARGS:%L\n" car(lis) args))
when(verb printf("PARENT::%L\n" parent))
when(parent
if(pinName=cadr(parent) then ;s'il existe un terminal ds list args ei. "A"
XY=cadr(assoc(pinName getInstTermPoint(car(parent))))
; nbIns=length(setof( term css()~>master~>terminals term~>direction=="input"))
nbIns=length(setof( term car(parent)~>master~>terminals term~>direction=="input"))
nbIn=nbIns-length(cdr(parent))
XYp=rodAddPoints(XY -pxStep:-hPin*nbIn)
printf("Pose %s en %s :%L %L\n" car(lis) pinName XY XYp)
schCreateWire(cv "route" "full" list(XY XYp)  0.0625 0.0625 0.0125)
XY=XYp
else XY=car(parent)~>xy printf("No pins left?=> taking parent~>xy=%L\n"))
when(pinName pinId=schCreatePin( cv iPin car(lis) "input" nil XY rot))
;; consomme un terminal => a p'us
args=append(list(cons(car(parent) cddr(parent))) cdr(args))
)
);end type string

(t printf("what that ?%L. List:go further\n" lis))
) parent=nil
(cons (car lis) 
; when first element is single process it (cons) and go further is returned
(parseCombi (cdr lis) args row)))
(t  ; when lis not a car(atom) => a list => spreac element. car<->cdr or foreach loop ?!
;; printf("Treats type:%s car=> %L \n" type(car(lis)) car(lis))
;; printf("Treats typecadr:%s cdr=> %L\n"  type(car(cdr(lis))) cdr(lis))
;; (append;) ; else append head and tail with the function itself recursing 
;; (parseCombi (car lis) args row)
;; (parseCombi (cdr lis) args row)
printf("A LIST ?:%L\n" lis)
xMax=0 ySum=0 yMin=bBoxHeight(inst~>bBox)
foreach(branch lis 
unless(atom(branch)
cell=symbolToString(car(branch))
when(verb printf("minMax %L %s %s XY=%L\n" branch cell libStd X:Y))
inst=(dbOpenCellViewByType libStd cell lay) 
YW=bBoxHeight(inst~>bBox) ySum=ySum+YW when(YW<yMin yMin=YW)
XW=bBoxWidth(inst~>bBox) when(XW>xMax xMax=XW)));end foreach calculate XY steps && end not atom
yMean=(ySum+Yscale*yMin*length(lis))/2 ; pour le premier on est monte de length_pList/2
Xs0=xMax*Xscale Ys0=yMean
X=X-Xs0 X=float(round(X/grid)*grid);on recule a gauche
Y=Y+Ys0 Y=float(round(Y/grid)*grid)
row=0
foreach(mapcar branch lis ; ie branch = 
when(and(args  row!=0 );le premier element est le symbol de la STDcell=> pas de chgment d'args
when(t verb printf("***%d>Treats args %L type(branch)=%s\n" row args  type(branch)))
parent=car(args); le parent est le premier de la liste des arguments
when(t verb printf("%L nthcdr(%d '%L) = %L\n" branch row parent nthcdr(2 parent)))
args=append(list(cons(car(parent) nthcdr(2 parent)||cdr(parent) )) cdr(args))
) row++
if(atom(branch) then ; si c'est une pin : "Qin" et non une liste (INV0 "Qq") Remark:branch args too
(parseCombi list(branch) args X:Y)
else ; not an atom => a list . Si le premier element est un symbol=> on mets a jour Y
when(type(car(branch))=='symbol cell=symbolToString(car(branch)) inst=(dbOpenCellViewByType libStd cell lay)
Y=Y-yMin*Yscale-bBoxHeight(inst~>bBox);<= pour le premier on est monte de length_pList/2, maintenant on descend
Y=float(round(Y/grid)*grid)
)
(parseCombi branch args X:Y)
); fin IO ou STD
;printf("`-->Branch %L args:%L row(%d):%L\n" branch args row X:Y)
);end foreach branch
);t last appended
))

printf("____________________%L_____________________\n" Ai)
parseCombi(Ai)

; geOpen(?lib libname ?cell cellname ?view "schematic" ?mode "r")

;; Branch (NAND20 "CNT" "Qi-1") args:((db:0x17258292 "A" "B")) row:(-1.7225 0.0325)
;; Branch (NAND40 (INV0 "CNT2") "Qi-1" "Qi" "Qi+1") args:((db:0x17258292 "A" "B")) row:(-3.315 -0.455)

;; Branch (INV0 "CNT2") args:((db:0x17258297 "A" "B" "C" "D") (db:0x17258292 "A" "B")) row(0):(-3.315 -0.455)
;; Branch "Qi-1" args:((db:0x17258297 "A" "B" "C" "D") (db:0x17258292 "A" "B")) row(1):(-3.315 -0.455)
;; Branch "Qi" args:((db:0x17258297 "B" "C" "D") (db:0x17258292 "A" "B")) row(2):(-3.315 -0.455)
;; Branch "Qi+1" args:((db:0x17258297 "D") (db:0x17258292 "A" "B")) row(3):(-3.315 -0.455)
