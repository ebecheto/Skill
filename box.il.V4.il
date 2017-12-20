; load("/home/validmgr/ebecheto/Skill/box.il.V4.il")

; i2cNames = '(


B='(
("gnd!" "PAD_GND") "IN_9"  ("VDD" "PAD_ALIM") 
("SDA" "BBCD24P")
"SCL"
"reset"
"input_select"
"add_0"
"add_1"
("vdd!" "PAD_ALIM")

("vcca!" "PAD_ALIM") ("gnd!" "PAD_GND") "OUT_9"
)

R='(
("vcca!" "PAD_ALIM") ("gnd!" "PAD_GND" )  "OUT<8>" "OUT<7>" "OUT<6>" "OUT<5>" "OUT<4>" "OUT<3>" "OUT<2>" "OUT<1>" "OUT_0" ("gnd!" "PAD_GND" ) ("vcca!" "PAD_ALIM")
)

T='(
("gnd!" "PAD_GND") ("VDD" "PAD_ALIM") "IN_BUF" "OUT_SH" "IN_SH" ("VDD" "PAD_ALIM") "test_ON" "OUT_PA"  ("VDD" "PAD_ALIM")  "PS_ON" "PS_RZ" "Vref_SH" ("gnd!" "PAD_GND" )
)
L='(
"IN_0" "IN<1>" "IN<2>" "IN<3>" "IN<4>" ("VDD" "PAD_ALIM") "IN<5>" "IN<6>" ("gnd!" "PAD_GND" ) "IN<7>" ("VDD" "PAD_ALIM") "IN<8>" ("gnd!" "PAD_GND" ) 
)

V4_names = append(append(B R) append(T L))


;; to fit to 52-pin
println(sprintf(nil "nb of pins : %L" length(V4_names) ))
println(sprintf(nil "B : %L" length(B) ))
println(sprintf(nil "R : %L" length(R) ))
println(sprintf(nil "T : %L" length(T) ))
println(sprintf(nil "L : %L" length(L) ))

createBox( V4_names 5 60 "T2K_V4" "T2K_V4_Ring"  "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell") t

;;  whereIs(help)
;;  load("~/Skill/pad_frame.il")

;; name of internal selections : 
;; input_select VDD gnd!
;; S1 S2 S3 Rpa_ON Rcut1 Rcut2 Rcut3 500f_sel 2M_sel 1M_sel
;; S1c S2c S3c Rpa_ONc Rcut1c Rcut2c Rcut3c 500f_c 2M_c 1M_c
