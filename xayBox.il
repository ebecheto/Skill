when(not(rexMatchList(pwd() getSkillPath()))  setSkillPath(cons(pwd() getSkillPath())))

; padLib='("short_io" "cmrf8sf" "cmos8rf" )
ibm_pins='(
( "VDD" "SIOVDD") ( "VDD" "SIOVDD") ( "VDD" "SIOVDD") ( "VDD" "SIOVDD")
"O1" "O2" "O3" "O4"
("GND" "SIOGND") ("GND" "SIOGND") ("GND" "SIOGND")
("GND" "SIOGND")
"I3"
("Idigital4" "SIOB04_B")
"I2"
;("I1")
)

createPadRing( ibm_pins 10 50 "TACTIC" "RINGtest" '("IO" "SIOWIRE_ESD") '("fill" "SIOFILL_10" "TACTIC" (("sx" "float" 50)) ) '("complete" "SHORT_IO_BREAKGND_CELL_8MA_44" "short_io") '("padCap" "SIOCORNER45")  '("metal" "MG") '("fillFirst" t) '("fillLast" t) '(fillOffset 0.2) )


