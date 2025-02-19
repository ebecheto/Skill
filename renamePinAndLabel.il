;ineed('renamePinAndLabel t)

defun(renamePinAndLabel (@optional (fromTo list("gnd!" "VSSA")) (cv nil))
let((from to RECs GNDs)
"redefines pin name and attached label all in one"
unless(cv cv=geGetWindowCellView())
RECs=setof(s cv~>shapes s~>objType=="rect")
RECs=setof(lab RECs lab~>children~>theLabel);=> (db:0x605f529a db:0x605f529c db:0x605f529e db:0x605f52a0 db:0x605f52a2)
from=car(fromTo)
to=cadr(fromTo)
GNDs=setof(r RECs rexMatchp(from r~>net~>name));=> (db:0x605f52a0)
GNDs=setof(r RECs rexMatchp(from r~>net~>name||""));=> (db:0x605f52a0)
foreach(mapcar g GNDs g~>pin~>name=to g~>pin~>term~>name=to g~>children~>theLabel=to g)
))

;renamePinAndLabel(list("vdda!" "VDDA") cv)
;renamePinAndLabel(list("VDDA" "vdda!"))
