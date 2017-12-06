;; copyleft ebecheto

; pour un schematic ou layout
; getInstTermPointLPP()
;; ;; return a list of :
;; ;; (label point lpp bBox fig?)


; (setq inst css())

procedure(getInstTermPointLPP(@optional (inst css()) )
let((point master pointList v5or6 labs ilab verb itrans)
verb=nil
master=inst~>master  ; printf("INST:%L\n" list(inst master~>terminals) )
itrans=inst~>transform||list(inst~>xy car(inst~>tileArray) 1.0);<= mosaic patch
labs=setof(shape inst~>master~>shapes shape~>objType=="label");<= utile si que des labels sans pi
; conn=car(master~>terminals )
foreach( conn master~>terminals 
; printf("INST:%L\n" list(conn~>name conn conn~>pins~>figs conn~>pins~>??) )
; printf("INST:%L\n" list(conn~>name conn conn~>pins~>fig~>??) ) ;version 5.141 => ~>fig et non figs !!
when(not(car(v5or6=conn~>pins~>figs)) v5or6=list(conn~>pins~>fig) )
; printf("\nv5or6 %L ?\n" car(v5or6))
when(point=centerBox(caar(v5or6)~>bBox);<= OK car une seul pin "PLUS" dans le symbol(figs)
pointList=append(pointList list(list(conn~>name dbTransformPoint(point itrans) car(conn~>pins~>fig~>lpp)
dbTransformBBox(caar(v5or6)~>bBox||list(0:0 0:0) itrans) caar(v5or6)
)))
);secure layout error suba...
unless(conn~>pins
when(verb printf("terminal [%s] n'a pas de pin => label\n" conn~>name) )
ilab=car(setof(lab labs lab~>theLabel==conn~>name))
; printf("%L\n" ilab~>??) ?! vsub! exist dans mast~>terms~>name mais dans labs~>name c'est vsubo! et pas de vsub!...
pointList=append(pointList list(list(conn~>name dbTransformPoint(ilab~>xy||'(0 0) itrans) ilab~>lpp
dbTransformBBox(ilab~>bBox||list(0:0 0:0) itrans) ilab
)))
);<== terminal sans rectangle pins : juste un label => reccup xy label, poser pin mini_rect 0.4x0.4
) pointList ));let proc
; assoc("A" getInstTermPoint()) ;=> ("A" (0.0 0.125))
; assoc("VBBB" getInstTermPointLPP(car(insts)))
;=> ("VBBB" (1270.925 1923.1) ("PIN" "metal4") ((1270.675 1922.85) (1271.175 1923.35)))
; rajout de la bBox de la pin

printf("getInstTermPointLPP()\n")


;; inst=css()
;; fcking objType "mosaic" ...
;; inst~>??
;; car(inst~>instanceList)~>transform
;; css()~>transform
;=> (db:0x274b4227 cellView db:0x3b92a79a objType "mosaic" prop nil bBox ((19.6 -21.66) (37.7 -17.23)) children nil groupMembers nil isAnyInst t isShape nil matchPoints nil net nil parent nil pin nil purpose "cell" textDisplays nil assocTextDisplays nil markers nil figGroup nil instanceList (db:0x274b4227) name "|I2(1)" numInstances 1 mosaicType "simple" libName "ED_TSMC130n" cellName "Mbit" viewName "layout" master db:0x32b6e21a instHeader db:0x32b6a59b instTerms (db:0x32b6bcea db:0x32b6bce9 db:0x32b6bce8 db:0x32b6bce7 db:0x32b6bce6 db:0x32b6bce5 db:0x32b6bce4 db:0x32b6bce3 db:0x32b6bce2) rows 1 columns 1 tileArray ("R0") uX 18.1 uY 4.43 xy (19.91 -17.66))
;; inst~>master~>sigNames;=> ("vsubo!" "PLUS" "MINUS" "PAD" "gnd3r!" "vsub!" "Z" "vdd3o!" "vdd3r1!" "vdd3r2!" "gnd3o!")
;; labs=setof(shape inst~>master~>shapes shape~>objType=="label")
;; labs~>??

;; ilab=car(setof(lab labs lab~>theLabel=="PAD"))
;; ilab=car(setof(lab labs lab~>theLabel=="vusb!"))


;; setof(lab labs lab~>theLabel=="Z");=> (db:0x2c903d69)
;; ilab=car(setof(lab labs lab~>theLabel=="Z"))
;; ilab~>??
;; ;=> (db:0x2c903d69 cellView db:0x2c906a1a objType "label" prop nil bBox ((36.173 199.0) (37.127 200.0)) children nil groupMembers nil isAnyInst nil isShape t matchPoints nil net nil parent nil pin nil purpose "metal1" textDisplays nil assocTextDisplays nil markers nil figGroup nil isUnshielded nil shieldedNet1 nil shieldedNet2 nil layerName "PIN" layerNum 70 lpp ("PIN" "metal1") connRoutes nil routeStatus "normal" font "stick" height 1.0 isDrafted t isOverbar nil isVisible t justify "centerCenter" labelType "normalLabel" orient "R0" theLabel "Z" xy (36.65 199.5) hasTextDisplay nil)


;; ;; renvoie un liste de
;; ;; (label point lpp bBox fig?)
;; ;; ("A" (52.925 690.225) ("MET4" "pin") ((8.45 645.55) (97.4 734.9)) db:0x35c7da63 )
