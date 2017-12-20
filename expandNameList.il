
; (setq names '("VDD" "VSS" "CKR" "WRb" "RST" "regIO<9>" "CN<0:10>" "regIO<0>" "PD_trig<1:9>"))

ineed('bus2flat)

defun(expandNameList (@optional (names '("VDD" "VSS" "CKR" "WRb" "RST" "regIO<9>" "CN<0:10>" "regIO<0>" "PD_trig<1:9>")))
names=if(listp(names) names list(names))
foreach(mapcan n names 
if(
length(parseString(n ":"))>1 
bus2flat(n)
list(n); sinon
)))


; expandNameList('("VDD" "bus<1:2>"));=> ("VDD" "bus<1>" "bus<2>")
; expandNameList()
;=> ("VDD" "VSS" "CKR" "WRb" "RST" "regIO<9>" "CN<0>" "CN<1>" "CN<2>" "CN<3>" "CN<4>" "CN<5>" "CN<6>" "CN<7>" "CN<8>" "CN<9>" "CN<10>" "regIO<0>" "PD_trig<1>" "PD_trig<2>" "PD_trig<3>" "PD_trig<4>" "PD_trig<5>" "PD_trig<6>" "PD_trig<7>" "PD_trig<8>" "PD_trig<9>")
