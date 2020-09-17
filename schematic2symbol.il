;; copyleft : ebecheto
;; au lieu de : Create->Cellview->FromCellView
ineed('(array2sch minmaxPts areaBox addCell terminal2pin))  ;=>terminal2pin=>wirePinName
; c'est un peu comme Create cellview->from cellview

defun(schematic2symbol (@optional (cv nil)(sim t)(open nil)(PWR t))
let((terms libName cellName cvs symPin pinName dcName termXY txy rot xyList bBox cvSim insts xy )
unless(cv cv=geGetWindowCellView())
terms=cv~>terminals
terms~>name;=>("Q_5" "Q_0" "S_0" "S_1" "S_2" "S_3" "S_4" "S_5" "S_6" "S_7" "S_8" "S_9")
libName=cv~>libName;=>"Ed_CMOS8"
cellName=cv~>cellName;=>"xor_ABCDEEDCBA"
cvs=dbOpenCellViewByType( libName cellName "symbol" "schematicSymbol" "w")
symPin = dbOpenCellViewByType("basic" "sympin" "symbolNN" nil "r")
foreach(mapcar term terms
pinName=term~>name;=>"Q_5" pinName="Q<6>"
dcName=sprintf(nil "cdsTerm(%L)" pinName);=>"cdsTerm(\"Q<6>\")"
termXY=caar(term~>pins~>figs)~>xy;=>(-1.125 -0.25)
schCreateSymbolPin(cvs symPin pinName term~>direction termXY "R0" ) ;; pin for the symbol
txy=car(term~>textDisplays)~>xy
rot=car(term~>textDisplays)~>orient
dbCreateLabel(cvs list("pin" "drawing") txy pinName "centerRight" rot "stick" 0.0625); label du symbol
lb=dbCreateLabel(cvs list("annotate" "drawing8") txy dcName "centerRight" rot "stick" 0.0625) lb~>labelType="ILLabel"
);end loop
xyList=foreach(mapcan term terms car(term~>pins~>figs)~>xy)
bBox=minmaxPts(xyList) printf("%L symbol bBox=%L\n" list(libName cellName areaBox(bBox)) bBox)
bBox=fixZeroBox(bBox) printf("fixed bBox=%L\n" bBox)
schCreateSymbolShape( cvs "rectangle" "outline" bBox)
schCreateSymbolLabel( cvs cadr(bBox) "instance label" "[@instanceName]" "lowerLeft" "R0" "euroStyle" 0.125 "NLPLabel" )
schCreateSymbolLabel( cvs list((caar(bBox)+caadr(bBox))/2 cadar(bBox)) "instance label" "[@cellName]" "lowerLeft" "R90" "euroStyle" 0.125 "NLPLabel" )
dbCreateRect(cvs list("instance" "drawing") bBox) ; <== selection box rect
schSetSymbolOrigin(cvs car(last(xyList)))
schVIC(cvs) dbSave(cvs) dbClose(cvs)
when(sim 
cvSim=dbOpenCellViewByType( libName cellSim=strcat(cellName "_sim") "schematic" "schematic" "w")
insts=addCell(cellName cvSim nil nil libName) schCheck(cvSim) dbSave(cvSim) 
wirePinName(nil nil 0.4 insts)
xy=mapcar('plus car(cvSim~>bBox) '(0 -1))
when(PWR==t PWR='(("vdc" ("gnd!" "vdd!") (("vdc" "string" "1.2")))("vdc" ("gnd!" "nw!") (("vdc" "string" "1.2")))("vdc" ("gnd!" "sx!") (("vdc" "string" "0")))))
when(PWR array2sch(list(PWR) cvSim~>libName cvSim~>cellName nil 0.4 0.4 t nil "a" xy))
geOpen(?lib libName ?cell cellSim ?view "schematic")
)
when(open geOpen(?lib libName ?cell cellName ?view "symbol"))
list(cellName cvSim~>cellName cvSim)
))

printf("schematic2symbol (@optional (cv nil)(sim t)(open nil)(PWR t))\n")
printf("schematic2symbol(nil t nil t) ;<= gen _sim TBn no not open\n")
printf("schematic2symbol(nil nil t t) ;<= no TestBench\n")
