;; eventually loaded from "~/Skill/mos2fet.il"
unless(fboundp('mkFlipList) load("mkFlipList.il"))

;; ;; construction of list "flip" has to be updated for other technologies.
;; flip='(("INV0" "INVERT_A")("INV1" "INVERT_B")("INV2" "INVERT_C")("INV3" "INVERT_D")("INV4" "INVERT_E")("INV6" "INVERT_F")("INV8" "INVERT_H")("INV10" "INVERT_I")("INV12" "INVERT_J")("INV15" "INVERT_K"))
;; flip=append(flip '(("NOR20" "NOR2_A")("NOR21" "NOR2_B")("NOR22" "NOR2_C")("NOR23" "NOR2_D")("NOR24" "NOR2_E")("NOR26" "NOR2_F")("NOR28" "NOR2_H")) )
;; flip=append(flip '(("BUF2" "BUFFER_C")("BUF4" "BUFFER_D")("BUF6" "BUFFER_E")("BUF8" "BUFFER_F")("BUF12" "BUFFER_H")("BUF15" "BUFFER_I")) )
;; flip=append(flip '(("NAND20" "NAND2_A")("NAND21" "NAND2_B")("NAND22" "NAND2_C")("NAND23" "NAND2_D")("NAND24" "NAND2_E")("NAND26" "NAND2_F")("NAND28" "NAND2_H")) )


equiv='( ("^INVERT_" "^INV") ("^NAND2_" "^NAND2" ) ("^NAND3_" "^NAND3" ) ("^NAND4_" "^NAND4" ) ("^AND2_" "^AND2" ) ("^AND3_" "^AND3" ) ("^AND4_" "^AND4" ) ("^NOR2_" "^NOR2" ) ("^NOR3_" "^NOR3" ) ("^NOR4_" "^NOR4" )  ("^BUF" "^BUFFER_") ("^DF" "^DF" ) ("^AO" "^AO") ("^MUX21_" "^MUX2") ("^MUX31_" "^MUX3") ("^MUX41_" "^MUX4") ("^IMUX2" "^IMUX2") ("^IMUX3" "^IMUX3") ("^IMUX4" "^IMUX4")("^CLK_" "^CLKBU"))


mkFlipList2("cmos8rf" "CORELIB" equiv) ; IBM130->AMS_C35
flip=mkFlipList2("CORELIB" "cmos8rf" foreach(mapcar equ equiv reverse(equ)))  ; AMS_C35->IBM130


flip=append(flip '(("DF1" "DFF_E" "cmos8rf" (("flipPin" (("Q" "Q")("QN" "QBAR")("D" "D")("C" "CLK")) ))) ))

; DIGITAL construct list
dftNewLib="cmos8rf" concFlip='()
foreach(fp flip 
when(length(fp)==1 fp=append(fp list(fp)))
when(length(fp)==2 fp=append(fp list(dftNewLib)))
concFlip=tconc(concFlip fp)
) flip=car(concFlip);=> ("INV0" "INVERT_A" "cmos8rf") ("INV1" "INVERT_B" "cmos8rf")

; PRIMLIB => new Lib construc
flip=append(flip '("subc"  ("rpolyhc" "oprppres")("rpolyh" "oprppres")("rpoly2c" "oprppres")("rpoly2" "oprppres")))
flip=append(flip '(("cpoly" "mimcap" "cmrf8sf" (("flipPin" (("PLUS" "D")("MINUS" "S")))))))
flip=append(flip '(("cpolyc" "vncap" "cmrf8sf" (("flipPin" (("PLUS" "D")("MINUS" "S")("SUB" "G")))))))
flip=append(flip '(("nmos4" "nfet" "cmrf8sf"   (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf")))))))
flip=append(flip '(("nmos4" "lvtnfet" "cmrf8sf"   (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf")))))))
flip=append(flip '(("pmos4" "pfet" "cmrf8sf"   (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf")))))))
dftNewLib="cmrf8sf" concFlip='()
foreach(fp flip 
when(!listp(fp) fp=list(fp))
when(length(fp)==1 fp=append(fp fp))
when(length(fp)==2 fp=append(fp list(dftNewLib)))
when(length(fp)>4 printf("For now AST of 4 max not %d %L\n" length(fp) fp))
concFlip=tconc(concFlip fp)
) flip=car(concFlip)

;; append options for pins correspondences ie. 'rpolyhc' terminals are : MINUS, PLUS REF, where 'oprppres' terminals are S, D and G.
flip=foreach(mapcar fp flip 
if(cadr(fp)=="oprppres"&&length(fp)==3 then fp=append(fp '((("flipPin" (("MINUS" "S")("PLUS" "D")("REF" "G")))))) else fp))

;; for DIGITAL cells, PRIMLIB output is named Q but cmos8rf output is named Z à part DF1<->DFFR
flip=foreach(mapcar fp flip 
if(and(caddr(fp)=="cmos8rf" length(fp)>=3 not(apply('or foreach(mapcar spec car(nthcdr(3 fp)) (car spec)=="flipPin" ))))
then fp=append(fp '((("flipPin" (("Q" "Z")))))) else fp))



; foreach(mapcar fp flip not(apply('or foreach(mapcar spec car(nthcdr(3 fp)) (car spec)=="flipPin" )))) ;;=> montre les elements qui n'ont pas l'option sideWays
; foreach(mapcar fp flip apply('or foreach(mapcar spec car(nthcdr(3 fp)) (car spec)=="sideWays" ))) ;;=> montre les elements qui ont l'option sideWays

;; ; note that oprppres will also be vertically mirrored, but is does not cause any PB
;; ; If we want to adapt the difference in two different symbol from 2 dif. techno, ONE adjustement is possible
;; ; Please determine on your own what is the 'optimum' adjustment
;; AA=dbOpenCellViewByType("PRIMLIB" "rpolyhc" "symbol")
;; BB=dbOpenCellViewByType("cmrf8sf" "oprppres" "symbol")
;; adjust=rodSubPoints(getMasterTermPoint(AA "PLUS") getMasterTermPoint(BB "S"))
;; ;==> (0.0 0.1875)

;; AA=dbOpenCellViewByType("PRIMLIB" "nmos4" "symbol")
;; BB=dbOpenCellViewByType("cmrf8sf" "nfet" "symbol")
;; adjust=mapcar('minus rodSubPoints(getMasterTermPoint(AA "B") getMasterTermPoint(BB "B"))) 
;; ;==> (0.0625 0.0)


flip=foreach(mapcar fp flip if(and(or(car(fp)=="nmos4" car(fp)=="pmos4") length(fp)>=3) then 
list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0625 0.0) )))) else fp))

flip=foreach(mapcar fp flip if(cadr(fp)=="oprppres"&&length(fp)>=3 then 
list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0 0.1875) )))) else fp))


;; append options for swapping instance on a two-pin axe. ie. oprppres and rpolyXc are mirrored on the axe of their pins "S" "D" (resp. "PLUS" "MINUS")
flip=foreach(mapcar fp flip if(cadr(fp)=="oprppres"&&length(fp)>=3 then 
list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("sideWays")))) else fp))


;; append(cadddr(f2) '(("adjust" '(0.0625 0.0) ))); => (  ("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))   ("adjust" '(0.0625 0.0))  )


;; f1='("pmos4" "pfet" "cmrf8sf")
;; f2='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) )
;; fp='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) (("adjust" '(0.0625 0.0))))
;; f4='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) (("adjust" '(0.0625 0.0))))


;; car(setof(lib ddGetLibList() lib~>name=="cmos8rf"))~>cells~>name
;; car(setof(lib ddGetLibList() lib~>name=="cmrf8sf"))~>cells~>name
