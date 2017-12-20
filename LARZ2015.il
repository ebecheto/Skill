;; ~/Work/IC6/ams410/c35b4/box_0.il

cv= geGetWindowCellView()


consos='(2.99m 800u 108u 844u 2.624m 2.618m 9.3u 3.169m)
foreach(mapcar conso consos aelSuffixNotation(conso*16))
;=> ("47.84m" "12.8m" "1.728m" "13.5m" "41.98m" "41.89m" "148.8u" "50.7m")


apply('plus consos)*16
;=> 0.1627568;=> 0.0101723
cv~>conns~>name
("ENA" "Rdiod" "V18" "in_pa" "OUTN"
    "OUTP" "VT1" "VDD" "VDB1" "Vref"
    "VSS" "VSB2" "vcm" "Dzi" "Dzo"
    "Dzk" "Cstim"
)
; modit sans quote

ENA Rdiod V18 
    VT1 VDD VDB1 Vref
    VSS VSB2 vcm Dzi Dzo
    Dzk Cstim
in_pa<0:15> 
OUTP<0:15> 
OUTN<0:15> 



cv~>sigNames
"in_pa<7>" "in_pa<6>" "in_pa<1>" "OUTN<15>" "OUTN<14>"
	"OUTN<13>" "OUTN<12>" "in_pa<5>" "in_pa<3>" "in_pa<8>"
	"in_pa<9>" "in_pa<10>" "VDD" "OUTP<1>" "VSB2"
	"Dzk" "Vref" "in_pa<11>" "in_pa<12>" "in_pa<13>"
	"in_pa<14>" "in_pa<15>" "V18" "Rdiod" "ENA"
	"OUTN<11>" "OUTP<12>" "OUTP<13>" "OUTP<14>" "OUTP<15>"
	"OUTN<0>" "OUTN<1>" "in_pa<4>" "in_pa<2>" "in_pa<0>"
	"OUTP<11>" "OUTN<2>" "OUTN<3>" "OUTN<4>" "OUTN<5>"
	"OUTN<6>" "OUTN<7>" "OUTN<8>" "OUTN<9>" "OUTN<10>"
	"OUTP<3>" "Dzi" "OUTP<9>" "OUTP<7>" "OUTP<10>"
	"OUTP<5>" "OUTP<8>" "OUTP<6>" "OUTP<4>" "OUTP<2>"
	"OUTP<0>" "VT1" "VDB1" "VSS" "vcm"
	"Dzo" "Cstim"



terminalGen(pinlist)