;; copyleft ebecheto
;; Needs ~/.emacs.d/skillMode.el to work with

defun( socketHandlerIPC (ipcId data)
let((fp res inPort)
(errset eval(t))
; printf("RCV:%L\n" data)
; res=load("~/.emacs2icfb.il")
cond(
(;;;; Case C-c-f : load file where the region text was copied
rexMatchp("load" data) 
unless(errset(res=load("~/.emacs2icfb.il")  nil)
fprintf(fep=outfile("~/.virtuoso2error.txt") "%L" errset.errset) close(fep)
error(car(parseString(nth(5 errset.errset)  "*Error* "))
)))
(;;; case C-c-r
rexMatchp("region" data) 
printf("EXECUTE REGION\n")
res="NOT YET while readline remove command, change \\n into space etc...==> prefer C-c-f"
)
(t ;default
;;; case C-c-v  eval line
inPort=infile("~/.emacs2icfb.il")
when(inPort while(gets(nextLine inPort) unless((or nextLine=="\n" rexMatchp("^ *;" nextLine) )
;removing comment " *;" is not necessary, was only to check warning parenthesis mistake
; removing \n is to prevent last res=t ...
res=evalstring(nextLine))))  close(inPort)
));end cond parse data
printf("\nEMACS>");<== can be commented/removed
printf("%L\n" res)
fprintf(fp=outfile("~/.virtuoso2emacs.txt") "%L" res) close(fp) ;=> saves resutls in a file for emacs to fetch it if you want
sh("rm -f ~/.emacs2icfb.il");<== prevent loop ?
))

sh("rm -f ~/.emacs2icfb.il");<== prevent loop ?

ipcBeginProcess(strcat(getShellEnvVar("SKILLDIR") "/" "ipcPipe2CAT.sh") "" 'socketHandlerIPC)

printf("Try something like :\t\tControl-c-v\n")
printf("get result back with :\t\tControl-c-s\n")
printf("send region with :\t\tControl-c-r\n")
printf("force load  with :\t\tControl-c-f;<== when WARNING : too few right parentheses, ')' mayby because of unmatch simple quote ' in comments. Wierd\n")
;cid = ipcBeginProcess("hostname" "" (lambda (cid data) printf("\n Hostname:%s\n" data)))
; ipcBeginProcess("emacs" "" (lambda (cid data) evalstring(data)))
;;; if it loops
; $> rm /tmp/ipcPipe2CAT_$USER
; $> rm ~/.emacs2icfb.il
; CIW> ipcKillAllProcesses( )