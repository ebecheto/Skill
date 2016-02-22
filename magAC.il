;; copyleft ebecheto

defun(magAC ()
let((textlist fp nextLine cnt)
unless(textlist=strcat(asiGetNetlistDir(asiGetCurrentSession( )) "/input.scs")
printf("reload func after doing : ADE->Result->Select Return\n"))
fp = infile(textlist)
nextLine = nil
cnt=0
while(gets(nextLine fp) 
when(rexMatchp(" mag=" nextLine)
printf("%s" nextLine ) cnt++)
)
printf("[AC] found %d AC parameters in netlist %s\n" cnt textlist)
))

printf("magAC();<= tell ne source that have ac parameter enable\n")