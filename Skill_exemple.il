x=4;;; There is 3 way of wrinting in skill
printf "The value of x is %n \n" x    ;; simplest way but wont be clear for a function of functions
printf("The value of x is %n \n" x)   ;; standard C-like syntax
(printf "The value of x is %n \n" x)  ;; standart lisp syntax, the recommend way to use it, but people usualy prefer C-like


sprintf(cmd "echo \"%s\"" " Hello world" )
(system cmd) ;; ==> renvoie sur le shell le resultat
;; (system "xterm") ;; <== will launch an xterm, ==> wait for it to close ==> freeze
(system "xterm&")

editor="emacs"
; editor="vi"
; editor = "nedit";
edit("/cds/local/cadence")

whereIs( printf)
help whereIs ;==> whereIs Prints where a function is defined <=> which in shell
whereIs help ;==> 


libName = "Cells"
cellName = "inverter"
viewName = "schematic"
shapeCount = 200
printf("The design of %s %s %s is %n \n" libName cellName viewName shapeCount)

layerName= "MET_1"
purpose= "png"
rectCount= 7346546413516
labelCount= 10
lineCount=30
miscCount=50

printf(
/* "\n%-15s %-15s %-10d  %-10d  %-10d  %-10d " */
"\n%-15L %-15L %-10L  %-10L  %-10L  %-10L "
layerName
purpose   
rectCount 
labelCount
lineCount 
miscCount 
)

aList = '(1 2 3) ; ' quote <=> if initialisation of the list
aLongList = '(1 2 3 4 5 6 7 8) ; ' quote <=> if initialisation of the list
aNestedList = '(1 (2 3) 4 5 (6 7)) ; ' quote <=> if initialisation of the list
println( aList )
println( aLongList )
println( aNestedList )

printf("This is a liste :")

a=1 b=2
aList = list(a b)
bList = '(a b)   ;;;;  <== c'est une initialisation ==> pointeurs
a= 3
nth(0 bList)
eval(nth(0 bList))


result = '(1 2 3) ;;'
result = cons(result 1)
result = cons(1 result)  ;;<== erreur arg 1 doit etre une liste
result = cons(() 1 result)  ;;<== erreur cons a seulement 2 arguments

aList= nil
aList='()   ; equivalent'

