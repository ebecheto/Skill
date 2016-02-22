;; copyleft ebecheto
; load("padRing.proc.il")

procedure(firstFoundCell(libList_ cell) ;obsolete
(let (libList)
libList=libList_
while( libList && not((dbOpenCellViewByType car(libList) cell "layout")) libList=cdr(libList) );end while depile la liste tant que ne trouve pas la cellule
;;when( libList printf("%L found in %L\n" cell car(libList)) );; quand la liste n'est pas vide
when( !libList fprintf(stdout "%L does not exist in %L\nPlease add the library where %L exist in the sensitivity list" cell libList_ cell) );; quand la liste n'est pas vide
car(libList)
))


;DANGER dans /home/validmgr/ebecheto/Skill/mos2fet.proc.il j'ai modifie cette fonction qui a  3 arguments
; preferer l'autre fonction 
procedure(whereExistCell(  @optional (cell "nmos4") (libList ddGetLibList()) )
let((g_libList ret) ret='()
if(type(car(libList))=='string 
g_libList=foreach(mapcar lib libList car(setof(g_lib  ddGetLibList() g_lib~>name==lib)))
g_libList=libList)
g_libList=remove(nil g_libList)
foreach( g_lib g_libList  when(member("layout" dbAllCellViews(g_lib cell))  ret=tconc(ret g_lib~>name) ) )
car(ret)))

;; whereExistCell("AVSUBP_3B")
;; whereExistCell("INVX1")
;; whereExistCell("PERI_SPACER_50_P" "Ed_CMOS8") ;=> *Error* car:...
;; whereExistCell("PERI_SPACER_50_P" list("Ed_CMOS8")) ;=> ok, but nil, since not in the lib

