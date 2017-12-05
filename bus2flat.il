;; copyleft ebecheto

;; TODO : correct bus2flat("MULT<3:0>") see instBusMatch  MSB_first variant

ineed('netMakeBus)

unless(fboundp('a2s) ineed('itos) alias(a2s itos))


defun(bus2flat (@optional (net "Q<1:10>"))
let((netb)
netb=parseString(net ":<>" )
if(length(netb)==3 

netMakeBus(car(netb) list(atoi(cadr(netb)) atoi(caddr(netb)))) 
net)
))


; bus2flat();=> ("Q<1>" "Q<2>" "Q<3>" "Q<4>" "Q<5>" "Q<6>" "Q<7>" "Q<8>" "Q<9>" "Q<10>")
; bus2flat("in<1:16>");=> ("in<1>" "in<2>" "in<3>" "in<4>" "in<5>" "in<6>" "in<7>" "in<8>" "in<9>" "in<10>" "in<11>" "in<12>" "in<13>" "in<14>" "in<15>" "in<16>")


printf("obsolete, prefer >>> bus2list <<< function\n")
printf("see also functions _bus2()  and bus2_() in terminal2pin.il\n")
printf("ineed('terminal2pin)\n")


;; css()~>net~>term~>name="TOTO"


;; lb="IN_1"

;; defun( string_2bus (@optional (lb "IN_1"))
;; plb=parseString(lb "_");=> ("IN" "1")
;; llb=car(last(plb));=> "1"
;; ldr=reverse(cdr(reverse(plb)));=> ("IN")
;; debut=buildString(ldr "_");=> "IN" remet en forme s'il y avait plusieurs _
;; er=errset(evalstring(llb))
;; if(er
;; ; numberp(evalstring(llb)) ;=>> error si pas nombre dans string
;; then 
;; nlb=strcat(debut "<" llb ">") 
;; else
;; printf("not a number? %L\n" llb)
;; lb)
;; )




;; foreach(mapcar g geGetSelectedSet() when(g~>net~>term g~>net~>term~>name=string_2bus(g~>net~>term~>name)))

