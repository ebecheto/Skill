;ineed('transistor_sizeup)
ineed('abInvokeCdfCallbacks) ;=> abInvokeInstCdfCallbacks

;; inst=css()
;; oldvals=foreach(mapcar i inst~>prop list( i~>name i~>value))
;; ;=> (("wf" "1u") ("transisorSizeup" "TRUE") ("m" "1") ("l" "120.0n") ("ng" "3") ("wtot" "3u") ("ps" "5.82u") ("pd" "5.82u") ("as" "9.1e-13") ("ad" "9.1e-13") ("psp" 0) ("psp?" "FALSE") ("nrs" "0.06") ("nrd" "0.06") ("rf_rsub" "1") ("rgatemod" 0) ("rgate" "no gate resistor") ("rbodymod" 0) ("rbody" "network off") ("vtsens" "FALSE") ("lnws" 0) ("nws" "no proximity effect") ("lstis" 1) ("stis" "stress effect") ("trench" "FALSE") ("rightAlign" "bottom") ("centerAlign" "bottom") ("leftAlign" "bottom") ("centerFill" "100") ("rightFill" "100") ("leftFill" "100") ("connect" "FALSE") ("ngcon" "1") ("rightCnt" "TRUE") ("leftCnt" "TRUE") ("rightExt" 0.0) ("leftExt" 0.0) ("rightRX" 0.55) ("leftRX" 0.55) ("idg" 0) ("interdigitation?" "FALSE") ("mSwitch" 0) ("par" "1") ("nf" "3") ("wff" 1.0) ("w" "3u") ("wt" "3u") ("sd" "3.6e-07"))

;; inc=180/120.0;=> 1.5
;; force=nil

;transistor_sizeup(list(css()) list("pe" "ne" "pel" "nel") 1.5 t)


defun(transistor_sizeup (@optional (insts nil) (filters list("pe" "ne" "pel" "nel")) (inc 1)(force nil))
let((lold wold ratio)
unless(insts insts=geGetWindowCellView()~>instances)
when(filters insts=foreach(mapcan filter filters setof(inst insts inst~>cellName==filter)) )

foreach(mapcar inst insts
printf("%L" list(inst~>name inst~>cellName))

when(
(or dbFindProp(inst "transisorSizeup")~>value!="TRUE" force==t)
dbCreateProp(inst "transisorSizeup" 'boolean t);<= to prevent double apply

lold=dbFindProp(inst "l")~>value;=> "120.0n"
wold=dbFindProp(inst "w")~>value;=> "3u"
ratio=evalstring(wold)/evalstring(lold);=> 25.0

dbFindProp(inst "w")~>value=aelSuffixNotation(evalstring(wold)*inc)
dbFindProp(inst "l")~>value=aelSuffixNotation(evalstring(lold)*inc)

(abInvokeInstCdfCallbacks inst)
); unless prop
)))