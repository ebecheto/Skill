x=4;;; There is 3 way of wrinting in skill
;; printf "The value of x is %n \n" x    ;; simplest way but wont be clear for a function of functions
;; printf("The value of x is %n \n" x)   ;; standard C-like syntax
;; (printf "The value of x is %n \n" x)  ;; standart lisp syntax, the recommend way to use it, but people usualy prefer C-like

aList = '(1 2 3)                   ;;;' quote <=> list si initialisation de la liste
aLongList = '(1 2 3 4 5 6 7 8)     ;;;' quote <=> list si initialisation de la liste
aNestedList = '(1 (2 3) 4 5 (6 7)) ;;;' quote <=> list si initialisation de la liste
println( aList )      ;=>(1 2 3)
println( aLongList )  ;=>(1 2 3 4 5 6 7 8)
println( aNestedList );=>(1 (2 3) 4 5 (6 7))

a=1 b=2 ;=> 2 <= Renvoie le dernier element evalue de la ligne
aList = list(a b) ;=> (3 2) <= evalue a & b et cree une list de ces elements
bList = '(a b)    ;=> (a b)  <== c'est une initialisation ==> pointeurs
a=3 ;=> 3
nth(0 bList)       ; => a
eval(nth(0 bList)) ; => 3

aList = '(1 2 3 4 5 6 7 8)     ;;;' quote <=> list si initialisation de la liste
car(aList);=> 1 <= prend le premier element d'une liste
cdr(aList);=> (2 3 4 5 6 7 8)  prend le reste d'une liste (pas le premier)
last(aList);=> (8) revoie une *LISTE* contenant le dernier element

car(aList)   
nth(0 aList)  ; notations equivalentes /!\ nth demarre a 0 /!\

cadr(aList)  
nth(1 aList) 
car(cdr(aList))  ; notations equivalentes

caddr(aList) 
nth(2 aList) 
car(cdr(cdr(aList))) ; notations equivalentes

aList= nil
aList='()   ; equivalent

