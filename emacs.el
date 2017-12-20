(shell-command-to-string "echo -test! $x-")
(shell-command-to-string "ls")

(let ((cmd (mapconcat 'shell-quote-argument args " ")))
    (shell-command-to-string cmd))