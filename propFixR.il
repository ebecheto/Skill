; ineed('propFixR t)

;propFixR(nil list("rnp1h"))

ineed('abInvokeCdfCallbacks) ;=> abInvokeInstCdfCallbacks
;; inst=css()
;; inst~>prop~>name  ;=> ("l" "ng" "fingers" "wf" "w" "fps" "fpd" "fas" "fad" "ps" "pd" "as" "ad" "nf")
;; oldvals=foreach(mapcar i inst~>prop list( i~>name i~>value))
;=> (("calculatedParam" "Length") ("propFixR" "TRUE") ("effectiveWidth" "0.42") ("l" "29.005") ("segLength" "29.005") ("cdlLen" "29.005") ("cdlWidth" "0.42") ("r" "430"))
;=> (("calculatedParam" "Length") ("leftCnxCnt" "4") ("encnx" "4") ("encnxe" "4") ("encnxs" "4") ("rstrip" "1520.91") ("rtot" "1520.91") ("effectiveWidth" "0.42") ("segLength" "29.005") ("cdlLen" "29.005") ("cdlWidth" "0.42") ("r" "1520.91"))

;dbFindProp(inst "encnx")~>value="2"
;dbFindProp(inst "encnxe")~>value="2"
;dbFindProp(inst "m")~>value   ;="2"

defun(propFixR (@optional (insts nil) (filters list("pe" "ne")))
let((l ng w par cdf cb)
unless(insts insts=geGetWindowCellView()~>instances)
when(filters insts=foreach(mapcan filter filters setof(inst insts inst~>cellName==filter)) )

foreach(mapcar inst insts
printf("%L" list(inst~>name inst~>cellName))

l=dbFindProp(inst "l")
r=dbFindProp(inst "r")
;rtot=dbFindProp(inst "rtot");; rtot=r/rstrip;=> nil n'existe pas au debut
;rstrip=dbFindProp(inst "rstrip")
w=dbFindProp(inst "w")

rold=r~>value ;=> "5K" ; ;rold="5K";=> "430"

when(
or(
evalstring(l~>value||"1")> 0.18  ;<= when trans is not in
nil ;dbFindProp(inst "propFixR")~>value!="TRUE"
);
dbCreateProp(inst "propFixR" 'boolean t);<= to prevent double apply
;dbDeletePropByName(inst "propFixR")
when(w w~>value=aelSuffixNotation(evalstring(w~>value||"0")*1u))
when(l l~>value=aelSuffixNotation(evalstring(l~>value)*1u)) ;=> "1u"
;cdf=(cdfGetInstCDF inst) cb=car(setof(p cdf~>parameters p~>name==w~>name))~>callback evalstring(cb) ; SAME CALLBACK FOR ALL
(abInvokeInstCdfCallbacks inst)
;; DONE W

rtot=dbFindProp(inst "rtot");; rtot=r/rstrip;=> nil n'existe pas au debut, existe apres abInvok
rtot~>value;=> "1520.91"
;rold="21.29"

when(evalstring(dbFindProp(inst "rtot")~>value)>evalstring(rold) printf("FIX PARALLEL (INCREMENT) %L" list(inst~>name inst~>cellName)))
when(evalstring(dbFindProp(inst "rtot")~>value)<evalstring(rold) printf("FIX SERIES   (INCREMENT) %L" list(inst~>name inst~>cellName)))

;; ;; vv BUGGY
epsilon=1m
if(abs(evalstring(dbFindProp(inst "rtot")~>value)-evalstring(rold))<epsilon then
printf("[DONE] rtot=rold+/- 1m:  %L" list(inst~>name inst~>cellName dbFindProp(inst "m")~>value dbFindProp(inst "m")~>value dbFindProp(inst "rtot")~>value rold))
else


nbmax=10
while(
and(abs(evalstring(dbFindProp(inst "rtot")~>value)-evalstring(rold))>epsilon nbmax>0)
nbmax-=1

unless(dbFindProp(inst "m") dbCreateProp(inst "m" 'string "1"));<= when "m"==1, prop disapear

dbFindProp(inst "m")~>value=aelSuffixNotation(evalstring(dbFindProp(inst "m")~>value||"1")*2)
dbFindProp(inst "r")~>value=aelSuffixNotation(evalstring(rold||"1")/evalstring(dbFindProp(inst "m")~>value||"1"))
(abInvokeInstCdfCallbacks inst)
printf("FIX SERIES (INCREMENT) %L\n" list(inst~>name inst~>cellName dbFindProp(inst "r")~>value dbFindProp(inst "m")~>value dbFindProp(inst "rtot")~>value rold))
);Paralell fix
;=> still bug, needs to put length calue to 1u sometimes.


); adapt w and l when w i not correct.
);foreach
));end let defun

