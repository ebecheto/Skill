;; copyleft ebecheto

ineed('itos)
;;modif a2s -> itos car a2s n'existe pas toujours suivant les version de cadence

defun(netMakeBus (@optional (net "S_87-4_")(L 8)(flat t)(bus "<"))
let((from to expand as)
if(listp(L) then from=car(L) to=cadr(L) else from=0 to=L-1)
bud=if(bus=="<" ">" "")
expand='()
for(i from to expand=cons( strcat(net bus itos(i) bud) expand))
expand=reverse(expand)
cond(
(flat==t expand)
(flat=='sym sh(sprintf(nil "echo \"%s\"\n" as=apply('strcat foreach(mapcar a expand strcat( " " a))))) as)
(t list(strcat(net "<" itos(from) ":" itos(to) ">")))
);cond
))

;; netMakeBus("Q" '(4 6));=>("Q<4>" "Q<5>" "Q<6>")
;; netMakeBus("Q" '(1 5));=>("Q<1>" "Q<2>" "Q<3>" "Q<4>" "Q<5>")
;; netMakeBus("Q" 5)  ;=>("Q<0>" "Q<1>" "Q<2>" "Q<3>" "Q<4>")
;; netMakeBus("Q" 5 t);=> ("Q<0>" "Q<1>" "Q<2>" "Q<3>" "Q<4>")
;; netMakeBus("Q" 5 nil);=>("Q<0:4>")
;; netMakeBus("Q" 5 t "_");=>("Q_0" "Q_1" "Q_2" "Q_3" "Q_4")
printf("netMakeBus(\"Q\" 5 t \"_\");=>%L\n" netMakeBus("Q" 5 t "_"))
printf("netMakeBus(\"Q\" 5 'sym);=>\" Q<0> Q<1> Q<2> Q<3> Q<4>\"")

defun(netMakeTruePos (@optional (net "Q<5>") (L '(4 10)) (true t))
foreach(mapcar i linRg(1 cadr(L) 1) if(i==car(L) net true)))
;; netMakeTruePos();=>(t t t "Q<5>" t t t t t t)
;; netMakePost("BU<4>" list(5 2*10));=>(t t t "BU<4>" t t t t t t t t t t t t t t t t)
;; ; Position t
;; netMakeTruePos("PD_5" '(10 10)) ;=> (t t t t t t t t t "PD_5")
