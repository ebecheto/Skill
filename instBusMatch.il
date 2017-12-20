defun(instBusMatch (@optional (name css()~>name))
let((pname ltmi gtmi buslen MSB_first)
pname=parseString(name "<:>")
ltmi=cadr(pname);=> "15"  ;<= ltmi lowerThanMultInst
gtmi=car(last(pname));=> "0"  ;<= gtMI greater Than Mult Inst
MSB_first=when(ltmi && gtmi buslen=(atoi(gtmi)-atoi(ltmi))  if(buslen<0 1 0))
when(ltmi && gtmi buslen=buslen + (-1)**MSB_first)
list(ltmi gtmi MSB_first buslen car(pname))
))


;; bus2list()


;; instBusMatch("MULT<31:16>");=> ("31" "16" 1 -15 "MULT")
;; instBusMatch("MULT<3:0>");=> ("3" "0" 1 -3 "MULT")
;; instBusMatch("MULT<0:3>");=> ("0" "3" 0 3 "MULT")
;; instBusMatch("MULT<0>");=> ("0" "0" 0 0 "MULT")
;; instBusMatch("MULT");=> (nil "MULT" nil nil "MULT")



