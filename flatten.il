;; copyleft ebecheto
;; flatten fct thanks to http://answers.yahoo.com/question/index?qid=20101106203548AALDgwY

(defun flatten (list)
(cond
((null list) list)   ;=> nothing in the list anymore = stop condition
((null (car list)) (flatten (cdr list)))     ;=> first element is nil => ignore it and go further
((atom (car list)) (cons (car list) (flatten (cdr list))))  ; when first element is single process it (cons) and go further is returned
(t                 (append (flatten (car list)) (flatten (cdr list)))) ; else append head and tail with the function itself recursing
))
