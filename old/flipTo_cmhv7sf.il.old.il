;; load "~/Skill/h18_to_130.il"

;; fp='("NOR20" "NOR2_A")
;; tata~>cellName==

; when(tata~>cellName==car(fp)||strcat(car(fp) "_3B") tata~>master=dbOpenCellViewByType("cmos8rf" cadr(fp) "symbol") )


;; ih = car(setof( instHead cv~>instHeaders instHead~>libName == "origLibName" && instHead~>cellName == "origCellName")
;; dbSetInstHeaderMasterName(ih "NEW_PROCESS" ih~>cellName ih~>viewName)
;; setof( oldProp  css()~>prop  oldProp~>name == "wf" )
;; setof( newProp  css()~>prop  newProp~>name == "w" )
;; css()~>prop~>??
;; foreach(mapcar prop css()~>prop  when(prop~>name=="w" printf("oldProp %s=%s convert to : \n" prop~>name prop~>value)))
;; dbCreateProp(inst "w" "float" )
;; tata~>prop~>??
;; when(setof( newProp   css()~>prop newProp~>name=="wf" ) newProp=dbCreateProp(css() "w" "float" ))

;; car(setof(lib ddGetLibList() lib~>name=="cmhv7sf"))
;; car(setof(lib ddGetLibList() lib~>name=="cmhv7sf"))~>cells~>name
;; co35=sort(car(setof(lib ddGetLibList() lib~>name=="CORELIB"))~>cells~>name 'alphalessp)     ;=> 262
;; co18=sort(car(setof(lib ddGetLibList() lib~>name=="CORELIB_H18"))~>cells~>name 'alphalessp) ;=> 476 pfff....



defun( alphaNum (aa) let((sa csa tsa) sa=list(car(aa)) csa=cdr(aa)
foreach( a csa tsa='() csa=sa
(when alphaNumCmp(a car(csa))<0  sa=append(list(a) csa) csa='())
while( csa&&alphaNumCmp(a car(csa))>=0
tsa=append(tsa list(car(csa))) csa=cdr(csa))
sa=append(append(tsa list(a)) csa)
) sa))

co35=sort(car(setof(lib ddGetLibList() lib~>name=="CORELIB"))~>cells~>name 'alphalessp)     ;=> 
co18=sort(car(setof(lib ddGetLibList() lib~>name=="CORELIB_H18"))~>cells~>name 'alphalessp) ;=> 476 pfff....
co35=alphaNum(co35)
co18=alphaNum(co18)

coType='( "^INV" "NAND2" "NAND3" "NAND4" "NOR2" "NOR3" "NOR4" "^BUF" "DF" "^AO" "^MUX2" "^MUX3" "^MUX4" "^IMUX2" "^IMUX3" "^IMUX4")
coType=append(coType list("^CLKBU" "^CLKIN")) 
alphaNum(setof(c co35 rexMatchp("NAND4" c )))

;; vaut mieux matcher NAND3 NAND4 ...
;  and sort PB : alphalessp notgood enough => defun( alphaNum ...)


compare=foreach(mapcar co coType list(
alphaNum(setof(c co35 rexMatchp(co c )) )
alphaNum(setof(c co18 rexMatchp(co c )) ) ))

; setof(c co35 rexMatchp("AND" c ))
inv=car(compare) invList='()
for(i 1 
max(length(car(inv)) length(cadr(inv)))
un=nth(i car(inv) )||un
de=nth(i cadr(inv))||de
invList=append(invList list(list(un de)))
) invList

fullList=foreach(mapcar comp compare
compList='()
for(i 0 
length(car(comp))-1
; max(length(car(comp)) length(cadr(comp)))-1; convertion c35 to 180nm donc pas besoin de plus d'element que c35.
un=nth(i car(comp) )||un
de=nth(i cadr(comp))||de
compList=append(compList list(list(un de "CORELIB_H18" )))
) compList)


flatList='() foreach(mapcar co fullList flatList=append(flatList co)); 141 element, enougth for now

; ________________________________________________________________________________________________________________________________________________________________
cv = geGetWindowCellView()
flip='()
;; flip='(("INV0" "INVERT_A")("INV1" "INVERT_B")("INV2" "INVERT_C")("INV3" "INVERT_D")("INV4" "INVERT_E")("INV6" "INVERT_F")("INV8" "INVERT_H")("INV10" "INVERT_I")("INV12" "INVERT_J")("INV15" "INVERT_K"))
;; flip=append(flip '(("NOR20" "NOR2_A")("NOR21" "NOR2_B")("NOR22" "NOR2_C")("NOR23" "NOR2_D")("NOR24" "NOR2_E")("NOR26" "NOR2_F")("NOR28" "NOR2_H")) )
;; flip=append(flip '(("BUF2" "BUFFER_C")("BUF4" "BUFFER_D")("BUF6" "BUFFER_E")("BUF8" "BUFFER_F")("BUF12" "BUFFER_H")("BUF15" "BUFFER_I")) )
;; flip=append(flip '(("NAND20" "NAND2_A")("NAND21" "NAND2_B")("NAND22" "NAND2_C")("NAND23" "NAND2_D")("NAND24" "NAND2_E")("NAND26" "NAND2_F")("NAND28" "NAND2_H")) )
;; flip=append(flip '(("DF1" "DFFR_E") ))
flip=append(flip '("subc" ("cap" "cmimx") ))
flip=append(flip '(("rpoly2" "oprpres")("rpoly2" "oprpres")("rpolyhc" "oprrpres")("rpolyhc" "oprrpres") ))

dftNewLib="cmhv7sh" concFlip='()
foreach(fp flip 
when(!listp(fp) fp=list(fp))
when(length(fp)==1 fp=append(fp fp))
when(length(fp)==2 fp=append(fp list(dftNewLib)))
when(length(fp)>4 printf("For now AST of 4 max not %d %L\n" length(fp) fp))
concFlip=tconc(concFlip fp)
) flip=car(concFlip)


;; ;; for DIGITAL cells, PRIMLIB output is named Q but cmos8rf output is named Z  ;not true for cmhv7sh
;; flip=foreach(mapcar fp flip 
;; if(caddr(fp)=="cmos8rf"&&length(fp)>=3 then fp=append(fp '((("flipPin" (("Q" "Z")))))) else fp))


; cmhv7sf_pfetx -> cmrf8sf_pfet

foreach(mapcar inst cv~>instances
when(inst~>libName=="cmhv7sf"
printf("___ Changing Instance %s %s" inst~>name inst~>cellName)
when(inst~>cellName=="pfet"||inst~>cellName=="pfetx" inst~>master=dbOpenCellViewByType("cmrf8sf" "pfet" "symbol") )
when(inst~>cellName=="nfet"||inst~>cellName=="nfetx" inst~>master=dbOpenCellViewByType("cmrf8sf" "nfet" "symbol") )
printf(" to -> %L >>>\n" inst~>cellName)
when(inst~>cellName=="nfet"||inst~>cellName=="pfet" 
printf("-> PROP  %L_%L __" inst~>name inst~>cellName)
; printf("PROP: %L %L %L %L\n" prop~>name prop~>value prop~>object prop~>objType)
;; inst~>libName="cmrf8sf" ;<== impossible de changer libname, il faut passer par le master.
flop='("w" "wf")
oldProp=car(setof( oldProp   inst~>prop oldProp~>name==car(flop) ))
when(not(setof( newProp   inst~>prop newProp~>name==cadr(flop) )) newProp=dbCreateProp(inst cadr(flop) "string" oldProp~>value))
newProp~>value=oldProp~>value
printf(": %s=%L %s=%L\n" oldProp~>name oldProp~>value newProp~>name newProp~>value)
);end when nmos

when(master=dbOpenCellViewByType("cmrf8sf" inst~>cellName "symbol")
	printf("<- Update %s into  %L ->\n" inst~>libName inst~>cellName)
		inst~>master=master) ;end default when name exist in lib1 and lib2
);end when_cmhv7sf



when(inst~>libName=="CORELIB"||inst~>libName=="CORELIB_HV"
foreach(mapcar fp flip
;;printf("Trying %s<->%s\n" car(fp) cadr(fp))
when(inst~>cellName==car(fp)||inst~>cellName==strcat(car(fp) "_HV") 
	printf("___ Change Instance %s %s %s" inst~>libName inst~>name inst~>cellName cadr(fp))
	inst~>master=dbOpenCellViewByType("cmos8rf" cadr(fp) "symbol") 
	printf("-> into  %L ___\n" inst~>cellName)
	);end when element of list fp
))

when(inst~>libName=="cmhv7sf"
foreach(mapcar fp flip
;;printf("Trying %s<->%s\n" car(fp) cadr(fp))
when(inst~>cellName==car(fp)||inst~>cellName==strcat(car(fp) "_3B") 
	printf("___ Changing Instance %s %s %s" inst~>name inst~>cellName cadr(fp)) 
	inst~>master=dbOpenCellViewByType("cmrf8sf" cadr(fp) "symbol")
	printf("-> into  %L ___\n" inst~>cellName)
	);end when element of list fp
);end foreach element to replace
);end CORELIB
);end foreach

