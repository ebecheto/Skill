;; copyleft ebecheto
/**************************************************
* Authors : Edouard BECETHOILLE               	  *
*			IPNL (IN2P3-CNRS / UCBL ) *
* Version : 0.6   October 2008                    *
* History :  rajoute creation sch et sym          *
***************************************************/
; load("~/Skill/pad_frame.il")

; sch and symbol createBox functions
load("~/../ebecheto/Skill/Pin.box.il")

;procedure(createBox( l_pins @optional (libname getEditRep()~>libName) (cellname getEditRep()~>cellName) (IO "PAD_IO") (GND "PAD_GND") (PWR "PAD_ALIM") (inter "PAD_inter1") (padCap "PAD_capa") (padLib "PAD_cell_S35D4"))
procedure(createBox( l_pins @optional (spaceL 5) (spaceH 5) (libname getEditRep()~>libName) (cellname getEditRep()~>cellName) (IO "PAD_IO") (GND "PAD_GND") (PWR "PAD_ALIM") (inter "PAD_inter1") (padCap "PAD_capa") (padLib "PAD_cell_S35D4") (price 890) )
let( (cv nPad nMiss cList rList tmp tmpList sx sy pinBox epinBox textBox etextBox x0 x1 y0 y1 step dbLabel norient)  
; nb of pads, missingPads, currentListElement,  remainingList, step in x, step in y
(setq lay "layout") norient=0
;printf("\n**** : %L\n" l_pins)
printf("Generate Layout in %L %L with %L %L %L %L %L %L\n" libname cellname IO GND PWR inter padCap padLib) 
nPad = floor(length(l_pins)/4.0)
when( length(l_pins)/4 != length(l_pins)/4.0 
	nPad = nPad+1
	nMiss = nPad*4 - length(l_pins)
	for( i 0 nMiss-1  l_pins=append( l_pins list(list(inter inter)))) ;<== complète avec des spacer; mettre dimension 70
	;;for( i 0 nMiss-1  l_pins=append( l_pins list(list("gnd" GND)))) ;<==complète avec des gnd!
	); fin du when


unless( ddGetObj(libname) error("Couldn't open library %L. Please open any new layout.\n" libname)  )
cv = dbOpenCellViewByType( libname cellname "layout"  "maskLayout" "w")
;cv = dbOpenCellViewByType( "INNOTEP_v4" "box2" "layout" "maskLayout" "w")
;cv = ddGetObj(libname cellname "layout")
;printf("\nCVCVCVCVCVCV %L CVCVCVCVCVCV\n" cv)


rList = foreach( mapcar x l_pins if(!listp(x) then append(list(x) list(IO)) else x)) ;; pour les elements seul, "in", rajoute ("in" "PAD_IO")
;;** Sch Sym creation du symbol et du schematic associé :
;procedure(createSch( l_pins @optional (library getEditRep()~>libName ) (cell getEditRep()~>cellName) (padLib "PAD_cell_S35D4") (padCap "PAD_capa") )
createSch(rList libname cellname padCap padLib); getEditRep()~>libName getEditRep()~>cellName padLib padCap)


tmpList = rList
;printf("llll %L llll : %L\n" nPad rList)
;(setq spaceL 5)     ; wanted length for horizontal interSpacer : Length
;(setq spaceH 5)      ; wanted length for vertical interSpacer   : Height
(setq padLength 100) ; MET1 abutment length for a PAD
(setq sx 271.95)  ; motif capa length to increment
(setq sy 271.95)  ; motif capa height
pinLay = list( "PIN" "pad")
bBox = nil
(setq sizeL 2*sx+nPad*padLength+(nPad+1)*spaceL)  ; total Length
(setq sizeH 2*sy+nPad*padLength+(nPad+1)*spaceH)  ; total Height

; préparation les offsets des pins et labels pour le chgt de repère avec rodAddPoints
x0=7.5 x1=x0+85 y0=10.4 y1=y0+85
pinBox = '(x0:y0 x1:y1) textBox = subst(-y0 'y0 pinBox) textBox = subst(-y1 'y1 textBox)
epinBox  = foreach(mapcar x pinBox eval(x))  ; evaluated pinBox
etextBox = foreach(mapcar x textBox eval(x)) ; evaluated textBox


tmp=nil B=nil R=nil T=nil L=nil ;  coupe la liste en quatre suivant : Bottom Right Top Left

for(i 1 nPad tmp=tconc(tmp car(tmpList)) tmpList=cdr(tmpList)) B=car(tmp) tmp=nil
for(i 1 nPad tmp=tconc(tmp car(tmpList)) tmpList=cdr(tmpList)) R=car(tmp) tmp=nil
for(i 1 nPad tmp=tconc(tmp car(tmpList)) tmpList=cdr(tmpList)) T=car(tmp) tmp=nil
for(i 1 nPad tmp=tconc(tmp car(tmpList)) tmpList=cdr(tmpList)) L=car(tmp) tmp=nil


(foreach orient '( ("R0" "R180" spaceL sx B T ) ("R90" "R270" spaceH sy R L) )
(setq RH car(orient)) (setq RL cadr(orient)) (setq step eval(caddr(orient))) (setq dX eval(cadddr(orient))) 
(setq rListH eval(car(nthcdr(4 orient)))) 
(setq rListL eval(car(nthcdr(5 orient))))  (setq rListL reverse(rListL))
;printf("\norient: %L " orient) printf("\nnthorient: 4 %L 5 %L\n" nthcdr(4 orient)  nthcdr(5 orient))
;printf("space : %L %L step:  %L dX:%L H:%L L:%L \n" spaceL spaceH step dX rListH rListL)
(setq size 2*dX+nPad*padLength+(nPad+1)*step)  ; total 
bBox = append(bBox list(size))
isL = if((RH=="R0") then 1 else 0);; first  iteration
isH = if((RH=="R90") then 1 else 0); second iteration

(for i 1 nPad
cListH = car(rListH) cListL = car(rListL) ; first remaining element of RailLength and RailHeight
rListH = cdr(rListH) rListL = cdr(rListL) ; tail of the remaining list

; INSERTION des spacers
(dbCreateParamInst cv (dbOpenCellViewByType padLib inter  lay) nil (list isL*dX+isH*sizeL isH*dX) RH 1 list(list("width" "float" step-30))) ; "RO" ou R90
;printf("space : %L %L step:  %L dX:%L H:%L L:%L \n" spaceL spaceH step dX rListH rListL)
(setq dX dX+step)  ; <== incrémente point car RL flipped et next RH incrémenté
(dbCreateParamInst cv (dbOpenCellViewByType padLib inter  lay) nil (list isL*dX isH*dX+isL*sizeH) RL 1 list(list("width" "float" step-30)))

;; INSERTION PAD ROW1 ;;
(dbCreateInst cv (dbOpenCellViewByType padLib cadr(cListH) lay) nil (list isL*dX+isH*sizeL isH*dX) RH)	;ie. "PAD_IO" "RO" ou R90
;printf("insert %L %L in %L\n" car(cListH) (list isL*dX+isH*sizeL isH*dX) RH)
 ;; INSERTION label+text ROW1 ;;
when((RH=="R90") epinBox = list(-y0:x0 -y1:x1) etextBox = list(y0:x0 y1:x1) )
when((RH=="R0")  epinBox = list(x0:y0 x1:y1)   etextBox = list(x0:-y0 x1:-y1) )
refpBox=foreach( mapcar x epinBox   rodAddPoints(x (list isL*dX+isH*sizeL isH*dX))) ;; cgt de referenciel, suivant Origin du PAD
reftBox=foreach( mapcar x etextBox  rodAddPoints(x (list isL*dX+isH*sizeL isH*dX))) ;; cgt de referenciel, suivant Origin du PAD
leCreatePin(  cv pinLay "rectangle" refpBox car(cListH) "inputOutput" list("left" "right") )
dbCreateLabel(cv pinLay  centerBox(refpBox) car(cListH) "centerCenter" "R0" "roman" 3)
dbLabel=dbCreateLabel(cv "text"  centerBox(reftBox) car(cListH) "centerRight" sprintf(nil "R%d" 90*(norient+1)) "stick" 40)


(setq dX dX+padLength) ; <== incrémente point
 ;; INSERTION PAD ROW2 ;;
(dbCreateInst cv (dbOpenCellViewByType padLib cadr(cListL) lay) nil (list isL*dX isH*dX+isL*sizeH) RL)	;ie. "PAD_IO" "R180" ou R270
;printf("insert %L %L in %L\n" car(cListL) (list isL*dX isH*dX+isL*sizeH) RL)
 ;;INSERTION label+text ROW2 ;;
when((RL=="R270") epinBox = list(y0:-x0 y1:-x1)    etextBox = list(-y0:-x0 -y1:-x1) ) ;==> R90
when((RL=="R180") epinBox = list(-x0:-y0 -x1:-y1)  etextBox = list(-x0:y0 -x1:y1) ) ;==> R0
refpBox=foreach( mapcar x epinBox   rodAddPoints(x (list isL*dX isH*dX+isL*sizeH))) ;; cgt de referenciel, suivant Origin du PAD
reftBox=foreach( mapcar x etextBox  rodAddPoints(x (list isL*dX isH*dX+isL*sizeH))) ;; cgt de referenciel, suivant Origin du PAD
leCreatePin(  cv pinLay "rectangle" refpBox car(cListL) "inputOutput" list("left" "right") )
dbCreateLabel(cv pinLay  centerBox(refpBox) car(cListL) "centerCenter" "R0" "roman" 3)
dbCreateLabel(cv "text"  centerBox(reftBox) car(cListL) "centerRight" sprintf(nil "R%d" mod(270+norient*90 360)) "stick" 40)

); for nPad
;ending spacer before corner
(dbCreateParamInst cv (dbOpenCellViewByType padLib inter lay) nil (list isL*dX+isH*sizeL isH*dX) RH 1 list(list("width" "float" step-30)))  ; "RO" ou R90
(dbCreateParamInst cv (dbOpenCellViewByType padLib inter lay) nil (list isL*(dX+step) isH*(dX+step)+isL*sizeH) RL 1 list(list("width" "float" step-30)))
;dbCreateParamInstByMasterName( d_cellView t_libName t_cellName t_viewName t_name l_origin l_orient [ x_numInst [ l_params [ b_physOnly ] ] ] )
;     => d_inst | nil
;dbCreateParamInst( d_cellView d_master t_name l_point t_orient [ x_numInst [ l_params [ b_physOnly ] ] ] )
;     => d_inst | nil
;corners
(dbCreateInst cv (dbOpenCellViewByType padLib padCap lay) nil (list isH*sizeL 0) RH)
(dbCreateInst cv (dbOpenCellViewByType padLib padCap lay) nil (list isL*sizeL sizeH ) RL)
norient++
);foreach orient 0;180 puis 90;270

;dbCreateLabel(cv "text"  (0:0) sprintf(nil "bBox (L, H) : %L. \nArea : %L mm2" bBox car(bBox)*cadr(bBox)/1000000.0) "centerRight" "R0" "stick" 40)
dbCreateLabel(cv "text"  (sx:0) sprintf(nil "bBox (L, H) :\n%L\nArea :\n%L mm2" bBox car(bBox)*cadr(bBox)/1000000.0) "upperRight" "R0" "stick" 40)
printf("bBox (L, H) : %L price: %L  " bBox price*(240+car(bBox))*(240+cadr(bBox))/1000000.0)  printf(" nPad:%L nMiss %L\n" nPad nMiss)
dbSave(cv) dbClose(cv)
l_pins
);let
);proc


nbOfPin = 52
result ='() for(i 1 nbOfPin result=tconc(result sprintf(nil "pad_%d" i))) result=car(result)


; USAGE :

; exemple30_pin = '("in0" "in1" "in2" "in3" "in4" "in5" "in6" "in7" "in8" "in9" "in10" "in11" "in12" "in13" "in14" "in15" "in16" "in17" "in18" "in19" "in20" "in21" "in22" "in23" "in24" "in25" "in26" "in27" "in28" "in29" "in30" "in31")
;t2kNames = '( 
;("gnd!" "PAD_GND") ("vdd!" "PAD_ALIM")  "T1_8" "PS_ON1" "PS_ON7" "PS_ON8" "PS_RZ" "PS_RZ1" "Vref_SH" "Rpa" ("vdd!" "PAD_ALIM") ("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND") 
;("vdda!" "PAD_ALIM") ("gnd!" "PAD_GND" ) "OUT<8>" "OUT<7>" "OUT<6>" "OUT<5>" "OUT<4>" "OUT<3>" "OUT<2>" "OUT<1>" "OUT<0>" ("gnd!" "PAD_GND" ) ("vdda!" "PAD_ALIM")
;("gnd!" "PAD_GND") ("VDDB" "PAD_IO") "IN_BUF" "VSSB" "OUT_SH" "IN_SH" "Vref_SH1" ("vdd!" "PAD_ALIM") "OUT_PA"  ("VDD1" "PAD_IO") ("VSS1" "PAD_IO" ) "T1" ("gnd!" "PAD_GND" )
;("vdd!" "PAD_ALIM") ("gnd!" "PAD_GND" ) "IN<0>" "IN<1>" "IN<2>" "IN<3>" "IN<4>" ("vdd!" "PAD_ALIM") "IN<5>" "IN<6>" "IN<7>" "IN<8>" ("gnd!" "PAD_GND" ) 
;)

