;  load("box.il.LARZIC_2014.coreLimited_rect.il")
; load("padRing.il")

println(i=foreach(mapcar p linRg(1 16 1) sprintf(nil "IN_%d" p)))
println(foreach(mapcar p linRg(1 16 1) sprintf(nil "PA_%d" p)))
println(t1=foreach(mapcar p linRg(1 16 1) sprintf(nil "T1_%d" p)))
mapcan('list i t1)

println(foreach(mapcan p linRg(1 16 1) a=list(sprintf(nil "IN_%d" p) sprintf(nil "T1_%d" p)) if(evenp(p) reverse(a) a)))


larzPins='(
("VSS" "AGND3ALLC_3B")
("VDD" "AVDD3ALLC_3B")
 "RDIOD" "RN" "Dzk" "Dzo" "Dzi" "Cstim"
"VDB1"
"VSB2"
("VSS" "AGND3ALLC_3B")

;("CUT" "PWRCUT_DIG_C_3B_DXS")
("VDDB" "AVDD3ALLC_3B")
("VSSB" "AGND3ALLC_3B")
; "VBBB"
("VDDB" "AVDD3ALLC_3B") 
("VSSB" "AGND3ALLC_3B") 
("sub!" "AVSUBC_3B") 
;("CUT" "PWRCUT_DIG_C_3B_DXS")

"ENA"
"CHOP"

("VSS" "AGND3ALLC_3B") 

("VSS" "AGND3ALLC_3B") 

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
("VDD" "AVDD3ALLC_3B")

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
("VSS" "AGND3ALLC_3B") 
("VSS" "AGND3ALLC_3B") 
)

larP=setof(p larzPins !listp(p))
;terminalGen(larzP)

length(larzPins) ;=> 76

;; padLib='("IOLIB_4M" "IOLIB_ANA_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
padLib=list("IOLIBC_3B_4M" "IOLIBC_ANA_3B_4M")
IOCELL="APRIOC_3B"
PERICELL="PERI_SPACER_100_C_3B"
;; PERICELL="PERI_SPACER_01_C_3B"
CORNERCELL="CORNERC_3B"
; createPadRing(larzPin 0 0 "LARZIC_16" "RING_C"  '("IO" IOCELL)  '("padCap" CORNERCELL) '("fill" PERICELL) '("fillFirst" nil) '("GND" "VSS") '(xn 18))
createPadRing(larzPins 2 2 "LARZIC_2014" "LARZ_RING3cc"  '("IO" IOCELL)  '("padCap" CORNERCELL)  '("GND" "VSS") '("fill" PERICELL))

;; generateAllPins(t nil t)
;; metalPin2pinDrawing()
; netSetPatch( geGetWindowCellView() "gnd!" "vdd!" )
;; netSetPatch( geGetWindowCellView() "VSSB" "VDDB" )
;; netSetPatch( nil "VSSB" "VDDB" )