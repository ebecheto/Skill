; load("ibmBox.il")

load("padRing.il")
defun( assuraPinPatch (a) nil) ;<= useless and trouble some function with ibm
;; ; padLib='("short_io" "cmrf8sf" "cmos8rf" )
;; ibm_pins='(
;; ( "VDD" "SIOVDD") ( "VDDD" "SIODVDD") ( "VDD" "SIOVDD") ( "VDD" "SIOVDD")
;; "O1" "O2" "O3" "O4"
;; ("VSS" "SIODVSS") ("GND" "SIOGND") ("GND" "SIOGND")
;; ("GND" "SIOGND")
;; "I3"
;; ("Idigital4" "SIOB04_B")
;; "I2"
;; ;("I1")
;; )

;; createPadRing( ibm_pins 10 50 "Ed_CMOS8" "RINGxx" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_sx" "Ed_CMOS8" (("sx" "float" 50)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" t) '("fillLast" t) '(fillOffset 0.2) '(xn 2) '("shortList" '("SIOVDD" "SIOGND" "SIODVSS")))

ibm_pins='(
( "VDD" "SIOVDD") ( "VDDD" "SIODVDD") ( "VDD" "SIOVDD") ( "VDD" "SIOVDD")
"O1" "O2" "O3" "O4"
("VSS" "SIODVSS") ("GND" "SIOGND") ("GND" "SIOGND")
("GND" "SIOGND")
"I3"
("Idigital4" "SIOB04_B")
"I2"
;("I1")
)




 
;; ibm_pins='(
;; "C40MHz"  "clk" 
;; "vref" "Vcasc" "e" "test"
;; ("VSS" "SIODVSS")
;; ("gnda!" "SIOGND") 
;; ("gndd!" "SIOGND") 
;; ("vssd!" "SIOGND") 

;; "OUT<31>" "OUT<30>" "OUT<29>" "OUT<28>" "OUT<27>" "OUT<26>" "OUT<25>" "OUT<24>" "OUT<23>" "OUT<22>" "OUT<21>" "OUT<20>" "OUT<19>" "OUT<18>" "OUT<17>" "OUT<16>" "OUT<15>" "OUT<14>" "OUT<13>" "OUT<12>" "OUT<11>" "OUT<10>" "OUT<9>" "OUT<8>" "OUT<7>" "OUT<6>" "OUT<5>" "OUT<4>" "OUT<3>" "OUT<2>" "OUT<1>" "OUT<0>" 

;; "INCMP" "OUTCMP" 
;; "OUTCSA" "INCSA"
;; ("VDD"  "SIODVDD")
;; ("vcca!"  "SIODVDD")
;; ("vdd!"  "SIODVDD")
;; ("vddd!"  "SIODVDD")
;; ("gnda!" "SIOGND") 
;; ("gnda!" "SIOGND") 

;; "IN<0>" "IN<1>" "IN<2>" "IN<3>" "IN<4>" "IN<5>" "IN<6>" "IN<7>" "IN<8>" "IN<9>" "IN<10>" "IN<11>" "IN<12>" "IN<13>" "IN<14>" "IN<15>" "IN<16>" "IN<17>" "IN<18>" "IN<19>" "IN<20>" "IN<21>" "IN<22>" "IN<23>" "IN<24>" "IN<25>" "IN<26>" "IN<27>" "IN<28>" "IN<29>" "IN<30>" "IN<31>")

