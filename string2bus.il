;; copyleft : ebecheto

defun( string2bus (@optional (lb "IN_1"))
plb=parseString(lb "_");=> ("IN" "1")
llb=car(last(plb));=> "1"
ldr=reverse(cdr(reverse(plb)));=> ("IN")
debut=buildString(ldr "_");=> "IN" remet en forme s'il y avait plusieurs _
er=errset(evalstring(llb))
if(er
; numberp(evalstring(llb)) ;=>> error si pas nombre dans string
then 
strcat(debut "<" llb ">")
else
printf("not a number? %L\n" llb)
lb)
)




; foreach(mapcar g geGetSelectedSet() when(g~>net~>term g~>net~>term~>name=string2bus(g~>net~>term~>name)))


;; string2bus();=> "IN<1>"
;; string2bus("t_t_2_3");=> "t_t_2<3>"
;; string2bus("out<2>");=> "out<2>"
;; string2bus("out__2");=> "out<2>"
;; string2bus("out_2") ;=> "out<2>"