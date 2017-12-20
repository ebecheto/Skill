; load("CntUcnt.il")
load("padRing.proc.il")
; define bBoxWidth getInstTermPoint bBoxHeight
;; grid = leDisplayOptionsForm->spacing->value
;; grid = leDisplayOptionsForm->xSnap->value
grid=0.0325
; float( round( xcrd/PGtextGrid ) )*PGtextGrid

libname="LARZIC"
cellname="cntucnt"
; (setq lay "layout")
(setq lay "symbol")
norient=0
rot=sprintf(nil "R%d" 90*norient)
Xscale=2
Yscale=1

unless( ddGetObj(libname) error("Couldn't open library %L. Please open any new layout.\n" libname)  )
cv=dbOpenCellViewByType( libname cellname "schematic" "schematic" "w")

; Ai='NAND20(NADN20(CNT Qi-1) NAND40(INV0(CNT) Qi-1 Qi Qi+1))
; Ai='NAND20(NADN20(CNT 'Qi-1) NAND40(INV0(CNT) 'Qi-1 Qi 'Qi+1)) ;=> - et + transforme l'element en liste quote ne suffit pas
Ai='NAND20(NAND20("CNT" "Qi-1") NAND40(INV0("CNT") "Qi-1" "Qi" "Qi+1")); string ou bien interdire les + et -
; Try a recursion loop
; foreach(mapcar a Ai printf(""))


(defun parseCombi (list)
(cond
((null list) list)   ;=> nothing in the list anymore = stop condition
((null (car list)) (parseCombi (cdr list)))     ;=> first element is nil => ignore it and go further
((atom (car list)) 
printf("Atom type : %s_:%L\n" type(car(list)) list)
(cons (car list) 
; when first element is single process it (cons) and go further is returned
(parseCombi (cdr list))))
(t                 
printf("Treats type:%s car=> %L \n" type(car(list)) car(list))
printf("Treats typecadr:%s cdr=> %L\n"  type(car(cdr(list))) cdr(list))
(append ; else append head and tail with the function itself recursing 
(parseCombi (car list))
(parseCombi (cdr list))
));t last appended
))
parseCombi(Ai)


inst=(dbOpenCellViewByType "CORELIB" "NAND20" lay)
X=0 Y=0
iSch=(dbCreateInst cv inst nil X:Y rot)
; assoc("A" getInstTermPoint()) ;=> ("A" (0.0 0.125))
; ptA=cadr(assoc("A" getInstTermPoint()))
; X=X+Xs*bBoxWidth(inst~>bBox)
; rodAddPoints
; xsLabel=0.0625
xsLabel=0.1

iSchP=iSch;instance parente
; on veux connecter NAND20 a l'instance parente de pin A
pList='((("NAND20" "A") "CNT" "Qi-1")(("NAND40" "B") "CNTb" "Qi-1" "Qi" "Qi+1"))
ySum=0 yMin=bBoxHeight(inst~>bBox)
xMax=0 
foreach(p pList cell=caar(p) inst=(dbOpenCellViewByType "CORELIB" cell lay) 
YW=bBoxHeight(inst~>bBox) ySum=ySum+YW when(YW<yMin yMin=YW)
XW=bBoxWidth(inst~>bBox) when(XW>xMax xMax=XW))
yMean=(ySum+Yscale*yMin*length(pList))/2
Xs0=xMax*Xscale
Ys0=yMean
first=t
X0=X Y0=Y
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
schPin = dbOpenCellViewByType("basic" "iopin"  "symbol")
pxStep=0.2

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
(defun parseCombi (lis @optional (args nil))
(cond
((null lis) lis)   ;=> nothing in the list anymore = stop condition
((null (car lis)) (parseCombi (cdr lis) args))     ;=> first element is nil => ignore it and go further
((atom (car lis)) ; le permier element n'est pas une liste=> symbol ou string (stdCell ou IO)
printf("Atom type : %s_:%L\n" type(car(lis)) lis)
parent=car(args)
(cond 
(type(car(lis))=='symbol cell=symbolToString(car(lis)) inst=(dbOpenCellViewByType libStd cell lay)
terms=setof( term inst~>terminals term~>direction=="input")
unless(terms printf("NO input terminals in %s %s?!\n" libStd cell))
iSch=(dbCreateInst cv inst nil X:Y rot);=> instance posé sur le schematic
X=X-1
args=append(list(cons(iSch reverse(terms~>name))) args)
printf("stdCell:%L =>cell %s .ARGS:%L\n" car(lis) cell args)
);end type symbol
(type(car(lis))=='string 
printf("IO::%L => insert pin.ARGS:%L\n" car(lis) args)
printf("PARENT::%L\n" parent)
when(parent 
if(pinName=cadr(parent) then
XY=cadr(assoc(pinName getInstTermPoint(car(parent))))
; nbIns=length(setof( term css()~>master~>terminals term~>direction=="input"))
nbIns=length(setof( term car(parent)~>master~>terminals term~>direction=="input"))
nbIn=nbIns-length(cdr(parent))
XYp=rodAddPoints(XY -pxStep:-hPin*nbIn)
printf("Position:%L %L\n" XY XYp)
schCreateWire(cv "route" "full" list(XY XYp)  0.0625 0.0625 0.0125)
XY=XYp
else XY=car(parent)~>xy printf("No pins left?=> taking parent~>xy=%L\n"))
when(pinName pinId=schCreatePin( cv schPin car(lis) "inputOutput" nil XY rot))
;; consomme un terminal => a plus
printf("%d %d\n" nbIns nbIn)
args=append(list(cons(car(parent) cddr(parent))) cdr(args))
)
);end type string
(t printf("what that ?%L. List:go further\n" lis))
) parent=nil
(cons (car lis) 
; when first element is single process it (cons) and go further is returned
(parseCombi (cdr lis) args)))
(t                 
printf("Treats type:%s car=> %L \n" type(car(lis)) car(lis))
printf("Treats typecadr:%s cdr=> %L\n"  type(car(cdr(lis))) cdr(lis))
(append ; else append head and tail with the function itself recursing 
(parseCombi (car lis) args)
(parseCombi (cdr lis) args)
));t last appended
))
parseCombi(Ai)

; geOpen(?lib libname ?cell cellname ?view "schematic" ?mode "r")