; createBox( exemple30_pin ) t
; createBox( exemple30_pin 35 5 "INNOTEP_v4" "box35") t
; createBox( result 80 5  "Ed" sprintf(nil "boox%d" nbOfPin)  "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter" "PAD_capa" "PAD_cell"  ) t
; createBox( result 80 5  "Ed" sprintf(nil "box%d" nbOfPin)  "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter" "PAD_capa" "PAD_cell" ) t

; createBox( t2kNames 5 50  "T2K_2009" sprintf(nil "bOx_%d" nbOfPin) "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell") t
; createBox( t2kNames 5 60  "T2K_V4" sprintf(nil "box_%d" nbOfPin) "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell") t
; createBox( result 5 40  "Ed_Si" sprintf(nil "box%d" nbOfPin) "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell_S35D4") t

; createBox( l_pinList 30 5 )
; createBox( l_pinList 5 5 )
; createBox( l_pinList 5 5 "INNOTEP_v4" )
; createBox( l_pinList 5 5 "INNOTEP_v4" "box" "PAD_IO" "PAD_GND" "PAD_ALIM")
; createBox( l_pinList 5 5 "INNOTEP_v4" "box" "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter1")
; createBox( l_pinList 5 5 "INNOTEP_v4" "box" "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter1" "PAD_capa")
; createBox( l_pinList 5 5 "INNOTEP_v4" "box" "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter1" "PAD_capa" "PAD_cell_S35D4")

;; ; load("~/Skill/pad_frame.il")
;; nbOfPin=84 bx=5 by=10
;; result ='() for(i 1 nbOfPin-1 result=tconc(result sprintf(nil "pad_%d" i))) result=car(result)
;; result = append(result '(("gnd!" "PAD_GND")))
;; createBox( result bx by "DSm" sprintf(nil "box%d_%dx%d" nbOfPin bx by) "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter1" "PAD_capa" "PAD_cell_S35D4")
