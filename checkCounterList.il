defun(checkCounterList (l_123 @optional (i -1))
"check if there are some erronous bits"
remove(nil foreach(mapcan s l_123 i++ if(i==s nil list(list(i s)))))
)

;; sommes='(0 1 2 4 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 22)

;; checkCounterList(sommes) ;=> ((3 4) (20 22))
;; ;=> send the position error and the value error.
;; ;=> if output nil => no error

;; checkCounterList(linRg(0 10 1));=> nil
;; checkCounterList(append(linRg(0 10 1) '(12)));=> ((11 12)) ; 11 eme code erreur

