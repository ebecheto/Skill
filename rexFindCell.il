;; copyleft ebecheto

;pattern=".*_sim"
;pattern;=> ".*_sim"
;(setq libNames ddGetLibList()~>name)
;(setq libNames '("analogLib"))

defun(rexFindCell (@optional (pattern ".*_sim") (libNames ddGetLibList()~>name) (insensitive nil))
" commentary "
let((ddLibs cellName)
unless(listp(libNames) libNames=list(libNames))
ddLibs=setof(dd ddGetLibList() member(dd~>name libNames))
assocLib=foreach(mapcan dd ddLibs foreach(mapcan cc dd~>cells list(list(dd~>name cc~>name))))
; lib_cell=nth(3 assocLib);=> ("analogLib" "xfmr")
remove(nil foreach(mapcar lib_cell assocLib
cellName=cadr(lib_cell)
if(insensitive then pattern=lowerCase(pattern) cellName=lowerCase(cellName))
if(rexMatchp(pattern cellName) then lib_cell else nil)
))))

;; _USAGE_
;; rexFindCell(".*_sim")
;; rexFindCell("^mos" '("PRIMLIB" "analogLib"))
;; rexFindCell("cap$"  "analogLib")
;; rexFindCell("^simu_" )
printf("rexFindCell(\"^mos\" '(\"PRIMLIB\" \"analogLib\"));<== search in lib for cells starting by nmos\n")
printf("rexFindCell(\"^simu\"));<== search cells starting with simu in all libraries\n")
printf("rexFindCell(\"cap$\"  \"analogLib\");<== searching in one lib for cell ending with name cap\n")
printf("rexFindCell(\"or\" \"CORELIB\" t);<= find pattern 'or', with case insensitivity\n")
printf("foreach(mapcar a rexFindCell(%L %L t) cadr(a));<= get only name of cells" "poly" "tsmcN65")