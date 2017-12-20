;createBox( '("in0" "in1" "in2" "in3" "in4" "in5" "in6" "in7"  )) t
;createBox( '("in0" "in1" "in2" "in3" "in4" "in5" "in6" "in7" "in8" "in9" "in10" "in11" "in12" "in13" "in14" "in15")) t


;createBox( '(
;"in0" ("in1" "PAD_IO") ("in2" "PAD_IO") ("in3" "PAD_IO") 
;("gnd!" "PAD_GND" )("gnd!" "PAD_GND" )("gnd!" "PAD_GND" )("gnd!" "PAD_GND" ) 
;("out0" "PAD_IO") ("out1" "PAD_IO") ("out2" "PAD_IO") ("out3" "PAD_IO")  
;("vdd!" "PAD_ALIM" )("vdd!" "PAD_ALIM" )
;)) t


innoPadList = '( 
("gnd!" "PAD_GND" ) ("vdda!" "PAD_ALIM" )("gnd!" "PAD_GND" ) ("vdda!" "PAD_ALIM" )("gnd!" "PAD_GND" ) "Vbi_cmfb" ("gnd!" "PAD_GND" )
"Vcons"  "Vbi_casc" ("gnd!" "PAD_GND" )  "OUT2" "OUT1"  ("gnd!" "PAD_GND" )  ("vdda!" "PAD_ALIM" )
("gnd!" "PAD_GND" ) ("vdda!" "PAD_ALIM" ) ("gnd!" "PAD_GND" ) "Vbias_casc" ("vdda!" "PAD_ALIM" ) ("vdda!" "PAD_ALIM" ) ("gnd!" "PAD_GND" )
("vdda!" "PAD_ALIM" ) "Vbi_diff"  "IN2" ("gnd!" "PAD_GND" ) "IN1" ("gnd!" "PAD_GND" ) ("vdda!" "PAD_ALIM" ) 
)

exemple30_pin = '("in0" "in1" "in2" "in3" "in4" "in5" "in6" "in7" "in8" "in9" "in10" "in11" "in12" "in13" "in14" "in15" "in16" "in17" "in18" "in19" "in20" "in21" "in22" "in23" "in24" "in25" "in26" "in27" "in28" "in29" "in30" "in31")



t2kNames = '( 
("gnd!" "PAD_GND") ("VDD" "PAD_ALIM")  "T1_8" "PS_ON1" "PS_ON7" "PS_ON8" "PS_RZ1" "PS_RZ" "Vref_SH" "Rpa" ("VDD" "PAD_ALIM") ("VCC" "PAD_ALIM") ("gnd!" "PAD_GND")
("VCC" "PAD_ALIM") ("gnd!" "PAD_GND" ) "OUT<8>" "OUT<7>" "OUT<6>" "OUT<5>" "OUT<4>" "OUT<3>" "OUT<2>" "OUT<1>" "OUT<0>" ("gnd!" "PAD_GND" ) ("VCC" "PAD_ALIM")
("gnd!" "PAD_GND") ("VDDB" "PAD_IO") "IN_BUF" "gnd!" "OUT_SH" "Vref_SH1" "IN_SH" ("VDD" "PAD_ALIM") "OUT_PA"  ("VDD1" "PAD_IO") "gnd!" "T1" ("gnd!" "PAD_GND" )
("VDD" "PAD_ALIM") ("gnd!" "PAD_GND" ) "IN<0>" "IN<1>" "IN<2>" "IN<3>" "IN<4>" ("VDD" "PAD_ALIM") "IN<5>" "IN<6>" "IN<7>" "IN<8>" ("gnd!" "PAD_GND" ) 
)

nbOfPin = 52
result ='() for(i 1 nbOfPin result=tconc(result sprintf(nil "pad_%d" i))) result=car(result)

createBox( result 5 40  "Ed" sprintf(nil "box%d" nbOfPin) "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell_S35D4") t

;; createBox( i2cNames 0 40  "SLAVe_SI2" "RING2"  "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell") t


