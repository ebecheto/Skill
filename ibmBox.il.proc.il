;; ;_schematic___________________________________________________________________
;; cv=cvSch; 
; cv=geGetWindowCellView()
;; cv~>terminals~>name

;; ;; foreach(term cv~>terminals 
;; ;; when(rexMatchp("^DVSS_" term~>name) 
;; ;; dbDeleteObject(term)
;; ;; ;; rexCompile("^DVSS_")
;; ;; ;; term~>name=rexReplace(term~>name "" 1)
;; ;; ))


;; ;; foreach(mapcar term cv~>terminals 
;; ;; when(rexMatchp("^GND_" term~>name) 
;; ;; ;; dbDeleteObject(term)
;; ;; rexCompile("^GND_")
;; ;; AA=term
;; ;; schReplaceProperty(list(term) "name" rexReplace(term~>name "" 1)) ;=> pas OK sur terminals, mais ok sur instances !
;; ;; printf("term %L\n" term~>??)
;; ;; ))

;; ;; schReplaceProperty(list(css()) "name" "vdd!") ;=> OK
;; ;; schReplaceProperty(list(css()) "name" "gnda!") ;=> OK

;; rexCompile("^GND_")
;; inst=setof(term cv~>instances rexMatchp("^GND_" term~>net~>name||"") )
;; foreach(in inst
;; schReplaceProperty(list(in) "name" rexReplace(in~>net~>name "" 1)) ;=> OK
;; )

;; pattern="^GND_"
;; inst=setof(term cv~>instances rexMatchp(pattern term~>net~>name||"") )
;; foreach(in inst
;; schReplaceProperty(list(in) "name" rexReplace(in~>net~>name "" 1)) ;=> OK
;; )

;; cv=geGetWindowCellView()
;; pattern="^CNT" rexCompile(pattern)
;; inst=setof(term cv~>lpps rexMatchp(pattern term~>net~>name||"") )
;; foreach(in inst
;; schReplaceProperty(list(in) "name" rexReplace(in~>net~>name "" 1)) ;=> OK
;; )


;; ;; ;supprime toutes les pins "DVSS_qqechose"
;; ;; aa=setof(term cv~>instances rexMatchp("^DVSS_" term~>net~>name||"") )
;; ;; foreach(a aa dbDeleteObject(a))


