;ineed('netSetAdd t)
;; copyleft ebecheto

;(setq tuples '((GND "GND")(VDD "VDD")(SUB "sub")))
(setq tuples '((GND VSSA)(PWR VDDA)(SUB sub)))
tuple=car(tuples);=> (GND "GND")

; Net Name : GND!
; Property name : GND 
; Default Net GND!
; Evaluated Name GND!

defun( netSetAdd (@optional (cv nil) (insts nil) (tuples '((GND VSSA)(PWR VDDA)(SUB sub))))

let((prop pName nName)
unless(cv cv=geGetWindowCellView())
unless(insts
insts=geGetSelectedSet()
)
insts=setof(inst insts inst~>objType=="inst")

;inst=css();=> db:0x2b314bc7
foreach(mapcar inst insts
foreach(mapcar tuple tuples
pName=car(tuple);=> GND
nName=cadr(tuple);=> VSSA

;; defun will mork either for symbol o string syntax
when(symbolp(pName) pName=symbolToString(pName))
when(symbolp(nName) nName=symbolToString(nName))

if(
prop=dbGetPropByName(inst pName)
then
prop~>value=nName
else
prop=dbCreateProp(inst pName "netSet" nName) 
);end if
prop
))
))

;netSetAdd(nil nil '((GND VSSA)(PWR VDDA)))

