; load("amsBox.il")
load("padRing.il")
padLib='("IOLIB_4M" "IOLIB_ANA_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
l_pins='(
( "VDD" "AVDD3ALLP") ( "VDD" "AVDD3ALLP") ( "VDD" "AVDD3ALLP") ( "VDD" "AVDD3ALLP")
"O1" "O2" "O3" "O4"
("GND" "AGND3ALLP") ("GND" "AGND3ALLP") ("GND" "AGND3ALLP")
("GND" "AGND3ALLP")
"I3"
("Idigital4" "BBCU4P")
"I2"
;("I1")
)

createPadRing( l_pins 10 50 "Ed_IC6" "RINGtest" '("IO" "APRIOP") '("fill" "PERI_SPACER_100_P") '("padCap" "CORNERP")  list("padLib" padLib))