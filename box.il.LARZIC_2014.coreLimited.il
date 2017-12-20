;  load("box.il.LARZIC_2014.coreLimited.il")
; load("padRing.il")

println(i=foreach(mapcar p linRg(1 16 1) sprintf(nil "IN_%d" p)))
println(foreach(mapcar p linRg(1 16 1) sprintf(nil "PA_%d" p)))
println(t1=foreach(mapcar p linRg(1 16 1) sprintf(nil "T1_%d" p)))
mapcan('list i t1)

println(foreach(mapcan p linRg(1 16 1) a=list(sprintf(nil "IN_%d" p) sprintf(nil "T1_%d" p)) if(evenp(p) reverse(a) a)))


larzPin='(
("VSS" "AGND3ALLC_3B") 
"ENA"
("VDD" "AVDD3ALLC_3B") 
"VDB1"
"VSB2"
("VSS" "AGND3ALLC_3B") 

;("CUT" "PWRCUT_DIG_C_3B_DXS")
("VDDB" "AVDD3ALLC_3B") 
("VSSB" "AGND3ALLC_3B") 
"VBBB"
"OUT"
"OUTN"
("VDDB" "AVDD3ALLC_3B") 
("VSSB" "AGND3ALLC_3B") 
("vsub!" "AVSUBC_3B") 
;("CUT" "PWRCUT_DIG_C_3B_DXS")

("VSS" "AGND3ALLC_3B") 
("VDD" "AVDD3ALLC_3B")
("VSS" "AGND3ALLC_3B") 
("vsub!" "AVSUBC_3B") 

"ENA2"
"Vref"

"IN_9"
"T1_9"
"T1_10"
"IN_10"
"IN_11"
"T1_11"
"T1_12"
"IN_12"
"IN_13"
"T1_13"
"T1_14"
"IN_14"
"IN_15"
"T1_15"
"T1_16"
"IN_16"

("VSS" "AGND3ALLC_3B") 
("VSS" "AGND3ALLC_3B") 

"PA_16"
"PA_15"
"PA_14"
"PA_13"
"PA_12"
"PA_11"
"PA_10"
"PA_9"
"PA_8"
"PA_7"
"PA_6"
"PA_5"
"PA_4"
"PA_3"
"PA_2"
"PA_1"
("VSS" "AGND3ALLC_3B") 
("VSS" "AGND3ALLC_3B") 

"IN_1"
"T1_1"
"T1_2"
"IN_2"
"IN_3"
"T1_3"
"T1_4"
"IN_4"
"IN_5"
"T1_5"
"T1_6"
"IN_6"
"IN_7"
"T1_7"
"T1_8"
"IN_8"

"IN_diff"
"diod"
)

larP=setof(p larzPin !listp(p))
;terminalGen(larzP)

length(larzPins)
;; padLib='("IOLIB_4M" "IOLIB_ANA_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
padLib=list("IOLIBC_3B_4M" "IOLIBC_ANA_3B_4M")
IOCELL="APRIOC_3B"
PERICELL="PERI_SPACER_100_C_3B"
CORNERCELL="CORNERC_3B"
; createPadRing(larzPin 0 0 "LARZIC_16" "RING_C"  '("IO" IOCELL)  '("padCap" CORNERCELL) '("fill" PERICELL) '("fillFirst" nil) '("GND" "VSS") '(xn 18))
createPadRing(larzPins 5 5 "LARZIC_2014" "RING_C_LIMITED"  '("IO" IOCELL)  '("padCap" CORNERCELL)  '("GND" "VSS") '("fill" "PERI_SPACER_01_C_3B"))

larzPins='(
"FX_1" "FX_2" "FX_3" "FX_4" "FX_5" "FX_6" "FX_7" "FX_8" "FX_9" "FX_10" "FX_11" "FX_12" "FX_13" "FX_14" "FX_15" "FX_16" "FX_17" "FX_18" "FX_19" "FX_20" "FX_21" "FX_22" "FX_23" "FX_24" "FX_25" "FX_26" "FX_27" "FX_28" "FX_29" "FX_30" "FX_31" "FX_32" 

"OUT_32" "OUT_31" "OUT_30" "OUT_29" "OUT_28" "OUT_27" "OUT_26" "OUT_25" "OUT_24" "OUT_23" "OUT_22" "OUT_21" "OUT_20" "OUT_19" "OUT_18" "OUT_17" "OUT_16" "OUT_15" "OUT_14" "OUT_13" "OUT_12" "OUT_11" "OUT_10" "OUT_9" "OUT_8" "OUT_7" "OUT_6" "OUT_5" "OUT_4" "OUT_3" "OUT_2" "OUT_1" 

"T_32" "T_31" "T_30" "T_29" "T_28" "T_27" "T_26" "T_25" "T_24" "T_23" "T_22" "T_21" "T_20" "T_19" "T_18" "T_17" "T_16" "T_15" "T_14" "T_13" "T_12" "T_11" "T_10" "T_9" "T_8" "T_7" "T_6" "T_5" "T_4" "T_3" "T_2" "T_1" 

"IN_1" "IN_2" "IN_3" "IN_4" "IN_5" "IN_6" "IN_7" "IN_8" "IN_9" "IN_10" "IN_11" "IN_12" "IN_13" "IN_14" "IN_15" "IN_16" "IN_17" "IN_18" "IN_19" "IN_20" "IN_21" "IN_22" "IN_23" "IN_24" "IN_25" "IN_26" "IN_27" "IN_28" "IN_29" "IN_30" "IN_31" "IN_32" 
)

