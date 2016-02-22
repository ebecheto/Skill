;; copyleft ebecheto
;load("netSetPatch.il")


procedure( netSetPatch(@optional (cv nil) (GND "GND")(VDD "VDD")(SUB "sub"))
let((pList a insts VDDo VDDr GNDo GNDr)
unless(cv cv=geGetWindowCellView())
insts=geGetSelectedSet()||cv~>instances
unless(SUB SUB=GND)
when(rexMatchp("TECH_C35" techGetTechFile(cv)~>libName)
printf("apply netSet power:%s ground:%s\n" VDD GND)
pList='(
("APRIOP"    ("vdd3r" VDD)("vdd3o" VDD)("gnd" GND) )
("AGND3ALLP" ("vdd3o" VDD)("gnd" GND))
("AVDD3ALLP" ("vdd3r" VDD)("vdd3o" VDD)("gnd" GND) )
("BBCU4P"    ("vdd3r" VDD)("vdd3o" VDD)("gnd" GND) )
("APRIOP_3B"    ("vdd3r" VDD)("vdd3r1" VDD)("vdd3r2" VDD)("vdd3o" VDD)("gnd3o" GND)("gnd3r" GND))
("AVSUBP_3B"    ("vdd3r" VDD)("vdd3r1" VDD)("vdd3r2" VDD)("vdd3o" VDD)("gnd3o" GND)("gnd3r" GND))
("AGND3ALLP_3B" ("vdd3r" VDD)("vdd3r1" VDD)("vdd3r2" VDD)("vdd3o" VDD)("gnd3o" GND)("gnd3r" GND))
("AVDD3ALLP_3B" ("vdd3r" VDD)("vdd3r1" VDD)("vdd3r2" VDD)("vdd3o" VDD)("gnd3o" GND)("gnd3r" GND))
("BBCU4P_3B"    ("vdd3r" VDD)("vdd3r1" VDD)("vdd3r2" VDD)("vdd3o" VDD)("gnd3o" GND)("gnd3r" GND))
("AVDD3ALLC_3B" ("vdd3r" VDD)("vdd3o" VDD)("gnd3o" GND) ) ;("vsubo!" SUB) let's make it common short M2
("AVSUBC_3B" ("vdd3o" VDD)("gnd3o" GND)) ;("vsubo!" SUB)  
("AGND3ALLC_3B" ("vdd3o" VDD)("gnd3o" GND)("gnd3r" GND));("vsubo!" SUB)
)
;printf("%L %L\n" GND VDD)
foreach(mapcar inst insts
when(a=assoc(inst~>cellName  pList) foreach(mapcar net cdr(a) 
if(prop=dbGetPropByName(inst car(net)) 
then
prop~>value=eval(cadr(net))
else
dbCreateProp(inst car(net) "netSet" eval(cadr(net))) inst~>name
)))
))))

;netSetPatch(geGetWindowCellView() "VSSB" "VDDB")
;netSetPatch(geGetWindowCellView() "VSS" "VDD")

; netSetPatch( nil "VSSB" "VDDB" "sub! )
; netSetPatch( nil "vdd!" "gnd!" )