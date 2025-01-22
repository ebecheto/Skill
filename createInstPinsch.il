;; copyleft : ebecheto
; ineed('createInstPinsch t)
;(setq cv geGetWindowCellView())
;; inst=css()
;; (setq nlist '(("D" "Zi")("CLK" "Zi")))

ineed('(angleBox getInstTermPoint))

defun( createInstPinsch (@optional (insts t) (cv nil)(nlist '(("D" "Zi")("CLK" "Zi")))(inc -1)(skip nil)(inci t)(incL '("A" "B" "C" "D" "E" "F" "H" "I" "J" "K" "L") )(rev nil))
let(( dx ic terms pinName sbBox bBox os x y orient wid lab label)
;inc="name" ||t || number(ie. 1)
unless(skip skip='("VDD" "NW" "SX" "GND"))
; printf("inc=%L__%L\n" inc incL )
(setq font "euroStyle")
dx=0.125;*2
ic=0
unless(cv cv=geGetWindowCellView())
when(insts=='t insts=geGetSelectedSet())
unless(insts insts=cv~>instances)
;unless(listp(insts) insts=list(insts))
insts=setof(inst insts inst~>objType=="inst")
;; printf("** CV=%L\n" cv~>?? )
;inst=css()
foreach(inst insts 
when(inci ic++)
terms=inst~>terminals
;term=car(terms)
foreach(term terms ;term=car(terms);~>??
pinName=term~>name
unless(
term~>net~>figs
when( point=cadr(assoc(pinName getInstTermPoint(inst)))
unless(inci ic++)
;printf("%L\n" inst~>??)
sbBox=car(setof(x inst~>master~>shapes x~>layerName=="instance" && x~>objType=="rect")~>bBox);||list(0:0 0:0)
bBox=dbTransformBBox(sbBox inst~>transform)
os=angleBox(point bBox)
;printf("os='%L point='%L bBox='%L pinName='%L\n"  os point bBox pinName)
x=car(point) y=cadr(point)
cond((os==0 y=y-dx)(os==1 x=x+dx)(os==2 y=y+dx)(os==3 x=x-dx))
orient=sprintf(nil "R%d" mod(90*(os+1) 360))
wid=schCreateWire( cv "draw" "direct" list(point x:y) 0.0625 0.0625 0 ); <== creat wire line
when(an=assoc(pinName nlist) pinName=cadr(an))
when(inc==t while(member(label=sprintf(nil "%s_%d" pinName ic) cv~>sigNames ) ic++))
switches=list(pinName cadr(parseString(inst~>cellName "_"))||inst~>cellName)
when(rev switches=reverse(switches))
when(inc=="name" label=sprintf(nil "%s_%s" nth(0 switches) nth(1 switches) ))
when(numberp(inc) label=sprintf(nil "%s%s" pinName nth(inc incL)||""))
when(member(pinName skip) label=pinName)
lab=schCreateWireLabel(cv car(wid) centerBox(list(point x:y)) label "lowerRight" orient font 0.0625 nil)
;pin=leCreatePin(cv lpp "rectangle" point tName dir accessDir)
))))));=> done also by wirePinName


printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L)\n" '(("D" "Zi_")("CLK" "Zi_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L)\n" '(("D" "Z_")("CLK" "Z_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L)\n" '(("A" "Z_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L)\n" '(("A" "Zi_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() nil %L)\n" "name")
printf("createInstPinsch(geGetSelectedSet() cv nil t)\n")
printf("createInstPinsch(list(css()) nil '%L t)\n" '(("instpin_A" "netToPut_Z_")))
printf("createInstPinsch(t nil '%L t)\n" '(("instpin_A" "netToPut_Z_")))
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() nil -1 nil nil);<= last one in use\n")
printf("createInstPinsch(geGetSelectedSet() geGetWindowCellView() '%L -1 nil t '%L)\n" '(("A" "Zi_")) '("L" "1" "2" "3" "4" "6" "8"))
printf("schCheck(cv) dbSave(cv) : CHECK AND SAVE BEFORE USING : createInstPinsch\n")
;css()~>terminals~>net~>figs
;; a='() for(i 1 11 a=append(a list("INVERT_B")))
;; addCell(a)
printf("createInstPins();<= cree les pins de l'instance layout selectionnee. No LVS proof\n")
printf("createInstPinsch();<= cree les pins de l'instance schematic selectionnee pr IBM c cool!\n")

printf("createInstPinsch((dbCreateInst cvsim vfes \"I<0:16>\" -7.0:0  \"R0\")  cvsim '((\"iin\" \"Y<99>,Y<117>,Y<135>,Y<260>,Y<278>,Y<296>,Y<314>,Y<439>,Y<457>,Y<475>,Y<600>,Y<618>,Y<636>,Y<654>,Y<779>,Y<797>,Y<815>\")) )")
printf("^^^^^^^^^^^^^^^ Create an instance<0:16> with its pin 'iin' with a custom label busname\n")
printf("^^^^^^^^^^^^^^^ instance creation can be made (preferably) separately of course\n")
