;; copyleft ebecheto
;; Needs ~/.emacs.d/skillMode.el to work with

defun( socketHandler (ipcId data)
let((fp res inPort)
(errset eval(t))
; printf("RCV:%L\n" data)
; res=load("~/.emacs2icfb.il")
if(rexMatchp("load" data) then 
unless(errset(res=load("~/.emacs2icfb.il")  nil)
error(car(parseString(nth(5 errset.errset)  "*Error* "))
))
else
inPort=infile("~/.emacs2icfb.il")
when(inPort while(gets(nextLine inPort) unless((or nextLine=="\n" rexMatchp("^ *;" nextLine) )
;removing comment " *;" is not necessary, was only to check warning parenthesis mistake
; removing \n is to prevent last res=t ...
res=evalstring(nextLine))))  close(inPort)
)
printf("\nEMACS>");<== can be commented/removed
printf("%L\n" res)
fprintf(fp=outfile("~/.virtuoso2emacs.txt") "%L" res) close(fp) ;=> saves resutls in a file for emacs to fetch it if you want
))

ipcBeginProcess(strcat(getShellEnvVar("SKILLDIR") "/ipcPipe2CAT.sh") "" 'socketHandler)

printf("Try something like :\t\tControl-c-v\n")
printf("get result back with :\t\tControl-c-s\n")
printf("send region with :\t\tControl-c-r\n")
printf("force load  with :\t\tControl-c-f;<== when WARNING : too few right parentheses, ')'\n")
;cid = ipcBeginProcess("hostname" "" (lambda (cid data) printf("\n Hostname:%s\n" data)))
; ipcBeginProcess("emacs" "" (lambda (cid data) evalstring(data)))
