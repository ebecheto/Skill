;; load "padRing.il"
;  load("box.il.LARZIC_2014.coreLimited_rect.il")


larzPins='(
("gnd!" "AGND3ALLP_3B")
("gnd!" "AGND3ALLP_3B")
"OUT"
("sub" "AVSUBP_3B") 
("vdd!" "AVDD3ALLP_3B")
("vdd!" "AVDD3ALLP_3B")
"IN1"
"IN2"
)

larP=setof(p larzPins !listp(p))
;terminalGen(larzP)

length(larzPins) ;=> 76

;; padLib='("IOLIB_4M" "IOLIB_ANA_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
padLib=list("IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
IOCELL="APRIOP_3B"
PERICELL="PERI_SPACER_100_P_3B"
;; PERICELL="PERI_SPACER_01_C_3B"
CORNERCELL="CORNERP_3B"
; createPadRing(larzPin 0 0 "LARZIC_16" "RING_C"  '("IO" IOCELL)  '("padCap" CORNERCELL) '("fill" PERICELL) '("fillFirst" nil) '("GND" "VSS") '(xn 18))
createPadRing(larzPins 2 2 "LARZIC_2014" "padLimited"  '("IO" IOCELL)  '("padCap" CORNERCELL)  '("GND" "VSS") '("fill" PERICELL))

geOpenOrRaise(?cell  "LARZIC_2014"  ?lib "padLimited" ?view "layout")


generateAllPins(t nil t)
metalPin2pinDrawing()
