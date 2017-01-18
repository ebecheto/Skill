;; copyleft ebecheto
;; buggy code, just for the sake of an axample to generate code from string
;; does not handle multiple output of a signle instance ...


; load("CntUcnt.il")
when(or( !fboundp('bBoxWidth) !fboundp('bBoxHeight) !fboundp('getInstTermPoint) ) load("padRing.proc.il") )
; define bBoxWidth getInstTermPoint bBoxHeight

(defun parseCombi (lis @optional (args nil) (row nil)(verb t)) let((parent terms iSch pinName XY XYp pinNamep)
;(parent terms pinName pinNamep iSch XY XYp iout nbIns nbIn X Y inst yMin xMax YW XW yMean Xs0 Ys0 nrow branch)
(cond
((null lis) lis)   ;=> nothing in the list anymore = stop condition
((null (car lis)) (parseCombi (cdr lis) args row))     ;=> first element is nil => ignore it and go further
((atom (car lis)) ; le permier element n'est pas une liste=> symbol ou string (stdCell ou IO)
when(verb printf("Atom type : %s_:%L\n" type(car(lis)) lis))
parent=car(args)
(cond 
(type(car(lis))=='symbol cell=symbolToString(car(lis)) inst=(dbOpenCellViewByType libStd cell lay)
when(verb printf("STD:%L =>cell %s .ARGS:%L\n" car(lis) cell args))
terms=setof( term inst~>terminals term~>direction=="input")
unless(terms printf("NO input terminals in %s %s?!\n" libStd cell))
when(row  X=car(row) Y=cadr(row) )
iSch=(dbCreateInst cv inst nil X:Y rot);=> instance posé sur le schematic
when(verb printf("INSERT %s %s in %L FROM %L args:%L\n" iSch~>name iSch~>cellName X:Y lis args))
pinName=car(setof( term iSch~>master~>terminals term~>direction=="output"))~>name
XY=cadr(assoc(pinName getInstTermPoint(iSch)))
if(args then;;construction nets entre iSch et le parent s'il y a un parent
when(pinNamep=cadr(parent) 
XYp=cadr(assoc(pinNamep getInstTermPoint(car(parent))))
when(verb printf("_/--\\_WIRE entre %s-%s :%L %L\n" pinName pinNamep XY XYp))
schCreateWire(cv "route" "full" list(XY XYp)  0.0625 0.0625 0.0125)
)
else ;first element => rajout d'une pin de sortie
iout=1 while(member(sprintf(nil "OUT_%d" iout) cv~>terminals~>name) iout++)
schCreatePin( cv oPin sprintf(nil "OUT_%d" iout) "output" nil XY rot)
)
; X=X-1
args=append(list(cons(iSch reverse(terms~>name))) args)
when(verb printf("STD::%L => insert pin.ARGS:%L\n" car(lis) args))
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
when(verb printf("Pose pin:%s en %s :%L %L\n" car(lis) pinName XY XYp))
wId=car(schCreateWire(cv "route" "full" list(XY XYp)  0.0625 0.0625 0.0125))
XY=XYp
else XY=car(parent)~>xy printf("No pins left?=> taking parent~>xy=%L\n"))
when(pinName
if(member(car(lis) cv~>terminals~>name)||member("!" last(parseString(car(lis) ""))) then
; si la pin est deja posé on mets un label plutot
; ou bien si le nom est global : ! => label
when(verb printf("%s pin %s allready exists in %L.wId%L\n" pinName car(lis) cv~>terminals~>name wId~>??))
;when(wId schCreateWireLabel(cv wId car(last(wId~>points)) car(lis) "lowerRight" "R0" "fixed" 0.0625 nil )) else
when(wId schCreateWireLabel(cv wId XY car(lis) "centerRight" "R0" "fixed" 0.0625 nil )) else
when(verb printf("%s pin %s do not exists in cvTerms:%L\n" pinName car(lis) cv~>terminals~>name))
pinId=schCreatePin( cv iPin car(lis) "input" nil XYp rot))
)
;; consomme un terminal => a p'us
when(verb printf("Removes elment %L form %L car(parent)=%L\n" cadr(parent) args car(parent)))
args=append(list(cons(car(parent) cddr(parent))) cdr(args))
)
);end type string
(t when(verb printf("what that ?%L. No symbol no string: 'list?:go further\n" lis)))
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
when(verb printf("A LIST ?:%L\n" lis))
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
nrow=0
foreach(mapcar branch lis ; ie branch = 
when(and(args  nrow!=0 );le premier element est le symbol de la STDcell=> pas de chgment d'args
when(verb printf("***%d>Treats args %L type(branch)=%s\n" nrow args  type(branch)))
parent=car(args); le parent est le premier de la liste des arguments
when(verb printf("%L nthcdr(%d '%L) = %L\n" branch nrow parent nthcdr(2 parent)))
args=append(list(cons(car(parent) nthcdr(2 parent)||cdr(parent) )) cdr(args))
) nrow++
if(atom(branch) then ; si c'est une pin : "Qin" et non une liste (INV0 "Qq") Remark:branch args too
(parseCombi list(branch) args X:Y)
else ; not an atom => a list . Si le premier element est un symbol=> on mets a jour Y
when(type(car(branch))=='symbol cell=symbolToString(car(branch)) inst=(dbOpenCellViewByType libStd cell lay)
Y=Y-yMin*Yscale-bBoxHeight(inst~>bBox);<= pour le premier on est monte de length_pList/2, maintenant on descend
Y=float(round(Y/grid)*grid)
)
(parseCombi branch args X:Y)
); fin IO ou STD
;printf("`-->Branch %L args:%L row(%d):%L\n" branch args nrow X:Y)
);end foreach branch
);t last appended
) dbSave(cv) dbCheck(cv)  ;dbClose(cv)
lis;<= last element returned => for cons return
))




defun( combiToSch ( @optional (Ai nil) (cellname "parseCombi") (libname "LARZIC") (libStd "CORELIB") (split t) (ystep 0.48) )
unless(Ai Ai='NAND20(NAND20("CNT" "Qi-1") NAND40(INV0("CNT2") "Qi-1" "Qi" "Qi+1")))
grid=0.0325 ; X=float(round(X/grid))*grid
(setq lay "symbol")
norient=0
rot=sprintf(nil "R%d" 90*norient)
Xscale=2
Yscale=1
hPin=0.109375;=0.21875/2; bBoxHeight(css()~>bBox);=> 0.31875  Heigth of a pin hexagon. bBoxWidth(css()~>bBox);=>0.21875
iPin = dbOpenCellViewByType("basic" "ipin"  "symbol")
oPin = dbOpenCellViewByType("basic" "opin"  "symbol")
pxStep=0.2
verb=nil
X=0 Y=0 args=nil
unless( ddGetObj(libname) error("Couldn't open library %L. Please open any new layout.\n" libname)  )
cv=dbOpenCellViewByType( libname cellname "schematic" "schematic" "w")
; 
printf("____________________%L_____________________\n" Ai)
printf("Creating %s %s\n" cellname libname )
if(split then
if(apply('and foreach(mapcar a Ai listp(a)));;si tous les elements du premier niveau sont des lists, on split les listes et on adapte XY
then
foreach(mapcar a Ai
printf("parsing %L in XY=%L of %L\n" a X:Y Ai)
parseCombi(a)
X=caadr(cv~>bBox)-0.84; -0.1 pour un leger ajustement en retrait de bBox 
Y=cadar(cv~>bBox)-ystep; pour etre mieux ajuster, il faudrait soustraire le X0 Y0 de l'origine de la premiere instance.. 
)
else
parseCombi(Ai))
else
parseCombi(Ai)
)
if(apply('or foreach(mapcar win hiGetWindowList() win~>cellView~>cellName==cell)) then printf("%s already opened\n" cell) else 
printf("Opening %s\n" cellname) geOpen(?lib libname ?cell cellname ?view "schematic" ?mode "r")))

; combiToSch()

;; cel="Ai_2"
;; combiToSch(Ai cel)
;; geOpen(?lib "LARZIC" ?cell cel ?view "schematic" ?mode "r")

;; printf("____________________%L_____________________\n" Ai)
;; parseCombi(Ai)

; for(i 1 20  printf("Ai='NAND20(NAND20(\"CNT\" \"Q%d\") NAND40(INV0(\"CNT\") \"Q%d\" \"Q%d\" \"Q%d\"))\n" i-1 i-1 i i+1) )

A40=foreach(mapcar i linRg(1 40 1)  
printf("Ai='NAND20(NAND20(\"CNT\" \"Q%d\") NAND40(INV0(\"CNT\") \"Q%d\" \"Q%d\" \"Q%d\"))\n" i-1 i-1 i i+1) 
; setq(Ai 'NAND20(NAND20("CNT" sprintf(nil  "Q%d" i-1)) NAND40(INV0("CNT") sprintf("Q%d" i-1) sprintf(nil "Q%d" i) sprintf(nil "Q%d" i+1))) )
setq(Ai evalstring(sprintf(nil "'NAND20(NAND20(\"CNT\" \"Q%d\") NAND40(INV0(\"CNT\") \"Q%d\" \"Q%d\" \"Q%d\"))\n" i-1 i-1 i i+1) ))
)


; geOpen(?lib "LARZIC" ?cell "parseCombi" ?view "schematic" ?mode "r")


; A2='((NAND20 (NAND20 "CNT" "Q0") (NAND40 (INV0 "CNT") "Q0" "Q1" "Q2")) (NAND20 (NAND20 "CNT" "Q1") (NAND40 (INV0 "CNT") "Q1" "Q2" "Q3")))
; parseCombi(A2) ;=>OK 

; libname="LARZIC"
libname=car(sort(setof(lib ddGetLibList() lib~>isWritable)~>name nil))

;; cel="A40"
;; combiToSch(A40 cel)

;; A3='INV0(NOR20("reset" DF1(NAND20(NAND20("CNT" "Qi-1") NAND40(INV0("CNT") "Qi-1" "Qi" "Qi+1")) "clk" )))
;; cel="A3"
;; combiToSch(A3 cel)

;; combi='INV0(NAND20(INV0("reset!") DF1(NAND20(NAND20("CNT!" "Qi-1") NAND40(INV0("CNT!") "Qi-1" "Qi" "Qi+1")) "clk!" )))
;; cel="ARST1"
;; combiToSch(combi cel libname)

printf("Erreur dans le code : Regarder la sortie de la bascule D!\n")
printf("A2='%L\n" '((NAND20 (NAND20 "CNT" "Q0") (NAND40 (INV0 "CNT") "Q0" "Q1" "Q2")) (NAND20 (NAND20 "CNT" "Q1") (NAND40 (INV0 "CNT") "Q1" "Q2" "Q3"))))
printf("combi='INV0(NAND20(INV0(\"reset!\") DF1(NAND20(NAND20(\"CNT!\" \"Qi-1\") NAND40(INV0(\"CNT!\") \"Qi-1\" \"Qi\" \"Qi+1\")) \"clk!\" )))\n")
printf("combiToSch(combi %L %L)\n" "newCellName" "LARZIC")
printf("combi='NOR20(NOR20(\"IN\" \"OUT_0\" ) \"RC\")\n")
printf("combiToSch(combi %L %L)\n" "newCellName" "LARZIC")

;; printf("combi='INVERT_A(NAND2_A(INVERT_A(\"reset!\") DFF_E(NAND2_A(NAND2_A(\"CNT!\" \"Qi-1\") NAND4_A(INVERT_A(\"CNT!\") \"Qi-1\" \"Qi\" \"Qi+1\")) \"clk!\" )))\n")
;; combiToSch(combi "newCellName" "PRACTIC_32" "cmos8rf")
