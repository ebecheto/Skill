; ineed('propFixC t)

;propFixR(nil list("rnp1h"))

ineed('abInvokeCdfCallbacks) ;=> abInvokeInstCdfCallbacks
;inst=css()
;inst~>prop~>name;=> ("c" "llayout" "nf" "l")
;oldvals=foreach(mapcar i inst~>prop list( i~>name i~>value))
;=> (("c" "1.24484p") ("llayout" "15.3u") ("nf" "84") ("l" "15.3"))
; (abInvokeInstCdfCallbacks inst)
;=> (("c" "943.800f") ("m" "2") ("DoNotUse" "FALSE") ("advParam" "TRUE") ("perimeter" "410.00000u") ("area" "1e-09") ("ctot" "1.8876p") ("llayout" "15.3u") ("nf" "84") ("l" "200.0000u"))
;=> (("c" "943.800f") ("perimeter" "410.00000u") ("area" "1e-09") ("ctot" "943.800f") ("llayout" "15.3u") ("nf" "84") ("l" "200.0000u"))
;cold=dbFindProp(inst "c")~>value

;; dbFindProp(inst "c")~>value="1.24484p"  (abInvokeInstCdfCallbacks inst)
;; dbFindProp(inst "c")~>value=="1.24484p"  ;=> nil
;; dbFindProp(inst "ctot")~>value="1.24484p"  (abInvokeInstCdfCallbacks inst)
;; dbFindProp(inst "ctot")~>value=="1.24484p"  ;=> nil
;; dbFindProp(inst "ctot")~>value
;; dbFindProp(inst "area")~>value=aelSuffixNotation(evalstring(dbFindProp(inst "area")~>value)*2)
;; dbFindProp(inst "l")~>value=aelSuffixNotation(evalstring(dbFindProp(inst "l")~>value)*2)
;; (abInvokeInstCdfCallbacks inst)
;; cold="1.24484p"


;dbFindProp(inst "encnx")~>value="2"
;dbFindProp(inst "encnxe")~>value="2"
;dbFindProp(inst "c")~>value

defun(propFixC (@optional (insts nil) (filters list("pe" "ne")));=> "2"
let((l ng w par cdf cb)
unless(insts insts=geGetWindowCellView()~>instances)
when(filters insts=foreach(mapcan filter filters setof(inst insts inst~>cellName==filter)) )

foreach(mapcar inst insts
printf("%L" list(inst~>name inst~>cellName))

l=dbFindProp(inst "l")
;rtot=dbFindProp(inst "rtot");; rtot=r/rstrip;=> nil n'existe pas au debut

cold=dbFindProp(inst "c")~>value ;<= then this value will be modified

when(
or(
evalstring(l~>value||"1")> 0.18  ;<= when length is not in microamp (depends on tech)
dbFindProp(inst "propFixC")~>value!="TRUE"
);
dbCreateProp(inst "propFixC" 'boolean t);<= to prevent double apply
(abInvokeInstCdfCallbacks inst)

;;HERE ADAPT OLD VALUE TO NEW TECH
;dbFindProp(inst "c")~>value=aelSuffixNotation(evalstring(cold)/2.0)

w~>value=aelSuffixNotation(evalstring(w~>value||"0")*1u)
;l~>value=aelSuffixNotation(evalstring(loldcval)*1u) ;=> "1u"
cdf=(cdfGetInstCDF inst)
;; cb=car(setof(p cdf~>parameters p~>name==l~>name))~>callback
;; evalstring(cb) ; SAME CALLBACK FOR ALL
;; DONE W


when(evalstring(dbFindProp(inst "ctot")~>value)>evalstring(cold) printf("FIX PARALLEL (INCREMENT) %L" list(inst~>name inst~>cellName)))
when(evalstring(dbFindProp(inst "ctot")~>value)<evalstring(cold) printf("FIX SERIES   (INCREMENT) %L" list(inst~>name inst~>cellName)))
when(evalstring(dbFindProp(inst "ctot")~>value)==evalstring(cold) printf("[DONE] %L" list(inst~>name inst~>cellName)))

printf("FIX SERIES (INCREMENT) %L\n" list(inst~>name inst~>cellName dbFindProp(inst "m")~>value dbFindProp(inst "m")~>value dbFindProp(inst "ctot")~>value cold))

epsilon=1m

if(abs(evalstring(dbFindProp(inst "ctot")~>value)-evalstring(cold))<epsilon then
printf("[DONE] ctot=cold+/- 1m:  %L" list(inst~>name inst~>cellName dbFindProp(inst "m")~>value dbFindProp(inst "m")~>value dbFindProp(inst "ctot")~>value cold))
else
;; try method INCREMENT

;; vv CAN BE BUGGY vv
unless(dbFindProp(inst "m") dbCreateProp(inst "m" 'string "2"));<= double multiplicity
nbmax=10
while(and(dbFindProp(inst "ctot")~>value!=cold nbmax>0) nbmax-=1
dbFindProp(inst "c")~>value=aelSuffixNotation(evalstring(cold)/evalstring(dbFindProp(inst "m")~>value))
(abInvokeInstCdfCallbacks inst)
)
)
;multiplicity fix
;=> still bug, needs to put length calue to 1u sometimes.


); adapt w and l when w i not correct.
);foreach
));end let defun

