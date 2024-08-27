;; copyleft ebecheto
;; Code for DB, to increase each vias *3 in x and *3 in y field
;; Because Txx018 changes ther rules in pdk for via width and length
;; so transfering back into axx414 need that (former design in axx411)

defun(viaxRowCol (@optional (lpp "MT_AM") (mXY 3:3) (cv nil))
let((vias params mX mY cutRows cutColumns) mX=car(mXY) mY=cadr(mXY)
unless(cv cv=geGetWindowCellView())
vias=setof(via cv~>vias via~>viaHeader~>viaDefName==lpp)
foreach(mapcar via vias unless(dbFindProp(via "viax3Done")~>value=="TRUE"
params=via~>viaHeader~>overrideParams;=> (("cutRows" 10) ("cutColumns" 10))
cutRows   =mY*(cadr(assoc("cutRows" params))||1)
cutColumns=mX*(cadr(assoc("cutColumns" params))||1)
unless(params printf("CHECK : %L" list(params via via~>xy )))
dbReplaceProp(via "cutColumns" 'int cutColumns)
dbReplaceProp(via "cutRows" 'int cutRows)
dbCreateProp(via "viax3Done" 'boolean t);<= to prevent double apply
))
))