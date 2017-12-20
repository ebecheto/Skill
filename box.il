
cv= geGetWindowCellView()
foreach(term cv~>terminals printf("\"%s\" \n" term->name ))

foreach(mapcar term cv~>terminals 
cond(
(term->name=="VDD" list(term->name "PAD_ALIM"))
(term->name=="VSS" list(term->name "PAD_GND"))
(t term->name)))

; load("~/Skill/box.il")
; load("~/Skill/pad_frame.il")


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


; load("~/Skill/pad_frame.il")

leftNames='(
"comp_high_50-64" 
"comp_mid_50-64" 
"comp_low_50-64" 

"comp_high_49-63" 
"comp_mid_49-63" 
"comp_low_49-63" 

("vdd!" "PAD_ALIM")
("gnd!" "PAD_GND" )

"comp_high_34-48" 
"comp_mid_34-48" 
"comp_low_34-48" 

"comp_high_33-47" 
"comp_mid_33-47" 
"comp_low_33-47"
)

diracNames='(
"SDA_D"
"reset"
"clk"
"SCL_D"
"write_data"
"I2C_add_0_D"
"I2C_add_1_D"
"carry_out"


"comp_low_1-15"
"comp_mid_1-15"
"comp_high_1-15"


"comp_low_2-16"
"comp_mid_2-16"
"comp_high_2-16"

"comp_low_17-31"
"comp_mid_17-31"
"comp_high_17-31"

"comp_low_18-32"
"comp_mid_18-32"
"comp_high_18-32"

)


slaveNames1='(
"scan_enable"
"I2C_add_0_S"
"I2C_add_1_S"
"tdi"
"tdo"

("gnd!" "PAD_GND" )
("vdd!" "PAD_ALIM")

"SCL_S"
"SDA_S"
"DataToRead_0"
"DataToRead_1"
"DataToRead_2"
"DataToRead_3"
"DataToRead_4"
"DataToRead_5"
"DataToRead_6"
"DataToRead_7"
)

slaveNames2='(
"ReadWrite"
"DataToWrite_0"
"DataToWrite_1"
"DataToWrite_2"
"DataToWrite_3"
"DataToWrite_4"
"DataToWrite_5"
"DataToWrite_6"
"DataToWrite_7"
"clock_reg"
"address_reg_0"
"address_reg_1"
"address_reg_2"
"address_reg_3"
"address_reg_4"
"address_reg_5"
"address_reg_6"
"address_reg_7"
("vdd!" "PAD_ALIM")
)


paNames='(
"IN"
("vdd!" "PAD_ALIM")
("gnd!" "PAD_GND")
"OUT"
("gnd!" "PAD_ALIM")
"gain1"
"gain2"
"gain3"
"PS"
"Vref"
"IN_test"
"reset_pa"
"enableTest"
"select_conf_pa"
)

i2cNames='()
i2cNames=append(i2cNames diracNames)
i2cNames=append(i2cNames slaveNames1)
i2cNames=append(i2cNames paNames)
i2cNames=append(i2cNames slaveNames2)
i2cNames=append(i2cNames leftNames)

length(diracNames)
length(slaveNames1)
length(slaveNames2)
length(paNames)
length(i2cNames)

;; createBox( i2cNames 0 40  "SLAVe_SI2" "RING2"  "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell") t


dsmNames='(

"CMD0.25"
"CMD0.5"
"CMD1"
"CMD2"

("gnd!" "PAD_GND" )
("vcca!" "PAD_ALIM" )
"vdd!"


"Vref"
"IN_PA"
"OUT_SH"
"IN_BUF"
"OUT_BUF"
("vcc!" "PAD_ALIM" )


"Output_Discrim_16_voies<0>" 
"Output_Discrim_16_voies<1>" 
"Output_Discrim_16_voies<2>" 
"Output_Discrim_16_voies<3>" 
"Output_Discrim_16_voies<4>" 
"Output_Discrim_16_voies<5>" 
"Output_Discrim_16_voies<6>" 
"Output_Discrim_16_voies<7>" 


("vcca!" "PAD_ALIM" )
("gnd!" "PAD_GND" )

"Output_PAC_16_voies<0>" 
"Output_PAC_16_voies<1>" 
"Output_PAC_16_voies<2>" 
"Output_PAC_16_voies<3>" 
"Output_PAC_16_voies<4>" 
"Output_PAC_16_voies<5>" 
"Output_PAC_16_voies<6>" 
"Output_PAC_16_voies<7>" 
"Output_PAC_16_voies<8>" 
"Output_PAC_16_voies<9>" 
"Output_PAC_16_voies<10>" 
"Output_PAC_16_voies<11>" 
"Output_PAC_16_voies<12>" 
"Output_PAC_16_voies<13>" 
"Output_PAC_16_voies<14>" 
"Output_PAC_16_voies<15>" 
"Output_PAC" 

("gnd!" "PAD_GND" )
("vcca!" "PAD_ALIM" )

"Output_Discrim_16_voies<8>" 
"Output_Discrim_16_voies<9>" 
"Output_Discrim_16_voies<10>" 
"Output_Discrim_16_voies<11>" 
"Output_Discrim_16_voies<12>" 
"Output_Discrim_16_voies<13>" 
"Output_Discrim_16_voies<14>" 
"Output_Discrim_16_voies<15>" 


"Output_Discrim" 

("gnd!" "PAD_GND" )
("vcca!" "PAD_ALIM" )

"vdd!"

("gnd!" "PAD_GND" )
("vcca!" "PAD_ALIM" )

"Output_CC_PAC" 
"Iin_PAC" 

"Output_CC_Discrim" 
"Iin_Discrim" 
"Vbias_bip"
"Iref_Discrim" 
"Iref_in_16_voies" 

