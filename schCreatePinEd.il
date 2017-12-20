;; copyleft : ebecheto

defun(schCreatePinEd (@optional (cv nil) (name "IN")(dir "inputOutput")(XY list(0 0))(rot "R0")(zero2 0.1))
let((lap aPin PIN rotP)
unless(cv cv=geGetWindowCellView())
lap=cond((dir=="input" "ipin")(dir=="output" "opin")(t "iopin"))
aPin = dbOpenCellViewByType("basic" lap  "symbol")
printf("PIN : %L\n" AA=list( cv aPin name dir nil XY rot))
PIN=schCreatePin(cv aPin name dir nil XY rot)
rotP=sprintf(nil "R%d" mod(evalstring(car(parseString(rot "R")))+270 360))
PIN~>children~>xy=dbTransformPoint(list(0 zero2) list(XY rotP 1))
PIN~>children~>justify="centerLeft"
PIN
))


printf("schCreatePinEd() ;<= create a pin IN in 0:0\n")
printf("schCreatePinEd(nil \"YOYO\" \"input\" 2:3 \"R90\" ) ;<= create a pin YOYO in 2:3\n")
printf("schCreatePinEd(nil \"YOYO\" \"input\" 2:3 \"R90\" 0.2) ;<= create a pin YOYO in 2:3 label farrer (default 0.1)\n")


;; apply('schCreatePin list(geGetWindowCellView() dbOpenCellViewByType("basic" "ipin" "symbol") "NOM" "input" nil 0:0 "R0"))
;; apply('schCreatePin list(geGetWindowCellView() dbOpenCellViewByType("basic" "iopin" "symbol") "NOM" "inputOutput" nil 0:0 "R0"))
;; apply('schCreatePin list(geGetWindowCellView() dbOpenCellViewByType("basic" lap "symbol") "NOM" "inputOutput" nil 0:0 "R0"))