;; createPadRing( ibm_pins 10 50 "PRACTIC_32" "RING" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_sx" "Ed_CMOS8" (("sx" "float" 5)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" t) '("fillLast" t) '(fillOffset 0.2) '(xn 10 '("shortList" '("SIOVDD" "SIOGND" "SIODVSS")))

;; ibm_pins='(
;; "C40MHz"  "clk" "e"
;; ("suba" "SIODVSS")
;; ("gnda!" "SIOGND")
;; ("vdd!"  "SIODVDD")
;; ("subd" "SIODVSS") 
;; ("vddd!"  "SIODVDD")
;; ("gndd!" "SIOGND")
;; "OUT<31>" "OUT<30>" "OUT<29>" "OUT<28>" "OUT<27>" "OUT<26>" "OUT<25>" "OUT<24>" "OUT<23>" "OUT<22>" "OUT<21>" "OUT<20>" "OUT<19>" "OUT<18>" "OUT<17>" "OUT<16>" "OUT<15>" "OUT<14>" "OUT<13>" "OUT<12>" "OUT<11>" "OUT<10>" "OUT<9>" "OUT<8>" "OUT<7>" "OUT<6>" "OUT<5>" "OUT<4>" "OUT<3>" "OUT<2>" "OUT<1>" "OUT<0>" 
;; ("gndd!" "SIOGND") 
;; ("vdd!"  "SIOVDD")
;; "OUTCMP" 
;; ; corner to delete
;; ("gnda!" "SIOGND") 
;; "test"  
;; "INCMP" 
;; "OUTCSA" "INCSA"
;; "ALIM"
;; ; corner to delete
;; ("VDD"  "SIODVDD")
;; ("vcc!"  "SIOVDD")
;; ("gnda!" "SIOGND") 
;; "IN<0>" "IN<1>" "IN<2>" "IN<3>" "IN<4>" "IN<5>" "IN<6>" "IN<7>" "IN<8>" "IN<9>" "IN<10>" "IN<11>" "IN<12>" "IN<13>" "IN<14>" "IN<15>" "IN<16>" "IN<17>" "IN<18>" "IN<19>" "IN<20>" "IN<21>" "IN<22>" "IN<23>" "IN<24>" "IN<25>" "IN<26>" "IN<27>" "IN<28>" "IN<29>" "IN<30>" "IN<31>" 
;; ("gnda!" "SIOGND") 
;; "vref" "Vcasc")

;; ibm_pins='(
;; ("gnda!" "SIOGND")
;; ("gnda!" "SIOGND")
;; ("vdd!"  "SIOVDD")
;; "C40MHz"  "clk" 
;; ;corner1
;; ("subd"  "SIODVSS")
;; ("vddd!" "SIODVDD")
;; ("gndd!" "SIOGND")
;; "ESDO<2>" "ESDO<1>" "ESDO<0>"
;; "OUT<31>" "OUT<30>" "OUT<29>" "OUT<28>" "OUT<27>" "OUT<26>" "OUT<25>" "OUT<24>" "OUT<23>" "OUT<22>" "OUT<21>" "OUT<20>" "OUT<19>" "OUT<18>" "OUT<17>" "OUT<16>" "OUT<15>" "OUT<14>" "OUT<13>" "OUT<12>" "OUT<11>" "OUT<10>" "OUT<9>" "OUT<8>" "OUT<7>" "OUT<6>" "OUT<5>" "OUT<4>" "OUT<3>" "OUT<2>" "OUT<1>" "OUT<0>" 
;; ("gndd!" "SIOGND") 
;; ("vdd!"  "SIOVDD")
;; ("vddd!" "SIODVDD")
;; "OUTCMP" 
;; ; corner not delete
;; "test"  
;; "INCMP" 
;; "OUTCSA" "INCSA"
;; ("vcc!"  "SIOVDD")
;; ; corner not delete
;; ("suba" "SIODVSS")
;; ("VDD"  "SIODVDD")
;; ("vcc!"  "SIOVDD")
;; ("gnda!" "SIOGND") 
;; "IN<0>" "IN<1>" "IN<2>" "IN<3>" "IN<4>" "IN<5>" "IN<6>" "IN<7>" "IN<8>" "IN<9>" "IN<10>" "IN<11>" "IN<12>" "IN<13>" "IN<14>" "IN<15>" "IN<16>" "IN<17>" "IN<18>" "IN<19>" "IN<20>" "IN<21>" "IN<22>" "IN<23>" "IN<24>" "IN<25>" "IN<26>" "IN<27>" "IN<28>" "IN<29>" "IN<30>" "IN<31>" 
;; "ESDI<0>" "ESDI<1>" "ESDI<2>"
;; "vref" "Vcasc" "e")


