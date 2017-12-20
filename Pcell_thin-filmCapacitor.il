;; techGetTechFile(geGetWindowCellView())  ?? ou pas

pcDefinePCell(
list( ddGetObj( "T2K_2008") "cap" "layout")
( ( pcW 100. )
( pcH 100. ) )
let( (h2 tf 01 02 fig1 fig2 net trm pin)
; determine some internal dimensions using data from the techFile:
h2 = pcH * .5
tf = techGetTechFile(ddGetObj(pcCellView))
o1 = techGetOrderedSpacingRule(tf "minEnclosure" "metal1" "metal2")
o2 = techGetOrderedSpacingRule(tf "minEnclosure" "metal2" "abVia")
; Create the shapes that form the cap; metal1 and metal2 are pins:
fig1 = dbCreateRect( pcCellView list( "metal1" "drawing")
list( 0.:-h2-o1 pcW+o1+o1:h2+o1))
fig2 = dbCreateRect( pcCellView list( "metal2" "drawing")
list( o1:-h2 pcW+o1:h2))
dbCreateRect( pcCellView list( "abVia" "drawing")
list( o1+o2:o2-h2 pcW+o1-o2:h2-o2))
; Create the nets and terminals and bind the metal pins to them:
net = dbCreateNet( pcCellView "n1")
trm = dbCreateTerm( net "n1" "inputOutput")
pin = dbCreatePin( net fig1 "n1")
pin~>accessDir = '( "left" "right" "top" "bottom")
net = dbCreateNet( pcCellView "n2")
trm = dbCreateTerm( net "n2" "inputOutput")
pin = dbCreatePin( net fig2 "n2")
pin~>accessDir = '( "left" "right" "top" "bottom")
; Create the instNamePrefix property
dbReplaceProp(pcCellView "instNamePrefix" "string" "cap")
t
);; end let
);; end pcDefinePCell

pcDefinePCell(
list( ddGetObj( "T2K_2008") "muxPcell" "layout")
; parameters and their optional default values:
list(
( width 1.0)
( length 10.)
( numGates 1)
) ;end of parameter list
; parameters and their default values:
list(
(param1 ddGetObj("libName")~>param1Default)
(param2 techGetParam(techGetTechFile(pcCellView,param2Default))
) ;end of parameter list


;tf = techGetTechFile(geGetWindowCellView())
;o1 = techGetOrderedSpacingRule(tf "minEnclosure" "MET1" "MET2")

;o1 = techGetOrderedSpacingRule(tf "minEnclosure" 
;list("MET1" "drawing")
;list("MET2" "drawing") 
;)
;car(tf~>lps)

;tf = techGetTechFile(geGetWindowCellView())
;car(car(tf~>lps)~>groupMembers)
;car(car(tf~>lps)~>groupMembers)~>prop~>??
;proptf=car(car(tf~>lps)~>groupMembers)~>prop
;cdddr(proptf)~>??