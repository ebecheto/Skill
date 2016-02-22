;; copyleft ebecheto

; iopin to direction name
defun(io2dir (@optional (io t))
cond(
(io=="ipin"  "input"       )
(io=="opin"  "output"      )
(io=="iopin" "inputOutput" )
(t          "inputOutput" )
))

defun(dir2io (@optional (io t))
cond(
(io=="input"       "ipin"  )
(io=="output"      "opin"  )
(io=="inputOutput" "iopin" )
(t "iopin")
))

