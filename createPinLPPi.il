;; copyleft ebecheto

defun(createPinLPP (@optional (sigNames list("GND" "" ))(inst css())
apn=assoc(pn getInstTermPointLPP(inst))
;=>("Z" (5.1 22.71) ("M1" "pin") ((5.0 22.41) (5.2 23.01)) db:0x1495141d)
; createPinLPP(name bBox lpp dir)
bBox=nth(3 apn) lpp=nth(2 apn); dir=nth(4 apn)~>pin~>term~>direction
printf("createPinLPP%L\n" list(sigName bBox lpp dir))
if(bBox&&lpp then createPinLPP(sigName bBox lpp dir) else printf("NO LPP or bBox for:%L\n" list(sigName bBox lpp dir)))
