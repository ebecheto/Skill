; does work also for layout

insts=nil
css()~>objType
; unless(insts setof(i insts=geGetSelectedSet() or(i~>objType=="inst" i~>objType=="mosaic")))
cv= geGetWindowCellView()
insts=cv~>instances
;inst=car(insts)
inst=css()
;; names=foreach(mapcar inst insts list(inst~>name inst))
;; tris=sortcar(names 'alphalessp)
;; tris
;; ;=> (("|IB(0)" db:0x2af26d1a) ("|IB(1)" db:0x2af26d1b) ("|IB(10)" db:0x2af26d24) ("|IB(2)" db:0x2af26d1c) ("|IB(3)" db:0x2af26d1d) ("|IB(4)" db:0x2af26d1e) ("|IB(5)" db:0x2af26d1f) ("|IB(6)" db:0x2af26d20) ("|IB(7)" db:0x2af26d21) ("|IB(8)" db:0x2af26d22) ("|IB(9)" db:0x2af26d23))

; failed because of 10

names=foreach(mapcar inst insts 
; parseString(inst~>name "()");=> ("|IB" "0")
;name=atoi(cadr(parseString(inst~>name "()")))
name=atoi(cadr(parseString(inst~>name "I")))
list(name inst))
triok=sortcar(names 'lessp)

foreach(mapcar ok triok
obj=cadr(ok)
i=car(ok)+10.0
XY=mapcar('difference 0:i obj~>xy) ;<==> rodAddPoint
dbMoveFig(obj nil list(XY "R0" 1.0))   ; dbMoveFig(css() nil list(0:1 "R0" 1.0))
printf("%L %L %g \n" XY obj~>name i)
)