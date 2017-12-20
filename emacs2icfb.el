;; copyleft ebecheto

;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(send-string-to-terminal "pwd")

(message "On a recu du shell : %s" (send-string-to-terminal "pwd"))

(send-string-to-terminal " println(\"hello\") \n")
(send-string-to-terminal " printf(\"hello %s World\n\" \"you\")")
(buffer-file-name)
geOpen(?lib "analogLib" ?cell "vdc" ?view "spectre" ?mode "r")

;;  (send-string-to-terminal (format "load(\"%s\") \n" (buffer-file-name)))

(send-string-to-terminal (format "printf(\"\\\nloadFile\\\n\") load(\"%s\") \n" "~/.emacs2icfb.il"))

;; evalstring("printf(\"hello %s World\n\" \"you\")")

;; write-region (point-min) (point-max) file)
(write-region (point-min) (point-max) "~/.emacs2icfb.buffer.il")
(write-region (region-beginning) (region-end) "~/.emacs2icfb.region.il")
(write-region (line-beginning-position) (line-end-position) "~/.emacs2icfb.line.il")

C-M-n
    Move forward over a parenthetical group (forward-list). 

(insert-file-contents "~/.virtuoso2emacs.txt");=> rajout au curseur, je veux juste copier la donne...

(foo-read-file-comma "~/.virtuoso2emacs.txt" )


(defun foo-read-file-comma (full-filename)
  "Read a file and return foo-file as a string."
  (concat ";=> " (with-temp-buffer
    (insert-file-contents full-filename))))

(defun foo-read-file (full-filename)
  "Read a file and return foo-file as a string."
  (with-temp-buffer
    (insert-file-contents full-filename)
    (buffer-string)))


;(with-output-to-string (insert-file-contents "~/.virtuoso2emacs.txt"))


(with-temp-buffer (insert-file-contents "~/.virtuoso2emacs.txt") (buffer-string));=> OK ca va dans message en lisant la string!


(file-name-nondirectory f)  
(buffer-file-name)

(setq fName (buffer-file-name))
(file-name-nondirectory fName)  ;=> "emacs2icfb.el"
(shell-command-to-string "ls")


(call-process "pwd" nil t);=> /home/validmgr/ebecheto/Skill

(call-process "grep" nil "bar" nil "lewis" "/etc/passwd")

(call-process "/bin/hostname" nil standard-output nil);=> lyosrv017.in2p3.fr
(call-process "/bin/hostname" nil nil t) ;=> to message

