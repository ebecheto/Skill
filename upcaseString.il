;; copyleft ebecheto
;; Check is a string is only made of UPPER CASE of digits ABCFGH123 => [OK]
;; 

;defun(upcaseString (str) apply('and foreach(mapcar letter parseString(str "") (rexMatchp "[A-Z]" letter))))
;defun(upcaseString (str) apply('and foreach(mapcar letter parseString(str "") (rexMatchp "[A-Z]+[0-9]+" letter))))
defun(upcaseString (str) apply('and foreach(mapcar letter parseString(str "") or((rexMatchp "[A-Z]" letter)(rexMatchp "[0-9]" letter)))))

;; CHECKS to verify
;; upcaseString("BUFFLVTD24") ;=> t
;; upcaseString("nmos1v_mis") ;=> nil
;; upcaseString("nmos")       ;=> nil


;; foreach(mapcar letter parseString("BUFFLVTD24" "") printf("%s %L\n" letter (rexMatchp "[A-Z]+[0-9]+" letter))) 


;; https://stackoverflow.com/questions/2129840/check-if-a-string-is-all-caps-in-emacs-lisp
;; (defun string-is-capitalized (str)
;;   (let ((case-fold-search nil))
;;     (string-match-p "\\`[A-Z]*\\'" str)))
;; (defun stringIsCapitalized (str)   (rexMatchp "\\`[A-Z]*\\'" str))
;; stringIsCapitalized("ABC");=> nil
;; stringIsCapitalized("Abc");=> nil
;; stringIsCapitalized("abc");=> nil
;; NOT OK


;; (rexMatchp "[A-Z]||[0-9]" "A");=> nil
;; (rexMatchp "[0-9]" "2");=> t
;; (rexMatchp "[A-Z]*[0-9]*" "A");=> t
;; (rexMatchp "[A-Z]*[0-9]*" "A9");=> t
;; (rexMatchp "[A-Z]*[0-9]*" "9");=> t
;; (rexMatchp "[A-Z]+[0-9]+" "a");=> nil
;; (rexMatchp "[A-Z]+[0-9]+" "A");=> nil
;; or((rexMatchp "[A-Z]" "A") (rexMatchp "[0-9]" "A") );=> t

;; (rexMatchp "[A-Z]+[0-9]*" "A9");=> t
;; (rexMatchp "[A-Z]+[0-9]*" "9");=> nil

;; (rexMatchp "[A-Z]" "A");=> t
;; (rexMatchp "[A-Z]" "Abc");=> t
;; (rexMatchp "[A-Z]*" "Abc");=> t
;; (rexMatchp "[a-z]*" "Abc");=> t
;; (rexMatchp "[a-z]+" "Abc");=> t
;; (rexMatchp "[A-Z]+" "Abc");=> t
;; (rexMatchp "^[A-Z]+" "Abc");=> t
;; (rexMatchp "^[A-Z]+" "abc");=> nil
;; foreach(mapcar letter parseString("abc" "") (rexMatchp "[A-Z]" letter));=> (nil nil nil)
;; foreach(mapcar letter parseString("ABC" "") (rexMatchp "[A-Z]" letter));=> (t t t)
;; and(foreach(mapcar letter parseString("ABC" "") (rexMatchp "[A-Z]" letter)));=> (t t t)

;; and(t t t);=> t
;; and(list(t t t));=> (t t t)
;; apply('and list(t t t));=> t
;; apply('and foreach(mapcar letter parseString("ABC" "") (rexMatchp "[A-Z]" letter)));=> t