("vcca!" "PAD_ALIM" )
("gnd!" "PAD_GND" )


"Iin_CC" 
"Iin_16_voies<15>" 
"Iin_16_voies<14>" 
"Iin_16_voies<13>" 
"Iin_16_voies<12>" 
"Iin_16_voies<11>" 
"Iin_16_voies<10>" 
"Iin_16_voies<9>" 
"Iin_16_voies<8>" 
"Iin_16_voies<7>" 
"Iin_16_voies<6>" 
"Iin_16_voies<5>" 
"Iin_16_voies<4>" 
"Iin_16_voies<3>" 
"Iin_16_voies<2>" 
"Iin_16_voies<1>" 
"Iin_16_voies<0>" 

("vcca!" "PAD_ALIM" )
("gnd!" "PAD_GND" )

)

;; printf("NB PAD=%d\n" length(dsmNames))
;; createBox( dsmNames 5 5 "DSm" "RING4" "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter1" "PAD_capa" "PAD_cell_S35D4")


nbOfPin=84 bx=5 by=10
result ='() for(i 1 nbOfPin-1 result=tconc(result sprintf(nil "pad_%d" i))) result=car(result)

printf("NB PAD=%d\n" length(result))
;; createBox( result bx by "T2K_V5" "BOX_84" "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell")


pinList='( 
( "VDD" "AVDD3ALLP_3B") ( "VDD" "AVDD3ALLP_3B") ( "VDD" "AVDD3ALLP_3B") ( "VDD" "AVDD3ALLP_3B")
"O1" "O2" "O3" "O4"

("GND" "AGND3ALLP_3B") ("GND" "AGND3ALLP_3B") ("GND" "AGND3ALLP_3B")
("VSUB" "AVSUBP_3B")
"I4" 
"I3"
"I2"
"I1"
)
;; createPadRing( pinList bx by "T2K_V5" "COUR1" "APRIOP_3B" "AGND3ALLP_3B" "AVDD3ALLP_3B" "PERI_SPACER_01_P" "CORNERP" '("IOLIB_ANA_3B_4M"))


;; additionnal iternal nets : EN_ABc PS_ENc<1> PS_ENc<2> PS_ENc<3> PS_ENc<4> EN_AB PS_EN<1> PS_EN<2> PS_EN<3> PS_EN<4>
pins='(
("gnd!" "PAD_GND" ) "T1" ("VDD" "PAD_ALIM") "SDA" "SCL" "reset" "input_select" "add_0" "add_1" ("vdd!" "PAD_ALIM") ("VCC" "PAD_ALIM") ("gnd!" "PAD_GND")  "Vref_SH"

("VCC" "PAD_ALIM") ("gnd!" "PAD_GND" ) "OUT<8>" "OUT<7>" "OUT<6>" "OUT<5>" "OUT<4>" "OUT<3>" "OUT<2>" "OUT<1>" "OUT_BUF" ("gnd!" "PAD_GND" ) ("VCC" "PAD_ALIM")

("gnd!" "PAD_GND" ) ("VDD" "PAD_ALIM")  "IN_BUF" "OUT_SH" "IN_SH" ("VDD" "PAD_ALIM") "test_ON"  "OUT_PA" ("VDD" "PAD_ALIM") "PS_ON"  "PS_RZ" "T1" ("gnd!" "PAD_GND")
"IN_PA" "IN<1>" "IN<2>" "IN<3>" "IN<4>" ("VDD" "PAD_ALIM") "IN<5>" "IN<6>" ("gnd!" "PAD_GND") "IN<7>" ("VDD" "PAD_ALIM") "IN<8>" ("gnd!" "PAD_GND")
)

printf("NB PAD=%d\n" length(pins))
createBox( pins 5 50 "T2K_V5" "T2K_V5_BOX2" "PAD_IO" "PAD_GND" "PAD_ALIM" "PAD_inter0" "PAD_capa" "PAD_cell")
;; load("~/Skill/box.il")

; load("padRing.il")

larzPin='(
"T1" 
("VSS" "AGND3ALLP") 
("VDD" "AVDD3ALLP") 
"Vref"
"RB2"
"RBS" "RB1" "RBD"
"OUT"
"OUTN"
"OUTx2N"
"OUTx2"
("VSS" "AGND3ALLP") 
("VCC" "AVDD3ALLP") 
"ENd"
"ENA"
"OUT_8"
"OUT_7"
"OUT_6"
"OUT_5"
"OUT_4"
"OUT_3"
"OUT_2"
"OUT_1"
"ENt"
("VCC" "AVDD3ALLP") 
"OUTCSA"
("VSS" "AGND3ALLP") 
"INCSA"
"OUTBUF"
"INBUF"
"OUTSH"
"INSH"
"conf"
"OUTPA2"
("VDD" "AVDD3ALLP") 
"OUTPA"
("VSS" "AGND3ALLP") 
"T1" 
"INPA"
"INPA2"
"IN_1" 
"IN_2"
"IN_3"
"IN_4"
"IN_5"
"IN_6"
"IN_7"
"IN_8"
("VSS" "AGND3ALLP") 
"IND"
("VSS" "AGND3ALLP") 
) length(larzPin)

; load("padRing.il")
IOCELL="APRIOP"
;PERICELL="PERI_SPACER_01_P"
PERICELL="PERI_SPACER_100_P"
CORNERCELL="CORNERP"
createPadRing(larzPin 50 5 "LARZIC" "CORE_RING5" '("IO" IOCELL) '("fill" PERICELL) '("padCap" CORNERCELL) '("fillFirst" nil) '("fillLast" nil) '("GND" "VSS"))


