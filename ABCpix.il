;; copyleft ebecheto ;; load("ABCpix.il")
ineed('(CreateVias createHexagon bBoxShrink textDisplay2label createPinLPP))

;; NXmax=10000
;; NYmax= 4500
;; NX=NXmax/(2*1.5*pitch/sqrt(3));=> 1154.701
;; NY=NYmax/(3*pitch) ;=> 300
;; nbpixels=1154*300*6 ;=> 2 077 200 : 2Mega-pixels 
;; 10000 * 4500 /(5**2*sqrt(3)/2);=> 2078461.0 ;<= verification with hexagon surface area calculation.
;; ; aire d'un hexagone : 3*sqrt(3)*a²/2   2b=a.sqrt(3)=pitch => a=pitch/sqrt(3) => Aire =pitch²*sqrt(3)/2
;; NX=11 NY=3
;; NX=1154 NY=300
 
NX=115/2 NY=30/2
NX=115/4 NY=30/4
printf("%d-A, %d-B, %d-C for Dist_Y=%d[um], Dist_X=%d[um]\n" 2*NY NX+NY NX+NY round(NY*3*pitch) round(NX*sqrt(3)*pitch ))
printf("%d-discri for Dist_Y=%d[um], Dist_X=%d[um]\n" 2*NY+NX+NY+NX+NY round(NY*3*pitch) round(NX*sqrt(3)*pitch ))


label=""
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
pair=0
;; foreach(mapcar xya AST) ) ;<== equiv for(paire 0 1 ...)
for(pair 0 1;<= oddOReven
xya=nth(pair AST)
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

;; PIN NAMES ADJUSTMENT
;when(row==0 ;<= check first row only for now =< to remove later
; i=0 => A
; i=1 => B
; i=2 => C
(cond 
((i==0) label=sprintf(nil "%s_%d" nth(i names) col*2+pair))
((i==1) label=sprintf(nil "%s_%d" nth(i names) col-row   ))
((i==2) label=sprintf(nil "%s_%d" nth(i names) col+row+pair  ))
)
createPinLPP(label bBoxShrink(hex~>bBox 0.1) '("TOP_M" "drawing"))
;);end row
); end loop 3 : ABC
ya=ya+3*pitch
)
xa=xa+2*xStep
))

printf("Opening %s\n" cv~>cellName) geOpen( ?lib cv~>libName ?cell cv~>cellName  ?view cv~>viewName )) ;; <== check results
textDisplay2label(cv)
