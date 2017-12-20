;; copyleft : ebecheto
; notation tower en micron => si ibm length=1u< 0.18 => on multiplie par 1e6
; j'aurai du faire une fonction generique ... TODO later
; Tue Oct 24 02:25:49 CEST 2017 [DONE]
; tester la liste des parametres a passer en revue.
; verifier ceux qui sont utile (resistance, capa, mos)
; les passer en revue un par un pour verifier sur un example
; cdfgData~>parameters~>name
; quand value!=defValue => apply 
; choisir le param qui doit etre modifier (et non mis a def value) ie. not2def='res 

defun(evalCallBackParam (@optional (cdfgData (cdfGetInstCDF css())) (name "res")(verb t))
(setq callback (getq (get cdfgData name) callback))
when(verb printf("model:%L param:%L :callback:%L\n" cdfgData~>simInfo->auLvs->componentName||"unamed" name callback))
(when (and callback (nequal callback "")) (errset (evalstring callback) t)))
;; evalCallBackParam(cdfgData "l");=> (t)
;; evalCallBackParam(cdfgData "");=> nil
;; evalCallBackParam(cdfgData "w");=> (t)

defun(evalCallBackInit (@optional (inst css()) (verb t))
let((cdfgData cdfgForm callback success)
(setq cdfgData (cdfGetInstCDF inst))
(setq cdfgForm cdfgData); some callbacks use cdfgForm instead, sinon *Error* eval: unbound variable - cdfgForm
(setq callback (getq cdfgData formInitProc))
when(verb printf("INIT:%s\n" cdfgData||"nil")) 
success=t
(when (and callback (nequal callback "")) (unless (errset (evalstring (strcat callback "(cdfgData)")) nil) (setq success nil)))
when(verb&&success&&callback printf("INIT correctly executed!!!\n"))
when(verb printf("%s with %d parameters\n" inst~>name length(cdfgData~>parameters)))
cdfgData))
;cdfgData=evalCallBackInit()
;cdfgData~>parameters

defun(cdfgDataParametersLook  (@optional (inst css()) (verb t) ) let((cdfgData i)
cdfgData=evalCallBackInit(inst verb)
i=0 (foreach mapcar param cdfgData~>parameters printf("%d|%s | %s | %L| %L| %s\n" i++ param~>name param~>prompt param~>value||"nil?" param~>defValue||"nil?" param~>callback||"noCB") )))
;cdfgDataParametersLook()

