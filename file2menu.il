;; aa=file2menu('("Functions")
;; eval(car(aa))
;; ;=> hiMenuItem@0x185cac50
;; aa=file2menu('("Functions" "file") ) #<== it suposed that file.il exist in ~/Skill

defun(file2menu  (files)
let(()
foreach(mapcar file files ;file=car(files)
set(concat('caz file) hiCreateMenuItem(?name concat('caz file) ?itemText file ?callback sprintf(nil "load(\"%s.il\")" file )))
concat('caz file))
))
