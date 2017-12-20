/**************************************************
* Authors : Edouard BECETHOILLE               	  *
* copyleft: ebecheto  IPNL (IN2P3-CNRS / UCBL )   *
* Version : 0.3   november 2011                   *
* History :  function adaptable to other kit      *
* + change property type enable                   *
***************************************************/

;; TODO : adapt flip list to existing symbol in the cellView => shorten the foreach( flip) loop rplaca or something
;; DONE : Update Hierarchy when symbol exist ! See function : updateLibSymbol

;; load("~/Skill/mos2fet.il")
setSkillPath(cons("~/../ebecheto/Skill" getSkillPath()))
load("mos2fet.proc.il")   ;<= defines additional procedures and flipList
; load "flipTo_cmos8rf.il" ;<= defines flipList
load("flipTo_cmhv7sf.il") ;<= defines flipList


procedure(c35toc18(@optional (flip flip) (cv geGetWindowCellView()) )
let((inst A B sA sB Axy newName newLib oldProp newProp flipProp aPoint bPoint special flipPin pA pB pAB mvA mvB netName carPoint mvPoints sideWay transform orient adjust tmp tmp2 samePin doSideWay rmDouble)
sideWay='(("R0" "MY")("R90" "MYR90")("R180" "MX")("R270" "MXR90"))
sideWay=append(sideWay foreach(mapcar x sideWay list(cadr(x) car(x)))); and the way around
when(!flip load("flipTo_cmos8rf.il")) ;<= defines flipList

;; adapt flip List to only existing elements assoc List will be even better than : foreach(mapcar fp flip ..) ?
rmBouble=nil  
flip=remove(nil  foreach(mapcar f cv~>instances~>cellName ;printf("f:%L\n" f)  
unless(member(f rmBouble ) 
; printf("%L %L %L \n" f rmBouble assoc(f flip ))
rmBouble=append(rmBouble list(f)) assoc(f flip )))) 
printf("FLIP : %L\n" flip)

foreach( inst cv~>instances
; printf("\n___ Changing Instance %s %s" inst~>name inst~>cellName)
Axy=inst~>xy
; ie:fp= ("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) ("cpoly" "mimcap" "cmrf8sf" (("flipPin" (("PLUS" "D")("MINUS" "S"))))) )
;          car     cadr   caddr
foreach(mapcar fp flip
flipPin='()
when(inst~>cellName==car(fp)
newName=cadr(fp)
newLib=caddr(fp)

doSideWay=nil
;special Case Handling : AST 4th element
when(length(fp)>=4
foreach( special nth(3 fp)
when(car(special)=="flipProp" ;; <= or assoc(special) ...   ;; ie. special='("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))
foreach(flop cadr(special)    ;; foreach( toto assoc(special) ...  ) au lieu de when ie flop='("ng" "nf" "int" 'atoi)
oldProp=car(setof( oldProp   inst~>prop oldProp~>name==car(flop) ))
nPropName=cadr(flop)
if(nType=caddr(flop) t nType="string") ; prendre le type demande ou default : "string"
if(and(toApply=eval(cadddr(flop)) oldProp~>value) nValue=apply(toApply list(oldProp~>value)) nValue=oldProp~>value ) ;add &&oldProp~>value because of *Error* atoi: argument #1 should be a string (type template = "t") - nil
when(not(setof( newProp inst~>prop newProp~>name==nPropName ))&&nValue newProp=dbCreateProp(inst nPropName nType nValue)) ; because of *Error* dbCreateProp: Invalid integer - nil
newProp~>value=nValue        ; printf("PROP: %s=%L %s=%L\n" oldProp~>name nValue newProp~>name newProp~>value)
));special Case flipProp
when(car(special)=="flipPin" flipPin=cadr(special) );;special Case flipPin (initiate flipPinList)
when(car(special)=="sideWays" doSideWay=t );;special Case sideWays
));special Case Handling

;; A=old B=new
A=dbOpenCellViewByType(inst~>libName inst~>cellName "symbol")
when(not(B=dbOpenCellViewByType(       newLib        newName "symbol")) printf("\ndbOpenCellViewByType(%L %L %L)"       newLib      newName "symbol")
printf("\n*** Please add the library of %s to your cds.lib Try somesing like \nDEFINE %s /data/kit/techno/%s\n" newName newLib newLib) )

; #### move nets of pins location modification
sA=sort(A~>terminals~>name nil)
sB=sort(B~>terminals~>name nil)
when(sA==sB flipPin=foreach(mapcar x sA append(flipPin list(x x))));==> when all pin name match

tmp='()
foreach( x sA when(member(x sB) tmp=tconc(tmp x))) tmp=car(tmp);==> get similar names
;; printf("\n*** Plea\n")
foreach( x tmp when(not(apply('or foreach(mapcar z flipPin cadr(z)==x))) flipPin=append(flipPin list(list(x x)) )))
;append only if samePin not present in second member of flipPin


when(flipPin ; case handling for fliping pins
; printf("FLIPPING  %s-%s %L TOFLIP\n" inst~>baseName inst~>cellName flipPin)
foreach( pAB flipPin
pA=car(pAB); ie. pin name "PLUS" old One
pB=cadr(pAB) ; ie. pin name "D" new One
; printf("dbTransformPoint(%L %L)\n" getMasterTermPoint(A pA) inst~>transform)
mvA=dbTransformPoint(getMasterTermPoint(A pA) inst~>transform)
transform=inst~>transform
orient=inst~>orient
when(doSideWay ; subcase for sideways
foreach(x sideWay when(inst~>orient==car(x) orient=cadr(x)))
transform=list(inst~>xy orient inst~>mag)
)
; printf("B:%L\n" B~>??)
; printf("dbTransformPoint('%L '%L)\n" getMasterTermPoint(B pB) transform)
mvB=dbTransformPoint(getMasterTermPoint(B pB) transform)

when(not(netName=getInstNetName(inst pA) );get net name connected to inst "S" ie. => "net079"
printf("\nPLEASE CHECK AND SAVE first %L !\n" B~>?? ))
when(mvA!=mvB
foreach(mapcar net cv~>nets
when(netName||net~>name==netName||net~>name==strcat(netName "!")
isBetweenPoints(mvB netName cv); change to 'flight lines' a possible crossing net when netNames are differents
foreach(mapcar fig net~>figs
mvPoints=foreach(mapcar point fig~>points
if(point==mvA then mvB else point); move to same point => not moved
);move old point A to new point B
when(fig~>points!=mvPoints 
; printf("\n** changing %L %s form %L to %L\n" fig netName fig~>points mvPoints)
fig~>points=mvPoints)
);end check all nets  rodSubPoints('(2.96875 3.5) '(2.96875 3.5))
);pass unecessary nets
);
); postions pins are != mvA!=mvB
);end check all pins pAB to flip off selected instance   0x0fb18393
); when flipPin list is not nil

; ####CHANGE MASTER###
; inst~>master=dbOpenCellViewByType("cmrf8sf" "pfet" "symbol")
; B=dbOpenCellViewByType("cmrf8sf" "oprppres" "symbol")
inst~>master=B  ;<== ####CHANGE MASTER###
inst~>orient=orient ;<== is it useful ? to update orientation ? Yes surely
; printf("-> into  %L ___\n" inst~>cellName)

when(length(fp)>=4 foreach( special nth(3 fp) when(car(special)=="adjust"
adjust=cadr(special)
xform=list(rodSubPoints(inst~>xy dbTransformPoint(adjust inst~>transform)) "R0" 1)
schStretch(list(inst) dbConcatTransform(dbConcatTransform(list(mapcar('minus inst~>xy) "R0" 1) xform) list(inst~>xy "R0" 1)))
)));adjust => prettier view, this is just tunning, is avoided when not sepcified in the input list flip
);for allinst
);when 
) t ;end foreach instances in cellView
));;let proc
printf("c35toc18\n");

;; schStretch(list(inst) list(rodSubPoints(dbTransformPoint(rodAddPoints('(-0.0625 0.0)  inst~>xy) list('(0.0 0.0) inst~>orient inst~>mag )) inst~>xy ) "R0"))
;;fp='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf")  ("wtot" "wt")  ("ng" "nf")   )            )        ))

; c35toc18


;; oldLib="T2K_V5"
;; newLib=sprintf(nil "%s_TR" oldLib )
;; oldLib="T2K_2009"
;; cellName="Rds_noise"
;; ;cellName="ota8"

; ddCreateLib( newLib)

defun( translateLib (oldLib @optional (flip flip) newLib)
when(!newLib newLib=sprintf(nil "%s_TR" oldLib ))
printf("Creating:%s, from %s into techno:%s (<-ie. first element)\n" newLib oldLib caddar(flip)||"empty?")
ddLib=setof(lib ddGetLibList() lib~>name==oldLib) ; ddLib~>cells~>name
printf("oldLib:%L\n" list(oldLib))
when(not(setof(lib ddGetLibList() lib~>name==newLib)) printf("Creating %s, **** please do CIW->Tools->TechnologyFileManager...->Attch  TECH_youWant after! **** \n" newLib)  ddCreateLib( newLib))
foreach(mapcar cell car(ddLib~>cells)
cellName=cell~>name
printf("dbOpenCellViewByType%L\n" list(oldLib cellName "schematic" "schematic" "r"))
when(oldCV = dbOpenCellViewByType( oldLib  cellName "schematic" "schematic" "r")  ; can only copy it when a view schematic exist
; geOpen( ?lib oldLib ?cell cellName  ?view "schematic" ) ;; <== check results
printf("dbCopyCellView('%L)\n" list(oldCV newLib cellName))
newCV = dbCopyCellView( oldCV newLib  cellName "schematic" "schematic" "w")
dbClose(oldCV)
c35toc18(flip newCV)
when(newCV dbSave(newCV) dbClose(newCV) )
when(cvSym = dbOpenCellViewByType( oldLib cellName "symbol" "schematicSymbol" "r") dbCopyCellView( cvSym newLib  cellName "symbol"))
)))

defun( translateCell (oldLib cellName @optional (flip flip) newLib)
when(!newLib newLib=sprintf(nil "%s_TR" oldLib ))
printf("Creating:%s, from %s into techno:%s (<-ie. first element)\n" newLib oldLib caddar(flip)||"empty?")
printf("dbOpenCellViewByType%L\n" list(oldLib cellName "schematic" "schematic" "r"))
when(oldCV = dbOpenCellViewByType( oldLib  cellName "schematic" "schematic" "r")  ; can only copy it when a view schematic exist
printf("dbCopyCellView('%L)\n" list(oldCV newLib cellName))
newCV = dbCopyCellView( oldCV newLib  cellName "schematic" "schematic" "w")
dbClose(oldCV)
c35toc18(flip newCV)
when(newCV dbSave(newCV) dbClose(newCV) )
geOpen( ?lib newLib ?cell cellName  ?view "schematic" ) ;; <== check results
when(cvSym = dbOpenCellViewByType( oldLib cellName "symbol" "schematicSymbol" "r") 
printf("dbCopyCellView%L\n" list( cvSym newLib  cellName "symbol"))
nSim=dbCopyCellView( cvSym newLib  cellName "symbol")
)
; when(cvSym dbClose(cvSym))
when(nSim dbSave(nSim) dbClose(nSim) )
)) ; USAGE : translateCell("T2K_V5" "bias") ; <= where flip is defined in load("flipTo_cmhv7sf.il")


defun( updateLibSymbol (oldLib @optional newLib)
when(!newLib newLib=sprintf(nil "%s_TR" oldLib ))
; car(setof( inst geGetWindowCellView()~>instances inst~>libName==oldLib))~>master~>??
ddLib=setof(lib ddGetLibList() lib~>name==oldLib) ; ddLib~>cells~>name
foreach(mapcar cell car(ddLib~>cells)
; cv=geGetWindowCellView()
cellName=cell~>name
when(cv=dbOpenCellViewByType( newLib cellName "schematic" "schematic"); oppen in append mode (editable)
updateLib=setof( inst cv~>instances  inst~>libName==oldLib)
printf("Exist in %L %s" cv~>cellName newLib)
foreach(mapcar inst updateLib when(newMast=dbOpenCellViewByType(newLib inst~>cellName "symbol") inst~>master=newMast))
))) 
; USAGE : 
; updateLibSymbol("T2K_V5") 
; updateLibSymbol("T2K_V5" "T2K_V5_TR")




;; USAGE 
;  c35toc18()
;  c35toc18('(("pmos4" "pfetx"  "cmhv7sf" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf" "int" 'atoi)))))) ) ; transform only pmos4 into pfetx in current cellview
;  c35toc18('(("pmos4" "pfetx"  "cmhv7sf" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf" "int" 'atoi)))))) geGetWindowCellView())
;  c35toc18(flip dbOpenCellViewByType( "T2K_V5_TR"  "Rds_noise" "schematic" "schematic")) ; <= where flip is defined in load("flipTo_cmhv7sf.il")
;  c35toc18(flip dbOpenCellViewByType( "T2K_V5_TR"  "degent_WS_miror" "schematic" "schematic")) ; <= where flip is defined in load("flipTo_cmhv7sf.il")
;  c35toc18(flip dbOpenCellViewByType( "T2K_V5_TR"  "bias" "schematic" "schematic")) ; <= where flip is defined in load("flipTo_cmhv7sf.il")
;  c35toc18(flip dbOpenCellViewByType( "T2K_V5_TR"  "1CH_flattent_sim" "schematic" "schematic")) ; <= where flip is defined in load("flipTo_cmhv7sf.il")

; translateCell("T2K_V5" "bias") ; <= where flip is defined in load("flipTo_cmhv7sf.il")
; translateCell("T2K_V5" "GB_CPa") ; <= where flip is defined in load("flipTo_cmhv7sf.il")
; translateCell("T2K_V5" "GB_CPTa") ; <= where flip is defined in load("flipTo_cmhv7sf.il")

; translateLib("T2K_V5") ;=> will create a transformed lib : T2K_V5_TR, using declared variable : flip defined in load("flipTo_cmhv7sf.il")
; translateLib("T2K_V5" flip "TOTO" ) ;=> will create a transformed lib : TOTO , using declared variable : flip defined in load("flipTo_cmhv7sf.il")