unless(fboundp('getInstTermPoint) load("padRing.proc.il"))

;; Layout --------------------------------------------------------------------
;; cv=geGetWindowCellView()
;; cv~>layerPurposePairs~>??
;; lpp=setof(lp cv~>layerPurposePairs lp~>layerName=="MA")
;; labels=car(setof(p lpp p~>purpose=="label"))
;; pins=car(setof(p lpp p~>purpose=="pin"))
;; pins~>shapes~>??

;; setof(p cv~>layerPurposePairs p~>purpose=="label")
;; foreach(mapcar l setof(p cv~>shapes p~>objType=="label") l~>lpp=list(car(l~>lpp) "label"))
foreach(mapcar l setof(p geGetWindowCellView()~>shapes p~>objType=="label") l~>lpp=list(car(l~>lpp) "label"))

foreach(mapcar l setof(p geGetWindowCellView()~>shapes p~>objType=="label") l~>lpp=list(car(l~>lpp) "pin"))


;; cv=geGetWindowCellView()
;; ;pattern="^CNT"
;; pattern="^IN<"
;; rexCompile(pattern)
;; flat=foreach(mapcan sh cv~>layerPurposePairs~>shapes sh)
;; ;setof(sh flat sh~>objType=="label");=>OK
;; patLabel=setof(sh flat sh~>objType=="label"&&rexMatchp(pattern sh~>theLabel||"")&&sh~>layerName=="MA")
;; length(patLabel);=> 32
;; foreach(sh patLabel sh~>lpp='("MA" "label"))


; point=cadr(assoc("DVSS" getInstTermPoint(css()))) ;=> (15.875 4.40625)
; point2=centerBox(css()~>bBox);=> (16.15625 4.34375)

;; os=angleSection(rodSubPoints(point centerBox(css()~>bBox)))
;; x=car(point) y=cadr(point) dx=0.125*2
;; cond((os==0 y=y-dx)(os==1 x=x+dx)(os==2 y=y+dx)(os==3 x=x-dx))
;; orient=sprintf(nil "R%d" mod(90*(os+1) 360))
;; wid=schCreateWire( cv "draw" "direct" list(point x:y) 0.0625 0.0625 0.0125  ); <== creat wire line
;; schCreateWireLabel(cv car(wid) point "sub!" "lowerRight" orient "fixed" 0.0625 nil )
;; schCreateWire( cv "draw" "direct" list(point point2) 0.0625 0.0625 0.0125  ); <== creat wire line

unless(fboundp('angleSection) load("padRing.proc.il"))
; hiZoomIn(hiGetCurrentWindow() list(point rodAddPoints(point 0.1:0.1)))

defun( addWireLabelToPin (@optional (pinName "DVSS") (label "sub!") (cv geGetWindowCellView()) (font "euroStyle"))
let((point os x y dx orient conn wid)
dx=0.125*2
foreach(inst cv~>instances when(point=cadr(assoc(pinName getInstTermPoint(inst)))
os=angleSection(rodSubPoints(point centerBox(inst~>bBox)))
x=car(point) y=cadr(point)
cond((os==0 y=y-dx)(os==1 x=x+dx)(os==2 y=y+dx)(os==3 x=x-dx))
orient=sprintf(nil "R%d" mod(90*(os+1) 360))
; check whether pin is connected to a wireNet or a Pin
conn=car(setof(i inst~>conns i~>name==pinName)); only 'one' pin of same pinName by symbol
when(conn&&not(conn~>net~>figs)&&not(conn~>net~>pins) printf("nothing connected. Go for it.Warning for instances <0:xx> => PB\n") A=inst
wid=schCreateWire( cv "draw" "direct" list(point x:y) 0.0625 0.0625 0  ); <== creat wire line
;printf("schCreateWire( cv \"draw\" \"direct\" list%L 0.0625 0.0625 0.0125  );" list(point x:y) ); <== creat wire line
schCreateWireLabel(cv car(wid) point label "lowerRight" orient font 0.0625 nil)
)))))

; do not forget a check& save before! A netlist is necessary !

;; addWireLabelToPin("VDD" "VDD")
;; addWireLabelToPin("SX" "SX")
;; addWireLabelToPin("NW" "NW")
;; addWireLabelToPin("GND" "GND")

;; addWireLabelToPin("VDD" "vdd!")
;; addWireLabelToPin("SX" "sub!")
;; addWireLabelToPin("NW" "vdd!")
;; addWireLabelToPin("GND" "gnd!")

;; addWireLabelToPin("RN" "RST")
;; addWireLabelToPin("CLK" "CLKF")


foreach(mapcar inst cv~>instances when(point=cadr(assoc(pinName getInstTermPoint(inst))) point))









;; ;_symbol_______________________________________________________________________

cvs=geGetWindowCellView();symbol
;; cvs~>??

ps=car(setof(purp cvs~>layerPurposePairs purp~>layerName=="pin"))
ps~>shapes~>?? ;=> rect ou label

todel=foreach(mapcan p ps~>shapes 
cond(
(p~>objType=="rect" if(rexMatchp("^DVSS_" p~>net~>name||"") list(p) nil))
(p~>objType=="label"  if(rexMatchp("^DVSS_" p~>theLabel||"") list(p) nil))
(t nil)
))

todel=foreach(mapcan p ps~>shapes 
cond(
(p~>objType=="rect" if(rexMatchp("^SX" p~>net~>name||"") list(p) nil))
(p~>objType=="label"  if(rexMatchp("^SX" p~>theLabel||"") list(p) nil))
(t nil)
))

;; foreach(del todel dbDeleteObject(del))

tosub=foreach(mapcan p ps~>shapes 
cond(
(p~>objType=="rect" if(rexMatchp("^GND_" p~>net~>name||"") list(p) nil))
(p~>objType=="label"  if(rexMatchp("^GND_" p~>theLabel||"") list(p) nil))
(t nil)
))

;; rexCompile("^GND_")
;; foreach(to tosub 
;; cond(
;; (to~>objType=="rect" to~>pin~>term~>name=rexReplace(to~>pin~>term~>name "" 1))
;; (to~>objType=="label" to~>theLabel=rexReplace(to~>theLabel "" 1))
;; ))


;; pattern="^DVDD_"
;; tosub=foreach(mapcan p ps~>shapes 
;; cond(
;; (p~>objType=="rect" if(rexMatchp(pattern p~>net~>name||"") list(p) nil))
;; (p~>objType=="label"  if(rexMatchp(pattern p~>theLabel||"") list(p) nil))
;; (t nil)
;; ))

;; rexCompile(pattern)
;; foreach(to tosub 
;; cond(
;; (to~>objType=="rect" to~>pin~>term~>name=rexReplace(to~>pin~>term~>name "" 1))
;; (to~>objType=="label" to~>theLabel=rexReplace(to~>theLabel "" 1))
;; ))




;schReplaceProperty(list(car(last(tosub)))~>net "name" "VSS");=> fail no net wire
; car(last(tosub))~>pin~>term~>name="VSS" ;=> OK
unless(fboundp('getInstTermPoint) load("padRing.proc.il"))
defun(bBoxWidth (bBox) caadr(bBox)-caar(bBox))
defun(bBoxHeight (bBox) cadadr(bBox)-cadar(bBox))
; (setq gss geGetSelectedSet() )
; (setq listCell '("SIOVDD"  "SIOGND" "SIOWIRE_ESD" "SIODVSS" "SIODVDD"))
; (setq listCell '(("SIOVDD" 2.51:-2.5)  ("SIOGND" 2.54:-2.5) ("SIOWIRE_ESD" 2.57:-2.5) ("SIODVSS"  2.54:-2.5) ("SIODVDD"  2.54:-2.5)))

defun(widenMADVpad (@optional (gss geGetSelectedSet())(listCell 
'(("SIOVDD" 2.55:-2.5)  ("SIOGND" 2.57:-2.5) ("SIOWIRE_ESD" 2.57:-2.5) ("SIODVSS"  2.57:-2.5) ("SIODVDD"  2.57:-2.5))
;'("SIOVDD"  "SIOGND" "SIOWIRE_ESD" "SIODVSS" "SIODVDD")
))
let((dvxy H tr xs rect ots elem layer)
unless(gss gss=geGetWindowCellView()~>instances)
gss=setof(g gss assoc(g~>cellName listCell))
; gss=setof(g gss g~>libName=="short_io")
foreach(g gss 
widenLayerPad("DV" 10 g)
;widenLayerPad("MA" 10 g 2.54:-2.5 115.02)
widenLayerPad("MA" 10 g eval(cadr(assoc(g~>cellName listCell))) 115.02)
)))


; widenLayerPad("MA" 10 css() 2.54:-2.5 115.02)
defun(widenLayerPad (@optional (layer "DV")(xSize 10)(inst css())(adjXY 0:0)(H nil))
let((dvxy tr xs ys rect pts elem)
dvxy=getMaxPointsLayer(inst~>master layer)
unless(H H=bBoxHeight(dvxy))
tr=inst~>transform
xs=caar(dvxy)+car(adjXY) ys=cadar(dvxy)
rect=list(list(-xSize+xs 0+ys) list( xs H+ys))
pts=dbTransformBBox(rect tr)
elem=dbCreateRect( geGetWindowCellView() list( layer "drawing" ) pts)
;------------
xs=caadr(dvxy)+cadr(adjXY) ys=cadar(dvxy)
rect=list(list(0+xs 0+ys) list( xs+xSize H+ys))
pts=dbTransformBBox(rect tr)
elem=dbCreateRect( geGetWindowCellView() list(layer "drawing" ) pts)
))



;; css()~>xy=rodAddPoints(css()~>xy 4.91:-9.93)
;; css()~>xy=rodAddPoints(css()~>xy -4.91:9.93)

;; css()~>xy
;; dbTransformBBox(4.91:-9.93 css()~>transform)
;; pts=dbTransformPoint( -9.93:-4.91 css()~>transform)
;; B=dbOpenCellViewByType("PRACTIC_32" "my_pad_esd" "layout")
;; css()~>master=B
;; css()~>xy=pts

;; B=dbOpenCellViewByType("PRACTIC_32" "my_pad_esd" "layout")
;; foreach(inst geGetSelectedSet()
;; css()~>xy
;; pts=dbTransformPoint( 9.93:4.91 css()~>transform)
;; pts=dbTransformPoint( -9.93:-4.91 css()~>transform)
;; css()~>master=B
;; css()~>xy=pts hiRedraw()


 B=dbOpenCellViewByType("short_io" "SIOWIRE_ESD" "layout")
;; foreach(inst geGetSelectedSet()
;; inst~>xy
;; pts=dbTransformPoint( 9.93:4.91 inst~>transform)
;; inst~>master=B
;; inst~>xy=pts
;; ) hiRedraw()

;; B=dbOpenCellViewByType("PRACTIC_32" "my_pad_esd" "layout")
;; foreach(inst geGetSelectedSet() inst~>xy inst~>master=B )



;; bBox='((-5.4 -5.4) (335.0 -4.9))
;; => X0 = caar(bBox)			      upperRight or uR
;; => Y0 = cadar(bBox)			      lowerRight or lR
;; => X1 = caadr(bBox)			      centerLeft or cL
;; => Y1 = cadadr(bBox)			      centerCenter or cC
defun(isInBox (bBox xy) caar(bBox)<=car(xy)&&caadr(bBox)>=car(xy)&&cadar(bBox)<=cadr(xy)&&cadadr(bBox)>=cadr(xy))
;; isInBox('((-5.4 -5.4) (335.0 -4.9)) 0:0)
;; isInBox('((-5.4 -5.4) (335.0 -4.9)) 0:-5)

defun(getInstPinPat (@optional (pattern "^IN<") (cellName "SIOWIRE_ESD") (cv geGetWindowCellView()))
let((insts terms pins)
insts=cv~>instances
when(cellName insts=setof(inst insts inst~>cellName==cellName))
terms=setof(term cv~>terminals rexMatchp(pattern term~>name))
pins=foreach(mapcan p terms~>pins p)
insts=setof(inst insts car(remove(nil foreach(mapcan b pins~>fig~>bBox list(isInBox(inst~>bBox centerBox(b)))))))
))

;; length(gg=getInstPinPat())
;; B=dbOpenCellViewByType("PRACTIC_32" "my_pad_esd" "layout")
;; foreach(inst gg inst~>xy inst~>master=B )



;; todel=setof(g geGetSelectedSet() g~>cellName=="SIOFILL_sx")
;; B=dbOpenCellViewByType("Ed_CMOS8" "SIOFILL_sxMA" "layout")
;; foreach(inst todel inst~>xy inst~>master=B )
;; ; foreach(del todel dbDeleteObject(del))

; geSelectFigs(getInstPinPat("^IN<" "my_pad_esd"))

(setq cv geGetWindowCellView())
pinList='(("INCSA" "IN") ("OUTCMP" "OUT") "OUTCSA" "INCMP")

defun( putPinToInst (pinList @optional (tName css()~>name||"I0") (lppd list("M2" "pin")) (cv geGetWindowCellView()) )
let((pinLists pName iName lpp pInst tInst tPoint pPoint toMove)
pinLists=foreach( mapcar x pinList if(!listp(x) list(x x) x))
pinLists=foreach( mapcar x pinLists if(length(x)<3 append(x list(lppd)) x))
foreach(pin pinLists
pName=car(pin)
iName=cadr(pin)
lpp=nth(2 pin)
; tName="|I8"
pInst=car(setof(term cv~>terminals term~>name==pName))
tInst=car(setof(term cv~>instances term~>name==tName))
tPoint=cadr(assoc(iName getInstTermPoint(tInst)))
pPoint=centerBox(car(pInst~>pins)~>fig~>bBox)
toMove=rodSubPoints( tPoint  pPoint)
dbMoveFig(car(pInst~>pins)~>fig nil list(toMove "R0"))
;geSelectFigs(pInst~>pins~>fig)
when(lpp
car(car(pInst~>pins)~>fig~>children)~>lpp=lpp
car(pInst~>pins)~>fig~>lpp=lpp
)
)))

putPinToInst('(("INCSA" "IN") ("OUTCMP" "OUT") "OUTCSA" "INCMP") "|I8")
putPinToInst('(("C40MHz" "A"))  "|CLK_I0" '("M1" "pin"))
putPinToInst('(("clk" "A"))  "|CLK_I1" '("M1" "pin"))


vdds=setof(g geGetSelectedSet() g~>objType=="rect")


defun( putPinToInstdb (@optional (pinList geGetSelectedSet()) (tInstList '("I0")) (lppd list("M3" "pin")) (cv geGetWindowCellView()) )
let(( pName iName lpp pInst tInst tPoint pPoint toMove)
pinLists=foreach( mapcar x pinList if(!listp(x) list(x car(x~>children~>theLabel)) x))
pinLists=foreach( mapcar x pinLists if(length(x)<3 append(x list(lppd)) x))
foreach(pin pinLists; '((db:0xaaa "vcc!" ("M3" "pin")) ()...)
pInst=car(pin);<= of type rect
iName=cadr(pin)
lpp=nth(2 pin)
tName=car(tInstList) tInstList=cdr(tInstList) ;<= depile la liste de d'instancePin selectionnee
tInst=car(setof(term cv~>instances term~>name==tName))
printf("tName=%L\n" list(tName tInst iName))
tPoint=cadr(assoc(iName getInstTermPoint(tInst)))
pPoint=centerBox(pInst~>pin~>fig~>bBox)
toMove=rodSubPoints(tPoint  pPoint)
dbMoveFig(pInst~>pin~>fig nil list(toMove "R0"))
when(lpp car(pInst~>pin~>fig~>children)~>lpp=lpp pInst~>pin~>fig~>lpp=lpp)
)))

;vdds=setof(g geGetSelectedSet() g~>objType=="rect")
length(vdds)
iInsts=foreach(mapcar i linRg(0 31 1) pName=sprintf(nil "|I0(%d)" i));=> ("|I0(0)" "|I0(1)" "|I0(2)" ...)
putPinToInstdb(vdds iInsts)
;getInstTermPoint(css())

iInsts=foreach(mapcar i linRg(0 2 1) pName=sprintf(nil "|I5(%d)" i));=> ("|I5(0)" "|I5(1)" "|I5(2)")

vdds=setof(g geGetSelectedSet() g~>objType=="rect")
iInsts=append(iInsts list("|I8"))
length(vdds)
putPinToInstdb(vdds iInsts)


a=foreach(mapcar i linRg(0 31 1) pName=sprintf(nil "|I0(%d)" i));=> ("|I0(0)" "|I0(1)" "|I0(2)" ...)
b=foreach(mapcar i linRg(0 2 1) pName=sprintf(nil "|I5(%d)" i));=> ("|I5(0)" "|I5(1)" "|I5(2)")
a=append(a b)
b=list("|I8")
a=append(a b)
length(vdds)
length(a)
putPinToInstdb(vdds a)
