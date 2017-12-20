; example d'utilisation des fonctions array2sch etc.
; pour la génération semi-automatique de schema

PD="phase_detector_Rst_simu"
ineed('(array2sch getPropList nthcdr2) t)
; array2sch('test)
;selectionner un element a recopier pour avoir une idee de la forme de la liste a generer
getPropList();=>("phase_detector_Rst"  ("SLOW" "FAST" "VOUT" "vdd!" "gnd!"	"Rst"    ) nil)
; ne prendre que les premiers parametres
nthcdr2(0 2 getPropList() )
;=> ("phase_detector_Rst" ("SLOW" "FAST" "VOUT" "vdd!" "gnd!" "Rst"))

; faire une matrice pour dire a la fonction array2sch ce qu'il faut generer.
cells=foreach(mapcar i linRg(1 9 1);=> (1 2 3 4 5 6 7 8 9 10)
foreach(mapcar j linRg(1 9 1);=> (1 2 3 4 5 6 7 8 9 10)
row=list("phase_detector_Rst" list(
sprintf(nil "S<%d>" i) ;=> "S_1"
sprintf(nil "F<%d>" i) ;=> "F_1"
sprintf(nil "PD_%d<%d>" i j)  "Rst"))
))

;EXECUTION DE LA FONCTION DE GENERATION
array2sch(cells nil nil)

; fonction subsidiaires pour generer des pins a placer automatiquement si besion
; netMakeBus("S" '(1 9) t "<" );=> ("S<1>" "S<2>" "S<3>" "S<4>" "S<5>" "S<6>" "S<7>" "S<8>" "S<9>")
; pins=list(netMakeBus("S" '(1 9)) netMakeBus("S" '(1 9) t "<" ) netMakeBus("S" '(1 9) t "<" )
; netMakeBus("PD_<1:9>" '(1 9) t "_")

PD_pins=foreach(mapcar i linRg(1 9 1) sprintf(nil "PD_%d<1:9>" i))
;=> ("PD_1<1:9>" "PD_2<1:9>" "PD_3<1:9>" "PD_4<1:9>" "PD_5<1:9>" "PD_6<1:9>" "PD_7<1:9>" "PD_8<1:9>" "PD_9<1:9>")
ineed('terminalGen t)
terminalGen(reverse(PD_pins))

