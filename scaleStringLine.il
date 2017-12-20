;; copyleft : ebecheto

defun(scaleStringLine (nextLine @optional (mult t))
let((ligne units i ncol scale towrite)
ligne=parseString(nextLine " ")
printf("%L" ligne)
units=cond(
(mult==nil printf("COND 1\n")
foreach(mapcar x ligne nil)
); cond #1
(or(type(mult)=='fixnum type(mult)=='flonum)  printf("COND 2\n")
foreach(mapcar s ligne if(or(type(x)=='flonum type(x)=='fixnum) nth(i mult) nil ) mult nil)
); cond #2
(
listp(mult)
;and(listp(mult) or( type(car(mult))=='fixnum type(car(mult))=='flonum)) 
printf("COND 3 %L %L\n" mult nth(0 mult))
i=-1
foreach(mapcar s ligne i++ x=evalstring(s) if(or(type(x)=='flonum type(x)=='fixnum) nth(i mult) nil ))
); cond #3
(t printf("COND t\n");==> take column exponent as scale argument
foreach(mapcar x ligne evalstring(if(expo=cadr(parseString(x "e")) strcat("1e" expo) "")))
); cond #4
); end cond affect units

ncol=-1
towrite=foreach(mapcar x ligne ncol++
if(unit=nth(ncol units) then 
;scale=evalstring(unit)
scale=unit
printf("take %L unit=%L %L ncol%L\n" scale unit x ncol)
if(type(nb=evalstring(x))=='flonum then sprintf(nil "%g" nb/scale) else x)
else x)
)
list(towrite units);return args
))

;; aelSuffixNotation(evalstring("1e-15"))

;; nextLine="   10e-15           585.7           \n"

;; scaleStringLine(nextLine nil) ; ==> "   10e-15           585.7           \n" ;do nothing
;; scaleStringLine(nextLine t) ; ==> "   10           585.7           \n"
;; scaleStringLine(nextLine '(1e-15) )
;; scaleStringLine(nextLine '("1e-15" nil nil)) ; ==> "   10           0.5857           \n"
;; nextLine="   10e-15           1.2e3           \n"
; scaleStringLine(nextLine '(1e-15 nil nil)) ; ==> "   10           1.2e3           \n"



