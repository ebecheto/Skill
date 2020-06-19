;copyleft ebecheto
; "change voltage transient name VT(xx) to v(xx ?resultsDir)"

defun(VT2v (@optional (nets "/I0/I17/I17/Ireg<9>/Q<10>"))
let(( pnets cnts dnets)
unless(listp(nets) nets=list(nets))
pnets=foreach(mapcar net nets buildString( parseString(net "/") "."))
cnets=foreach(mapcar net pnets strcat(buildString( parseString(net ">") "\\\>") if(rexMatchp( ">$" net) "\\\>" "")))
dnets=foreach(mapcar net cnets buildString( parseString(net "<") "\\\<"))
))

; VT2v("/I0/FLUSH");=> ("I0.FLUSH")
; VT2v("/I0/I17/I17/regIO<5>");=> ("I0.I17.I17.regIO\\<5\\>")
; VT2v("/I0/I17/I17/Ireg<9>/Q<10>");=> ("I0.I17.I17.Ireg\\<9\\>.Q\\<10\\>")

; VT2v(list("/I0/FLUSH" "/I0/I17/I17/regIO<5>" "/I0/I17/I17/Ireg<9>/Q<10>"))
;=> ("I0.FLUSH" "I0.I17.I17.regIO\\<5\\>" "I0.I17.I17.Ireg\\<9\\>.Q\\<10\\>")