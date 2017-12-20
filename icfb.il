(princ 'The\ cat )
(princ 'pwd' )


(defvar *standard-output* :stdout
  "The value of *STANDARD-OUTPUT*, called standard output, is a stream
that is used by many operators as a default destination for output
when no specific output stream is explicitly supplied.

Output stream.")

(setq foo (list nil))
           (nil)
     (setcar foo foo)
           (#0)
;; (let ((standard-output (current-buffer)))

(defvar *standard-output* :stdout
  "The value of *STANDARD-OUTPUT*, called standard output, is a stream
that is used by many operators as a default destination for output
when no specific output stream is explicitly supplied.

Output stream.")

(let ((standard-output :stdout)))

