;; copyleft ebecheto
/**************************************************
* Authors : Edouard BECETHOILLE               	  *
* copyleft: ebecheto  IPNL (IN2P3-CNRS / UCBL )       *
* Version : 0.4   january 2011                        *
* History :  Adding specific function to mos2fet.proc *
*     0.3 : function adaptable to other kit      *
* + change property type enable                   *
***************************************************/

;; TODO : move the cell out ouf bBox and back to xy, to force the redraw of th wire (if in route mode)
;; TODO : rename the function in : symbolSwap or something
;; TODO : scale w/l ratio for transistor when scaled down... 350n => 65n 
;; TODO : re-code alphaNum to work without sort (multi list for multy parttern name '(INV21 INV23 NOR33 INV22 ...)
;; DONE : adapt flip list to existing symbol in the cellView => shorten the foreach( flip) loop rplaca or something
;; DONE : Update Hierarchy when symbol exist ! See function : updateCellviews

;; load("~/Skill/mos2fet.il")
setSkillPath(cons("~/../ebecheto/Skill" getSkillPath()))
load("mos2fet.proc.il")   ;<= defines additional procedures and flipList
; load "flipTo_cmos8rf.il"     ;<= defines flipList amsc35->ibm130 ; 
; flip=revertFlip(flip) ;<== permet de faire ibm130->amsc35
; flip=removeInFlip(flip '("subc"))
load("flipTo_cmhv7sf.il")    ;<= defines flipList amsc35->amsh18
; loadi("flipTo_cmrf8sf_t18.il")  ;<= defines flipList ibm130->tower180

procedure(c35toc18(@optional (flip flip) (cv geGetWindowCellView()) (verb t) )
let((inst A B sA sB Axy newName newLib oldProp newProp flipProp aPoint bPoint special flipPin pA pB pAB mvA mvB netName carPoint mvPoints sideWay transform orient adjust tmp tmp2 samePin doSideWay rmDouble f instList cvNets mPoint)
sideWay='(("R0" "MY")("R90" "MYR90")("R180" "MX")("R270" "MXR90"))
sideWay=append(sideWay foreach(mapcar x sideWay list(cadr(x) car(x)))); and the way around
when(!flip load("flipTo_cmos8rf.il")) ;<= defines flipList

;; adapt flip List to only existing elements assoc List will be even better than : foreach(mapcar fp flip ..) ?
rmDouble=nil instList=nil
flip=remove(nil  foreach(mapcar cvi cv~>instances ;printf("f:%L\n" f)  
f=cvi~>cellName
when(assoc(f flip ) instList=append(instList list(cvi)	))
unless(member(f rmDouble ) ;printf("%L %L %L \n" f rmDouble assoc(f flip ))
rmDouble=append(rmDouble list(f)) assoc(f flip ))))
; printf("FLIP : %L\n" flip)
unless(instList printf("Nothing to do for %s_%s. No instances matching filpList %L\n" cv~>libName||"NoLibName?" cv~>cellName||"NoCellName?" cv~>??))

foreach(inst instList
; printf("\n___ Changing Instance %s %s from %L\n" inst~>name inst~>cellName instList~>??)
Axy=inst~>xy
; ie:fp= ("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) ("cpoly" "mimcap" "cmrf8sf" (("flipPin" (("PLUS" "D")("MINUS" "S"))))) )
;          car     cadr   caddr

; foreach(mapcar fp flip...)
flipPin='()
; when(inst~>cellName==car(fp)   ... ;)
when(fp=assoc(inst~>cellName flip)

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
newProp~>value=nValue         ;printf("PROP: %s=%L %s=%L\n" oldProp~>name||"nil ?" nValue newProp~>name||"nil?" newProp~>value||"nil??")
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
when(verb printf("FLIPPING  %s-%s %L TO %s\n" inst~>baseName inst~>cellName flipPin B~>cellName) )
foreach( pAB flipPin
pA=car(pAB); ie. pin name "PLUS" old One
pB=cadr(pAB) ; ie. pin name "D" new One
when(verb printf("dbTransformPoint(%L %L)\n" getMasterTermPoint(A pA) inst~>transform) )
when(mPoint=getMasterTermPoint(A pA)  mvA=dbTransformPoint(mPoint inst~>transform))
transform=inst~>transform
orient=inst~>orient
when(doSideWay ; subcase for sideways
foreach(x sideWay when(inst~>orient==car(x) orient=cadr(x)))
transform=list(inst~>xy orient inst~>mag)
) ;TODO later : change with rplaca or assoc

; printf("dbTransformPoint('%L '%L)\n" getMasterTermPoint(B pB) transform)
when(mPoint=getMasterTermPoint(B pB) mvB=dbTransformPoint(mPoint transform))
when(verb  printf("pB:%L_mPoint:%L\n" pB mPoint) )

; printf("%L%LmvA=%L...mvB=%L\t" pA pB mvA mvB)
when(and(mvA!=mvB netName=getInstNetName(inst pA)) ;get net name connected to inst "S" ie. => "net079"
; printf("%L...%L\n" netName cv~>nets~>name )
;; cvNets=setof(net cv~>nets or(net~>name==netName net~>name==strcat(netName "!"))); DANGER some nets could be called :"<*2>GND"
cvNets=setof(net cv~>nets rexMatchp(net~>name netName )); DANGER some netName could be called :"<*2>GND" where net~>name = GND
foreach( net cvNets 
when(mvB isBetweenPoints(mvB netName cv)); change to 'flight lines' a possible crossing net when netNames are differents
foreach( fig net~>figs
mvPoints=foreach(mapcar point fig~>points
if(point==mvA then mvB else point); move to same point => not moved
);move old point A to new point B
; printf("?? changing %L %s form %L to %L\n" fig netName fig~>points mvPoints)
when(fig~>points!=mvPoints fig~>points=mvPoints)
);end check all nets  rodSubPoints('(2.96875 3.5) '(2.96875 3.5))
);pass unecessary nets
); postions pins are != mvA!=mvB
);end check all pins pAB to flip off selected instance   0x0fb18393
); when flipPin list is not nil

;; ####CHANGE MASTER###
;; inst~>master=dbOpenCellViewByType("cmrf8sf" "pfet" "symbol")
;; B=dbOpenCellViewByType("cmrf8sf" "oprppres" "symbol")
inst~>master=B  ;<== ####CHANGE MASTER###
inst~>orient=orient ;<== is it useful ? to update orientation ? Yes surely
; printf("-> into  %L ___\n" inst~>cellName)

when(length(fp)>=4 foreach( special nth(3 fp) when(car(special)=="adjust"
adjust=cadr(special)
xform=list(rodSubPoints(inst~>xy dbTransformPoint(adjust inst~>transform)) "R0" 1)
schStretch(list(inst) dbConcatTransform(dbConcatTransform(list(mapcar('minus inst~>xy) "R0" 1) xform) list(inst~>xy "R0" 1)))
))) ;adjust => prettier view, this is just tunning, is avoided when not sepcified in the input list flip
); when(inst~>cellName==car(fp) ...)
;  (); foreach(mapcar fp flip) 
) t ;end foreach instances in cellView
));;let proc

printf("load(\"flipTo_cmos8rf.il\")     ;<= defines flipList amsc35->ibm130\n")
printf("load(\"flipTo_cmhv7sf.il\")     ;<= defines flipList amsc35->amsh18\n")
printf("load(\"flipTo_cmrf8sf_t18.il\") ;<= defines flipList ibm130->tower180\n")
printf("c35toc18\n");
printf("translateLib(\"T2K_V5\") ;=> create T2K_V5_TRANSLATE")
printf("flipList='((\"mem_1cell\" \"mem_1cell_modif\" \"xtract_ed\" ((\"flipPin\" ((\"read_cell\" \"READ\")(\"phi\" \"WRITE\"))))))\n")
printf("c35toc18(flipList);;<== those two lines will change the symbol into another, addapting pin nodifications:read_cell into READ...\n")


;; schStretch(list(inst) list(rodSubPoints(dbTransformPoint(rodAddPoints('(-0.0625 0.0)  inst~>xy) list('(0.0 0.0) inst~>orient inst~>mag )) inst~>xy ) "R0"))
;;fp='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf")  ("wtot" "wt")  ("ng" "nf")   )            )        ))

; c35toc18


;; oldLib="T2K_V5"
;; newLib=sprintf(nil "%s_TRSLT" oldLib )
;; oldLib="T2K_2009"
;; cellName="Rds_noise"
;; ;cellName="ota8"

; ddCreateLib( newLib)

;; Change
;; dbOpenCellViewByType(newLib inst~>cellName "symbol") 
;; with member("symbol" dbAllCellViews(newLib inst~>cellName))



;; USAGE 
;  c35toc18()
;  c35toc18('(("pmos4" "pfetx"  "cmhv7sf" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf" "int" 'atoi)))))) ) ; transform only pmos4 into pfetx in current cellview
;  c35toc18('(("pmos4" "pfetx"  "cmhv7sf" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf" "int" 'atoi)))))) geGetWindowCellView())
;  c35toc18(flip dbOpenCellViewByType( "T2K_V5_TRSLT"  "Rds_noise" "schematic" "schematic")) ; <= where flip is defined in load("flipTo_cmhv7sf.il")
;  c35toc18(flip dbOpenCellViewByType( "T2K_V5_TRSLT"  "degent_WS_miror" "schematic" "schematic")) ; <= where flip is defined in load("flipTo_cmhv7sf.il")
;  c35toc18(flip dbOpenCellViewByType( "T2K_V5_TRSLT"  "bias" "schematic" "schematic")) ; <= where flip is defined in load("flipTo_cmhv7sf.il")
;  c35toc18(flip dbOpenCellViewByType( "T2K_V5_TRSLT"  "1CH_flattent_sim" "schematic" "schematic")) ; <= where flip is defined in load("flipTo_cmhv7sf.il")

; translateCell("T2K_V5" "bias") ; <= where flip is defined in load("flipTo_cmhv7sf.il")
; translateCell("T2K_V5" "GB_CPa") ; <= where flip is defined in load("flipTo_cmhv7sf.il")
; translateCell("T2K_V5" "GB_CPTa") ; <= where flip is defined in load("flipTo_cmhv7sf.il")

; translateLib("T2K_V5") ;=> will create a transformed lib : T2K_V5_TRSLT, using declared variable : flip defined in load("flipTo_cmhv7sf.il")
; translateLib("T2K_V5" flip "TOTO" ) ;=> will create a transformed lib : TOTO , using declared variable : flip defined in load("flipTo_cmhv7sf.il")
