
defun(lay2schName (@optional (ins "|MULT(0)"))
strip=parseString(ins "|()"); ;=> ("MULT" "0")
if(length(strip)>1  strcat(car(strip) "<" cadr(strip) ">") strip)
)

;; lay2schName();=> "MULT<0>"
;; lay2schName("|I12(123)");=> "I12<123>"