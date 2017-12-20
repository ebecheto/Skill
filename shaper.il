/**************************************************
* Authors : Edouard BECETHOILLE               	  *
*			IPNL (IN2P3-CNRS / UCBL ) *
* Version : 0.1   November 2008                   *
* History :                                       *
***************************************************/

;  load("~/Skill/shaper.il")

procedure(createShaper( R2 @optional (library getEditRep()~>libName ) (cell getEditRep()~>cellName)   )
let((Gain tau R1p2 R2p2 R1hc R1hc X Y)
;unless( ddGetObj(library) error("Couldn't open library %L. Please open any new layout.\n" library)  )
dbLib = ddGetObj(library)

;; TO RM
;; TO RM
;R2 = 4e+6
library = getEditRep()~>libName
cell = getEditRep()~>cellName
Gain = 12.0
Tau = 4.0
WH = 0.8u
W2 = 0.65u
L2 = 0.0

C2 = C1/Gain
R1 = Tau/C1
R2 = Gain*R1

LH = 1.2k*WH*RH
L2 = W2*R2/50

printf("Generate Shaper with (R2 C2 R1 C1)  %L \n" list(R2 C2 R1 C1))

step = 0.45
rotate = 0 X=0 Y=0 rot="R0"

;cv=getEditRep()~>cellView
;library=getEditRep()~>libName
;cell=getEditRep()~>cellName

cvSch = dbOpenCellViewByType( library cell "schematic" "schematic" "a")
;printf("%L %L %L \n" library cell list(cvSch))
schPin = dbOpenCellViewByType("basic" "iopin" "symbol")
;cvSym = dbOpenCellViewByType( library cell "symbol" "schematicSymbol" "w")
;symPin=dbOpenCellViewByType("basic" "sympin" "symbolNN" nil "r")


;; loop on pins
dbCreateInstByMasterName(cvSch padLib padCap "symbol" sprintf(nil "corner_%d" edge) X:Y rot)
dbCreateInstByMasterName(cvSch padLib cadr(pad) "symbol"  sprintf(nil "PAD_%d" mn) X:Y rot)
db=dbCreateParamInst( cvSch (dbOpenCellViewByType "PRIMLIB" "rpoly2c" "symbol") nil (list X Y) rot 1 list(list("r" "float" R2) list("w" "float" W2) list("l" "float" L2) ))  ; "RO" ou R90
;; ^^^^^^^ marche pas ! comment insere automatiquement rpoly ?

dbSave(cvSym) dbClose(cvSym) dbSave(cvSch) dbClose(cvSch) 
);end let
);end proc




;createShaper( 4.0e+6 )



;createSch( '("in0" "in1" "in2" "in3" "in4" "in5" "in6" "in7" "in8" "in9" "in10" "in11" "in12" "in13" "in14" "in15" "in16" "in17" "in18" "in19" "in20" "in21" "in22" "in23" "in24" "in25" "in26" "in27" "in28" "in29" "in30" "in31")) t
;createSch( '(("IN0" "PAD_IO") ("IN1" "PAD_IO") ("IN2" "PAD_IO") ("IN3" "PAD_IO") ("IN4" "PAD_IO") ("IN5" "PAD_IO") ("IN6" "PAD_IO") ("IN7" "PAD_IO") ("IN8" "PAD_IO") ("IN9" "PAD_IO") ("IN10" "PAD_IO") ("IN11" "PAD_IO") ("IN12" "PAD_IO") ("IN13" "PAD_IO") ("IN14" "PAD_IO") ("IN15" "PAD_IO")))