;net="io<2:3>"

defun(bus2square (@optional (net "io<2:3>")) let((pa)
pa=parseString(net "<>");=> ("io" "2:3")
if(length(pa)>= 2 strcat(car(pa) "[" cadr(pa) "]") net)
;=> "io[2:3]"
))

;; bus2square();=> "io[2:3]"
;; bus2square("i<1>");=> "i[1]"
;; bus2square("lalala");=> ("lalala")
