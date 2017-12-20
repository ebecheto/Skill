;; load "~/Skill/mos2fet.il"
cv = geGetWindowCellView()
flip='(("INV0" "INVERT_A")("INV1" "INVERT_B")("INV2" "INVERT_C")("INV3" "INVERT_D")("INV4" "INVERT_E")("INV6" "INVERT_F")("INV8" "INVERT_H")("INV10" "INVERT_I")("INV12" "INVERT_J")("INV15" "INVERT_K"))
flip=append(flip '(("NOR20" "NOR2_A")) )

foreach(mapcar inst cv~>instances
printf("Entering inst %L\n" inst~>name)
when(inst~>libName=="CORELIB"||inst~>libName=="CORELIB_3B"
foreach(mapcar fp flip
printf("Trying %s<->%s\n" car(fp) cadr(fp))
when(inst~>cellName==car(fp)||inst~>cellName==strcat(car(fp) "_3B") 
	printf("___ Changing Instance %s %s" inst~>name inst~>cellName) 
	inst~>master=dbOpenCellViewByType("cmos8rf" cadr(fp) "symbol") 
	printf("-> into  %L ___\n" inst~>cellName)
	);end when element of list fp
);end foreach element to replace
);end CORELIB
);end foreach

