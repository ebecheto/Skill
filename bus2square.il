;net="io<2:3>"

defun(bus2square (@optional (net "io<2:3>")) let((ret)
ret=net
pa=parseString(net "<>");=> ("io" "2:3")
when(length(pa)>= 2 ret=strcat(car(pa) "[" cadr(pa) "]"))
;=> "io[2:3]"
))

bus2square();=> "io[2:3]"
bus2square("i<1>");=> "i[1]"

