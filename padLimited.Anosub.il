;; load "padRing.il"
;  load("box.il.LARZIC_2014.coreLimited_rect.il")


larzPins='(
("gnd!" "AGND3ALLP")
("gnd!" "AGND3ALLP")
"OUT1"
"OUT2"
("vdd!" "AVDD3ALLP")
("vdd!" "AVDD3ALLP")
"IN1"
"IN2"
)

larP=setof(p larzPins !listp(p))
;terminalGen(larzP)

length(larzPins) ;=> 76

;; padLib='("IOLIB_4M" "IOLIB_ANA_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
padLib=list("IOLIB_4M" "IOLIB_ANA_4M")
IOCELL="APRIOP"
PERICELL="PERI_SPACER_100_P"
;; PERICELL="PERI_SPACER_01_C_3B"
CORNERCELL="CORNERP"
; createPadRing(larzPin 0 0 "LARZIC_16" "RING_C"  '("IO" IOCELL)  '("padCap" CORNERCELL) '("fill" PERICELL) '("fillFirst" nil) '("GND" "VSS") '(xn 18))
createPadRing(larzPins 2 2 "LARZIC_2014" "padLimited_Anosub"  '("IO" IOCELL)  '("padCap" CORNERCELL)  '("GND" "VSS") '("fill" PERICELL))

geOpenOrRaise(   ?lib "LARZIC_2014" ?cell "padLimited_Anosub" ?view "layout")
geOpenOrRaise(   ?lib "LARZIC_2014" ?cell "padLimited_Anosub" ?view "schematic")


generateAllPins(t nil t)
metalPin2pinDrawing()
; netSetPatch( geGetWindowCellView() "gnd!" "vdd!" )