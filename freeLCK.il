;; copyleft ebecheto

; load("freeLCK.il")

unless(fboundp('freeLCK)
defun( freeLCK (@optional (cv geGetWindowCellView())) let((ret path cmd)
; printf("NAME%L: %L\n" cv~>libName geGetWindowCellView()~>??)
;; path=strcat("/" buildString(reverse(cdr(reverse(parseString( car(ddGetObj(cv~>libName)~>files~>readPath) "/")))) "/"))
path=strcat("/" buildString(reverse(cdr(reverse(parseString( cv~>fileName "/")))) "/"))
; => "/home/validmgr/ebecheto/Work/IC6/T2K_V5" alors que dans le cds.lib c'est definit comme :  ./T2K_V5
;; cmd=strcat("rm " path "/" cv~>cellName  "/" cv~>viewName "/*cdslck*")
cmd=strcat("rm " path  "/*cdslck*")
ret=system(cmd)
; => si renvoie 0 => ca a suprimé des truc
; => si renvoie 1 => il n'y a plus rien a supprimer
if(ret printf("Nothing removed from %s\n" cmd) printf("Someting removed from %s\n" cmd))
))
)

freeLCK()
_leChangeEditMode("a")