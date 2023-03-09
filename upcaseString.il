;; copyleft ebecheto
defun(upcaseString (str) apply('and foreach(mapcar letter parseString(str "") (rexMatchp "[A-Z]" letter))))


;; https://stackoverflow.com/questions/2129840/check-if-a-string-is-all-caps-in-emacs-lisp
;; (defun string-is-capitalized (str)
;;   (let ((case-fold-search nil))
;;     (string-match-p "\\`[A-Z]*\\'" str)))
;; (defun stringIsCapitalized (str)   (rexMatchp "\\`[A-Z]*\\'" str))
;; stringIsCapitalized("ABC");=> nil
;; stringIsCapitalized("Abc");=> nil
;; stringIsCapitalized("abc");=> nil
;; NOT OK

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
