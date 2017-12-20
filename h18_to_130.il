;; load "~/Skill/h18_to_130.il"
cv = geGetWindowCellView()
flip='(("INV0" "INVERT_A")("INV1" "INVERT_B")("INV2" "INVERT_C")("INV3" "INVERT_D")("INV4" "INVERT_E")("INV6" "INVERT_F")("INV8" "INVERT_H")("INV10" "INVERT_I")("INV12" "INVERT_J")("INV15" "INVERT_K"))
flip=append(flip '(("NOR20" "NOR2_A")("NOR21" "NOR2_B")("NOR22" "NOR2_C")("NOR23" "NOR2_D")("NOR24" "NOR2_E")("NOR26" "NOR2_F")("NOR28" "NOR2_H")) )
flip=append(flip '(("BUF2" "BUFFER_C")("BUF4" "BUFFER_D")("BUF6" "BUFFER_E")("BUF8" "BUFFER_F")("BUF12" "BUFFER_H")("BUF15" "BUFFER_I")) )
flip=append(flip '(("NAND20" "NAND2_A")("NAND21" "NAND2_B")("NAND22" "NAND2_C")("NAND23" "NAND2_D")("NAND24" "NAND2_E")("NAND26" "NAND2_F")("NAND28" "NAND2_H")) )
flip=append(flip '(("DF1" "DFFR_E") ))
flip=append(flip '(("subcx" "subc")("cmimx" "mimcap") ))
flip=append(flip '(("opppcresx" "opppcres") ))

flip=append(flip '(("OA21X1" "OA21")("OA21X2" "OA21_B")("OA21X3" "OA21_C") ))
flip=append(flip '(("OAI22X1" "OAI22")("OAI22X2" "OAI22_B")("OAI22X3" "OAI22_C") ))
flip=append(flip '(("NOR2XL" "NOR2_A")("NOR2X2" "NOR2_B")("NOR22X3" "NOR2_C") ))

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

