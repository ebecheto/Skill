file="/home/validmgr/ebecheto/group/techno/ibm/doc/xor2_delay.txt"
pf=infile(file)
xlist='()


while(gets(line pf)&&line!="\n"


cell=car(parseString(line "\n"))

gets(line pf)
rexCompile("Cload")
s=rexReplace(line " " -1)
tmp1=remove("+" remove(" " remove("\n" parseString(s " "))))
gets(line pf)
rexCompile("Cload")
s=rexReplace(line " " -1)
tmp2=remove("+" remove(" " remove("\n" parseString(s " "))))
xlist=append(xlist list(list(cell tmp1 tmp2)))
gets(line pf)
gets(line pf)
;dump B
)

close(pf)

length(xlist)

cap='(("A" 2)("B" 3)("C" 4)("D" 1)("E" 4)("F" 4)("H" 4)("I" 6)("J" 7))


xslist=foreach(mapcar x xlist list(car(x) nth(1 x) nth(2 x) cadr(assoc(car(x) cap))))



linRg(1 3 1)

linRg(0 0 1)

