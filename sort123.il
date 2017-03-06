;; copyleft : ebecheto

; load("sort123.il")
defun( alphaNum (aa) let((sa csa tsa) sa=list(car(aa)) csa=cdr(aa)
foreach( a csa tsa='() csa=sa
(when alphaNumCmp(a car(csa))<0  sa=append(list(a) csa) csa='())
while( csa&&alphaNumCmp(a car(csa))>=0
tsa=append(tsa list(car(csa))) csa=cdr(csa))
sa=append(append(tsa list(a)) csa)
) sa))
;; alphaNum marche bien que si c'est deja trie par sort....
;; alphaNum('("XOR4X6" "XOR4XL" "XOR4X8" "XOR4X6" "XOR4X4")) error si deux elements identiques ?


defun( insertAlphaNum (sa lsa) let((OUT ins done) foreach( a lsa
when(alphaNumCmp(a sa)>=0 ins=t)
if(done||!ins then
OUT=append(OUT list(a))
else
OUT=append(OUT list(sa a)) done=t
)
; printf("%L %L %s %L\n" done ins a OUT)
);foreach
unless(lsa OUT=list(sa) ins=t)
unless(ins OUT=append(OUT list(sa)))
OUT))
;; insertAlphaNum("XOR4X6" '("XOR4X1" "XOR4X2" "XOR4X3" "XOR4X10"))


defun( sort123 (toSort) (let (l_var s_var pattern OUT)
pattern="ed_"
when(listVariables(strcat("^" pattern)) printf("\nATTENTION DANGER\n") ) ; eventuelement while(pattern_ pattern_i++ ...)
foreach(mapcar so toSort ss=parseString(so "0123456789")
s_var=strcat(pattern car(ss))
not(boundp(stringToSymbol( s_var)))&&set(stringToSymbol( s_var) nil)
unless(member(s_var l_var) l_var=append(l_var list(s_var))); evite les doublon dans l_var. liste des element a purger apres
; printf("SO:%s" so) println(insertAlphaNum(so eval(stringToSymbol(s_var)))) printf("\n")
;set(stringToSymbol(s_var) append(eval(stringToSymbol(s_var)) list(so)));<= action a modifier en fonction du tri
set(stringToSymbol(s_var) insertAlphaNum(so eval(stringToSymbol(s_var))));<= action a modifier en fonction du tri
eval(stringToSymbol(s_var))
)
l_var=sort(l_var nil) foreach(l l_var OUT=append(OUT eval(stringToSymbol(l))))
; OUT=nil l_var=sort(listVariables(pattern) nil) foreach(l l_var OUT=append(OUT eval(l)))
unless(length(toSort)==length(OUT) printf("Lost elements ?%d\n" length(toSort)-length(OUT)))
; losts=remove(t foreach(mapcar to toSort if(member(to OUT) t to)))
foreach(l l_var set(stringToSymbol(l) 'unbound)) ; purge les liste definies
; foreach(mapcar l listVariables(strcat("^" pattern)) eval(l)) ; check results
OUT))

