;ineed('image2layers t)
;; SKILLDIR=env("SKILLDIR");=> "/home/validmgr/ebecheto/Skill"
;; nb=7
;; ifile="~/groupU/me_embosse_100x80.bmp"


defun(image2layers (@optional (ifile "~/groupU/me_embosse_100x80.bmp") (nb 7) (px 0.065) (SKILLDIR nil))
let((si ofile cmd)
unless(SKILLDIR SKILLDIR=env("SKILLDIR"))
ifile=simplifyFilename(ifile)
si=parseString(ifile ".");=> ("~/groupU/me_embosse_100x80" "bmp")
ofile=buildString(append(reverse(cdr(reverse(si))) list("il")) ".")
if(isFile(ifile) then
; unset PYTHONPATH; unset PYTHONHOME;
;cmd=sprintf(nil "unset PYTHONPATH; unset PYTHONHOME; /usr/bin/python3 %s/image2layers.py %s %d %g > %s" SKILLDIR ifile nb px ofile)
cmd=sprintf(nil "unset LD_LIBRARY_PATH; /usr/bin/python3 %s/image2layers.py %s %d %g > %s" SKILLDIR ifile nb px ofile)
;cmd=sprintf(nil "python3 %s/image2layers.py %s %d %g > %s" SKILLDIR ifile nb px ofile)
printf("IF:\n=Fatal Python error: init_fs_encoding:\n THEN do manually in the shell :\n")
printf(cmd)
printf("\nBackINTO CAD, then : \nload(%L) " ofile)
(system cmd)
cmd=sprintf(nil "wc -l < %s" ofile)
(system cmd)

printf("\n%s GENERATED, now i load it for you in the active cellView\n" ofile)
load(ofile)
else
printf("%s #<= no input file?\n" ifile)
)
))

; ineed('shout t)
;shout("python -c \"import PIL\" ; echo $?")
; ret=shout("/usr/bin/python3 -c \"import PIL\" ; echo $?")

printf("NEED python and pillow library :\n")
printf("USAGE :\n")
printf("image2layers(\"~/groupU/Mi2i/pics/wharol2.bmp\" 1)\n")
printf("image2layers(\"~/PICMIC/PRESENTATION/logo_shandong.bmp\")\n")
printf("image2layers(\"~/groupU/me_embosse_100x80.bmp\")\n")
printf("image2layers(\"~/groupU/me_embosse_100x80.bmp\" 7 );<= to change default tech stack\n")
printf("image2layers(\"~/groupU/me_embosse_100x80.bmp\" 7 0.130);<= to change pixel size\n")
printf("image2layers(\"~/groupU/me_embosse_100x80.bmp\" 7 0.065 env(\"SKILLDIR\")) ;<= if the python file is here\n")
;; ~/groupU/Mi2i/WP5.1_comm/logos_MI2I/Tous_logos_png/
;;~/groupU/Mi2i/WP5.1_comm/logos_MI2I/Tous_logos_png/Signe-MI2I.png