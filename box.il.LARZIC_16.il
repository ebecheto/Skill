; load("box.il.LARZIC_16.il")
; load("padRing.il")

println(i=foreach(mapcar p linRg(1 16 1) sprintf(nil "IN_%d" p)))
println(foreach(mapcar p linRg(1 16 1) sprintf(nil "PA_%d" p)))
println(t1=foreach(mapcar p linRg(1 16 1) sprintf(nil "T1_%d" p)))
mapcan('list i t1)

println(foreach(mapcan p linRg(1 16 1) a=list(sprintf(nil "IN_%d" p) sprintf(nil "T1_%d" p)) if(evenp(p) reverse(a) a)))


larzPin='(
("VSS" "AGND3ALLP_3B") 
"ENA"
("VDD" "AVDD3ALLP_3B") 
"VDB1"
"VSB2"
("VSS" "AGND3ALLP_3B") 

;("CUT" "PWRCUT_DIG_P_3B_DXS")
("VDDB" "AVDD3ALLP_3B") 
("VSSB" "AGND3ALLP_3B") 
"VBBB"
"OUT"
"OUTN"
("VDDB" "AVDD3ALLP_3B") 
("VSSB" "AGND3ALLP_3B") 
("vsub!" "AVSUBP_3B") 
;("CUT" "PWRCUT_DIG_P_3B_DXS")

("VSS" "AGND3ALLP_3B") 
("VDD" "AVDD3ALLP_3B")
("VSS" "AGND3ALLP_3B") 
("vsub!" "AVSUBP_3B") 

"ENA2"
"Vref"

"IN_9"
"T1_9"
"T1_10"
"IN_10"
"IN_11"
"T1_11"
"T1_12"
"IN_12"
"IN_13"
"T1_13"
"T1_14"
"IN_14"
"IN_15"
"T1_15"
"T1_16"
"IN_16"

("VSS" "AGND3ALLP_3B") 
("VSS" "AGND3ALLP_3B") 

"PA_16"
"PA_15"
"PA_14"
"PA_13"
"PA_12"
"PA_11"
"PA_10"
"PA_9"
"PA_8"
"PA_7"
"PA_6"
"PA_5"
"PA_4"
"PA_3"
"PA_2"
"PA_1"
("VSS" "AGND3ALLP_3B") 
("VSS" "AGND3ALLP_3B") 

"IN_1"
"T1_1"
"T1_2"
"IN_2"
"IN_3"
"T1_3"
"T1_4"
"IN_4"
"IN_5"
"T1_5"
"T1_6"
"IN_6"
"IN_7"
"T1_7"
"T1_8"
"IN_8"

"IN_diff"
"diod"
)

larP=setof(p larzPin !listp(p))
;terminalGen(larzP)

length(larzPin)
;; padLib='("IOLIB_4M" "IOLIB_ANA_4M" "IOLIB_3B_4M" "IOLIB_ANA_3B_4M")
padLib=list("IOLIB_3B_4M" "IOLIB_ANA_3B_4M" "IOLIB_4M" "IOLIB_ANA_4M")
IOCELL="APRIOP_3B"
PERICELL="PERI_SPACER_100_P_3B"
CORNERCELL="CORNERP_3B"
createPadRing(larzPin 0 0 "LARZIC_16" "RING_7"  '("IO" IOCELL) '("fill" PERICELL) '("padCap" CORNERCELL) '("fillFirst" nil) '("GND" "VSS") '(xn 18))


larzJLCC68='(
("VSS" "AGND3ALLP_3B") 
"ENA"
("VDD" "AVDD3ALLP_3B") 
"VDB1"
"VSB2"
("VSS" "AGND3ALLP_3B") 
("VDDB" "AVDD3ALLP_3B") 
("VSSB" "AGND3ALLP_3B") 
"VBBB"
"OUT"
"OUTN"
("VDDB" "AVDD3ALLP_3B") 
("VSSB" "AGND3ALLP_3B") 
("vsub!" "AVSUBP_3B") 
("VSS" "AGND3ALLP_3B") 
("VDD" "AVDD3ALLP_3B")
("vsub!" "AVSUBP_3B") 

("VSS" "AGND3ALLP_3B") 
"ENA2"
"Vref"
"IN_9"
"T1_910"
"IN_10"
"IN_11"
"T1_1112"
"IN_12"
"IN_13"
"T1_1314"
"IN_14"
"IN_15"
"T1_1516"
"IN_16"

("VSS" "AGND3ALLP_3B") 
("VSS" "AGND3ALLP_3B") 

"PA_16"
"PA_15"
"PA_14"
"PA_13"
"PA_12"
"PA_11"
"PA_10"
"PA_9"
"PA_8"
"PA_7"
"PA_6"
"PA_5"
"PA_4"
"PA_3"
"PA_2"
"PA_1"
("VSS" "AGND3ALLP_3B") 
("VSS" "AGND3ALLP_3B") 
("VSS" "AGND3ALLP_3B") 

"IN_1"
"T1_12"
"IN_2"
"IN_3"
"T1_34"
"IN_4"
"IN_5"
"T1_55"
"IN_6"
"IN_7"
"T1_78"
"IN_8"

"IN_diff"
"diod"
("VSS" "AGND3ALLP_3B") 
)

length(larzJLCC68)
createPadRing(larzJLCC68 0 0 "LARZIC_16" "LARZIC_JLCC68"  '("IO" IOCELL) '("fill" PERICELL) '("padCap" CORNERCELL) '("fillFirst" nil) '("GND" "VSS") '(xn 18))

i=26
pin="IN_1"
pin='("VSS" "blalba")
pf = outfile("~/projet/io.csv")
foreach( pin larzJLCC68
c1="" c2="" c3=sprintf(nil "%d" mod(i 68)+1 ) i=i+1
if(!listp(pin) c1=pin c1=car(pin))
cond(
(rexMatchp("IN" c1) c2="INPUT")
(rexMatchp("PA" c1) c2="OUTPUT")
(rexMatchp("OUT" c1) c2="OUTPUT")
(rexMatchp("VSS" c1) c2="GROUND")
(rexMatchp("VDD" c1) c2="POWER")
(rexMatchp("T1_" c1) c2="POWER")
)
fprintf(pf "%s;%s;%s;\n" c1 c2 c3)
)
close(pf)
edit("~/projet/io.csv")
