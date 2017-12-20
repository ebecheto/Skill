pwd="/data/ebecheto/Sim/ADC_tb1/UltraSim/config/netlist/"
file="input.ckt"
myPort=infile(strcat(pwd file))
inst='()
gets(nextLine myPort)
nextLine
line=list(nextLine)
line=flatten(foreach(mapcar l line  parseString( l "\t")))
line=flatten(foreach(mapcar l line  parseString( l "\n")))
line=flatten(foreach(mapcar l line  parseString( l ";")))
line=flatten(foreach(mapcar l line  parseString( l " ")))

while(not(member("subckt" parseString( nextLine " "))) gets(nextLine myPort))

while(not(member("ends" line))
gets(nextLine myPort)
line=list(nextLine)
line=flatten(foreach(mapcar l line  parseString( l "\t")))
line=flatten(foreach(mapcar l line  parseString( l "\n")))
line=flatten(foreach(mapcar l line  parseString( l ";")))
line=flatten(foreach(mapcar l line  parseString( l " ")))
while(last(line)=='("\\")
carl=remove("\\" line)
gets(nextLine myPort)
line=list(nextLine)
line=flatten(foreach(mapcar l line  parseString( l "\t")))
line=flatten(foreach(mapcar l line  parseString( l "\n")))
line=flatten(foreach(mapcar l line  parseString( l ";")))
line=flatten(foreach(mapcar l line  parseString( l " ")))
line=append(carl line)
);; while \<= caracter
inst=append(inst list(line))
) nextLine


inst=list(car(inst))
AST='()

foreach(mapcar in inst 
name=car(in) in=cdr(in) iname='nil rest=in
io='() par=nil i=0
foreach(mapcar init in 
printf("init:%s\n" init)
pr=parseString( init "")
printf("iniL:%s\n" car(pr))
when(member("(" pr ) par='t printf("\nGO\n") )
when(iname instName=init iname='nil rest=cdr(rest))
when(par io=append(io list(init)) rest=cdr(rest))
when(member(")" pr ) par='nil iname='t printf("\nCLOSE\n"))
)
io=flatten(foreach(mapcar l io  parseString( l "(")))
io=flatten(foreach(mapcar l io  parseString( l ")")))
AST=append(AST list(name io instName rest))
)
