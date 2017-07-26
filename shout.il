;; copyleft ebecheto

defun( shout (command @optional (rmNL nil) (verb t) )
(let (ipcId ret) ;// not to use with complex shell command , no time stamp specified
ipcId=ipcBeginProcess(command)
ipcWaitForProcess(ipcId)
ret=ipcReadProcess(ipcId 30) ;=>"now you see it..."
when(verb printf("SHELL>%s" ret))
when(rmNL rexCompile("\n") ret=rexReplace( ret "" 1));<== bad idea if multiline answer...
ret
))

printf("shout(\"hostname\")\n")
printf("ret=shout(\"ls *.log\")\n")
printf("ret=shout(\"env\")\n")
printf("ret=shout(\"echo $SHELL\")\n")
printf("ret=shout(\"spectre -help bsim3v3\")\n")
printf("ret=shout(\"cds_root virtuoso\")\n")
;printf("ret=shout(\"echo `date +'_%Hh%M_%F'`\")\n")
printf("ret=shout(\"echo `date +'%%F_%%Hh%%M_'`\")\n")
;printf("ret=shout(\"echo `date +F`TATA\")\n")
