skillDir="~/../ebecheto/Skill"
when(not(rexMatchList(skillDir getSkillPath())) setSkillPath(cons(skillDir getSkillPath())))
load("padRing.il")

 for(i 0 31 printf( "\"I%d\" " i))
for(i 0 31 printf( "\"O%d\" " i))
;; for(i 0 31 printf( "\"O%d\" " 31-i))


pinList='(
"O6" "O7" "O8" "O9" "O10" "O11" "O12" "O13" "O14" "O15" 
("VSS" "AGND3ALLP") 
("VDD" "AVDD3ALLP") 
"O16" "O17" "O18" "O19" "O20" "O21" "O22" "O23" "O24" "O25" "O26" "O27" "O28" "O29" "O30" "O31"
("VSS" "AGND3ALLP") 

"I0" "I1" "I2" "I3" "I4" "I5" "I6" "I7" "I8" "I9" "I10" "I11" "I12" "I13" "I14" "I15" 
("VSS" "AGND3ALLP")
("VSS" "AGND3ALLP")
("VSS" "AGND3ALLP")
("VSS" "AGND3ALLP")
("VSS" "AGND3ALLP")

("VSS" "AGND3ALLP")
("VDD" "AVDD3ALLP")
("VSS" "AGND3ALLP")
("VDD" "AVDD3ALLP")

; ("CLK160" "BBCU4P");<= non ? LVDS => plot IO
"CLK160" 

"SDA" "SDC" "RST"
"PAC"
"Vbias"
"Vref"
"Iref"
("VSS" "AGND3ALLP")
("VDD" "AVDD3ALLP")
("VSS" "AGND3ALLP")
("VDD" "AVDD3ALLP")

("VSS" "AGND3ALLP")
("VSS" "AGND3ALLP")
("VSS" "AGND3ALLP")
("VSS" "AGND3ALLP")
("VSS" "AGND3ALLP")

"I16" "I17" "I18" "I19" "I20" "I21" "I22" "I23" "I24" "I25" "I26" "I27" "I28" "I29" "I30" "I31"

("VSS" "AGND3ALLP") 
"O0" "O1" "O2" "O3" "O4" "O5"
)

printf("LENGTH:%d\n" length(pinList))

createPadRing( pinList 40 5 "AA" "RING" '("IO" "APRIOP") '("fill" "PERI_SPACER_50_P") '("complete" "PERI_SPACER_100_P" ) '("padCap" "CORNERP") '(xn 22) '("fillLast" 5 5) '("shortList" '("SIOVDD" "SIOGND" "SIODVSS"  "my_pad_esd2")) '(skipSch t))
