; array2sch tutorial USAGE
; semi-automatic schematic generate

;needed function load
ineed('(array2sch getPropList nthcdr2) t)
; array2sch('test) ;<== uncomment the dummy example for instance

; cellName of the instance to generate
cell2pose="phase_detector_Rst";<== [TODO] : MODIFY this name for your purpose
; if you have one such cell on your schematic, select it and 
getPropList();=>("phase_detector_Rst"  ("SLOW" "FAST" "VOUT" "vdd!" "gnd!"	"Rst"    ) nil)
; ne prendre que les premiers parametres
nthcdr2(0 2 getPropList() )
;=> ("phase_detector_Rst" ("SLOW" "FAST" "VOUT" "vdd!" "gnd!" "Rst"))
; WARNING, in this example, the net vdd! and gnd! are global and should not be put in the parameter list.

; faire une matrice pour dire a la fonction array2sch ce qu'il faut generer.
cells=foreach(mapcar i linRg(1 9 1);=> (1 2 3 4 5 6 7 8 9 10)
foreach(mapcar j linRg(1 9 1);=> (1 2 3 4 5 6 7 8 9 10)
row=list(cell2pose list(
sprintf(nil "S<%d>" i) ;=> "S_1"
sprintf(nil "F<%d>" i) ;=> "F_1"
sprintf(nil "PD_%d<%d>" i j)  "Rst"))
))
;=> ((("phase_detector_Rst_simu" ("S<1>" "F<1>" "PD_1<1>" "Rst")) ...("phase_detector_Rst_simu" ("S<9>" "F<9>" "PD_9<9>" "Rst"))))


;EXECUTION OF THE GENERATION FONCTION
array2sch(cells nil nil)
; OPTIONNAL => add input and output pins
PD_pins=foreach(mapcar i linRg(1 9 1) sprintf(nil "PD_%d<1:9>" i))
;=> ("PD_1<1:9>" "PD_2<1:9>" "PD_3<1:9>" "PD_4<1:9>" "PD_5<1:9>" "PD_6<1:9>" "PD_7<1:9>" "PD_8<1:9>" "PD_9<1:9>")
ineed('terminalGen t)
terminalGen(reverse(PD_pins))


