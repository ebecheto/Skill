 ineed('propMult t)
ineed('abInvokeCdfCallbacks) ;=> abInvokeInstCdfCallbacks


;; insts=geGetWindowCellView()~>instances
;; ;(setq filters list("pe" "ne"))
;; (setq filters list("ne"))
;; insts=foreach(mapcan filter filters setof(inst insts inst~>cellName==filter))
;; inst=car(insts)
;; inst=css()


defun(propMult (@optional (insts nil) (filters list("pe" "ne")))
let((l ng w par cdf cb)
unless(insts insts=geGetWindowCellView()~>instances)
when(filters insts=foreach(mapcan filter filters setof(inst insts inst~>cellName==filter)) )
foreach(mapcar inst insts
;dbFindProp(inst "m") ;=> nil
unless(dbFindProp(inst "m") dbCreateProp(inst "m" 'string "1"));<= when "m"==1, prop disapear
;dbFindProp(inst "m");=> db:0x41a3e63f
dbFindProp(inst "m")~>value=aelSuffixNotation(evalstring(dbFindProp(inst "m")~>value||"1")*2)
(abInvokeInstCdfCallbacks inst)
dbFindProp(inst "m")~>value=aelSuffixNotation(evalstring(dbFindProp(inst "m")~>value||"1")/2)
(abInvokeInstCdfCallbacks inst)
printf("FIX MULT x2 div2 %L\n" list(inst~>name inst~>cellName  dbFindProp(inst "m")~>value ))
)))
