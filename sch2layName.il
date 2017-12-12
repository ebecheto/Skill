;; copyleft ebecheto

defun(sch2layName (@optional (ins "MULT<0>)"))
let((strip)
strip=parseString(ins "<>)"); ;=> ("MULT" "0")
if(length(strip)>1 strcat("|" car(strip) "(" cadr(strip) ")")  strcat("|" car(strip))))
)

;; USAGE
;; sch2layName();=> "|MULT(0)"
;; sch2layName("MULT<4>");=> "|MULT(4)"
;; sch2layName("I0");=> ("|I0") 