ibm_pins='(
("gnda!" "SIOGND")
("gnda!" "SIOGND")
("vdd!"  "SIOVDD")
"C40MHz"  "clk" 
;corner1
("subd"  "SIODVSS")
("vddd!" "SIODVDD")
("gndd!" "SIOGND")
"ESDO<2>" "ESDO<1>" "ESDO<0>"
"OUT<31>" "OUT<30>" "OUT<29>" "OUT<28>" "OUT<27>" "OUT<26>" "OUT<25>" "OUT<24>" "OUT<23>" "OUT<22>" "OUT<21>" "OUT<20>" "OUT<19>" "OUT<18>" "OUT<17>" "OUT<16>" "OUT<15>" "OUT<14>" "OUT<13>" "OUT<12>" "OUT<11>" "OUT<10>" "OUT<9>" "OUT<8>" "OUT<7>" "OUT<6>" "OUT<5>" "OUT<4>" "OUT<3>" "OUT<2>" "OUT<1>" "OUT<0>" 
("gndd!" "SIOGND") 
("vdd!"  "SIOVDD")
("vddd!" "SIODVDD")
"OUTCMP" 
; corner not delete
"test"  
"INCMP" 
"OUTCSA" "INCSA"
("vcc!"  "SIOVDD")
; corner not delete
("suba" "SIODVSS")
("VDD"  "SIODVDD")
("vcc!"  "SIOVDD")
("gnda!" "SIOGND") 
("IN<0>" "my_pad_esd2") ("IN<1>" "my_pad_esd2") ("IN<2>" "my_pad_esd2") ("IN<3>" "my_pad_esd2") ("IN<4>" "my_pad_esd2") ("IN<5>" "my_pad_esd2") ("IN<6>" "my_pad_esd2") ("IN<7>" "my_pad_esd2") ("IN<8>" "my_pad_esd2") ("IN<9>" "my_pad_esd2") ("IN<10>" "my_pad_esd2") ("IN<11>" "my_pad_esd2") ("IN<12>" "my_pad_esd2") ("IN<13>" "my_pad_esd2") ("IN<14>" "my_pad_esd2") ("IN<15>" "my_pad_esd2") ("IN<16>" "my_pad_esd2") ("IN<17>" "my_pad_esd2") ("IN<18>" "my_pad_esd2") ("IN<19>" "my_pad_esd2") ("IN<20>" "my_pad_esd2") ("IN<21>" "my_pad_esd2") ("IN<22>" "my_pad_esd2") ("IN<23>" "my_pad_esd2") ("IN<24>" "my_pad_esd2") ("IN<25>" "my_pad_esd2") ("IN<26>" "my_pad_esd2") ("IN<27>" "my_pad_esd2") ("IN<28>" "my_pad_esd2") ("IN<29>" "my_pad_esd2") ("IN<30>" "my_pad_esd2") ("IN<31>" "my_pad_esd2")
"ESDI<0>" "ESDI<1>" "ESDI<2>"
"vref" "Vcasc" "e")

;________________________________________________________________________________
;; netMakeBus("")
ibm_pins='(
("gnda!" "SIOGND")
("gnda!" "SIOGND")
("vdd!"  "SIOVDD")
"C40MHz"  "clk" 
"REG" "REG_CLK"
;; "S<1>" "S<2>" "S<3>" "S<4>" "S<5>" "S<6>" "S<7>" "S<8>" "S<9>" "S<10>" 
;; "Sf<1>" "Sf<2>" "Sf<3>" "Sf<4>" "Sf<5>" "Sf<6>" "Sf<7>" "Sf<8>" "Sf<9>" "Sf<10>"
"In_1" "Inf_1" "In_2" 
"Inf_2" "In_3" "Inf_3" "clk" "RN"
"PN" "D" "Sl" "Q" "P"
"Fs" "Qout" "Sync_1" "B_1" "Bf_1"
"Sync_2" "Bf_2" "B_3" "Sync_3" "Bf_3"
"Reset" "Preset" "B_2"
;corner1
("subd"  "SIODVSS")
("vddd!" "SIODVDD")
("gndd!" "SIOGND")
("gndd!" "SIOGND") 
("vdd!"  "SIOVDD")
("vddd!" "SIODVDD")
; corner not delete
("vcc!"  "SIOVDD")
; corner not delete
("suba" "SIODVSS")
("VDD"  "SIODVDD")
("vcc!"  "SIOVDD")
("gnda!" "SIOGND") 
)
; TDC pins
length(ibm_pins)

defun( assuraPinPatch (a) nil) ;<= useless and trouble some function with ibm

