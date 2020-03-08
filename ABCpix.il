;; copyleft ebecheto ;; load("ABCpix.il")
ineed('(CreateVias createHexagon bBoxShrink))

;; NXmax=10000
;; NYmax= 4500
;; NX=NXmax/(2*1.5*pitch/sqrt(3));=> 1154.701
;; NY=NYmax/(3*pitch) ;=> 300
;; NX=11 NY=3
;; NX=1154 NY=300
NX=115/2 NY=30/2

; cv=geGetWindowCellView() ; lib="picmic0_master"
lib="picmic0_ebecheto"
cv=dbOpenCellViewByType(lib sprintf(nil "hexagoneTricot_%d-%d" NX NY)  "layout" "maskLayout" "a")
tech = techGetTechFile(cv)
layers=foreach(mapcar l list("M3" "M4" "M5") list(l "drawing")) ;=> (("M3" "drawing") ("M4" "drawing") ("M5" "drawing"))
viaNames=list("M4_M3_S" "M5_M4_S" "ML_M5_S")
vias=foreach(mapcar v viaNames techFindViaDefByName(tech v))

pitch=5
xStep=1.5*pitch/sqrt(3)
yStep=pitch;<= 
minTOP=0.46
r=(pitch-minTOP)/sqrt(3)  ; r=xStep/sqrt(3)  
;<== radius of the hexagone. By radius, i mean a = arete = demi-diametre du cercle circonscrit de l'hexagone
pw=1 ;<= width line of the interconnecting layers. 
X=0 Y=0 i=0

printf("Creation array of %L-pitch, hexagon a=%L, b=%L space=pitch/2-b=%L\n" pitch r r*sqrt(3)/2 pitch/2-r*sqrt(3)/2)

wireSteps=list((2*xStep:0)(xStep:xStep*sqrt(3))(xStep:-xStep*sqrt(3)))
AST=list(list(0 0) list(xStep xStep*sqrt(3)))
names=list("A" "B" "C")
xya=car(AST)
;; AST represent the even and odd ROWS

foreach(mapcar xya AST  ;<== equiv for(paire 0 1 ...)
xa0=car(xya)  ; 0 puis xStep
ya0=cadr(xya) ; 0 puis xStep*sqrt(3)
xa=xa0
for(row 0 NX
ya=ya0
for(col 0 NY
for(i 0 2 ;<= creation des pixels ABC espaces de yStep
via321=nthcdr(i vias)
;; creation du premier demi motif pour A
X=xa
Y=ya+i*yStep
wxyp=nth(i wireSteps) wxy=mapcar('plus X:Y wxyp)

rodCreatePath(?cvId cv ?layer nth(i layers) ?width pw ?pts  list((X:Y) wxy))
hex=createHexagon( X Y "TOP_M" cv r)
CreateVias(via321 X Y cv)
;;when(row==0 createPinLPP(sprintf(nil "%s_%d" nth(i names) col) bBoxShrink(hex~>bBox) '("TOP_M" "drawing")))
)
ya=ya+3*pitch
)
xa=xa+2*xStep
))

printf("Opening %s\n" cv~>cellName) geOpen( ?lib cv~>libName ?cell cv~>cellName  ?view cv~>viewName )) ;; <== check results
