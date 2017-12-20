; load("padRing.il")
; load("box.il.LARZIC.il")

larzPin='(
("VDD" "AVDD3ALLP") 
("VSS" "AGND3ALLP") 
"T1" 
"RB1"
"RB2"
"RBS" 
"RBD"
"ENA"
"ENd"
"ENt"
("VSS" "AGND3ALLP") 
"OUT"
"OUTN"
"OUT_8"
"OUT_7"
"OUT_6"
"OUT_5"
"OUT_4"
"OUT_3"
"OUT_2"
"OUT_1"
"Vref"
"Vref242"
"conf"
"OUTBUF"
"INBUF"
"OUTSH"
"INSH"
"OUTPA2"
"INPA2"
"OUTPA"
("VSS" "AGND3ALLP") 
("VDD" "AVDD3ALLP") 
"INPA"
"IN_1" 
"IN_2"
"IN_3"
"IN_4"
"IN_5"
"IN_6"
"IN_7"
"IN_8"
"IND"
("VDD" "AVDD3ALLP") 
)

length(larzPin)
;; padLib='("IOLIB_4M" "IOLIB_ANA_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
padLib=list("IOLIB_4M" "IOLIB_ANA_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
IOCELL="APRIOP"
PERICELL="PERI_SPACER_100_P"
CORNERCELL="CORNERP"
createPadRing(larzPin 50 5 "LARZIC" "CORE_RING2"  '("IO" IOCELL) '("fill" PERICELL) '("padCap" CORNERCELL) '("fillFirst" nil) '("fillLast" nil) '("GND" "VSS"))


