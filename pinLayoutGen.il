;; copyleft ebecheto

; unless(fboundp('getInstTermPoint) load("padRing.proc.il"))
; getInstTermPoint(css());<= recode. besoins de LPP aussi

ineed('(getInstTermPointLPP pinAddText))
;; unless(fboundp('pinAddText) load("pinAddText.il"))
;; load("pinLayoutGen.il")

defun( pinLayoutGen (@optional (name "in") (nbs lnReg(1 8 1)) (step 1.3) (cv geGetWindowCellView())  (zoom t) (addT t))
let((pos pts box size pin)
;  nb=8
size=0.6
;; cv=geGetWindowCellView()
;; p=car(cv~>terminals~>pins)
;; term=car(cv~>terminals)
;; pos=car(cv~>bBox)
pos=list(round(caar(cv~>bBox)) round(cadar(cv~>bBox)))
pts=rodSubPoints(pos 0:10)
box=list(rodSubPoints(pts 0.6:0.6) pts )
dir="inputOutput";dir="input" 
accessDir=list("top" "bottom" "left" "right")
; lpp=list("PIN" "metal1"); 
lpp=list("MET1" "drawing")
s=0
foreach(i nbs
s=s+step
box=list(rodSubPoints(rodAddPoints(pts s:0) 0.6:0.6) rodAddPoints(pts s:0) )
nom=sprintf(nil "%s_%d" name i)
pin=leCreatePin(cv lpp "rectangle"  box nom dir accessDir)
; printf("Create :%d\n" i)
)
when(zoom hiZoomIn(hiGetCurrentWindow() list(rodSubPoints(car(pin~>fig~>bBox) 10:10) rodAddPoints(cadr(pin~>fig~>bBox) 10:10) )))
when(addT pinAddText(geGetWindowCellView() "drawing" "R90"))
))

nbrs='()
foreach(lst list(
linRg(1 8 1) 
reverse(linRg(1+8 8+8 1))
linRg(1+8*2 8*3 1) 
reverse(linRg(1+8*3 8*4 1))
)
nbrs=append(nbrs lst))



printf("pinLayoutGen(%L '(1 2 3 4))\n" "In");=> generate In_1 In_2 In_3 In_4 pins
printf("pinLayoutGen(%L linRg(1 8 2))\n" "In");=> generate In_1 to In_10
printf("pinLayoutGen(%L nbrs)\n" "In") ;=> generate the list of numbrers in the list nbrs
printf("pinLayoutGen(%L nbrs 1.3);<= 1.3 : default step\n" "In")
printf("pinLayoutGen(%L '%L)\n" "In" list(1 2 3 4 5 6 7 8 16 15 14 13 12 11 10 9 17 18 19 20 21 22 23 24 32 31 30 29 28 27 26 25))

; pinLayoutGen("In" nbrs)
; pinAddText(geGetWindowCellView() "drawing" "R90")




;cv=geGetWindowCellView()
sList='("T1" "IN" ("OUTB" "PA"))

defun( pinLayoutSub (@optional (sList '("T1" ("in_pa" "IN") ("OUTB" "PA"))) (insts geGetSelectedSet()) (cv geGetWindowCellView()) )
;insts=geGetSelectedSet()
;inst=car(insts)
subList=foreach(mapcar sub sList if(stringp(sub) list(sub sub) sub))
foreach(inst insts
lpps=getInstTermPointLPP(inst)
pinList=foreach(mapcar sub subList
i=1
; sub=car(subList)
; sub=nth(2 subList)
;cv~>terminals~>name
pin=cadr(sub) pinin=car(sub)
while(member(subs=sprintf(nil "%s<%d>" pin i) cv~>terminals~>name) i++)
;pinin="OUTB"
lp=assoc("IN" lpps)
lp=assoc(pinin lpps) 
dbPin=nth(4 lp)
lpp=nth(2 lp)
box=nth(3 lp)
dir=dbPin~>pin~>term~>direction
acc=dbPin~>pin~>accessDir
printf("%L\n" list(pin pinin subs box dir acc))
pin=leCreatePin(cv lpp "rectangle"  box subs dir acc)
)
pinAddText(pinList)
))

printf("pinLayoutSub();<== change T1 en T1<1> , in_pa en IN<1>, OUTB en PA<1> et incremente, les instances selectionnnes\n")
printf("pinLayoutSub('(\"T1\" (\"in_pa\" \"IN\")(\"OUTB\" \"PA\")));<== si T1<1> existe => T<2>\n")

