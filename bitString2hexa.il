;; copyleft ebecheto
ineed('abBinaryStrToInt)

defun( bitString2hexa (@optional (bitstr "10111000111011100011") (noquote nil))
let((r739 x739)
r739=reverse(parseString(bitstr ""));=> ("1" "1" "0" "0" "0" "1" "1" "1" "0" "1")
x739='()
while(r739 
x739=append(x739 list(
sprintf(nil "%02x" abBinaryStrToInt(apply('strcat reverse(list(
car(r739) nth(1 r739)||"" nth(2 r739)||"" nth(3 r739)||""
nth(4 r739)||"" nth(5 r739)||"" nth(6 r739)||"" nth(7 r739)||""
)))))
))
r739=nthcdr(8 r739)
) 
when(noquote foreach(mapcar x reverse(x739) printf("%s " x)))
reverse(x739) ;=> ("2" "e3")
))


printf("bitString2hexa();<= defaulf : convertit une string de bit en hexa \"10111000111011100011\"\n")
printf("bitString2hexa(%L t);<= fait aussi un printf (sans les quotes)\n" "10111000111011100011")
printf("bitString2hexa(strcat(%L %L) t);<= fait aussi un printf (sans les quotes)\n" "1011100011" "1011100011")
printf("hex=apply('strcat cons(\"0x\" bitString2hexa()));=> \"0x0b8ee3\"\n")
printf("sprintf(nil \"%%d\" evalstring(hex));=> \"757475\"\n")

; apply('strcat cons("0x" bitString2hexa())) ;=> "0x0b8ee3"
;; hex="0x0b8ee3"
;; sprintf(nil "%02x" evalstring(hex))
;; sprintf(nil "%x" evalstring(hex))
;; sprintf(nil "%d" evalstring(hex));=> "757475"

