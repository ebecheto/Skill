;; copyleft ebecheto

;; load("ineed.il")

;; quand j'y pense, ma fonction ineed ressemble pas mal a (require 'truc) de emacs... non ? 
;; si ce n'est les search dans les differents repertoires

;; ineed('whereExistCell3) ;=> ok charge whereExistCell3.il
;; putd('whereExistCell3 nil);=> purge la fonction


defun(ineed (func @optional (force nil))
cond((nil nil)
(listp(func) foreach(mapcar f func ineed(f force)))
(t unless(fboundp(func)&&not(force) load(strcat(symbolToString(func) ".il"))))))

;; ineed('(getInstTermPoint whereExistCell3))
;; putd('whereExistCell3 nil)
;; putd('getInstTermPoint nil)


; oldest -1
;; defun(ineed (func @optional (force nil))
;; cond((nil nil)
;; (listp(func) foreach(mapcar f func unless(fboundp(f)&&not(force) load(strcat(symbolToString(f) ".il")))))
;; (t unless(fboundp(func)&&not(force) load(strcat(symbolToString(func) ".il"))))))

; oldest version
;; defun(ineed (func) unless(fboundp(func) load(strcat(symbolToString(func) ".il"))))
