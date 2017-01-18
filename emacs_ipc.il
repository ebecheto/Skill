;; copyleft ebecheto

;; Needs ~/.emacs.d/skillMode.el to work with
procedure(socketHandler(ipcId data)
let((inPort nextline tmp toto fp res)
if(not(rexMatchp("load(" data)) then
inPort=infile(data) ; once for printing
  when(inPort while(gets(nextLine inPort) printf("\n%s \n" nextLine)))  close(inPort)
inPort=infile(data) ; once for evaluating
;  when(inPort while(gets(nextLine inPort) return(print(evalstring(nextLine))))  )   close(inPort) ;<= return only within a prog
  when(inPort while(gets(nextLine inPort) print(res=evalstring(nextLine)))  )   close(inPort)
fprintf(fp=outfile("~/.virtuoso2emacs.txt") "%L" res) close(fp)
;;return(printf("%s\n" ""))
;; load("~/.emacs2icfb.newline.il") printf("OLDLINE")
else 
printf("LOAD a FILE\n")
res=evalstring(data) t;<== RUN IT !
;ipcWriteProcess(ipcData res);<= does it gives back to emacs the results that can be wrap by the message function ?
fprintf(fp=outfile("~/.virtuoso2emacs.txt") "%L" res) close(fp)
printf("\n")
;; printf("\n%s\n" data)
;; edit(data)
;; tmp=simStringsToList(data)
;; parseString(data "\"")

;edit(cadr(parseString(data "\"")))

;; printf("PAR%LSED? :" tmp)
;; ;; tmp=sprintf(nil "%s" data)
;; toto=parseString(tmp "(")
;; printf("TOTO?%LPARSED\n" toto)
;; printf("PRINTF:%sPRINTED\n" data)
; eval(t)
)
))
; ipcBeginProcess("emacs ~/../ebecheto/Skill/my-log.txt" "" 'socketHandler)

; ipcBeginProcess(\"emacs ~/../ebecheto/Skill/my-log.txt\" \"\" 'socketHandler) printf(\"Try something like :\\n\\t\\tControl-c-v\")"

ipcBeginProcess(\"emacs ~/../ebecheto/Skill/my-log.txt\" \"\" 'socketHandler) 
printf("Try something like :\\n\\t\\tControl-c-v")
printf("get the result back with :\\n\\t\\tControl-c-s")
printf("send region with :\\n\\t\\tControl-c-r")
