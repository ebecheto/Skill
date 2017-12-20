;; Make sure the the htmlize library is in load-path.
;; You might want to load ~/.emacs
(load "~/.emacs")
;; USAGE:
;;     emacs -batch -l my-htmlize.el INFILE > OUTFILE
;; for file in *.il ; do  emacs -batch -l my-htmlize.el $file > RTF/$file.rtf 2>/dev/null;echo $file;done
;; for file in *.il ; do  emacs -r -batch -l my-htmlize.el $file > RTF/$file.rtf 2>/dev/null;echo $file;done


;; Example why needed, normally set by color-theme, seems not to be...:
(custom-set-faces 
 '(default                      ((t (:foreground "#ffffff" :background "black"))))
 '(font-lock-builtin-face       ((t (:foreground "#ff0000"))))
 '(font-lock-comment-face       ((t (:italic t :foreground "#FF4500")))) ;peachpuff unreccocnized ?
 '(font-lock-constant-face      ((t (:foreground "magenta"))))
 '(font-lock-function-name-face ((t (:bold t :foreground "#00FFFF")))) ;cadetblue
 '(font-lock-keyword-face       ((t (:foreground "#00FFFF")))) ;"yellow3"
 '(font-lock-string-face        ((t (:foreground "#FFA07A"))))
 '(font-lock-type-face      ((t (:foreground "green"))))
 '(font-lock-variable-name-face ((t (:foreground "cyan" :bold t))))
 '(font-lock-warning-face       ((t (:foreground "red" :weight bold)))))

(setq htmlize-use-rgb-map 'force)
(require 'htmlize)
(color-theme-high-contrast)

(find-file (pop command-line-args-left))
(font-lock-fontify-buffer)
(with-current-buffer (htmlize-buffer)
  (princ (buffer-string)))
