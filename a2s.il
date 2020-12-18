;; copyleft ebecheto

; (mapcar 'a2s  r ) ;<= a2s n'existe plus ?
defun(a2s (r) foreach(mapcar s r if(stringp(s) s sprintf(nil "%L" s))))
