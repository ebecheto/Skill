;; copyleft ebecheto

;; Needs ~/.emacs.d/skillMode.el to work with
procedure(socketHandler(ipcId data)
let((fp res)
; printf("RCV:%L\n" data)
; res=load("~/.emacs2icfb.region.il")
inPort=infile("~/.emacs2icfb.il")
when(inPort while(gets(nextLine inPort) print(res=evalstring(nextLine)))  )   close(inPort)
;printf("LOADED\n")
; res=(errset evalstring(data));<== it RUNs IT in Cadence virtuoso!
printf("\nRES=%s\n" res)
fprintf(fp=outfile("~/.virtuoso2emacs.txt") "%L" res) close(fp) ;=> saves resutls in a file for emacs to fetch it if you want
;printf("\n")
))

; ie. ipcBeginProcess("emacs ~/../ebecheto/Skill/my-log.txt" "" 'socketHandler)

; i6=ipcBeginProcess("/tmp/ipcPipe2CAD_ebecheto" "" 'socketHandler);<= not working, no while read !!
; vv should work vv
; i5=ipcBeginProcess("~/../ebecheto/Skill/ipcPipe2CAD.sh" "" 'socketHandler)
; i2=ipcBeginProcess("xargs < ~/../ebecheto/Skill/ipcPipe2CAD.sh" "" 'socketHandler)   ; ;<== fail its like a read

; i3=ipcBeginProcess("xargs < /tmp/ipcPipe2CAD_ebecheto" "" 'socketHandler)
; i2=ipcBeginProcess("cat < /tmp/ipcPipe2CAD_ebecheto" "" 'socketHandler)
;i2=ipcBeginProcess("~/../ebecheto/Skill/ipcPipe2CAD.sh" "" 'socketHandler)
;sh("ls -l /dev/fd/")
; ipcCloseProcess(i2) 
; ipcCloseProcess(i5) 
; ipcCloseProcess(i6) 
;  ipcReadProcess(i2)
;  ipcReadProcess(i5)
; sh("~/../ebecheto/Skill/ipcPipe2CAD.sh&")
; ipcBeginProcess("/tmp/ipcPipe2CAD_ebecheto" "" 'socketHandler)
; ipcBeginProcess("xargs < /tmp/ipcPipe2CAD_ebecheto" "" 'socketHandler)
; echo "print 3"> /tmp/ipcPipe2CAD_ebecheto
; echo "print 3"> /tmp/ipcPipe2CAD
; sh("cat </tmp/ipcPipe2CAD&")