aList=tconc(aList 1)
aList=tconc(aList 2)          	    ;; liste = tconc(liste1 liste2)			      
aList=tconc(aList 3)	      	    ;; ==> liste = ( (liste1 liste2) liste2)		      
aList=tconc(aList '(3 4 5 6)) 	    ;; tconc est mieux car il evite de creer 2 espaces memoire
println aList		      	    ;; il marche avec le pointeur sur le dernier element      

result ='() for(i 0 31 result=tconc(result sprintf(nil "pad_%d" i))) result=car(result)


x0=10 y0=10  x1=10 y1=10
pinBox = list(x0:y0 x1:y1)
subst('(-10) 'y1 pinBox);==> marche pas car "list" fait un eval des valeurs pointées => pas de pointeur
subst('(-10) y1 pinBox);==> marche pas car change toutes les valeurs 10 par -10

pinBox = '(x0:y0 x1:y1)
subst('(-10) y1 pinBox) ;==> marche pas car y1 est la valeur pointé par y1 et non le pointeur y1
subst('(-10) 'y1 pinBox);==> ' permet de substituer le pointeur
subst(-y1 'y1 pinBox);==> remplace y1 par -y1


numbers = '(1 2 3 ) ;;;'
	    member( 4 numbers)
;;==> (1 2 3)    ;;<== renvoie la liste, puis la réponse : nil ou la liste troncé à partir de l'element cherché
;;==> nil     

numbers = '(1 2 3 4 9 5 4 6) ;;;'
	    member( 4 numbers)
;;==> (1 2 3 4 9 5 4 6)
;;==> (4 9 5 4 6)
	    car(member( 4 numbers))
;;==> 4

nthelem( 2 '( a b c ) ) ;==> a

A='(1 2 1 3 1 4 1 5) B='(1 3 5)
procedure(SubstractList(B A)
let((item)
while(B && A item=car(B) B=cdr(B) A=remove(item A) )
A))
SubstractList(B A)

full='("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
full='(("0") ("1") ("2") ("3") ("4") ("5") ("6") ("7") ("8") ("9") ("10") ("11") ("12") ("13") ("14") ("15"))
fourth=nil
fourtt=nil
for(i 1 4 fourth=append(fourth list(car(full))) full=cdr(full))
for(i 1 4 fourtt=tconc(fourtt car(full)) full=cdr(full))
println(fourth) ;==>(("0") ("1") ("2") ("3"))
println(fourtt) ;==>((("4") ("5") ("6") ("7")) ("7"))
println(car(fourtt)) ;==>(("4") ("5") ("6") ("7")

full='(("0") ("1") ("2") ("3") ("4") ("5") ("6") ("7") ("8") ("9") ("10") ("11") ("12") ("13") ("14") ("15"))
fourtt=nil
for(i 1 4 fourtt=tconc(fourtt car(full)) full=cdr(full))
println(fourtt) ;==>((("0") ("1") ("2") ("3")) ("3"))
println(car(fourtt)) ;==>(("0") ("1") ("2") ("3"))

nthcdr( 3 '( a b c d )) ;=> (d)
z = '( 1 2 3 )
nthcdr( 2 z ); => ( 3 )

aList = '( a b c ) ;=> ( a b c )
subst( 'a 'b aList ) ;=> ( a a c )
anotherList = '( a b y ( d y ( e y )))
subst('x 'y anotherList ); => ( a b x ( d x ( e x )))

(
setof
 x
 numbers
 oddp(x)
)
help evenp ;; <=>isPaire?  |||  oddp <=> isImpaire?

'(0:0 10:10)    ;'  ==> ((X0:Y0)(X1:Y1))        <== danger ne donnera pas l effet escompte
list(0:0 10:10) ;   ==> ((X0 Y0)(X1 Y1))

one =1
two =2
three =3
moreNumbers = list( one two three)
moreNumbers

evenMoreNumbers = append( moreNumbers '(2 1)) ;;;' ))
;==> (1 2 3 2 1)

result = nil
result = cons(1 result)
result = cons(2 result)
result = cons(3 result)

reverse( result )


left = '(1 2 3)  ;; '
right = '(4 5 6) ;;'
leftRight = append(left right)
left
right


leftRight = append(left right)
rightLeft = append(right left)


cons(left right)
cons(right left)

list(7)

append(right list(7))
right
right=append(right list(7))
left =append(left list(4))

left = '(1 2 3)  ;; '
right = '(4 5 6) ;;'
cons(left right)
cons(cons(left right) right)
append(right cons(cons(left right) right))
     (println
append(right cons(left right))
     )

numbers = '(1 (2 3) ) ;;;'
type numbers
car numbers
cdr numbers
(car (cdr numbers))
(cadr numbers)
 window(3)
type  window(3)

hiGetCurrentWindow()->?
;; hiGetCurrentWindow()->stopLevel=0
hiGetWindowList

geOpen(
?lib "master"
?cell "mux2"
?view "schematic"
?mode "w"
)

alias(bk hiSetBindKey)

     view(
prependInstallPath("samples/local/schBindKeys.il")
)
    edit(
prependInstallPath("samples/local/schBindKeys.il")
)

hiSetWindowName(window(1) "Icfb")

ciwBBox = hiGetAbsWindowScreenBBox(window(1) t)


cv= geGetWindowCellView()
     ;;==> db:199725100  ;;<== database identifiant
type cv
     ;;==> dbobject



css() ;; alias qui retourne l id de l object selectionne (le premier de l'ensemble des selectionnés c'est en fait : car(geGetSelectedSet())

getWindowRep();; alias de geGetWindowCellView()
type getWindowRep();;==> dbobject
getWindowRep()~>instances~>?
getWindowRep()~>instances~>libName
getWindowRep()~>instHeaders

(println (car getWindowRep()~>instHeaders) ~>? )
     ;;==>(cellView objType prop cellName instances libName master timeStamp variants viewName)
getWindowRep()~>instHeaders~>libName
; getWindowRep()~>instHeaders~>libName="Ed" 
     ;;<== equivaut a rename /!\ attention si plusieurs libName differents


(foreach
nb_win
getWindowRep()~>instHeaders~>libName
(if
rexMatchp("Ed" )
hiSetWindowName(nb_win "ADE")
)
;;nb_win++
)


getWindowRep()~>instHeaders~>libName
     ;;==> ("Ed" "master" "master" "master" "master" "M1_POLY1" "M1_POLY1" )
getWindowRep()~>instHeaders~>cellName
     ;;==> ("mux2" "Inv" "nand2" "M2_M1" "M2_M1" "M1_POLY1" "M1_POLY1" )
aa = setof(x getWindowRep()~>instHeaders  x~>cellName == "nand2")
     ;;==>(db:199822980)
aa~>libName = "Ed"
     ;;==> ("Ed")
myHeader = setof(x getWindowRep()~>instHeaders x~>libName == "Ed")
myHeader~>libName = "master"

     ;; si par exemple on a :
getWindowRep()~>instHeaders~>libName
     ;;==> ("master" "Ed" "master" "master" "master" "master")
     ;;alors
nth(1 getWindowRep()~>instHeaders)~>libName="master"
     ;;==>"master" ;;<== renomme en master le 2eme element


_itemsperline
     ;;==> 5 ;;<== revoie la valeur par defaut du nomre d element a afficher sur une seule ligne, qui peut etre eviter par println, mais on peux redefinir cette valeur

_itemsperline = 15 ;; <== va afficher 15 ele;ent avant de revenir a la ligne

cv= geGetWindowCellView()
cv~>instances~>name
cv~>instances~>cellName
length(cv~>shapes)
cv~>shapes~>objType

;; MENU
hiGetCIWindow ;; <=> window(1)
hiGetBannerMenus(window(1))

member('ciwOptionsMenu hiGetBannerMenus(window(1)))  ;; ' <== not egal 0 si le menu est present

member('TrRaiseCurrentWindow hiGetBannerMenus(window(1))) ;;' <== not egal 0 si le menu est present

(if (length member('TrPulldownMenu  hiGetBannerMenus(window(1))) )
 (hiDeleteBannerMenu window(1)
  (difference
   (length hiGetBannerMenus(window(1)) )
   (length  member('TrPulldownMenu  hiGetBannerMenus(window(1))))
   )
  )
)

;; CUSTOMIZATION
getSkillPath;;==> comme la var d environment PATH sous unix
setSkillPath

prependInstallPath("")
     ;;==>"/net/trnfr-par/export1/CDSTOOLS/IC5141/lnx86/IC5141_ISR/tools.lnx86/dfII/"
     ;;==> equivaut a which icfb

simplifyFilename("~/")
     ;;==> "/home/class9/"  ;;<== affiche le path absolu 
simplifyFilename("../.")
     ;;==> "/home/class9/" ;;<==> ls  ..
simplifyFilename(".")   ;;<==> pwd
  
getShellEnvVar("USER")
println(getShellEnvVar("HOME"))
println(getShellEnvVar("PDK_OPT"))

;; FUNCTION PROCEDURE

;; definition de la fonction
procedure(
TrBBoxHeight(bBox)
     let( (ll ur lly ury ) ;; <== let assign a nil toutes ces variables locales
     ll= lowerLeft(bBox)
     ur= upperRight(bBox)
     lly= yCoord(ll)
     ury= xCoord(ur)
     ury - lly
     ); fin du let
     ); fin de la procedure

;; execution de la fonction
TrBBoxHeight(list( 100:100 250:390 ))


;; definition de la fonction
procedure(
TrBBoxArea(bBox)
     let( (X0 Y0 X1 Y1 area)

     X0 = xCoord(lowerLeft(bBox))
     X1 = xCoord(upperRight(bBox))

     Y0 = yCoord(lowerLeft(bBox))
     Y1 = yCoord(upperRight(bBox))

     area= (X1-X0)*(Y1-Y0)
     printf("[X0 %u] [X1 %u] [Y0 %u] [Y1 %u] of area : %u" X0 X1 Y0 Y1 area)
     area  ;;<== dernier argument est la valeure de retour
     ); fin du let
     ); fin de la procedure



;; FLOW CONTROL

printf("%.30f" 1/3.0)
printf("%.17f" 1/3.0)

x=1 y=5
x<3 && y<4
x<3 && 1/0
y<4 && 1/0 ;; <== si la premiere expression est fausse le system s arrete et renvoie nil sans executer le suivant
1/0 && y<4 

x<3 || y<4
x<3 || 1/0 ;; <== si la premiere expression est true => pas besion de tester la suivante


shapeType = "triangle"
case( shapeType
( "rect"
  recCount++
(println "Shape is a rectangle")
)
( "line"
  lineCount++
(println "Shape is a line")
)
( "label"
  labelCount++
(println "Shape is a label")
)
( "triangle" || "Triangle" || "TRIANGLE" 
  triangleCount++
shapeType = "rect" ;; pour tester la difference avec le language C
(println "Shape is a triangle")
)
( "rect"
  recCount++
(println "Shape is a rectangle");<== ne passe pas la car break si une branche dessus est prise : different du language C
)
( t
  miscCount++
(println "Shape is a miscellaneous")
)
)

     ;; fonctions de test des types :
     numberp(3.3)
     numberp(3)
     floatp(3.3)
     floatp(3)
     fixp(3.3)
     fixp(3)
     ;; listp, stringp, symbolp, booleanp  existent aussi


floor(2.2)==2.2;==> nil  ;; partie enfière
floor(2.2)==2  ;==> t
floor(15/4)==(15/4.0) ;==> nil
floor(16/4)==(16/4.0) ;==> t

(for int 1 1000
(when int==10 int=999)  ;; <== on ne peux avoir access a la var int
(println int)
)

myPort = outfile("~/time.txt")
;;time=220
time=1520
(for int 1 28
(println fprintf(myPort "%dn d %dn d %dn h %dn h \\\n" time+1 time+20 time+21 time+40))
time=time+40
)
close(myPort) myPort=nil

edit("~/time.txt")

;;  symbolToString  stringToSymbol
;; evalstring

     ( foreach element list("rect" "polygon" "path" )
     printf("[%-15s | %15s ]\n" element concat(element "Count"))
     )

rectCountx = 10
aa = "rectCountx"
evalstring(aa)

evalstring(concat("rect" "Countx")) ;; <== error
type concat("rect" "Countx") ;; en effet c est un symbol e non une string
eval(concat("rect" "Countx")) ;; <== la solution est que un simple eval suffit
type strcat("rect" "Countx")  ;; <== renvoie une string
evalstring(strcat("rect" "Countx")) ;; <== marche aussi

rectCount=0
set(   concat(element "Count")    plus( eval(concat(element "Count")) 1) )

rotation = 0
rotation = mod(rotation+90 360)
sprintf(nil "R%d" rotation)

edge = 0
edge++ test = zerop(mod(edge 4)); ==> t|nil une fois tout les 4

;; une maniere d ecrire une fonction qui supprime les doublons
procedure(singleList(aList) bList=nil foreach(elt aList unless(member(elt bList) bList = append(bList list(elt) )) ) bList)
singleList(wid~>shapes~>objType)
     ;; il y a surement plus simple avec une reccursion


;;FILE I/O
;; drain(myport)  ;; <=> flush en C ==> balance le resultat du buffer 
;; gets : lit ligne par ligne


;; par defaut ouvre en ecrasement de fichier
myPort = outfile("~/MyFile.text")
     ;;myPort = outfile("~/MyFile.text" "w") ;;<== write
     ;;myPort = outfile("~/MyFile.text" "a") ;;<== append
outportp(myPort);; <== check that the variable my_port is an output port

lineCount = 0
fprintf( myPort "Line # %d \n" lineCount++)
fprintf( myPort "Line # %d \n" lineCount++)
fprintf( myPort "Line # %d \n" lineCount++)

     close(myPort)
     myPort;; <== myport pointe toujours vers le fichier
     outportp(myPort);; <== en effet, il est toujours compris comme tel
myPort=nil	 ;; <== il peut etre une bonne idee de l annuler


myPort = infile("~/MyFile.text")
nextLine = nil
gets(nextLine myPort)
nextLine
gets(nextLine myPort)
nextLine
gets(nextLine myPort)
nextLine
gets(nextLine myPort)
nextLine

myPort = infile("~/MyFile.text")
fscanf( myPort "%s" word)
word
fscanf( myPort "%s" word)
word
fscanf( myPort "%s" word)
word
fscanf( myPort "%s" word)
word
fscanf( myPort "%[$]" word);; <== va a la fin et ne mets pas word a jour
;;<== retoure la valeur 0 si fin de fichier, sinon fscanf retourn 1
word

wordList=nil
myPort = infile("~/MyFile.text")
fscanf( myPort "%s" word)
wordList=cons(word wordList)
fscanf( myPort "%s" word)
wordList=cons(word wordList)
fscanf( myPort "%s" word)
wordList=cons(word wordList)
close(myPort) 
myPort=nil

myPort = infile("~/MyFile.text")
fscanf( myPort "%[^0-9]" phrase)
fscanf( myPort "%d" number) ;;<== PROBLEM ICI

while(fscanf( myPort "%d:Ctrl-C" number)
     print(number)
     ) 
;; <== boucle infini si le dernier caracter n est pas un chiffre


;; pp <=> pretty print function



cv= geGetWindowCellView()
;;wid= window(9)
wid = geGetWindowCellView()

setof( x cv~>shapes~>objType x=="rect")  ;;<== sauvegarde les attributs
setof( x cv~>shapes x~>objType=="rect")  ;;<== sauvegarde les pointeurs ==> mieux!

singleList(wid~>shapes~>objType)
foreach(mapcar x singleList(wid~>shapes~>objType) concat(x "Count"))
;;==> (textDisplayCount rectCount pathCount)

cv~>layerPurposePairs~>?
cv~>shapes~>?

foreach( mapcar x cv~>shapes x~>objType)
foreach( mapcar x cv~>shapes x~>lpp)      ;;<== layer purpose pair

foreach( mapcar x cv~>shapes cons(x~>objType x~>lpp ))
cv~>layerPurposePairs~>layerName
;;==>("nwell" "pdiff" "cont" "ndiff" "text" "metal2" "poly1" "metal1" "changedLayer")


(ddGetObj "master")~>?
(ddGetObj "master")~>cells
((ddGetObj "master")~>cells)~>?

nand2wid = geOpen(?lib "master" ?cell "nand2" ?view "layout" ?mode "r")

;; Ouvre, edit et donc lock la cellule tant qu elle ne sera pas fermee ==> close needed
;; dbOpenCellViewByType( ) ;;<== pour ouvrir une database sans interface graphique
dbOpenCellViewByType( "master" "mux2" list("layout" "schematic")) ;; <= pas bon, prend le premier element qui existe uniquement
dbOpenCellViewByType( "master" "mux2" "layout" )

cellview = dbOpenCellViewByType( "master" "mux2" "layout" "" "a")


cellview~>lpps
;;==> renvoie toutes les layer purpose pairs
(car cellview~>lpps)~>?
;;==> (cellView objType prop layerName layerNum nShapes numInstTypes purpose shapes)
(car cellview~>lpps)~>purpose
;;==>"drawing"

dbClose(cellview) ;; <= ferme la cellulle
dbPurge(cellview) ;; <= ferme la cellulle et enleve les infos dans la memoire

;; dbCreateRect()

newCV = dbOpenCellViewByType( "master" "new" "layout" "maskLayout" "w")
newCV = dbOpenCellViewByType( "T2K_2008" "new" "layout" "maskLayout" "w")


newRect  = dbCreateRect(newCV "metal1" list(0:0 .5:.5))
newRect2 = dbCreateRect(newCV    30     list(0.5:0.5 1:1))

dbSave(newCV)
dbClose(newCV)

dbCreateLine( geGetWindowCellView() '("text" "drawing1") list(-0.5:100 1:100))
geTransformUserBBox(list(-0.5:100 1:100) list(0:0 "R0" 6))
dbTransformPoint( (1.5:2.5) list(0:0 "R90" 2.5) )
;=> (-6.250000 13.750000)
dbTransformPoint( (1.5:2.5) list(0:0 "R0" 2.5) ) ;; => (3.75 6.25)

cc=car(geGetSelSet())
cc~>cellView~>??
cc~>cellName
cc~>libName
cvSym = dbOpenCellViewByType( cc~>libName cc~>cellName "symbol" "schematicSymbol" "r")
cvSch = dbOpenCellViewByType( cc~>libName cc~>cellName "schematic" "schematic" "r")
cvSch~>??
cvSch~>terminals~>??
pp=car(cvSch~>terminals~>pins)
cvSym~>signals~>??
cvSym~>pins~>??

geOpen( ?lib "master" ?cell "new"  ?view "layout" ) ;; <== check results

geSelectAll()
foreach(dbObject geGetSelSet() dbDeleteObject(dbObject))

foreach(mapcar dbObject geGetSelSet()
	foreach(mapcar inst dbObject~>conns 
	inst~>name
	)
)


TrRectangles( "master" "new" "layout" list(
list("metal1" 0:0 1.0:1.5)
list("poly1" 1:1 2:3)
)
)

;; See /home/class9/SKILL/FlowOfControl/TrShapeReport.il

;; il faut parfois spécifier t_viewTypeName
ddMapGetToolNameViewType( "Composer-Schematic" ); ==>"schematic"
ddMapGetToolNameViewType( "Composer-Symbol" ) ;==>"schematicSymbol"
ddMapGetToolNameViewType( "Virtuoso" )  ;==>"maskLayout"

;;HIERARCHICAL DESIGN
mux2 = dbOpenCellViewByType( "master" "mux2" "schematic")

cv = geGetEditRep()
length(cv~>instances)

;; selectionner une instance dans Layout Editor
instId=css()
instId~>name;; <= check by "q" -> edit that it is I2
instId~>master;; <= renvoie le pointeur de l instance en question
geGetEditRep();; <= normalement c est le meme db:id  heu ?! PB



dbOpenCellViewByType( "master" "mux2" list("layout" "schematic")) ;; <= prend le premier element qui existe uniquement



mux2Layout = dbOpenCellViewByType( "master" "mux2" "layout")
mux2Sch = dbOpenCellViewByType( "master" "mux2" "schematic")
load( "HierarchyTraversal.il" )
TrSwitch(mux2Layout)  ;;<== renvoie db:iD si c'est bien un layout
TrSwitch(mux2Sch)

expandedHierarchy = TrHierarchyTraversal( mux2Layout nil )


foreach( mapcar net cv~>nets net~>name)
;;==>("SEL" "B" "A" "gnd!" "Y" "vdd!")


foreach( mapcar net cv~>nets 
list(
     net~>name
     net~>instTerms
    )
)


cv = geGetEditRep()
my_netList = foreach( mapcar net cv~>nets 
list(
     strcat("net : " net~>name)
     foreach( mapcar term net~>instTerms 
	     list(
		  term~>name
		  term~>inst~>name
		  )
	     )
     )
)


;; open-> New-> schematic
load "~/Skill/Formation/class9/SKILL/CaseStudy/RoadMap.il"
TrRoadMap(hiGetCurrentWindow());; => create a cellView Information Model graph


cv = geGetEditRep()
x=y=0
dx=100
dy=100

my_netList = foreach( mapcar net cv~>nets 
list(
     x=x+dx
     strcat("net : " net~>name)
     foreach( mapcar term net~>instTerms 
	     list(
		  term~>name
		  term~>inst~>name
		  list(x y)
		  y=y+dy
		  )
	     )
     y=0
     )
)

println(my_netList)
;;==> donne une liste du genre :   
tata = '(270 "net : net4" (("Y" "I1" (270 0) 10) ("A" "I0" (270 10) 20)) 0)

dbCellId = dbOpenCellViewByType( "master" "InstanceView" "layout" "maskLayout" "w")
;;dbCellId = geOpen( ?lib "master" ?cell "InstanceView"  ?view "layout" ) ;; <== check results
;;designWid = window

foreach( element my_netList  	
	foreach( inst  caddr(element)
		dbCreateLabel(dbCellId 
			      '("text" "drawing")
			      caddr(inst) 
			      strcat( cadr(inst) car(inst) )
			      "centerCenter"
			      "R0" "stick" 10.0
			      )
		)
	)
dbSave(dbCellId)
dbClose(dbCellId)
geOpen( ?lib "master" ?cell "InstanceView" ?view "layout")



procedure( TrShowProp(cv)
	  foreach( item cv~>prop
		  printf("%s" item~>name) ;;<= print without cotes ""
		  print(item~>name)       ;;<= print with cotes ""
		  println(item~>name)     ;;<= print with cotes "" and a final \n
		  )
	  t
	  )

TrShowProp(topLevelCV)


foreach( mapcar prop topLevelCV~>prop
	list( prop~>name prop~>value))

hiGetBannerMenus(window(1))
;;==> (ciwFileMenu ciwToolsMenu ciwOptionsMenu ddsvHelpMenu)



(procedure RmBannerItemByName(l_menuName @optional (window_id window(1)))
 (if (length member( l_menuName hiGetBannerMenus(window_id)) )
  (hiDeleteBannerMenu window_id
   (difference
    (length hiGetBannerMenus(window_id) )
    (length  member(l_menuName  hiGetBannerMenus(window_id)))
    )
   )
  )
 )

RmBannerItemByName('TrPulldownMenu)
RmBannerItemByName('trEdPulldownMenu)

procedure( TrCreateMenuItem( theMenuSymbol )
	  set(
	      theMenuSymbol
	      hiCreateMenuItem(
			       ?name theMenuSymbol
			       ?itemText get_pname( theMenuSymbol )
			       ?callback sprintf( nil "println('%L)" theMenuSymbol )
			       )
	      ) ;set
	  );procedure

TrCreateMenuItem('item1)
TrCreateMenuItem('item2)
TrCreateMenuItem('item3)
TrCreateMenuItem('item4)
TrCreateMenuItem('item5)


hiCreateVerticalFixedMenu(
'TrExempleVerticalFixedMenu
list(item1 item2 item3 item4 item5)
6;; number of rows
1;; number of column
)


hiDisplayFixedMenu( TrExempleVerticalFixedMenu "left"  )

attachedMenu = hiGetWindowFixedMenu()
;;==> hiFixMenu@0xbecbc08

println(attachedMenu~>?)
;;==> (fitItem zoomInItem zoomOutItem editPropItem rulerItem addedRow _doneAction _widgetInstanceList _menuItemList _orientation _cols _rows hiMenuSym)

hiRemoveFixedMenu()


hiAddFixedMenu( ?fixedMenu TrExempleVerticalFixedMenu )

hiDisplayAppBox(

		
hiDisplayAppDBox(
		?name gensym( 'TrDBox)
		?dboxBanner "Exemple"
		?dboxText "First\nSecond\nThird Line"
		?callback "printf(\"\nExecutinf Callback ..done\")"
		?dialogType hicInformationDialog
		?dialogStyle 'modeless
) 


(procedure testType(type)	
(let (text)
println(type)
sprintf(text "printf(\"Executinf Callback of %20L ..done\n\")", type )
hiDisplayAppDBox(
		?name gensym( 'TrDBox)
		?dboxBanner "Exemple"
		?dboxText "First\nSecond\nThird Line"
		?callback text
		?dialogType eval(type)
;;		?dialogType type  ;; <== si on mets type tout court ca remplace le type par sa valeur, 
		?dialogStyle 'modeless
) 
)
)

;;testType(hicInformationDialog)


foreach( type '(hicErrorDialog hicInformationDialog hicMessageDialog hicQuestionDialog hicWarningDialog hicWorkingDialog)
	testType(type)
	)


procedure( TrShowListBox(aList)
	  hiShowListBox(
			?name gensym( 'TrExampleListBox)
			?choices aList
			?callback 'TrExampleListBoxCB
			?title "Example List Box"
			?multipleSelect  t
			?applyButton t
			)
	  )

procedure( TrExampleListBoxCB(ok theListBox)
	  if(ok then
	     printf("You chose:\n")
	     foreach( choice theListBox->value
		     printf("%15s\n" choice)
		     )
	     else printf("You click cancel.\n")
	     )
	  )

TrShowListBox('("apple" "orange" "melon"))




wf1 = TrCreateWindowForm(window(1))

for(i 1 3
;;    set(concat(wf i) 2)
    set(strcat(wf i) 2)
)


wf2 = TrCreateWindowForm(window(2))
wf5 = TrCreateWindowForm(window(5))
hiDisplayForm(wf5)


listWinIn=hiGetWindowList()
rexCompile( "Virtuoso. " )
listIn = foreach(mapcar x listWinIn 
		 titleName = hiGetWindowName(x)
		 hiSetWindowName( x rexReplace( titleName "" 1) ) )
	 


deGetAllViewTypes();;<== il n y a plus que 4 types de view type dqns la 6.1
deGetAppInfo("schematic")->menuTrigger
;;==>schMenuTrigger
deGetAppInfo("schematic")->userPostInstallTrigger
;;==>TrUserPostInstallTrigger ;; <== si

tata = '( "Virtuoso\256 Schematic Editing: master mux2 schematic")
rexCompile( "\\256" )
rexReplace( car(tata) "" 1)
rexCompile( "Virtuoso" )
rexReplace( car(tata) "" 1)
rexCompile( "256" )
rexReplace( car(tata) "" 1)

rexCompile( "Virtuoso. " )
rexReplace( car(tata) "" 1)

rexCompile( "[Ss]chematic" )
rexReplace( car(tata) "" 0) ;==> "Virtuoso\256  Editing: master mux2 "



boundp('tata)
tata = 'unbound
boundp('tata)
;;==> nil

;;DATA STRUCTURE

aCard = '(nil rank "ace" suit "space")
aCard->rank
aCard->suit
aCard->nouvelElement = t;; <== append en fin de list le nouvel element
aCard
aCard->?
aCard->??



cv = geGetWindowCellView()
cv = hiGetCurrentWindow()

mp=hiGetWindowFixedMenu();; <== MenuPointer


;; vire la 1ere subWindow existante de awd
awvDeleteSubwindow(window(10))

;; vire la 1ere subWindow de awd
awvDeleteSubwindow(window(10) ?subwindow 3)

awvGetCurrentSubwindow( window(10) ) 

awvDeleteSubwindow(
	hiGetCurrentWindow() 
	?subwindow awvGetCurrentSubwindow( hiGetCurrentWindow() ) 
	)

gg=geGetObjectSelectedSet(geGetWindowCellView())
caar(gg)~>??
caar(gg)~>instTerms
caar(gg)~>instHeader~>??
ii = car(caar(gg)~>instTerms)
caar(gg)~>conns~>term~>??
caar(gg)~>conns~>??
car(caar(gg)~>conns)~>net~>??
car(caar(gg)~>conns)~>net~>figs~>??
caar(gg)~>pin
caar(gg)~>pin~>term->??

schHiCreateSymbolPin( "data1" "square" "inputOutput" "full" "single" 0 "left" )
schHiDrawSymbolPin( data1 "input" )

geGetWindowCellView()~>layerPurposePairs~>layerNeme="MET1"
geGetWindowCellView()~>lpps~>layerNeme="MET1"

cv=geGetWindowCellView()
setof(lpp cv~>layerPurposePairs lpp~>purpose=="MET1")

						Fonction d'acces directe a bBox
check if MET1 est au bord de la bBox                  upperLeft or uL	  
; println cv~>bBox => ((-0.3 0.0) (120.275 261.425))  lowerLeft or lL	  
; cdr(cv~>bBox)    => ((120.275 261.425))	      upperCenter or uC 
((X0 Y0)(X1 Y1)) 				      lowerCenter or lC 
=> X0 = caar(bBox)				      upperRight or uR  
=> Y0 = cadar(cv~>bBox)				      lowerRight or lR  
=> X1 = caadr(bBox)				      centerLeft or cL  
=> Y1 = cadadr(cv~>bBox)			      centerCenter or cC


cv=geGetWindowCellView()
xmin=caar(cv~>bBox)
ymin=cadar(cv~>bBox)
xmax=caadr(cv~>bBox)
ymax=cadadr(cv~>bBox)
x0M1=xmax
y0M1=ymax
x1M1=xmin
y1M1=ymin
foreach(met1Lpp 
	  setof(lpp geGetWindowCellView()~>layerPurposePairs lpp~>layerName=="MET1")
	(printf " ~>shapes = %L\n" met1Lpp~>shapes)
	foreach(shape met1Lpp~>shapes
		(printf "bBox = %L\n" shape~>bBox)
		x0M1=min(caar(shape~>bBox) x0M1)
		y0M1=min(cadar(shape~>bBox) y0M1)
		x1M1=max(caadr(shape~>bBox) x1M1)
		y1M1=max(cadadr(shape~>bBox) y1M1)

	         );foreach
         );foreach
x0M1=x0M1 - xmin
y0M1=y0M1 - ymin
x1M1=xmax - x1M1
y1M1=ymax - y1M1

printf("x0: left  MET1 Offset = %L\n" x0M1)
printf("y0: down  MET1 Offset = %L\n" y0M1)
printf("x1: right MET1 Offset = %L\n" x1M1)
printf("y1: top   MET1 Offset = %L\n" y1M1)

; a - b peut s'ecrire : plus(a minus(b))


offsets=let( (cv xmin ymin xmax ymax x0M1 y0M1 x1M1 y1M1)
cv=geGetWindowCellView()
xmin=caar(cv~>bBox)
ymin=cadar(cv~>bBox)
xmax=caadr(cv~>bBox)
ymax=cadadr(cv~>bBox)
x0M1=xmax
y0M1=ymax
x1M1=xmin
y1M1=ymin
foreach(met1Lpp 
	  setof(lpp geGetWindowCellView()~>layerPurposePairs lpp~>layerName=="MET1")
	(printf " ~>shapes = %L\n" met1Lpp~>shapes)
	foreach(shape met1Lpp~>shapes
		(printf "bBox = %L\n" shape~>bBox)
		x0M1=min(caar(shape~>bBox) x0M1)
		y0M1=min(cadar(shape~>bBox) y0M1)
		x1M1=max(caadr(shape~>bBox) x1M1)
		y1M1=max(cadadr(shape~>bBox) y1M1)

	         );foreach
         );foreach
x0M1=x0M1 - xmin
y0M1=y0M1 - ymin
x1M1=xmax - x1M1
y1M1=ymax - y1M1
;;list((x0M1 y0M1)(x1M1 y1M1));;<== derniere ligne est le resultat renvoye;;<== ne marche pas.. comprends pas la différence ...
list(x0M1:y0M1 x1M1:y1M1);;<== derniere ligne est le resultat renvoye
); fin du let

(layer \"MET1\") )

procedure(layerOffset( @optional (cv geGetWindowCellView()) (layer "MET1") )
let( (xmin ymin xmax ymax x0M1 y0M1 x1M1 y1M1) ; to use later with layerOffset(pcMaster)
xmin=caar(cv~>bBox)
ymin=cadar(cv~>bBox)
xmax=caadr(cv~>bBox)
ymax=cadadr(cv~>bBox)
x0M1=xmax
y0M1=ymax
x1M1=xmin
y1M1=ymin
foreach(met1Lpp 
	  setof(lpp cv~>layerPurposePairs lpp~>layerName==layer)
	(printf " ~>shapes = %L\n" met1Lpp~>shapes)
	foreach(shape met1Lpp~>shapes
		(printf "bBox = %L\n" shape~>bBox)
		x0M1=min(caar(shape~>bBox) x0M1)
		y0M1=min(cadar(shape~>bBox) y0M1)
		x1M1=max(caadr(shape~>bBox) x1M1)
		y1M1=max(cadadr(shape~>bBox) y1M1)

	         );foreach
         );foreach
x0M1=x0M1 - xmin
y0M1=y0M1 - ymin
x1M1=xmax - x1M1
y1M1=ymax - y1M1
;;list((x0M1 y0M1)(x1M1 y1M1));;<== derniere ligne est le resultat renvoye;;<== ne marche pas.. comprends pas la différence ...
list(x0M1:y0M1 x1M1:y1M1);;<== derniere ligne est le resultat renvoye
); fin du let
);fin procedure


;; steepness : pente de la pente à suivre pour ecarter le objets
procedure(spreadXY( @optional (cc geGetSelectedSet()) (steepness 1) (XY "Y"))
let( (xmin ymin xmax ymax csbBox step liste xn yn x0 y0) 
xmin=caar(car(cc)~>bBox)
ymin=cadar(car(cc)~>bBox)
xmax=caadr(car(cc)~>bBox)
ymax=cadadr(car(cc)~>bBox)
foreach( obj cc 
		(printf "bBox = %L\n" obj~>bBox)
		xmin=min(caar(obj~>bBox) xmin)
		ymin=min(cadar(obj~>bBox) ymin)
		xmax=max(caadr(obj~>bBox) xmax)
		ymax=max(cadadr(obj~>bBox) ymax)
	         );foreach
csbBox = list(xmin:ymin xmax:ymax);;<== centre de l'ensemble des objects selectinonnés
cC = centerBox(csbBox)
xc = car(cC)
yc = cadr(cC)
x0 = car(centerBox(csbBox))
y0 = cadr(centerBox(csbBox))
(printf "steepness = %L\n" steepness)
if( (y0 != yc) then a = (x0-xc)/(y0-yc)*steepness else a =1)
if( (steepness==0) then ia=0 else ia = (y0-yc)/(x0-xc)/steepness)
		(printf "steepness = %L\n" steepness)
if( (XY=="X") then ;;; alignement en X 
foreach( obj cc 
	x0 = car(centerBox(obj~>bBox))
	y0 = cadr(centerBox(obj~>bBox))
	xn=ia*(yn-a*xc+yc)
	dbMoveFig(obj nil list(xn-x0:0 "R0"))
);end foreach
else ;; alignement en Y ;; obj=car(cc) ; PB pas de grille ...
;;a=2  list(xc yc)
foreach( obj cc 
	x0 = car(centerBox(obj~>bBox))
	y0 = cadr(centerBox(obj~>bBox))
	yn=a*x0 + (yc-a*xc)
	dbMoveFig(obj nil list(0:yn-y0 "R0"))
);end foreach steepness=1
);end if
);fin du let
);fin procedure

	
;; cadr(cc)~>bBox=list( 0:0 0:0)  ne permet pas de déplacer l'object
dbMoveFig(car(cc) nil list( 0:0 0:0)) ;<== error : invalid orient
dbMoveFig(car(cc) nil list( -1:2 "R180"))
dbMoveFig(car(cc) nil list( -1:2 "R0"));; le ne veux pas faire un move, je veux faire un place


;; projection sur un droite de pente : 'steepness' centré sur l'ensemble des objets selectionnés
;; steepness : pente de la pente à suivre pour ecarter le objets
procedure(centerAlignXY( @optional (cc geGetSelectedSet()) (steepness 1) (XY "Y"))
let( (xmin ymin xmax ymax csbBox step liste xn yn x0 y0) 
xmin=caar(car(cc)~>bBox)
ymin=cadar(car(cc)~>bBox)
xmax=caadr(car(cc)~>bBox)
ymax=cadadr(car(cc)~>bBox)
foreach( obj cc 
		(printf "bBox = %L\n" obj~>bBox)
		xmin=min(caar(obj~>bBox) xmin)
		ymin=min(cadar(obj~>bBox) ymin)
		xmax=max(caadr(obj~>bBox) xmax)
		ymax=max(cadadr(obj~>bBox) ymax)
	         );foreach
csbBox = list(xmin:ymin xmax:ymax);;<== centre de l'ensemble des objects selectinonnés
cC = centerBox(csbBox)
xc = car(cC)
yc = cadr(cC)
(printf "steepness = %L\n" steepness)
if( (XY=="X") then ;;; alignement en X 
foreach( obj cc 
when( (steepness==0)  steepness=1 printf("1/0 ?! ==> steepness re-affected to 1\n"))
	x0 = car(centerBox(obj~>bBox))
	y0 = cadr(centerBox(obj~>bBox))
	xn=(y0-yc+steepness*xc)/steepness
	dbMoveFig(obj nil list(xn-x0:0 "R0"))
);end foreach
else ;; alignement en Y ;; obj=car(cc) ; PB pas de grille ...
;;a=2  list(xc yc)
foreach( obj cc 
	x0 = car(centerBox(obj~>bBox))
	y0 = cadr(centerBox(obj~>bBox))
	yn=steepness*x0 + (yc-steepness*xc)
	dbMoveFig(obj nil list(0:yn-y0 "R0"))
);end foreach steepness=1
);end if
);fin du let
);fin procedure. 
; USAGE : centerAlignXY(geGetSelectedSet() 2 "X")
; USAGE : centerAlignXY(geGetSelectedSet() 1 "Y")



css()~>bBox
bb = layerOffset()
css()~>master
css()~>cellView
css()~>cellName
css()~>orient

dbCreateInst( css()~>master css()~>cellView 
;; css()~>cellName ancien ou nouveau nom ? : nouveau
"toto"
list( 
caar(css()~>bBox) 
cadar(layerOffset()) - cadadr(layerOffset())
)
css()~>orient
)
;; ne marche pas car layerOffset() ne va pas dans la cellule !

dbCreateInst( css()~>cellView css()~>master 
;; css()~>cellName ancien ou nouveau nom ? : nouveau
nil ; "toto" ; 
list( 
caar(css()~>bBox) 
cadar(css()~>bBox) - abs( cadadr(css()~>bBox))
)
css()~>orient
)

marche pas car ne prends pas en compte l'Origin de la cellule


newInst = dbCreateInst( css()~>cellView css()~>master 
;; css()~>cellName ancien ou nouveau nom ? : nouveau
nil ; "toto" ; 
list( 
car(css()~>xy) 
; Yn = 2*Y0-Y1
2* cadar(css()~>bBox) - cadadr(css()~>bBox)
)
css()~>orient
)


;; copie n-fois de la meme instance bout a bout en Y vers le bas
selectedInst = css()
for(i 1 13
newInst = dbCreateInst( selectedInst~>cellView selectedInst~>master 
nil ; "toto" ;  ~>xy donne le point d'appel de l'origine de l'instance
list( 
car(selectedInst~>xy) 
2* cadar(selectedInst~>bBox) - cadadr(selectedInst~>bBox)
)
selectedInst~>orient ;;"R0";;
1
)
selectedInst = newInst
)



;; **************** ;;
;; copie n-fois de la meme instance bout a bout en X vers la droite
selectedInst = css()
for(i 1 13

foreach(met1Lpp 
	 setof(lpp css()~>master~>lpps lpp~>layerName=="MET4")
	(printf " ~>shapes = %L of %L\n" met1Lpp~>shapes met1Lpp~>layerName)
	foreach(shape met1Lpp~>shapes
		(printf "bBox of  = %L\n" shape~>bBox)
;;		(printf "bBox of  = %L\n" shape~>??)

	         );foreach
         );foreach


setof( css()~>master~>lpps~>layerName="MET4")

;; layerOffset(css()~>master  "MET4")
;;		css()~>instHeader
M4bBox = layerOffset(css()~>instHeader~>cellView  "MET4")
;;layerOffset(geGetWindowCellView()  "MET4")
x0 = car(selectedInst~>xy) 
y0 = cadr(selectedInst~>xy) 
yn = y0
xn = x0 +  caadr(M4bBox) - caar(M4bBox)
newInst = dbCreateInst( selectedInst~>cellView selectedInst~>master 
nil ; "toto" ;  ~>xy donne le point d'appel de l'origine de l'instance
list( 
car(selectedInst~>xy) 
2* cadar(selectedInst~>bBox) - cadadr(selectedInst~>bBox)
)
selectedInst~>orient ;;"R0";;
1
)
selectedInst = newInst
)

cv=geGetWindowCellView()
ss = car(setof(inst cv~>layerPurposePairs inst~>baseName==css()~>baseName))

tfId = techGetTechFile(geGetWindowCellView())
techGetOrderedSpacingRule(tfId "minEnclosure" "metal1" "metal2")
;==> WARNING* techGetOrderedSpacingRule: Illegal layer specified "metal1".
;==> nil
techGetOrderedSpacingRule(tfId "minEnclosure" "MET1" "MET2")
;==> nil  ;<== merche ou marche pas ?


metal1 = techGetParam(tfId "metal1") ;; marche pas ? => nil
MET1 = techGetParam(tfId "MET1")     ;; marche pas ? => nil

cv =geGetEditCellView()
;cv~>libName ;cv~>cellName ;strcat("layout" ".pin")
;;newCV = dbOpenCellViewByType( "T2K_2008" "new" "layout" "maskLayout" "w")
newCV = dbOpenCellViewByType( cv~>libName cv~>cellName strcat("layout" ".pin") "maskLayout" "w")
dstFig = dbCopyFig(srcFig, dstCellView, list(0:0 "R0" 1.0))
dbSave(newCV) dbClose(newCV)


cv = geGetWindowCellView()
setof(buf  cv~>instances  buf~>cellname ==  "buffer_HM_PWS2_CL")
setof(buf  cv~>instances  buf~>cellname ==  "PA_PS")
cv~>??


when( (getShellEnvVar("HOSTNAME")=="lyopcs24") print("hihi"))


;; whereIs est un peu pres l'equivalent de which sous linux
whereIs(load)
;;==>Function load is a built-in primitive.
t
whereIs(whereIs)
;;==>Function whereIs is defined in file "/home/data/cmpkit/bicmos7rf_63/UNIOPUS/uniopus/5.1.41/lnx/tools/dfII/group/il/src/skillDev/help.il" at line 119.
t

whereIs(spreadXY);;==> spreadXY is not a function. ;; <== not defined
whereIs(spreadXY);;==> Function spreadXY has no source information. ;;<== had been defined in icfb
whereIs(centerAlignXY);;==> Function centerAlignXY has no source information. ;;<== had been defined in icfb with load "~/Skill/centerAlignXY.il"

help listp
i2cNames='("scan_enable" "I2C_add_0_S" "I2C_add_1_S" "tdi" "tdo")
names = foreach( mapcar x i2cNames if(!listp(x) then sprintf(nil "%L\\n" x) else sprintf(nil "%L\\n" car(x)))) ;; pour les elements seul, "in"...
println(names)
sprintf(cmd "echo -e \"%L\"" names)
system(cmd)
