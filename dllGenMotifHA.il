ineed('itos)

defun(dllGenMotifHA (@optional (L 8)(charge 'test)(mdl 'ibmg))
let((i ni)
when(mdl=='ibm mdl='("GND" "SX" "NW" "VDD"))
when(mdl=='ibmg mdl='("gnd!" "sx!" "nw!" "vdd!"))
when(mdl=='tsmc mdl='("vdd!" "gnd!"))
when(charge=='test charge='(("BUFFER_C" (t "Q_")) ("DFF_E" (t t "Q_" "Q_"))))
i=-1 foreach(mapcar mot linRg(0 L-1 1) i++
foreach(mapcar ch charge
list(car(ch)
append(mdl 
foreach(mapcar ph cadr(ch) ;inc=t
if(ph=='t then t else 
p=if(listp(ph) car(ph) ph)
inc=if(listp(ph) cadr(ph) t)
ni=cond(
(listp(ph)&&not(cadr(ph)) "") ;=> si un seul arg ou deuxieme arg = nil => pas d'incrementation
(car(last(parseString(p "")))=="!" ""); idem pour les vdd! etc. pour eviter ("vdd!" nil)("gnd!" nil) ...
(listp(ph)&&(nth(2 ph)=='t) itos(i+cadr(ph)));=> si un 3eme argument 't => pas de modulo
(t itos(mod(L+i+if(listp(ph) cadr(ph) 0) L)) ) ;=> default mode : increment plus modulo
;(listp(ph)&&cadr(ph) itos(mod(L+i+cadr(ph) L)) )
)
printf("")
bus=if(car(last(parseString(p "")))=="<" ">" "")
;printf("i %d ni %d p %s ph %L mods :%L : mod(%d %d)\n" i ni p ph list(L mod(L+ni L)  mod(ni+L L) mod(ni+L+1 L)) ni+L L);=> logique qd n=1 => mords sa queue 
strcat(p ni bus)
; sprintf(nil "%s%d%s" p mod(L+ni L) bus||"")
))))))))


; dllGenMotifHA(8 '(("BUFFD1" (t "Q_")) ("DFD1" (t t "Q_" "Q_"))) 'tsmc)
