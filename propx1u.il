; ineed('propx1u t)


;; insts=geGetWindowCellView()~>instances
;; ;(setq filters list("pe" "ne"))
;; (setq filters list("ne"))
;; insts=foreach(mapcan filter filters setof(inst insts inst~>cellName==filter))
;; inst=car(insts)
;; inst=css()


defun(propx1u (@optional (insts nil) (filters list("pe" "ne")))
let((l ng w par cdf cb)
unless(insts insts=geGetWindowCellView()~>instances)
when(filters insts=foreach(mapcan filter filters setof(inst insts inst~>cellName==filter)) )

foreach(mapcar inst insts
printf("%L" list(inst~>name inst~>cellName))
l=dbFindProp(inst "l")
ng=dbFindProp(inst "ng")
w=dbFindProp(inst "w")
when(
evalstring(w~>value) > 0.18  ;<= when trans is not in
l~>value=aelSuffixNotation(evalstring(l~>value||"0")*1u)
;l~>value=aelSuffixNotation(evalstring(loldcval)*1u) ;=> "1u"

par=w
par~>value=aelSuffixNotation(evalstring(par~>value)*1u/evalstring(ng~>value))
par~>value;=> "20u"

cdf=(cdfGetInstCDF inst)
cb=car(setof(p cdf~>parameters p~>name==par~>name))~>callback
evalstring(cb) ; SAME CALLBACK FOR ALL

); adapt w and l when w i not correct.
);foreach
));end let defun


;; cv=geGetWindowCellView()
;; insts=cv~>instances
;; inst=car(insts)
;; pes=setof(inst insts inst~>cellName=="pe")
;; inst=car(pes)
;; inst~>prop~>name  ;=> ("l" "ng" "fingers" "wf" "w" "fps" "fpd" "fas" "fad" "ps" "pd" "as" "ad" "nf")
; propx1u()
; propx1u(nil list("pe"))
; propx1u(nil list("ne"))
; propx1u(nil list("ne" "pe"))
