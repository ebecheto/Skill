
;; SKILLDIR=env("SKILLDIR");=> "/home/validmgr/ebecheto/Skill"
;; nb=7
;; ifile="~/groupU/me_embosse_100x80.bmp"

defun(image2layers (@optional (ifile "~/groupU/me_embosse_100x80.bmp") (nb 7) (SKILLDIR env("SKILLDIR")))
let((si ofile cmd)
ifile=simplifyFilename(ifile)
si=parseString(ifile ".");=> ("~/groupU/me_embosse_100x80" "bmp")
ofile=buildString(append(reverse(cdr(reverse(si))) list("il")) ".")

cmd=sprintf(nil "/usr/bin/python3 %s/image2layers.py %s %d > %s" SKILLDIR ifile nb ofile)
(system cmd)
load(ofile)
))

; ineed('shout t)
;shout("python -c \"import PIL\" ; echo $?")
; ret=shout("/usr/bin/python3 -c \"import PIL\" ; echo $?")

printf("NEED python and pillow library :\n")
printf("USAGE :\n")
printf("image2layers(\"~/groupU/me_embosse_100x80.bmp\")\n")
printf("image2layers(\"~/groupU/me_embosse_100x80.bmp\" 7 );<= to change default tech stack\n")
printf("image2layers(\"~/groupU/me_embosse_100x80.bmp\" 7 env(\"SKILLDIR\")) ;<= if the python file is here\n")