aList=tconc(aList 1)
aList=tconc(aList 2)          	    ;; liste = tconc(liste1 liste2)
aList=tconc(aList 3)	      	    ;; ==> liste = ( (liste1 liste2) liste2)
aList=tconc(aList '(3 4 5 6)) 	    ;; tconc est mieux car il evite de creer 2 espaces memoire
println aList		      	    ;; il marche avec le pointeur sur le dernier element
println car(aList)

aelSuffixNotation(0.0019);=> "1.9m"
aelSuffixNotation(1.9m)  ;=> "1.9m"
aelSuffixNotation(1.2e-6);=> "1.2u"
aelNumber("1.2u")        ;=> 1.2e-06
atoi("26")        ;=> 26 <= All TO Integer 
atoi("26.0")      ;=> 26 <= All TO Integer 
atof("29m")       ;=> 29.0 <= error, not what you want
atof("0.029")     ;=> 0.029 <= ok for simple engineering string notations without suffixes!

logRg(1 1M 1)  ;=> (1.0 10.0 100.0 1000.0 10000.0 100000.0 1000000.0)
linRg(0 100 10);=> (0 10 20 30 40 50 60 70 80 90 100)

;; foreach( mapcar x aList ...) renvoie la liste des derniers element evalues dans ...
aList=list("one" "two" list("three"))
foreach( mapcar x aList "tata");==> ("tata" "tata" "tata")
foreach(        x aList "tata");==> ("one" "two" ("three")) ;<==revoie la liste aList
i=0 foreach( mapcar x aList i++ );==> (0 1 2)
i=0 foreach( mapcar x aList i++ sprintf(nil "tata_%d" i));==> ("tata_1" "tata_2" "tata_3")
foreach( mapcar x aList append(list(x) '("d sd" )  )) ;==>(("one" "d sd") ("two" "d sd") (("three") "d sd"))

aList=list("one" "two" "three")
i=0 newList=foreach( mapcar x aList i++ sprintf(nil "%s_%d" x i)) ;==> ("one_1" "two_2" "three_3")

println(foreach(mapcar x  logRg(1n 1M 1) aelSuffixNotation(x)))
("1n" "10n" "100n" "1u" "10u" "100u" "1m" "10m" "100m" "1" "10" "100" "1K" "10K" "100K")
println(foreach(mapcar x  logRg(1e-15 1e+15 1.0/3) aelSuffixNotation(x)))
("1f" "1p" "1n" "1u" "1m" "1" "1K" "1M" "1G" "1T")

sprintf(cmd "echo \"%s\"" " Hello world" )
cmd=sprintf(nil "echo \"%s\"" " Hello world" )  ;; aString=sprintf(nil "%s %2.3g %d %L" "a" 3e-3 -12 '(a b aList))
;^^         ^^^ standard way of using sprintf
(system cmd) ;; ==> renvoie sur le shell le resultat



numbers = '(1 2 3) ;==> (1 2 3)
member( 4 numbers)  ;;<== renvoie nil ou la liste tronce a  partir de l'element cherche
;;==> nil

numbers = '(1 2 3 4 9 5 4 6)
member( 4 numbers);;==> (4 9 5 4 6)
car(member( 4 numbers)) ;;==> 4

nthelem( 2 '( a b c ) ) ;==> b

A='(1 2 1 3 1 4 1 5) B='(1 3 5)
procedure(SubstractList(B A)
let((item)
while(B && A item=car(B) B=cdr(B) A=remove(item A) )
A))
SubstractList(B A)


nthcdr( 3 '( a b c d )) ;=> (d) ;nthcdr comme nth demarre a 0
cdddr( '( a b c d )) ;=> (d)
nthcdr( 2 '( a b c d )) ;=> (c d)
cddr( '( a b c d )) ;=> (c d)
nthcdr( 1 '( a b c d )) ;=> (b c d)
cdr( '( a b c d )) ;=> (b c d)
z = '( 1 2 3 )
nthcdr( 2 z ); => ( 3 )

aList = '( a b c ) ;=> ( a b c )
subst( 'a 'b aList ) ;=> ( a a c )
anotherList = '( a b y ( d y ( e y )))
subst('x 'y anotherList ); => ( a b x ( d x ( e x )))

numbers = '(1 2 3 4 9 5 4 6)
(setof x numbers oddp(x)) ;=> (1 3 9 5)
evenp(2);=>t   fonction est-ce pair ?
evenp(3);=>nil

cv=geOpen(?lib "GATES" ?cell "nand2_core" ?view "schematic" ?mode "r")
cv~>cellView~>instances~>?? ;=> trop de choses  on va filtrer
cv~>cellView~>instances~>cellName ;=> ("vdd" "vdd" "vdd" "vdd" "gnd" "gnd" "nmos4" "nmos4" "pmos4" "pmos4" "revblk" "ipin" "ipin" "opin")

PMOS=(setof x cv~>cellView~>instances  x~>cellName=="pmos4") ;=> (db:0x1091799b db:0x1091799a) il y a deux pmos dans une nand2
car(PMOS)~>? ;=> renvoie la liste des choses appartenant a la premiere instance PMOS
car(PMOS)~>??;=> renvoie la liste et ses valeurs
;ACTION : selectionner manuellement une instance puis taper :
css()~>??;=> decrit le 1er element de la selection
; css() est un alias de car(geGetSelectedSet())

css()~>bBox;=> ((-0.55 -0.8375) (0.74375 -0.13125)) ; coordonnees de la selection box
css()~>xy  ;=> (0.0 -0.375) coordonnee du point d'origine du symbol


'(0:0 10:10)    ;'  ==> ((X0:Y0)(X1:Y1))        <== danger ne donnera pas l effet escompte
list(0:0 10:10) ;   ==> ((X0 Y0)(X1 Y1))

one =1
two =2
three =3
moreNumbers = list( one two three)
moreNumbers

evenMoreNumbers = append( moreNumbers '(2 1)) ;==> (1 2 3 2 1)
; les deux elements de append sont des LIST

;_______________________________________________________________;
; RTFM : MANUAL : ou trouver les informations sur les fonctions :
help append
listFunctions("append") ;=> (append append1 appendPath appendWaves)
;=> renvoie la liste des fonctions existantes ; contenant le mot append
alias(lf listFunctions) ;=> a rajouter dans votre ~/.cdsinit_personal
lf("^open")  ;=> liste des fonctions commencant par open
lf("boundp$");=> liste des fonctions finissant par boundp
startFinder();=> interface graphique de listFunctions

;_____ concatenation de plusieurs listes dont le nom s'incremente
list_1='("a" "a")
list_2='("b" "b" "b")
list_3='("ccc")
masterList=foreach(mapcar i linRg(1 3 1) eval(concat("list_" i)))
println masterList ;=> (("a" "a") ("b" "b" "b") ("ccc"))

;_____ better approch
masterList='()
for(i 1 3 masterList=cons(symeval(concat('list_ i)) masterList) )
println masterList ;=> (("ccc") ("b" "b" "b") ("a" "a"))
reverse(masterList);=> (("a" "a") ("b" "b" "b") ("ccc"))

a=t
when(a=='t printf("TRUE"));=> TRUE t
when(a==t printf("TRUE")) ;=> TRUE t
when(a    printf("TRUE")) ;=> TRUE t
unless(a  printf("TRUE")) ;=> nil
unless(!a printf("TRUE")) ;=> TRUE t
if(a 0 1) ;=> 0
if(!a 0 1);=> 1
if(!a 0 1 23);=> *Error* if: too many arguments (missing then?) - (!a 0 2 1)
if(!a then 0 else "si plus que 2 element utiliser then[else]")

if(!a 0 1)     ;=>1
if(!a then 0 1);=> nil  et oui, c'est different il n'y a pas de cas FAUX qaund pas de 'else'

