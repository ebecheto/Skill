#!/usr/bin/emacs
; --script
;; cat loard.org |emacs -batch -l text2rtf.el
;; inspired from, addapted to generate colorized rtf files
;; http://joelmccracken.github.io/entries/reading-writing-data-in-emacs-batch-via-stdin-stdout/
; emacs --batch -l ~/bar.el test.txt -f process-color-file #<== if not (process-color-file) at end of file

;; (custom-set-variables
;;  '(htmlize-output-type (quote inline-css))
;; )
;; (add-to-list 'load-path "~/.emacs.d/")
;; (load "htmlize.el")
;; (load "skillMode.el")

; cat test_display.il |emacs -f ~/.emacs -script text2rtf.el 

(load "~/.emacs")
(require 'htmlize)
(setq htmlize-use-rgb-map 'force)
(font-lock-fontify-buffer)
(message "GOGOGO")
(package-initialize);<== what does that do.. load init.el ?
; (message custom-set-faces) => void...


(defun process-color-file ()   (interactive)   (let ((org-document-content "") this-read)
    (while (setq this-read (ignore-errors (read-from-minibuffer "")))
      (setq org-document-content (concat org-document-content "\n" this-read)))

    (with-temp-buffer
      (insert org-document-content)
      (skill-mode)
      (color-theme-high-contrast)
      (htmlize-buffer)
      (switch-to-buffer (get-buffer "*html*"))
      (princ (buffer-string))
      )))

(process-color-file)

;(exec-to-string "pwd > ~/toto")
;(message (exec-to-string "pwd"))

;(shell-command-to-string "echo -test! $x-")
;(shell-command-to-string "pwd > ~/toto")