defun(cdfgDataParametersDiff  (@optional (inst css()) (verb t)) 
(foreach mapcan param cdfgData~>parameters remove(nil when(param~>value!=param~>defValue
printf("%s | %s | %s| %s| %s\n" param~>name param~>prompt param~>value||"nil?" param~>defValue param~>callback||"noCB") '(()) ))))


; (setq not2def "res")
defun( except1restetParams (@optional (inst css()) (not2def "res")(verb t) ) let((cdfgData tokeep valtokeep)
cdfgData=evalCallBackInit(inst verb)
if(
tokeep=car(setof(param cdfgData~>parameters param~>name==not2def)) then
valtokeep=tokeep~>value
else
printf("no value to keep selected from %L\n Maybe you should pick one ?\n" cdfgData~>paramameters~>name))
foreach(mapcar param cdfgData~>parameters 
when( param~>value!=param~>defValue 
param~>value=param~>defValue 
when(verb printf("%s | %s | %s| %s| %s\n" param~>name param~>prompt param~>value||"nil?" param~>defValue param~>callback||"noCB"))))
when(tokeep~>value=valtokeep 
evalCallBackParam(cdfgData tokeep~>name)
when(verb printf("param %L backup %L re-affected\n" tokeep~>name valtokeep ))
)))


defun(modifSingleCdfParam (@optional (inst css()) (name "entryMode") (param "_c_")) let((cdfgData toModif)
cdfgData=evalCallBackInit(inst verb)
toModif=car(setof(param cdfgData~>parameters param~>name==name))
unless(toModif printf("Check that %L exist in %L\n" name cdfgData~>parameters~>name))
toModif~>value=param
evalCallBackParam(cdfgData name)
))
; select a capa and play modifSingleCdfParam()
; modifSingleCdfParam(css() "w" "10u")

; (setq not2def "res")
; (setq inst css())
;(setq not2def list("l" "w"))
defun(except2restetParams (@optional (inst css()) (not2def list("l" "w"))(verb t) )
let((cdfgData parvals tokeep)
unless(inst printf("select an instance\n"))
when(inst
cdfgData=evalCallBackInit(inst verb)
parvals=remove(nil foreach(mapcan param cdfgData~>parameters when(member(param~>name not2def) list(list(param~>name param~>value)))))
unless(tokeep printf("no value to keep selected from %L\n Maybe you should pick one ?\n" cdfgData~>paramameters~>name))
foreach(mapcar param cdfgData~>parameters 
when( param~>value!=param~>defValue 
param~>value=param~>defValue 
when(verb printf("%s | %s | %s| %s| %s\n" param~>name param~>prompt param~>value||"nil?" param~>defValue param~>callback||"noCB"))))
foreach(mapcar parval parvals
tokeep=car(setof(param cdfgData~>parameters param~>name==car(parval)))
when(tokeep~>value=cadr(parval)
evalCallBackParam(cdfgData tokeep~>name)
when(verb printf("param %L backup %L re-affected\n" tokeep~>name tokeep~>value ))
)
))))


;; definir la liste des instances a mettre a jour et des proprietes associes a affecter.

;; saucisses='(
;; ("pmos1v" ("w" "l"))
;; ("nmos1v" ("w" "l"))
;; ("rplpoly" ("res"))
;; ("rphpoly" ("res"))
;; ("rppoly_dis" ("res"))
;; ("rppolywo_dis" ("res"))
;; )


defun(strapPropCell (@optional (cv geGetWindowCellView())(saucisses nil)(verb t)) let((params)
unless(saucisses saucisses='( ("pmos1v" ("w" "l")) ("nmos1v" ("w" "l")) ("rplpoly" ("res")) ("rphpoly" ("res")) ("rppoly_dis" ("res")) ("rppolywo_dis" ("res"))))
foreach(mapcar inst cv~>instances
when(params=cadr(assoc(inst~>cellName saucisses))
when(verb printf("%L %L\n" inst~>name params ) )
except2restetParams(inst params verb)
))))



; cv=geGetWindowCellView()
; inst=car(cv~>instances)

;; ; BUGGY
;; defun(cellOrLibStrapProp (@optional (cv nil)(libName nil)(saucisses nil)(verb nil))
;; ;libName=nil
;; unless(cv cv=geGetWindowCellView())
;; unless(libName libName=cv~>libName)
;; ddLib=setof(lib ddGetLibList() lib~>name==libName) ; ddLib~>cells~>name
;; cvs=remove(nil foreach(mapcan cell car(ddLib~>cells)
;; cellName=cell~>name
;; list(cv=dbOpenCellViewByType( libName cellName "schematic" "schematic"))))
;; when(cv cvs=list(cv))
;; unless(saucisses saucisses='( ("pmos1v" ("w" "l")) ("nmos1v" ("w" "l")) ("rplpoly" ("res")) ("rphpoly" ("res")) ("rppoly_dis" ("res")) ("rppolywo_dis" ("res")) ))
;; foreach(mapcar cv cvs
;; foreach(mapcar inst cv~>instances
;; when(params=cadr(assoc(inst~>cellName saucisses))
;; except2restetParams(inst params verb)
;; ))))
;; cellOrLibStrapProp();<= entire lib of the viewing area
;; cellOrLibStrapProp(t);<= entire cell viewed
;; cellOrLibStrapProp(t nil nil t);<= entire cell viewed verbose


