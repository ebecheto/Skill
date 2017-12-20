equiv='( ("^INVD" "^INV") ("^ND2" "^NAND2" ) ("^ND3_" "^NAND3" ) ("^ND4_" "^NAND4" ) ("^AN2D" "^AND2" ) ("^AN3D" "^AND3" ) ("^AN4D" "^AND4" ) ("^NR2D" "^NOR2" ) ("^NR3D" "^NOR3" ) ("^NR4" "^NOR4" )  ("^BUFFD" "^BUFFER_") ("^DFD" "^DF" ) ("^AO" "^AO") ("^MUX2D" "^MUX2") ("^MUX3D" "^MUX3") ("^MUX4D" "^MUX4") ("^MUX2ND" "^IMUX2") ("^MUX3ND" "^IMUX3") ("^IMUX4ND" "^IMUX4")("^CKBD" "^CLKBU"))


;flip=mkFlipList2("CORELIB" "tcb013ghp" foreach(mapcar equ equiv reverse(equ)) nil t)  ; AMS_C35->TSMC130
ineed('mkFlipList t)
flip=mkFlipList2("CORELIB" "tcb013ghp" foreach(mapcar equ equiv reverse(equ)) t t)  ; AMS_C35->TSMC130

;; ;; studdy 
;; foreach(mapcar inst geGetSelectedSet()
;; foreach(mapcar prop inst~>prop list(prop~>name prop~>value)))
;; OR :
;; inst=css() cdfgData=(cdfGetInstCDF inst)
;; foreach(mapcar param cdfgData~>parameters list(param~>name param~>value))


flip=append(flip '(("pmos4" "pmos1v" "tsmc13rf"   (("flipProp" (("wtot" "w")("ng" "fingers")))))))
flip=append(flip '(("nmos4" "nmos1v" "tsmc13rf"   (("flipProp" (("wtot" "w")("ng" "fingers")))))))
flip=append(flip '(("rpoly2c" "rppoly_dis" "tsmc13rf" )))
flip=append(flip '(("rpoly2" "rplpoly" "tsmc13rf" )))
;; flip=append(flip '(("rpolyhc" "rppolywo_dis" "tsmc13rf"  )))
flip=append(flip '(("rpolyhc" "rppolyhri_dis" "tsmc13rf"  )))
flip=append(flip '(("rpolyh" "rphpoly" "tsmc13rf" )))
flip=append(flip '(("cpolyc" "crtmom" "tsmc13rf" (("flipPin" (("PLUS" "PLUS")("MINUS" "MINUS")("SUB" "BULK")))))))
flip=append(flip '(("cpoly" "mimcap" "tsmc13rf" (("flipPin" (("PLUS" "TOP")("MINUS" "BOTTOM")))))))


resList='("rplpoly" "rphpoly")
resList3T='("rppoly_dis" "rppolywo_dis" )


flip=foreach(mapcar fp flip if(and(length(fp)==3 or(member(cadr(fp) resList3T)))
then fp=append(fp '((("flipProp" (("r" "res")))("sideWays")("flipPin" (("PLUS" "PLUS")("MINUS" "MINUS")("REF" "BULK")))))) else fp))

flip=foreach(mapcar fp flip if(and(length(fp)==3 or(member(cadr(fp) resList)))
then fp=append(fp '((("flipProp" (("r" "res")))))) else fp))

;; setof(lib ddGetLibList() lib~>name=="tcb013ghp")~>cells~>name
;; ;"INVD"
;; lib1="CORELIB"
;; lib2="tcb013ghp"
;; co35=sort123(car(setof(lib ddGetLibList() lib~>name==lib1)~>cells~>name) ) 
;; co18=sort123(car(setof(lib ddGetLibList() lib~>name==lib2)~>cells~>name)) ;
;; ; what was i trying to do vvv ? Wed Sep  6 11:07:23 CEST 2017
;; alphaNum(setof(c co18 rexMatchp(lowerCase(co35) lowerCase(c) )))
;; ;;; dunno


