;; load "emacsIpc.il"
procedure(socketHandler(ipcId data)
let((nextLine inPort)
  when(inPort
    while(gets(nextLine inPort) 
        print(evalstring(nextLine))
    )
    close(inPort)))) ipcBeginProcess("emacs ~/../ebecheto/Skill/my-log.txt" "" 'socketHandler)
printf("Try something like :\n\t\tControl-c-v")



;; load "test.il" ;; in ICFB
procedure(socketHandler(ipcId data)
let((data)
  printf("COMMAND: %L\n" data)
  evalstring(data)
  printf("\n")
))
ipcBeginProcess("emacs" "" 'socketHandler)

;; load "emacsIpc.il"
procedure(socketHandler(ipcId data)
let((nextLine inPort)
inPort=infile(data)
  when(inPort
    while(gets(nextLine inPort)
        print(eval(nextLine))
    );while
  );when
 close(inPort)
);let
);proc
ipcBeginProcess("emacs ~/../ebecheto/Skill/my-log.txt" "" 'socketHandler)


(send-string-to-terminal "load(\"~/.emacs2icfb.line.il\")")
;; load "test.il" ;; in ICFB
procedure(socketHandler(ipcId data)
  printf("COMMAND: %L\n" data)
  evalstring(data)
  printf("\n")
)
ipcBeginProcess("emacs" "" 'socketHandler)

(send-string-to-terminal "~/.emacs2icfb.line.il")
;; load "test.il" ;; in ICFB
procedure(socketHandler(ipcId data)
let((inPort nextline)
inPort=infile(data)   printf("EMA $>: %L\n" data)
  when(inPort
    while(gets(nextLine inPort) return(print(evalstring(nextLine))))
  )
  close(inPort)
))
ipcBeginProcess("emacs" "" 'socketHandler)
;; ^^^ work correctly almost

(send-string-to-terminal "~/.emacs2icfb.line.il")
;; load "test.il" ;; in ICFB
procedure(socketHandler(ipcId data)
let((inPort nextline)
inPort=infile(data) 
  when(inPort while(gets(nextLine inPort) printf("\n%s \n" nextLine)))  close(inPort)
inPort=infile(data) 
  when(inPort while(gets(nextLine inPort) return(print(evalstring(nextLine))))  )   close(inPort)
return(printf("%s\n" ""))
))
ipcBeginProcess("emacs ~/../ebecheto/Skill/my-log.txt" "" 'socketHandler)

printf("%s\n" "")
