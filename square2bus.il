;ineed('square2bus t)
;net="io<2:3>"

defun(square2bus (@optional (net "io[2:3]")) let((pa)
pa=parseString(net "[]");=> ("io" "2:3")
if(length(pa)>= 2 strcat(car(pa) "<" cadr(pa) ">") net)
;=> "io[2:3]"
))

;; bus2square();=> "io[2:3]"
;; bus2square("i<1>");=> "i[1]"
;; bus2square("lalala");=> ("lalala")


;; name="bus<1:0>"
;; ; nindex(name "<");=> 4
;; splitName=parseString(name "<:>");=> ("bus" "1" "0")
;; dbGetNameNumBit(name);=> 2
;; ; check splitName length mayby
;; strcat(nth(0 splitName) "<" nth(2 splitName) ":" nth(1 splitName) ">");=> "bus<0:1>"
;; strcat(nth(0 splitName) "[" nth(2 splitName) ":" nth(1 splitName) "]");=> "bus[0:1]"