;; copyleft ebecheto

; (mapcar 'a2s  r ) ;<= a2s n'existe plus ?
defun(a2s (r) foreach(mapcar s r if(stringp(s) s sprintf(nil "%L" s))))

;; TOREMOVE !

;;  r= '(1 62 "Red" 840 1)
;;  a2s(r);=> ("1" "62" "Red" "840" "1")
;;  pas bon, la fonction initiale permettait de faire : (mapcar 'a2s  '(L 1 "3" _));=>("L" "1" "3" "_")
;;  (mapcar 'a2s  r ); *Error* mapcar: argument #2 should be a list (type template = "ul") - 1
;;  (mapcar 'a2s  list(r) );=> (("1" "62" "Red" "840" "1"))
;;  r=list(1 62 "Red" 840 1)
;; (mapcar 'a2s  r )