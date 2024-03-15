;copyleft ebecheto
; inspired from python habits 
; ineed('enumerate)
defun(enumerate (@optional (List '("A" "B" "C"))) let((i)  i=-1 foreach(mapcar L List i+=1 list(i L))))

;; enumerate();=> ((0 "A") (1 "B") (2 "C"))
;; enumerate('("zero" nil 'pomme 0:0));=> ((0 "zero") (1 nil) (2 'pomme) (3 (0:0)))