; 2.15
; createPadRing( ibm_pins 26.68+0.03 26.68+0.03 )
createPadRing( ibm_pins 6.68+0.03 6.68+0.03 "Ed_CMOS8" "RING3" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_sx" "Ed_CMOS8" (("sx" "float" 0)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" 5 5) '("fillLast" 5 5) '(fillOffset 0.2)  '("shortList" '("SIOVDD" "SIOGND" "SIODVSS"  "my_pad_esd2"))  )
;; createPadRing( ibm_pins 26.68+0.03 26.68+0.03 "PRACTIC_32" "RING11" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_sx" "Ed_CMOS8" (("sx" "float" 0)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" 10 10) '("fillLast" 5 5) '(fillOffset 0.2) '(xn 5) '("shortList" '("SIOVDD" "SIOGND" "SIODVSS"  "my_pad_esd2"))  '(skipSch t))
 miscPatch()
 widenMADVpad()
; REMOVE PINS SUBD && SUBA in the layout! 

loadi("ibmBox.il.proc.il");=> for tuning stuffs after creation



unless(fboundp('getInstTermPoint) load("padRing.proc.il"))
; getMaxPointsLayer((dbOpenCellViewByType "PRACTIC_32" "PRACTIC_RING10" "layout") "BP" ) ;=< attention fctino tres longue ....

;; println getMaxPointsLayer(geGetWindowCellView() "PROTECT" )
;; println getMaxPointsLayer(geGetWindowCellView() "BP" )

cv=geGetWindowCellView()
cv~>terminals~>name

pins='( 
"SkipA<0>" "SkipA<1>" 
("vdd!" "SIOVDD")
("gnd!" "SIOGND")
"SkipB<0>" "SkipB<1>" "SkipC<0>" "SkipC<1>" "Dzin"  
"gndd!" "vddd!" 
"Bf_3c" 
"Sync_3" 
"B_3c" 
"Bf_2c" 
"Sync_2" 
"B_2c" 
"Bf_1c" 
"Sync_1"
"B_1c" 
("vddd!" "SIODVDD")
("gndd!" "SIODVSS")
"etrou" "Vcasc" "OUTCSA" "vcc!" "gnda!" "IN" 
"Q" "D" "clk_cpff" "Qout" "Sl" "Fs" 
"sub!"
("gnd!" "SIOGND") ("vdd!" "SIOVDD")
"Dziout" "clk_Dzi"
("gnd!" "SIOGND") ("vdd!" "SIOVDD")
"RN" "PN"  "Rs" "In_1" "Inf_1" "In_2" "Inf_2"  "In_3" "Inf_3" "Rs3" "Ps3"
)


;foreach(mapcar p pins if(listp(p) car(p) p))


length(pins) ;=>52-pin : 4*13 

cv~>terminals~>name
length(cv~>terminals); =>47

dL=2.03;6.68+0.03
dH=2.03;6.68+0.03
dL=6.68+0.03
dH=6.68+0.03

createPadRing( pins dL dH "afs_TDC_BRICK" "RING3" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_sx" "Ed_CMOS8" (("sx" "float" 0)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" 5 5) '("fillLast" 5 5) '(fillOffset 0.2)  '("shortList" '("SIOVDD" "SIOGND" "SIODVSS"  "my_pad_esd2"))  )

createPadRing( pins -0.52 -0.52 "afs_TDC_BRICK" "RING6" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_sx" "Ed_CMOS8" (("sx" "float" 0)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" 5 5) '("fillLast" 5 5) '(fillOffset 0.4)  '("shortList" '("SIOVDD" "SIOGND" "SIODVSS"  "my_pad_esd2")) '("verb" nil))

miscPatch();=> rajoute my_bvel_Skill

enterPoint();=>(1424.44 1421.5)

que8plots='(
( "VDD" "SIOVDD") ( "VDDD" "SIODVDD") 
("VSS" "SIODVSS")
("GND" "SIOGND")
"IO1" "IO2" "IO3" "IO4"
)

createPadRing( que8plots -0.52 -0.52 "afs_TDC_BRICK" "A8plot" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_sx" "Ed_CMOS8" (("sx" "float" 0)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" 5 5) '("fillLast" 5 5) '(fillOffset 0.4)  '("shortList" '("SIOVDD" "SIOGND" "SIODVSS"  "my_pad_esd2")) '("verb" nil))


createPadRing( ibm_pins 6.68+0.03 6.68+0.03 "AAA" "RING3" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_sx" "Ed_CMOS8" (("sx" "float" 0)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" 5 5) '("fillLast" 5 5) '(fillOffset 0.2)  '("shortList" '("SIOVDD" "SIOGND" "SIODVSS"  "my_pad_esd2"))  )
