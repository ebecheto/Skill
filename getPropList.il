;; copyleft ebecheto
ineed('getInstTermPoint)
defun(getPropList (@optional (inst css()))
list(inst~>cellName foreach(mapcar coin mapcar('car getInstTermPoint(inst)) con=car(setof(conn inst~>conns conn~>name==coin)) con~>net~>name) foreach(mapcar pp inst~>prop list(pp~>name pp~>valueType pp~>value))))


; getPropList()
;=>("vpulse" (("v2" "string" "1.8") ("tf" "string" "100.0f") ("tr" "string" "100.0f") ("per" "string" "1n")))

; permet de reccup la liste des proprietes a donner a dbCreateParamInstByMasterName pour inserer a nouveau de composant similairement.

;; inst=css()
;; ; inst~>conns~>net~>name;=> ("Sf_3" "gnd!") pas dans le bon ordre
;; coins=mapcar('car getInstTermPoint(inst));=>("MINUS" "PLUS")
;; foreach(mapcar coin coins con=car(setof(conn inst~>conns conn~>name==coin)) con~>net~>name)
;; ;=> ("gnd!" "Sf_3") oki dans le bon ordre

;; foreach(mapcar coin mapcar('car getInstTermPoint(inst)) con=car(setof(conn inst~>conns conn~>name==coin)) con~>net~>name)

