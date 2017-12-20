; copyleft ebecheto
ineed('io2dir)
io="iopin"
dir=io2dir(io);=> "inputOutput"
cv=geGetWindowCellView()
aPin = dbOpenCellViewByType("basic" io "symbol")
; pinId=schCreatePin( cv aPin label dir nil XY "R0")
;; USED to generate KEL connectors
;; MOTIF :
;;  #2    #1
;;  #4		#3
;;  #6    #5
;;  #8		#7
;; ...............




XY=0:0
Ys=0.125
when(Ys=='t Ys=0.125)
XY=mapcar('plus XY cons(0 list(Ys)))

nbPins=80

paires=foreach(mapcar x linRg(2 nbPins  2) sprintf(nil "S%d" x)) ;=> ("S1" "S2" "S3" .. "S67" "S68")
;=> ("S2" "S4" "S6" "S8" "S10" "S12" "S14" "S16" "S18" "S20" "S22" "S24" "S26" "S28" "S30" "S32" "S34" "S36" "S38" "S40" "S42" "S44" "S46" "S48" "S50" "S52" "S54" "S56" "S58" "S60" "S62" "S64" "S66" "S68")

gauche=remove(nil foreach(mapcar x linRg(1 nbPins  1) when(mod(x-1 4)==0 sprintf(nil "S%d" x))))
;=> ("S1" "S5" "S9" "S13" "S17" "S21" "S25" "S29" "S33" "S37" "S41" "S45" "S49" "S53" "S57" "S61" "S65")
droite=remove(nil foreach(mapcar x linRg(1 nbPins  1) when(mod(x-3 4)==0 sprintf(nil "S%d" x))))
;=> ("S3" "S7" "S11" "S15" "S19" "S23" "S27" "S31" "S35" "S39" "S43" "S47" "S51" "S55" "S59" "S63" "S67")

X=0:0
foreach(mapcar label paires 
when(Ys=='t Ys=0.125)
XY=mapcar('plus XY cons(0 list(Ys)))
pinId=schCreatePin( cv aPin label dir nil XY "R0")
pinId~>children~>justify="upperLeft"   ; regle orientation pin label
text=car(setof(child pinId~>children child~>objType=="textDisplay"))
xyp=centerBox(pinId~>bBox) 
text~>xy=list(caadr(pinId~>bBox) (cadr(xyp)+cadar(pinId~>bBox))/2)
)


X=1 Ys=0.125*2
XY=X:Ys
foreach(mapcar label gauche 
XY=mapcar('plus XY cons(0 list(Ys)))
pinId=schCreatePin( cv aPin label dir nil XY "R0")
pinId~>children~>justify="upperLeft"   ; regle orientation pin label
text=car(setof(child pinId~>children child~>objType=="textDisplay"))
xyp=centerBox(pinId~>bBox) 
text~>xy=list(caadr(pinId~>bBox) (cadr(xyp)+cadar(pinId~>bBox))/2)
)

X=2 Ys=0.125*2
XY=X:Ys
foreach(mapcar label droite
XY=mapcar('plus XY cons(0 list(Ys)))
pinId=schCreatePin( cv aPin label dir nil XY "R0")
pinId~>children~>justify="upperLeft"   ; regle orientation pin label
text=car(setof(child pinId~>children child~>objType=="textDisplay"))
xyp=centerBox(pinId~>bBox) 
text~>xy=list(caadr(pinId~>bBox) (cadr(xyp)+cadar(pinId~>bBox))/2)
)


terminalGen(netMakeBus("P" 65 t "_") 1 1 t 0.125)

foreach(mapcar x linRg(1 16 1) sprintf(nil "gnd!"))
;=> ("gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!" "gnd!")



toto=foreach(mapcar x linRg(1 16 1) sprintf(nil "VT1"))
terminalGen(toto 1 1 t 0.25)
hiRedraw()

