; load("tower.il")
unless(fboundp('whereExistCell) load("padRing.proc.il"))
defun(bBoxWidth (bBox) caadr(bBox)-caar(bBox))
defun(bBoxHeight (bBox) cadadr(bBox)-cadar(bBox))

; -361.68:-131.68
;; defun( miscPatch (@optional (cv geGetWindowCellView()) (XY nil) (dxy 0:0) (back 0:0) (sealRing "TS18_Seal_ring_CIS_streachable"))
;; let((lc xs ys toAdd bb)
;; ; toAdd=bBoxHeight(getMaxPointsLayer((dbOpenCellViewByType "short_io" "SIOWIRE_ESD" "layout") "M1" ))
;; when(bb=shapesBox(cv nil "TOP_M")
;; printf("bb=%L\n" bb)
;; ; unless(XY XY=bBoxWidth(bb)+toAdd:bBoxHeight(bb)+toAdd)
;; unless(XY XY=bBoxWidth(bb)+car(dxy)-2*car(back):bBoxHeight(bb)+cadr(dxy)-2*cadr(back))
;; ; foreach(mapcar x XY aelSuffixNotation(x))
;; xs=car(XY) ys=cadr(XY)
;; printf("%L<-XY -> %L\n" XY list(xs ys))
;; when(lc=whereExistCell(sealRing)  ; <= for ibm only, bu PB with LOGO => my_bevel
;; dbCreateParamInstByMasterName(cv car(lc) sealRing "layout" nil back "R0" 1 list(list("sx" "float" xs) list("sy" "float" ys)))
;; )
;; list(xs ys))))


;; adj='(127.32 81.06)
;; defun( div2 (x) foreach(mapcar r x r/2.0))
;; div2(adj)
;; miscPatch(geGetWindowCellView() nil div2(adj) foreach(mapcar r adj -r/2.0))


;; cv~>instances~>master
;; cell="tsl18cio250FM_long" "pc3d01"
;; ccv=dbOpenCellViewByType("tsl18cio250FM_long" "pc3d01" "layout" "maskLayout" "r")

;; cv~>??
;; shList=setof(shape x~>shapes shape~>layerName=="M1")

;; masterH='()
;; foreach(inst cv~>instances
;; inst=nth(5 cv~>instances)
;; unless(assoc(inst~>master masterH)
;; sha=setof(shape inst~>master~>shapes shape~>layerName=="TOP_M")
;; inst~>master~>shapes~>bBox
;; X0=X1=0 Y0=Y1=0
;; foreach(s sha 
;; s=car(sha)
;; X0s =   caar(s~>bBox) when(X0s<=X0 X0=X0s)
;; Y0s =  cadar(s~>bBox) when(X1s>=X1 X1=X1s)
;; X1s =  caadr(s~>bBox) when(Y0s<=Y0 Y0=Y0s)
;; Y1s = cadadr(s~>bBox) when(Y1s>=Y0 Y1=Y1s)
;; )
;; bBoxlpp=list(X0:Y0 X1:Y1)

;; tran=inst~>transform
;; boxt=dbTransformBBox(bBoxlpp tran)
;; masterH=append(masterH list(inst~>master boxt))

;; layName="TOP_M"

;; when(shapes=inst~>master~>shapes bBoxlpp=shapeLayerBox(shapes layName bBoxlpp))

defun( shapeLayerBox (shapes @optional (layName "TOP_M") (bBox nil))
;(bBox list(0:0 0:0))
let((X0s X1s Y0s Y1s X0 X1 Y0 Y1)
sha=setof(shape shapes shape~>layerName==layName)
unless(bBox bBox=car(sha~>bBox))
X0=  caar(bBox) Y0= cadar(bBox)
X1= caadr(bBox) Y1=cadadr(bBox)
foreach(s sha
X0s =   caar(s~>bBox) when(X0s<=X0 X0=X0s)
Y0s =  cadar(s~>bBox) when(Y0s<=Y0 Y0=Y0s)
X1s =  caadr(s~>bBox) when(X1s>=X1 X1=X1s)
Y1s = cadadr(s~>bBox) when(Y1s>=Y0 Y1=Y1s)
)
if(sha list(X0:Y0 X1:Y1) nil)))

;; sBox=shapeLayerBox(inst~>master~>shapes)
;; insts=inst~>master~>instances

;; inst=car(insts)
;; tran=inst~>transform
;; bBoxlpp=shapeLayerBox(inst~>master~>shapes layName sBox)
;; boxt=dbTransformBBox(bBoxlpp tran)

;; ccv=dbOpenCellViewByType("tsl18cio250FM_long" "subil_pad" "layout" "maskLayout" "r")
;; ccv~>shapes
;; shapeLayerBox(ccv~>shapes layName nil)

;; inst=car( ccv~>instances)
;; foreach(mapcar inst ccv~>instances
;; tran=inst~>transform
;; printf("need to go further:%L\n" inst~>master~>instances)
;; bBoxlpp=shapeLayerBox(inst~>master~>shapes layName nil)
;; boxt=dbTransformBBox(bBoxlpp tran)
;; )

;; foreach(mapcar inst inst~>master~>instances
;; tran=inst~>transform
;; when(inst~>master~>instances printf("need to go further:%L\n" inst~>master~>instances))
;; bBoxlpp=shapeLayerBox(inst~>master~>shapes layName nil)
;; when(bBoxlpp boxt=dbTransformBBox(bBoxlpp tran))
;; )

;; i=last(inst~>master~>instances)
;; i~>master~>shapes
;; i~>??
;; inst~>master~>cellName
;; inst~>master~>instances~>master~>shapes
;; inst~>master~>instances~>master~>cellName
;; inst~>master~>instances~>master~>instances~>??
;; inst~>master~>instances~>master~>instances~>master~>instances
;; ;; Probleme : les 'stack' vias ont des sous instances de sous instance de sous instance

;; la=car(last(inst~>master~>instances~>master))
;; la~>instances
;; ;; probleme lie au cellules suivante qui contiennent trop de group de group de vias
;; ;; les groups sont vus comme des instances?! Non, comme des : objType "figGroup"
;; ;; subil_via1array
;; ;; subil_via2array
;; ;; subil_via3array
;; ccvv=dbOpenCellViewByType("tsl18cio250FM_long" "subil_via3array" "layout" "maskLayout" "r")

;; ccvv~>instances~>cellName ;=> plein de subil_m_via
;; length(ccvv~>instances);=>21204
;; ;=> imaginer un filtre sur certain types de cellules que l'on sait inutile :=> skipCells. Ou bien les enregister dans la table de hash masterH.

;;  geGetSelectedSet()~>??
;; car(last(geGetSelectedSet()))
;; shapeLayerBox(car(last(geGetSelectedSet()))~>master~>shapes)

;; masterH='()
;; inst=car(last(geGetSelectedSet()))
;; inst=nth(1 geGetSelectedSet())


;; ; Warning geGetSelectedSet() can be made of "rect"
;; instances=setof(g geGetSelectedSet() g~>objType=="inst")





;; insts=setof(g geGetSelectedSet() g~>objType=="inst")
;; shapes=insts~>master~>shapes
;; cv=geGetWindowCellView()
;; shapes=cv~>shapes
;; sha=setof(shape shapes shape~>layerName==layName)

;; maxBoxes(sha~>bBox)


;; defun( printDeep (master @optional (tran list(0:0 "R0" 1)))
;; (cond
;; ((null master) ;condition d'arret
;; ; printf("null %L" x) 
;; x)
;; ((atom master) ;printf("scopeBox %L LAYER_=%L________________\n" x~>cellName LAYER_)
;; foreach(mapcar inst master~>instances
;; ;printf("printDeep:%L\n" list(inst~>baseName inst~>cellName))
;; printDeep(inst~>master)
;; ))))
;; printDeep(master=cv=geGetWindowCellView())


;; defun( shapeDeep (master @optional (tran list(0:0 "R0" 1)))
;; (cond
;; ((null master) nil);renvoie nil => arret
;; ((atom master)
;; foreach(mapcar inst master~>instances
;; ;printf("shapeDeep:%L\n" list(inst~>baseName inst~>cellName))
;; shapeDeep(inst~>master inst~>transform)
;; ))))


;; defun( maxBoxes (bBoxes)
;; let((X0s X1s Y0s Y1s X0 X1 Y0 Y1)
;; when(car(bBoxes)
;; ;printf("XY01:%L\n" list(X0 Y0 X1 Y1 car(bBoxes)))
;; X0=  caar(car(bBoxes)) Y0= cadar(car(bBoxes))
;; X1= caadr(car(bBoxes)) Y1=cadadr(car(bBoxes))
;; ;printf("XY01:%L\n" list(X0 Y0 X1 Y1) cdr(bBoxes))
;; foreach(s cdr(bBoxes)
;; ;printf("%L vs %L\n" list(caar(s) cadar(s) caadr(s) cadadr(s)) list(X0:Y0 X1:Y1))
;; X0s =   caar(s) when(X0s<=X0 X0=X0s)
;; Y0s =  cadar(s) when(Y0s<=Y0 Y0=Y0s)
;; X1s =  caadr(s) when(X1s>=X1 X1=X1s)
;; Y1s = cadadr(s) when(Y1s>=Y1 Y1=Y1s)
;; )  list(X0:Y0 X1:Y1))))
;; ; renvoi nil s'il n'y a pas de 1er element

defun( maxBoxes (bBoxes)
let((X0s X1s Y0s Y1s X0 X1 Y0 Y1)
when(car(bBoxes)
; printf("XY01:%L\n" list(X0 Y0 X1 Y1 car(bBoxes)))
X0=  caar(car(bBoxes)) Y0= cadar(car(bBoxes))
X1= caadr(car(bBoxes)) Y1=cadadr(car(bBoxes))
;printf("XY01:%L\n" list(X0 Y0 X1 Y1) cdr(bBoxes))
foreach(s cdr(bBoxes)
;printf("%L vs %L\n" list(caar(s) cadar(s) caadr(s) cadadr(s)) list(X0:Y0 X1:Y1))
X0=min(X0   caar(s) )
Y0=min(Y0  cadar(s) )
X1=max(X1  caadr(s) )
Y1=max(Y1 cadadr(s) )
)  list(X0:Y0 X1:Y1))))
; renvoi nil s'il n'y a pas de 1er element



masterH='()
;master=cv=geGetWindowCellView()
defun( shapesBox ( @optional (mastR geGetWindowCellView()) (tran nil) (layName "TOP_M") )
(let (bBoxMaster bBoxShape bBoxInst bBoxes)
unless(tran tran=list(0:0 "R0" 1))
(cond
((null mastR)  nil)
((atom mastR)
;printf("master:%L\n" mastR~>cellName)
bBoxShape=setof(shape mastR~>shapes shape~>layerName==layName)~>bBox
bBoxInst=foreach(mapcar inst mastR~>instances
if(knownMaster=assoc(inst~>master masterH) then 
;printf("knownMaster:%L\n" knownMaster)
cadr(knownMaster) ; si le master est deja connu en profondeur on ne refait pas le boulot ;=>renvoie la valeur
else
shapesBox(inst~>master inst~>transform layName)
))
bBoxes=remove(nil append(bBoxShape bBoxInst))
when(bBoxes bBoxMaster=dbTransformBBox(maxBoxes(bBoxes) tran)
;printf("Computiing bBoxMaster:%L with %L into %L\n" bBoxes tran bBoxMaster)
)
unless(assoc(mastR masterH) masterH=append(masterH list(list(mastR bBoxMaster))))
bBoxMaster
))))

;;; ; ;;;maxBoxes(setof(shape cv~>shapes~>bBox shape~>layerName=="TOP_M"))
;maxBoxes(setof(shape cv~>shapes shape~>layerName=="TOP_M")~>bBox)

;; TOPMb=shapesBox()
;; '((-50.0 92.06) (945.765 941.36))





defun( miscPatch (@optional (cv geGetWindowCellView()) (adj nil) (XY nil) (sealRing "sealRingCIS"))
let((lc xs ys toAdd bb back)
xs=0 ys=0 back=0:0
when(lc=whereExistCell(sealRing)  ; <= for ibm only, bu PB with LOGO => my_bevel
propList=list(list("sx" "float" xs) list("sy" "float" ys))
SL=dbCreateParamInstByMasterName(cv car(lc) sealRing "layout" nil back "R0" 1 propList)
; when(adj==t '(-361.68 -131.68))
when(adj==t adj=list(11+10+4 11+10+4))
when(XY==t XY=list(0 -50.5))
unless(adj adj=0:0)
unless(XY XY=0:0)
printf("adj;%L XY:%L\n" adj XY)
when(bb=shapesBox(cv nil "TOP_M") printf("bb=%L XY:%L\n" bb XY)
;; xy0=car(bb)
;; xy1=cadr(bb)
bh=bBoxHeight(bb)
bw=bBoxWidth(bb)
printf("HUHU%L:%L\n" adj list(XY bh bw))
;; xs=bw+car(XY)+car(adj) ys=bh+cadr(XY)+cadr(adj)
;; back=list(car(adj)+car(XY)+caar(bb) cadr(adj)+cadr(XY)+cadar(bb))
slh=bBoxHeight(SL~>bBox);=>88.32
slw=bBoxWidth(SL~>bBox) ;=>88.32
xs=bw-slw+abs(car(XY))+2*car(adj)
ys=bh-slh+abs(cadr(XY))+2*cadr(adj)
back=list(
caar(bb)-car(adj)+car(XY)
cadar(bb)-cadr(adj)+cadr(XY)
)
printf("car(xy)%L\n" car(XY))
dbFindProp(SL "sy")~>value=ys
dbFindProp(SL "sx")~>value=xs
SL~>xy=back
)
list(xs ys back))))
 
;miscPatch(geGetWindowCellView() t t)
miscPatch(geGetWindowCellView() list(11+10 11+10) t)
;miscPatch(geGetWindowCellView() t t "TS18_Seal_ring_CIS_chamfered_a1_flat")

printf("%Lx%L\n" bBoxHeight(SL~>bBox) bBoxWidth(SL~>bBox))

