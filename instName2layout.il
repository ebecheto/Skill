;; copyleft ebecheto

defun(instName2layout (@optional (ins "I6<1>"))
if(length(pins=parseString(ins "<>"))>1 strcat("|" car(pins) "(" cadr(pins) ")") strcat("|" ins))
)



;; one could 'surcharge' (cast?) this function to map an expected table
;; defun(layoutInstName (@optional (ins "I6<1>"))
;; cond(
;; (ins=="TOTO" "TATA")
;; (ins=="TITI" "TUTU")
;; (t if(length(pins=parseString(ins "<>"))>1 strcat("|" car(pins) "(" cadr(pins) ")") strcat("|" ins)))
;; )


