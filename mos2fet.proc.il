;; copyleft ebecheto
; load("mos2fet.proc.il")
;######## used procedured definition #################################" 
procedure(getTermPoint(@optional (inst css()) (NAME "PLUS") )
let((point) foreach( conn inst~>instTerms when(NAME==conn~>term~>name
point=centerBox(caar(conn~>term~>pins~>figs)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
)) point ));let proc

procedure(getTermFig(@optional (inst css()) (NAME "PLUS") )
let((fig) foreach( conn inst~>instTerms when(NAME==conn~>term~>name
fig=caar(conn~>term~>pins~>figs);<= OK car une seul pin "PLUS" dans le symbol(figs)
)) fig ));let proc

procedure(getInstNetName(@optional (inst css()) (NAME "S") )
let((netName) foreach( conn inst~>instTerms when(NAME==conn~>term~>name
netName=conn~>net~>name;<= OK car une seul pin "PLUS" dans le symbol(figs)
)) netName ));let proc ;getInstNetName(css() "PLUS")


; isBetweenPoints('(5.4375 -0.84375) "net079")
; isBetweenPoints('(5.4375 -0.84375) "")

procedure(isBetweenPoints(@optional  (pt '(5.875 -0.78125)) (netName "") (cv geGetWindowCellView()) )
let((between pt1 pt2 xmax xmin ymax ymin)
foreach( net cv~>nets
foreach( fig net~>figs
when(fig
pt1=car(fig~>points)
pt2=cadr(fig~>points)
;;printf("Colinear points? %L :  %L off %s\n" pt fig~>points net~>name) 
when(pcColinearPoints(pt1 pt2 pt) 
xmax=max(car(pt1)  car(pt2))
ymax=max(cadr(pt1) cadr(pt2))
xmin=min(car(pt1)  car(pt2))
ymin=min(cadr(pt1) cadr(pt2))
between=and(not( car(pt)<xmin|| car(pt)>xmax)
	    not(cadr(pt)<ymin||cadr(pt)>ymax))
if(between&&net~>name!=netName then 
fig~>lpp='("wire" "flight") 
; printf("Point %L Between  %L of %s\n" pt fig~>points net~>name) 
else
nil ;printf("Point %L not Between  %L off %s\n" pt fig~>points net~>name) 
);if
))))
))

;; pcColinearPoints('(4.75 -0.78125) '(5.875 -0.78125) '(5.875 -0.78125))
;; changeInstMovePoint("mimcap" '(("PLUS" "D")("MINUS" "S")))
;; changeInstMovePoint("pfet")
procedure(getMasterTermPoint(@optional (master css()) (NAME "PLUS") )
let((point) 
when(master~>objType=="inst" master=master~>master)
foreach( conn master~>terminals when(NAME==conn~>name
point=centerBox(caar(conn~>pins~>figs)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
)) point ));let proc
;getMasterTermPoint(css() "SX")
;getMasterTermPoint(css() "NZ")

procedure(getInstTermPoint(@optional (inst css()) )
let((point master pointList) 
master=inst~>master ;printf("INST:%L\n" list(inst master~>terminals) )
foreach( conn master~>terminals 
point=centerBox(caar(conn~>pins~>figs)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
pointList=append(pointList list(list(conn~>name dbTransformPoint(point inst~>transform))))
) pointList ));let proc

;DANGER dans padRing j'ai modifie cette fonction qui n'a que 2 arguments
;________copied from padRing.proc.il _____replaced layout->symbol________________________________
;                          @optional (cell "nmos4") (libList ddGetLibList()) (viewType "symbol") 
procedure(whereExistCell(  @optional (cell "nmos4") (libList ddGetLibList()) (viewType list("symbol" "layout" "schematic")) )
let((g_libList ret ) ret='()
unless(libList libList=ddGetLibList())
unless(listp(viewType) viewType=list(viewType))
if(type(car(libList))=='string 
g_libList=foreach(mapcar lib libList car(setof(g_lib  ddGetLibList() g_lib~>name==lib)))
g_libList=libList)
g_libList=remove(nil g_libList)
foreach( g_lib g_libList  foreach( view viewType
when(member(view dbAllCellViews(g_lib cell))  ret=append(ret list(g_lib~>name view))
;printf("RET=%L\n" ret)
))); tconc(ret) car(ret) serait plus joli. Mais j'ai commencé a utiliser la fonction autrement
ret)) ; whereExistCell("INV0")
; whereExistCell("XOR2_A" nil "symbol")

;whereExistCell3 defined in whereExistCell3.il

;________USING c35toc18 procedure________________________________________________

defun( translateLib (oldLib @optional (flip flip) newLib) let((ddLib cellName newCV oldCV cvSym TRANSLATE)
; TRANSLATE="TRANSLATE"
TRANSLATE=nth(2 car(last(flip)));=> ie.PRIMLIB
when(!newLib newLib=sprintf(nil "%s_%s" oldLib TRANSLATE ))
printf("Creating:%s, from %s into techno:%s (<-ie. first element)\n" newLib oldLib caddar(flip)||"empty?")
ddLib=setof(lib ddGetLibList() lib~>name==oldLib) ; ddLib~>cells~>name
printf("oldLib:%L\n" list(oldLib))
when(not(setof(lib ddGetLibList() lib~>name==newLib)) printf("Creating %s, **** please do CIW->Tools->TechnologyFileManager...->Attch  TECH_youWant after! **** \n" newLib)  
;ddCreateLib( newLib)
dbCreateLib( newLib)
)
foreach(mapcar cell car(ddLib~>cells)
cellName=cell~>name
; printf("dbOpenCellViewByType%L\n" list(oldLib cellName "schematic" "schematic" "r"))
when(oldCV = dbOpenCellViewByType( oldLib  cellName "schematic" "schematic" "r")  ; can only copy it when a view schematic exist
; geOpen( ?lib oldLib ?cell cellName  ?view "schematic" ) ;; <== check results
printf("Treating %L with c35toc18\n" list(newLib cellName))
newCV = dbCopyCellView( oldCV newLib  cellName "schematic");( "schematic" "w")
dbClose(oldCV)
c35toc18(flip newCV)
; when(newCV dbSave(newCV) dbClose(newCV) )
when(member("symbol" dbAllCellViews(car(ddLib) cellName)) cvSym=dbOpenCellViewByType(oldLib cellName "symbol" "schematicSymbol" "r") dbCopyCellView(cvSym newLib  cellName "symbol"))
))
printf("updateCellviews%L\n" list(newLib)) updateCellviews(newLib)
printf("strapPropLib%L\n" list(newLib)) strapPropLib(newLib);; TODO TOTHINK :make it optional or not ?
printf("busToMultiplicityLib%L\n" list(newLib)) busToMultiplicityLib(newLib)

printf("someting it fails... reload it :\nbusToMultiplicityLib%L\n" list(newLib))
printf("addSubcLib%L\n" list(newLib)) addSubcLib(newLib)
printf("Now open h18 kit and do \n updateCellviewsLib( %L '%L )\n" newLib '("CORELIB" "CORELIB_HV") )
))

defun( translateCell (oldLib cellName @optional (flip flip) newLib)
when(!newLib newLib=sprintf(nil "%s_TRANSLATE" oldLib ))
printf("Creating:%s, from %s into techno:%s (<-ie. first element)\n" newLib oldLib caddar(flip)||"empty?")
;printf("dbOpenCellViewByType%L\n" list(oldLib cellName "schematic" "schematic" "r"))
when(oldCV = dbOpenCellViewByType( oldLib  cellName "schematic" "schematic" "r")  ; can only copy it when a view schematic exist
; printf("dbCopyCellView('%L)\n" list(oldCV newLib cellName))
newCV = dbCopyCellView( oldCV newLib  cellName "schematic");( "schematic" "w")
dbClose(oldCV)
c35toc18(flip newCV)
when(newCV dbSave(newCV) dbClose(newCV))
geOpen( ?lib newLib ?cell cellName  ?view "schematic" ) ;; <== check results
when(cvSym = dbOpenCellViewByType( oldLib cellName "symbol" "schematicSymbol" "r") 
; printf("dbCopyCellView%L\n" list( cvSym newLib  cellName "symbol"))
nSim=dbCopyCellView( cvSym newLib  cellName "symbol")
)
; when(cvSym dbClose(cvSym))
; when(nSim dbSave(nSim) dbClose(nSim) )
)) ; USAGE : translateCell("T2K_V5" "bias") ; <= where flip is defined in load("flipTo_cmhv7sf.il")


;______POST PROCESS FUNCTIONS, to adjust ... on one's need_______________________

defun( strapPropLib ( @optional (aLib geGetWindowCellView()~>libName) (param "m")  (varType "string")) let((ddLib cellName instList cnt) cnt=0
ddLib=setof(lib ddGetLibList() lib~>name==aLib) ; ddLib~>cells~>name
foreach(mapcar cell car(ddLib~>cells)
cellName=cell~>name
when(cv=dbOpenCellViewByType( aLib cellName "schematic" "schematic");( "a"); editable
instList=setof( inst cv~>instances inst~>libName!=aLib)
cnt=cnt+strapPropCell(param instList varType)
when(cv dbSave(cv) ) )) printf("Apply prop to %d elements\n" cnt) cnt ))
; strapPropLib("Ed_H18")

defun( strapPropCell (@optional (param "m")  (instList geGetWindowCellView()~>instances) (varType "string")) 
(let (ipp val cnt sList) cnt=0  printf("%s %s_INSTLIST:%L\n" param varType instList)
foreach(inst instList  ;printf("INSTname:%s_PROP:%L\n" inst~>cellName inst~>prop~>name)
; printf("...%L...%L\n" (setq ipp car(setof(ip inst~>prop ip~>name==param)))~>?? ipp~>valueType)
when((setq ipp car(setof(ip inst~>prop ip~>name==param))) ; ipp=car(setof(ip css()~>prop ip~>name=="m"))
; (and (setq ipp car(setof(ip inst~>prop ip~>name==param))) ipp~>valueType==varType )
if(type(ipp~>value)=='string  val=atoi(ipp~>value)  val=ipp~>value) ; printf("Changing %L in %L" "2" atoi("2"))
putprop(inst val param) cnt=cnt+1
))  cnt)) ; /!\ ipp~>valueType="string"  !=   type(ipp~>value)='string  /!\
; strapPropCell() 


; aLib="T2K_V5_TR"
defun( busToMultiplicityLib ( @optional (aLib geGetWindowCellView()~>libName))
(let (ddLib cellName cv cnt) cnt=0
ddLib=ddGetObj(aLib)
foreach(mapcar cell ddLib~>cells
;printf("Doing %s\n" cell~>name)
busToMultiplicityCell(ddLib~>cells)
cellName=cell~>name
when(member("schematic" dbAllCellViews(ddLib cellName)) cv=dbOpenCellViewByType( aLib cellName "schematic");( "schematic");( "a")
cnt=cnt+busToMultiplicityCell(cv~>instances)
; when(cv dbSave(cv) )
)) cnt)) ;busToMultiplicityLib()


defun( busToMultiplicityCell (@optional   (instList geGetWindowCellView()~>instances) ) 
(let (ipp val cnt mult lmult name multi sinsList) cnt=0 ; printf("%s %s_INSTLIST:%L\n" param varType instList)
sinstList=setof(inst instList rexMatchp(">" inst~>name))
; printf("Changing any <x:x> to a multiplicity if it exist.%L\n" sinstList)
foreach(inst sinstList ipp=nil
;printf("INSTname:%s_PROP:%L\n" inst~>name inst~>prop~>name)
; printf("Do %s\n" inst~>name)
mult=inst~>name
lmult=parseString(mult "<") name=car(lmult)
lmult=parseString(cadr(lmult)||"" ">")
lmult=parseString(car(lmult)||"" ":")
when(length(lmult)==2 multi=atoi(cadr(lmult))-atoi(car(lmult))+1 
if((and setq(ipp car(setof(ip inst~>prop ip~>name=="m"))) or(ipp~>value==1 ipp~>value=="1")) then
printf("%L=?\n" car(setof(ip inst~>prop ip~>name=="m"))~>??)
when(ipp~>valueType=="string" multi=sprintf(nil "%d" multi))
putprop(inst multi "m") inst~>name=name cnt=cnt+1
;evalstring(cdfFindParamByName( cdfGetInstCDF(inst) "m")->callback||"")
; eval callback or not ??... 
else when((and ipp~>value multi)
printf("%s has a bus naming <> and a multiplicity !=1 ?! check what you want to do : %dx%d or overwrite one of it %d or %d ?\n" inst~>name||"?nil"  ipp~>value||666 multi ipp~>value multi))
); ok "m" exist and ==1
))  cnt))
; busToMultiplicityCell()


; newLib="T2K_V5_TRSLT"
defun( updateCellviews (@optional (newLib geGetWindowCellView()~>libName))
let((ddLib cellName updateLib newMast cnt) cnt=0
; car(setof( inst geGetWindowCellView()~>instances inst~>libName==oldLib))~>master~>??
ddLib=setof(lib ddGetLibList() lib~>name==newLib) ; ddLib~>cells~>name
foreach( cell car(ddLib~>cells)
; cv=geGetWindowCellView()
cellName=cell~>name
when(member("schematic" dbAllCellViews(car(ddLib) cellName))
cv=dbOpenCellViewByType( newLib cellName "schematic"); ( "schematic");( "a") ; oppen in append mode (editable)
updateLib=setof( inst cv~>instances  inst~>libName!=newLib)
foreach( inst updateLib 
;printf("Not from lib in %L %s %L\n" cv~>cellName newLib inst~>?? )
when(member("symbol" dbAllCellViews(car(ddLib) inst~>cellName))
newMast=dbOpenCellViewByType(newLib inst~>cellName "symbol")  inst~>master=newMast cnt=cnt+1 printf("REMASTER : %s %L\n" inst~>cellName inst~>??))
) ; when(cv dbSave(cv) )
)) printf("Remastered %d instances\n" cnt) cnt))
; updateCellviews(newLib)


; update cells to the given libName or when still not existing and not defined in the choice list
; 
defun( updateCellviewsLib (@optional (newLib geGetWindowCellView()~>libName) (choiceLib ddGetLibList()~>name) )
let((ddLib cellName updateLib newMast cnt existLib) 
cnt=0 
; car(setof( inst geGetWindowCellView()~>instances inst~>libName==oldLib))~>master~>??
ddLib=ddGetObj(newLib) ; ddLib~>cells~>name
printf("ddGetObj(%L)\n" newLib)
foreach( cell ddLib~>cells
; cv=geGetWindowCellView()
printf("_________Entering %s_________\n" cell~>name)
cellName=cell~>name
when(member("schematic" dbAllCellViews(ddLib cellName))
cv=dbOpenCellViewByType( newLib cellName "schematic"); ( "schematic");( "a") ; oppen in append mode (editable)
updateLib=setof( inst cv~>instances  newLib!=inst~>libName)
; printf("going throught : %L\n" updateLib~>??)
foreach( inst updateLib
;printf("Not from lib in %L %s %L\n" cv~>cellName newLib inst~>?? )
if(member("symbol" dbAllCellViews(ddLib inst~>cellName)) then
newMast=dbOpenCellViewByType(newLib inst~>cellName "symbol")  inst~>master=newMast cnt=cnt+1 printf("REMASTER : %s %L\n" inst~>cellName inst~>??)
else ; qd la lib le l'inst n'existe pas ou qu'elle n'a pas de symbol => recherche autre existance dans d'autres libs
when( not( (and inst~>libName ddGetObj(inst~>libName) member("symbol" dbAllCellViews(ddGetObj(inst~>libName) inst~>cellName))) )
when(existLib=car(whereExistCell( inst~>cellName choiceLib "symbol"))
printf("Not in the current Lib but exist in \nwhereExistCell(%s '%L) :%L\n"  inst~>cellName choiceLib whereExistCell( inst~>cellName choiceLib "symbol"))
newMast=dbOpenCellViewByType(existLib inst~>cellName "symbol") 
inst~>master=newMast cnt=cnt+1 printf("REMASTER : %s %L\n" inst~>cellName inst~>??)
existLib=nil)); dbAllCellViews(ddGetObj(css()~>libName) css()~>cellName)
)) ; when(cv dbSave(cv) )
)) printf("Remastered %d instances\n" cnt) cnt))
; updateCellviews(newLib)
; updateCellviewsLib( geGetWindowCellView()~>libName '("CORELIB" "CORELIB_HV") )


defun( addSubcCV (@optional (cv geGetWindowCellView()) (sensivList '("nfet" "pfet" "cmim" "oprppres")) )
(let (exist sub gnd xy)
printf("addSubcCV %L, checking %L\n" cv~>cellName sensivList)
exist=remove(nil foreach(mapcar elem sensivList member(elem cv~>instances~>cellName)))
; printf("ESIST:%L\n" exist)
when((and exist not(member("subc" cv~>instances~>cellName))) ; quand il y a un element qui a besoin de subc qu'il n'y a pas de subc, je rajoute subc connecte a gnd
xy=list(caar(cv~>bBox) cadar(cv~>bBox))
sub=dbOpenCellViewByType( "cmhv7sf" "subc"  "symbol")
gnd=dbOpenCellViewByType( "analogLib" "gnd"  "symbol")
(dbCreateInst cv sub nil xy "R0")
(dbCreateInst cv gnd nil xy "R180")
)))



; addSubcLib("T2K_V5_TRANSLATE")
defun( addSubcLib ( @optional (aLib geGetWindowCellView()~>libName))
(let (ddLib  cv)
ddLib=ddGetObj(aLib)
schCells=setof(c ddLib~>cells member("schematic" dbAllCellViews(ddLib c~>name)))
foreach(mapcar cell schCells
cv=dbOpenCellViewByType( aLib cell~>name "schematic")
addSubcCV(cv)
) ))


load("oppres.il")
load("cmimcap.il")

defun( resCapFix (@optional (cv geGetWindowCellView()) (sensivList '("oprppres" "oprppresx" "cmim" "cmimx")) )
(let (instLib sub gnd xy)
printf("resistance %L, checking %L\n" cv~>cellName sensivList)
instList=remove(nil foreach(mapcar in cv~>instances when(rexMatchp(in~>cellName apply('strcat sensivList)) in)))
printf("ESIST:%L\n" instList~>name)
foreach(mapcar inst instList 
if(rexMatchp(car(sensivList) inst~>cellName)
oppresFix(inst)
cmimFix(inst)
)))) ;cmimFix(css()) oppresFix(css())



; dbCheck(dbOpenCellViewByType("T2K_V5_TRANSLATE" "ota_mil" "schematic"))
defun( cbCheckLib (@optional (aLib geGetWindowCellView()~>libName))
(let (ddLib  cv) ddLib=ddGetObj(aLib)
foreach(mapcar cell ddLib~>cells cellName=cell~>name
when(member("schematic" dbAllCellViews(ddLib cellName))
cv=dbOpenCellViewByType(aLib  cellName "schematic" "schematic" "a")
schCheck(cv) dbSave(cv) dbClose(cv)
;dbCheck(cv)
))))


;; ; ________________________________________________________________________________
;; ; cv=dbOpenCellViewByType(... "a") followed by  schCheck(cv) dbSave(cv)  dbClose(cv) 
;; ; is avoidable if I ask the user to do a Close Data Save All at the end. It will be much faster (prevent multiple open/close)
;; ; TOTHINK about
;; ; NB : in Close and Purge Data Form, one ca see Mode " editable", status "modified" !! without "a"  in dbOpen..
;; ; ________________________________________________________________________________

; printf("/!\\  At the end, please do File->CloseData->All->Ok  /!\\ \nor \nddsHiCloseData() ddsiCloseDataButtonCB('all) hiFormDone(ddsCloseDataForm) hiDBoxUser(ddsDBox22 nil 3)\n" )


;; ____________towerJazz specific function________________________ ;;
load("ts18StrapProp.il")

defun( strapPropLib_ts18 ( @optional (aLib geGetWindowCellView()~>libName)) let((ddLib cnt) cnt=0
ddLib=setof(lib ddGetLibList() lib~>name==aLib) ; ddLib~>cells~>name
foreach(mapcar cell car(ddLib~>cells)
when(cv=dbOpenCellViewByType( aLib cell~>name "schematic" "schematic");( "a"); editable
cnt=cnt+ts18StrapProp(cv)
when(cv dbSave(cv) ) )) printf("Apply prop to %d elements\n" cnt) cnt ))
; strapPropLib("1TEST_v18")


procedure( netSetChangeCv(@optional  (cList '(("VSS" "vssa!") ("VDD" "vdda!") )) (cv geGetWindowCellView())  (verb t) )
apply('plus foreach(mapcar inst cv~>instances 
netSetChangeInst(cList inst verb)
))) ; netSetChangeCv('(("VSS" "vssa!")("VDD" "vdda!")))



procedure( netSetChangeCell(@optional  (cList '(("VSS" "vssa!") ("VDD" "vdda!") )) (cellNom "A4") (cv geGetWindowCellView())  (verb t) )
apply('plus foreach(mapcar inst setof(cell cv~>instances cell~>cellName==cellNom)
netSetChangeInst(cList inst verb)
))) ; netSetChangeCell('(("reset!" "RST")("CNT!" "CNT")("clk!" "CLK")) "A4")



procedure( netSetChangeInst(@optional (cList '(("VSS" "vssa!") ("VDD" "vdda!") ))(inst css())(verb nil)(verb2 t) )
let((cvs intNet extNet viewType xview (cnt 0))
foreach(c cList
intNet=car(c)
extNet=cadr(c)
intNet=car(parseString(intNet "!"));enleve le ! pour traiter plus de c
viewType='("cmos_sch" "schematic")
xview=car(foreach(mapcan view viewType when(member(view dbAllCellViews(ddGetObj(inst~>libName) inst~>cellName)) list(view) )));first existing view in order
; cv=dbOpenCellViewByType("tsl18fs120" "inv0d2" "cmos_sch" "schematic" )
when(xview cvs=dbOpenCellViewByType( inst~>libName inst~>cellName xview "schematic")
foreach(sig cvs~>sigNames ; cv~>sigNames ;=> ("ZN" "VSS!" "VDD!" "I")
when(verb printf("Check %s %L\n" sig list(inst~>name inst~>cellName)))
when(or(sig==intNet sig==strcat(intNet "!"))
when(verb2 printf("Apply netSet %s->%s to %L\n" intNet extNet list(inst~>name inst~>cellName)))
if(prop=dbGetPropByName(inst intNet)
then cnt++
prop~>value=eval(extNet)
else cnt++
dbCreateProp(inst intNet "netSet" eval(extNet))
)))
)) cnt))


defun( revertFlip (flip @optional (libs '(("cmrf8sf" "PRIMLIB")("cmos8rf" "CORELIB"))))
foreach(mapcar fp flip
;lib1="cmos8rf"
lib1=caddr(fp)
lib2=cadr(assoc(lib1 libs))
if(lib2 then
fpN=list(cadr(fp) car(fp) lib2
foreach(mapcar fp3 nth(3 fp) printf("fp3=%L\n" fp3) ;=> ("flipPin" (("Q" "Z"))) ()
cond(
(car(fp3)=="flipPin" list("flipPin" foreach(mapcar fp4 cadr(fp3) reverse(fp4))))  ; pourkoi ai-je fais une list de list pour les elments de  flipProp ??
(car(fp3)=="flipProp" list("flipProp" foreach(mapcar fp4 cadr(fp3) reverse(fp4))))
(car(fp3)=="adjust" list("adjust" reverse(cadr(fp3))))
(t fp3 ))
))
else fp)
))
;revertFlip(flip)


defun( removeInFlip ( @optional (flip flip) (elements '("subc")))
remove(nil foreach(mapcan fp flip
list(if(member(car(fp) elements) nil fp))
)))
; flip=removeInFlip()               ;flip=remove(nil flip)
; flip=removeInFlip(flip '("subc")) ;flip=remove(nil flip)


;; _______________study a new library : lib2csv
defun( lib2csv (@optional (libName "ts018_prim") (row t) (verb t)) let((masterList file pf cv inst cdfgData srow)
ddLibName=car(setof(lib ddGetLibList() lib~>name==libName))
if(row srow="_row" srow="")
cv=dbOpenCellViewByType( "ANALOG_TUT" "tmp" "schematic" "schematic" "w")
masterList=ddLibName~>cells
file=strcat( pwd() "/" libName srow ".csv")
pf=outfile(file)  ; desactive la non creation du fichier, ce n est pas si long que ca.
when(verb printf("Treating %d-cells" length(masterList)))
foreach(cell masterList
when(member("symbol" dbAllCellViews(ddLibName cell~>name))  mast=dbOpenCellViewByType(libName cell~>name "symbol")
fprintf(pf "%s;%L;" cell~>name mast~>terminals~>name)
inst=(dbCreateInst cv mast nil 0:0 "R0")
cdfgData=(cdfGetInstCDF inst)
foreach(par cdfgData~>parameters
fprintf(pf "%s;%s;%L;%s;%L;" par~>name par~>prompt par~>value par~>paramType par~>defValue)
when(row fprintf(pf "\n"))
);end loop properties
fprintf(pf "\n")
printf("%s||%L\n" cell~>name mast~>??)
))
close(pf) sprintf(cmd  "cp %s ~/groupU/RunT2K/." file)
system(cmd)
)) ; lib2csv("tsl18fs120") lib2csv("ts018_prim") lib2csv("cmos8rf") lib2csv("cmrf8sf") lib2csv("CORELIB") lib2csv("PRIMLIB")