;; whereExistCell("AVSUBP_3B" '("IOLIB_ANA_3B_4M" "IOLIB_3B_4M" "IOLIB_ANA_4M"))
;; IOCELL="APRIO1V8_00"
;; whereExistCell(IOCELL)


procedure(whereExistCellx(  @optional (cell "nmos4") (libList ddGetLibList()) )
let((g_libList ret) ret='()
foreach(lib libList  
foreach(c lib~>cells
when(rexMatchp(cell c~>name)  ret=tconc(ret list(c~>name lib~>name)) ) ))
car(ret)))

; whereExistCellx("FILLCAP")


;; dbOpenPanicCellView("GATES" "tata" "layout")
;; dbOpenAutoSavedCellView("GATES" "tata" "layout")
;; dbAllCellViews(car(ddGetLibList(  )) "tata")
;; dbAllCellViews(car(ddGetLibList(  )) "VIA1_C")

; car(ddGetLibList(  ))~>name;=>"TECH_C35B3
;; foreach( g_lib ddGetLibList() when(got=member("layout" dbAllCellViews(g_lib "AVSUBP_3B"))  printf("Append %L ! Got :%L\n"  g_lib~>name got) ) ) t

;; tata=car(setof(g_lib  ddGetLibList() g_lib~>name=="IOLtatata"));==> Permits to check existance of a library exit lib dd:0xfafaa or nil
;; tata=car(setof(g_lib  ddGetLibList() g_lib~>name=="IOLIB_4M"))

;; cell="doesNotExist"
;; libList=list("IOLIB_4M" "IOLIB_ANA_3B_4M" "IOLIB_ANA_4M")
;; firstFoundCell(libList cell)

;; cell="APRIOP_3B"
;; libList=list("IOLIB_4M" "IOLIB_ANA_3B_4M" "IOLIB_ANA_4M")
;; firstFoundCell(libList cell)

;; padLib='("IOLIB_ANA_4M" "IOLIB_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")

;; foreach(mapcar lib padLib car(setof(g_lib  ddGetLibList() g_lib~>name==lib)))
;; type(car(padLib))=='string;=>t
;; type(car(ddGetLibList()))=='ddLibType;=>t



;; ne marche pas avec cadence 6.1.4 or higher ??! ==> Runtime Stack Overflow!
;; => http://www.cadence.com/Community/blogs/cic/archive/2012/10/15/unfinished-skill-for-the-skilled-many-ways-to-sum-a-list-part-4.aspx

; option 1
(defun flatten1Level (LIST) (if LIST (append (car LIST) (flatten1Level (cdr LIST)))  nil))

;; (defun flatten1Level (LIST) foreach(mapcan e LIST (if listp(e) e list(e))))
;; ;=> altere la liste
;; alist='(a (b (d (g f))) e)
;; foreach(mapcan e alist (if listp(e) e list(e)))
;; ;=> altere la list alist ?!

; option 2 => plus lente je crois
defun(flatten1Level (alist) let((tmp) tmp='()
foreach(a alist
if(listp(a) tmp=append(tmp a) tmp=append(tmp list(a) )))
tmp))

;; alist='(a (b (d (g f))) e) flatten1Level(alist)
;; println alist
;; println flatten1Level(alist)


procedure(getMaxPoints(LIST)
let((dY dX Xmin Xmax Ymin Ymax first)
(cond
((null LIST) LIST)
((atom car(LIST)) printf("getMaxPoints(%L) should be a list of list. bBox 'like'\n" LIST) LIST)
(t  first=car(LIST) 
Xmin=caar(first) Xmax=caadr(first)
Ymin=cadar(first) Ymax=cadadr(first)
;printf("1Box=%L \tX0:%L \tY0:%L  \tX1:%L \tY1:%L\t\n"  first caar(first) cadar(first) caadr(first) cadadr(first) )
foreach(bBox LIST
;printf("bBox=%L \tX0:%L \tY0:%L  \tX1:%L \tY1:%L\t%L\n"  bBox caar(bBox) cadar(bBox) caadr(bBox) cadadr(bBox) list(caar(bBox)>caadr(bBox) cadar(bBox)>cadadr(bBox) ))
when((dX=caar(bBox))<Xmin Xmin=dX   )
when((dY=cadar(bBox))<Ymin Ymin=dY  )
when((dX=caadr(bBox))>Xmax Xmax=dX  )
when((dY=cadadr(bBox))>Ymax Ymax=dY )
)
list(list(Xmin Ymin) list(Xmax Ymax))))
))



LAYER_="PAD"
(defun scopeBox (x)  
(let (shList downShapes trans inst box2trans tranList topRes)
(cond
((null x) printf("null %L" x) x)
((atom x) ;printf("scopeBox %L LAYER_=%L________________\n" x~>cellName LAYER_)
	topRes=foreach(mapcar inst x~>instances scopeBox(list(inst)))
	shList=setof(shape x~>shapes shape~>layerName==LAYER_) 
	cons(list(shList~>bBox) topRes));<= revoie une liste de liste de bBox
((null car(x))&&(null cdr(x)) x)
(t inst=car(x) 
	shList=setof(shape inst~>master~>shapes shape~>layerName==LAYER_) 
	toptopRes=foreach(mapcar ins inst~>master~>instances scopeBox(cons(ins x)));qd list nil => pas d'evaluation de la suite => plus de recursion possible
	tranList=foreach(mapcar shape shList box2trans=shape~>bBox
		foreach( upInst x when(upInst~>transform box2trans=dbTransformBBox(box2trans upInst~>transform) ))
		box2trans); foreach
	cons(tranList flatten1Level(toptopRes))
))))


;; scopeBox(geGetWindowCellView())
;; flatten1Level(scopeBox(geGetWindowCellView()))

; getMaxPointsLayer(css()~>master "MET1")
procedure(getMaxPointsLayer(@optional (master geGetWindowCellView()) (LAYER_ "PAD"))
getMaxPoints(flatten1Level(flatten1Level(scopeBox(master)))))

defun( getOrientLayer (master layer orient) 
let((points) points=getMaxPointsLayer(master layer)
; printf("POINTS!%L\n" points)
if(evenp(orient) bBoxWidth(points) bBoxHeight(points))))

; getOrientLayer( (dbOpenCellViewByType "IOLIB_4M" "CORNERP" "layout") "MET1"  0)

; LAYER_="MET1"
; getMaxPointsLayer
; getMaxPointsLayer((dbOpenCellViewByType "IOLIB_ANA_4M" "APRIOP" "layout") "PAD" )      ;((7.5 5.0) (92.5 90.0))
; getMaxPointsLayer((dbOpenCellViewByType "IOLIB_ANA_4M" "APRIOP" "layout") "MET1" )    ;((0.0 -5.4) (100.0 333.5))
; getMaxPointsLayer((dbOpenCellViewByType "IOLIB_4M" "CORNERP" "layout") "MET1")       ;((-5.4 -5.4) (335.0 335.0))
;; getMaxPointsLayer((dbOpenCellViewByType "IOLIB_4M" "PERI_SPACER_01_P" "layout") "MET1") ;((0.0 -5.4) (0.1 -4.9))	  
;; getMaxPointsLayer((dbOpenCellViewByType "IOLIB_4M" "PERI_SPACER_1_P" "layout") "MET1")	;((0.0 -5.4) (1.0 -4.9))	  
;; getMaxPointsLayer((dbOpenCellViewByType "IOLIB_4M" "PERI_SPACER_2_P" "layout") "MET1")	;((0.0 -5.4) (2.0 333.05)) 
;; getMaxPointsLayer((dbOpenCellViewByType "IOLIB_4M" "PERI_SPACER_5_P" "layout") "MET1")	;((0.0 -5.4) (5.0 333.05)) 
;; getMaxPointsLayer((dbOpenCellViewByType "IOLIB_4M" "PERI_SPACER_10_P" "layout") "MET1")	;((0.0 -5.4) (10.0 333.05))
;; getMaxPointsLayer((dbOpenCellViewByType "short_io" "SIOWIRE_ESD" "layout") "MG" )           ;((-0.2 0.72) (73.16 215.06))

defun(bBoxWidth (bBox) caadr(bBox)-caar(bBox))
defun(bBoxHeight (bBox) cadadr(bBox)-cadar(bBox))
;; padBox=getMaxPointsLayer((dbOpenCellViewByType "IOLIB_ANA_4M" "APRIOP" "layout") "MET1" )    ;((0.0 -5.4) (100.0 333.5))
;; padLength=bBoxWidth(padBox)
;; bBox='((-5.4 -5.4) (335.0 -4.9))
;; => X0 = caar(bBox)			      upperRight or uR
;; => Y0 = cadar(bBox)			      lowerRight or lR
;; => X1 = caadr(bBox)			      centerLeft or cL
;; => Y1 = cadadr(bBox)			      centerCenter or cC

; pour un schematic ou layout
procedure(getInstTermPoint(@optional (inst css()) )
let((point master pointList v5or6) 
master=inst~>master  ; printf("INST:%L\n" list(inst master~>terminals) )
foreach( conn master~>terminals 
; printf("INST:%L\n" list(conn~>name conn conn~>pins~>figs conn~>pins~>??) )
; printf("INST:%L\n" list(conn~>name conn conn~>pins~>fig~>??) ) ;version 5.141 => ~>fig et non figs !!
when(not(car(v5or6=conn~>pins~>figs)) v5or6=list(conn~>pins~>fig) )
; printf("\nv5or6 %L ?\n" car(v5or6))
when(point=centerBox(caar(v5or6)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
pointList=append(pointList list(list(conn~>name dbTransformPoint(point inst~>transform))))
);secure layout error suba...
) pointList ));let proc
; assoc("A" getInstTermPoint()) ;=> ("A" (0.0 0.125))



;; Trouver le cadran R0 R90 R180 ou R270 dans lequel se situe une intance   
;;  \2 /          
;;   \/
;; 3 /\ 1
;;  / 0\

defun( orientSection (XY)
let((X Y teta pi) X=car(XY) Y=cadr(XY) pi=acos(-1)
if(X!=0 then
teta=4*atan(Y/X)/pi
when(X<0 teta=teta+4)
floor(mod(round(teta)+9 8)/2)
else if(Y>0 1 0) )))

defun( orientList (@optional (inst css()))
(let (center xy)
foreach(mapcar term getInstTermPoint(inst) center=centerBox(inst~>bBox) xy=cadr(term)
list(car(term) xy sprintf(nil "R%d" 90*angleSection(rodSubPoints(xy center) -45))))
))

;; norient=foreach(mapcar term getInstTermPoint(css())
;; center=centerBox(css()~>bBox)
;; xy=cadr(term)
;; list(car(term) rodSubPoints(xy center ) sprintf(nil "R%d" 90*orientSection(rodSubPoints(xy center) ))))


; problem also with angeSection when selection box is more a rectancle than a square.
; I have a bug with orientSection for a purpose. check another solution ;=> angleBox  work ? SURE IT DOES !!
defun( angleSection (XY @optional (teta 45))
let((X Y pi Xr Yr) X=car(XY) Y=cadr(XY) pi=acos(-1)
Xr=cos(teta*pi/180.0)*X-sin(teta*pi/180.0)*Y
Yr=sin(teta*pi/180.0)*X+cos(teta*pi/180.0)*Y
cond(
(Xr>=0&&Yr>=0 1)
(Xr<=0&&Yr>0 2)
(Xr<0&&Yr<0 3)
(Xr>0&&Yr<=0 0)
)))

;; load("angleBox.il")

;; defun( angleSectionr (XY @optional (teta acos(-1)/2))  ;<= marche aussi ??
;; let((phi X Y pi Xr Yr) X=car(XY) Y=cadr(XY) pi=acos(-1)
;; cond(
;; (X==0 phi=pi/2 phi=atan(Y/X))
;; (X<0 if(Y<0 phi=atan(Y/X)+pi phi=pi-atan(Y/X)))
;; (t phi=atan(Y/X) ))
;; ;printf("phi:teta = %L\n" phi:teta)
;; printf("phi:teta = %L[deg]\n" list(phi/pi*180 teta/pi*180))
;; cond(
;; (-teta<=phi&&phi<teta 1)
;; (teta<=phi&&phi<pi-teta 2)
;; (pi-teta<=phi&&phi<pi+teta 3)
;; (t 0)
;; )))



;=> renvoie minmax des pins et selectionbox du symbol
defun( symbolBox (@optional (inst css()))
(let (bBox pts x0 x1 y0 y1 x y sBox tr)
sBox=car(setof(x inst~>master~>shapes x~>layerName=="instance" && x~>objType=="rect")~>bBox);<= selectionBox
tr=inst~>transform
bBox=dbTransformBBox(sBox tr)
pts=foreach(mapcar g getInstTermPoint(inst) cadr(g))
x0=caar(bBox)	y0=cadar(bBox)	
x1=caadr(bBox)	y1=cadadr(bBox)
foreach(p pts
x=car(p) y=cadr(p)
x0=min(x0 x) x1=max(x1 x)
y0=min(y0 y) y1=max(y1 y)
) list(x0:y0 x1:y1) ))



defun(intToPeri (x)
(let (rest x0 periList)
;; x0=truncate(10*(x-truncate(x))) ; why the Hell floor(0.7*10)=6 ! rounding error ?!
x0=atoi(sprintf(nil "%0.f" 0.7*10))
periList=reverse(foreach(mapcar peri reverse('(  1 2 5 10 20 50 100))
rest=floor(x/peri) x=x-peri*rest list(rest sprintf(nil "%d" peri) )))
cons(list(x0 "01") periList)
))


defun(intToPeriSpacer (x @optional (opt ""))
foreach(mapcar n intToPeri(x) list(car(n) sprintf(nil "PERI_SPACER_%s%s" cadr(n)||"" 
; to modify when i buggs
(cond
(opt=="H18" "")
(t opt)
)
;; if(opt=="H18" "" "_P")
;; if(opt!="H18" opt "")
))))
; intToPeriSpacer(13.4);=> ((7 "PERI_SPACER_01_P") (1 "PERI_SPACER_1_P") (1 "PERI_SPACER_2_P") (0 "PERI_SPACER_5_P") (1 "PERI_SPACER_10_P") (0 "PERI_SPACER_20_P") (0 "PERI_SPACER_50_P") (0 "PERI_SPACER_100_P"))

; intToPeriSpacer(13.4)

defun(biggerPeri (x @optional (opt ""))
let((one) one=0
car(remove(nil foreach(mapcar p reverse(intToPeriSpacer(x opt)) if(car(p)!=0&&one==0 then one=1 cadr(p) else nil))))))


defun( assuraPinPatch (@optional (cv geGetWindowCellView()) )
let((switchList)
unless(member("cmrf8sf" ddGetLibList()~>name)
switchList='(("MET1" "metal1") ("MET2" "metal2") ("MET3" "metal3") ("MET4" "metal4") ("PAD" "pad") )
foreach(x setof(p cv~>shapes p~>purpose=="pin")
x~>purpose=cadr(assoc(x~>layerName switchList))
x~>layerName="PIN"
))))


;; defun( miscPatch (@optional (cv geGetWindowCellView()) (XY nil) (dxy 35.46:29.47) )
;; let((lc xs ys toAdd bb)
;; ; toAdd=bBoxHeight(getMaxPointsLayer((dbOpenCellViewByType "short_io" "SIOWIRE_ESD" "layout") "M1" ))
;; bb=getMaxPointsLayer(cv "M1")
;; ; unless(XY XY=bBoxWidth(bb)+toAdd:bBoxHeight(bb)+toAdd)
;; unless(XY XY=bBoxWidth(bb)+car(dxy):bBoxHeight(bb)+cadr(dxy))
;; ; foreach(mapcar x XY aelSuffixNotation(x))
;; xs=aelSuffixNotation(1u*car(XY))
;; ys=aelSuffixNotation(1u*cadr(XY))
;; printf("%L<-XY -> %L\n" XY list(xs ys))
;; when(lc=whereExistCell("Image_bevel")  ; <= for ibm only, bu PB with LOGO => my_bevel
;; dbCreateParamInstByMasterName(cv car(lc) "Image_bevel" "layout" nil -17.39:-15.81 "R0" 1 list(list("l" "string" xs) list("w" "string" ys)))
;; )))


defun( miscPatch (@optional (cv geGetWindowCellView()) (XY nil) (dxy 0:0) (back -17.39:-15.81) )
let((lc xs ys toAdd bb)
; toAdd=bBoxHeight(getMaxPointsLayer((dbOpenCellViewByType "short_io" "SIOWIRE_ESD" "layout") "M1" ))
when(bb=getMaxPointsLayer(cv "M1")
printf("bb=%L\n" bb)
; unless(XY XY=bBoxWidth(bb)+toAdd:bBoxHeight(bb)+toAdd)
unless(XY XY=bBoxWidth(bb)+car(dxy)-2*car(back):bBoxHeight(bb)+cadr(dxy)-2*cadr(back))
; foreach(mapcar x XY aelSuffixNotation(x))
xs=car(XY) ys=cadr(XY)
printf("%L<-XY -> %L\n" XY list(xs ys))
when(lc=whereExistCell("my_bevel_SKILL")  ; <= for ibm only, bu PB with LOGO => my_bevel
dbCreateParamInstByMasterName(cv car(lc) "my_bevel_SKILL" "layout" nil back "R0" 1 list(list("sx" "float" xs) list("sy" "float" ys)))
)
list(xs ys))))

;; getMaxPointsLayer((dbOpenCellViewByType "PRACTIC_32" "RING10" "layout") "PROTECT" )
;; getMaxPointsLayer((dbOpenCellViewByType "PRACTIC_32" "RING10" "layout") "BP" )
;; println getMaxPointsLayer(geGetWindowCellView() "PROTECT" )
;; println getMaxPointsLayer(geGetWindowCellView() "BP" )


;cv=geGetWindowCellView()

procedure( netSetPatch(@optional (cv nil) (GND "GND")(VDD "VDD")(SUB "sub"))
let((pList a insts VDDo VDDr GNDo GNDr)
insts=geGetSelectedSet()||cv~>instances
unless(cv cv=geGetWindowCellView())
unless(SUB SUB=GND)
VDDo=strcat(VDD "o")
VDDr=strcat(VDD "r")
GNDo=strcat(GND "o")
GNDr=strcat(GND "r")
when(rexMatchp("TECH_C35" techGetTechFile(cv)~>libName)
printf("apply netSet power:%s ground:%s\n" VDD GND)
pList='(
("APRIOP"    ("vdd3r" VDD)("vdd3o" VDD)("gnd" GND) )
("AGND3ALLP" ("vdd3o" VDD)("gnd" GND))
("AVDD3ALLP" ("vdd3r" VDD)("vdd3o" VDD)("gnd" GND) )
("BBCU4P"    ("vdd3r" VDD)("vdd3o" VDD)("gnd" GND) )
("AVDD3ALLC_3B" ("vdd3r" VDD)("vdd3o" VDD)("gnd3o" GND))
("AGND3ALLC_3B" ("vdd3r" VDD)("vdd3o" VDD)("gnd3o" GND))
("APRIOC_3B"    ("vdd3r" VDD)("vdd3o" VDD)("gnd3o" GND))
("AVSUBC_3B"    ("vdd3r" VDDr)("vdd3o" VDDo)("gnd3o" GNDo)("gnd3r" GNDr))
("APRIOP_3B"    ("vdd3r" VDDr)("vdd3r1" VDDr)("vdd3r2" VDDr)("vdd3o" VDDo)("gnd3o" GNDo)("gnd3r" GNDr));("vsub" SUB)
("AVSUBP_3B"    ("vdd3r" VDDr)("vdd3r1" VDDr)("vdd3r2" VDDr)("vdd3o" VDDo)("gnd3o" GNDo)("gnd3r" GNDr))
("AGND3ALLP_3B" ("vdd3r" VDDr)("vdd3r1" VDDr)("vdd3r2" VDDr)("vdd3o" VDDo)("gnd3o" GNDo)("gnd3r" GNDr))
("AVDD3ALLP_3B" ("vdd3r" VDDr)("vdd3r1" VDDr)("vdd3r2" VDDr)("vdd3o" VDDo)("gnd3o" GNDo)("gnd3r" GNDr))
("BBCU4P_3B"    ("vdd3r" VDDr)("vdd3r1" VDDr)("vdd3r2" VDDr)("vdd3o" VDDo)("gnd3o" GNDo)("gnd3r" GNDr))
)
;printf("%L %L\n" GND VDD)
foreach(mapcar inst insts
when(a=assoc(inst~>cellName  pList) foreach(mapcar net cdr(a) 
if(prop=dbGetPropByName(inst car(net)) 
then
prop~>value=eval(cadr(net))
else
dbCreateProp(inst car(net) "netSet" eval(cadr(net))) inst~>name
)))
))))

;netSetPatch(nil "vdd!" "gnd!")
;netSetPatch(geGetWindowCellView() "VSSB" "VDDB")
;netSetPatch(geGetWindowCellView() "VSS" "VDD")

defun(addToThirdPar (pars x) 
cond(
(atom(car(pars)) list(nth(0 pars) nth(1 pars) nth(2 pars)+x ))
(null(cdr(pars))&&listp(car(pars)) list(list(nth(0 car(pars)) nth(1 car(pars)) nth(2 car(pars))+x )))
(listp(cdr(pars)) cons(addToThirdPar(car(pars) x) addToThirdPar(cdr(pars) x)))
(t nil)
))
;addToThirdPar(pars 3)
;addToThirdPar('(("sx" "float" 50)) 4)			;=>(("sx" "float" 54))
;addToThirdPar('(("sx" "float" 50)("sy" "float" 11)) 4) ;=>(("sx" "float" 54) ("sy" "float" 15))

defun(pointInBBox (pt bb) if(car(pt)<=caadr(bb)&&car(pt)>=caar(bb)&&cadr(pt)<=cadadr(bb)&&cadr(pt)>=cadar(bb) t nil))
; pointInBBox(pt bb)

defun(pinLabelPair (@optional (sio car(geGetSelectedSet())))
let((l_io p_io)
l_io=setof(lio sio~>master~>shapes lio~>objType=="label")
p_io=setof(lio sio~>master~>shapes lio~>purpose=="pin")
foreach(mapcan pt l_io
foreach(mapcan bb p_io
; printf("pt bb:%L\n" list(pt bb))
if(pt~>layerName==bb~>layerName&&pointInBBox(pt~>xy bb~>bBox) list(list(pt bb)) nil)
))))
; pp=pinLabelPair(sio)
