;copyleft ebecheto
; load("~/Skill/t65ResFix.il")
ineed('categoryGet)

defun(t65ResFix (@optional (cv nil) (filter nil))
unless(cv cv=geGetWindowCellView())
unless(filter filter=categoryGet("tsmcN65" "Resistors"))

let((name_cb CB)
foreach(mapcar inst cv~>instances
when((and filter member(inst~>cellName filter))
name_cb=foreach(mapcar c cdfGetInstCDF(inst)~>parameters list(c~>name c->callback))
CB=cadr(assoc("res" name_cb));=> "tsmcN65_rppolyCB( 'res )"
dbFindProp(inst "res")~>value=dbFindProp(inst "r")~>value
evalstring(CB||""))
)))


;; USAGE
;; t65ResFix()
;; t65ResFix(geGetWindowCellView())
;; t65ResFix(geGetWindowCellView() list("onlyThisCellName" "andThisOne"))
;; t65ResFix(geGetWindowCellView() categoryGet("PRIMLIB" "Resistors"))


;; ;;[TODO] : fix resistance callback update [TODO]
;; inst=css();=> db:0x3abd9a3e
;; dbFindProp(inst "r")~>value ;=> "430.149"
;; dbFindProp(inst "res")~>value;=> "340.011"
;; dbFindProp(inst "rs")~>value;=> nil
;; inst~>prop~>??
;; ;foreach(mapcar c cdfGetInstCDF(inst)~>parameters evalstring(c->callback||"" ))
;; name_cb=foreach(mapcar c cdfGetInstCDF(inst)~>parameters list(c~>name c->callback))
;; assoc("res" name_cb);=> ("res" "tsmcN65_rppolyCB( 'res )")
;; CB=cadr(assoc("res" name_cb));=> "tsmcN65_rppolyCB( 'res )"
;; evalstring(CB)


;; dbFindProp(inst "res")~>value=dbFindProp(inst "r")~>value
;; evalstring(CB)
;; dbFindProp(inst "res")~>value;=> "430.149" [OK]
;; inst~>cellName;=> "rppoly"
;; member(inst~>cellName categoryGet("tsmcN65" "Resistors"))

