;; copyleft : ebecheto

ineed(list('ocnPrint2list 'getHierName))

defun(sortOPpattern (@optional  (pattern "^c") (instName nil)(i 0))
let((alist clist ca sca out op)
unless(instName instName=strcat("/" getHierName(t "/") css()~>baseName))
unless(css() printf("Click on a instances\n"))
printf("Getting %s of %s\n" pattern instName)
unless(op=OP(instName "??") printf("Maybe %s is somesing with <>. So try : \nsortOPpattern(%L \"%s<0>\")\n" instName pattern instName))
alist=ocnPrint3(op)
rexCompile(pattern)
clist=setof(a alist rexExecute(car(a)))
ca=foreach(mapcar c clist list(abs(cadr(c)) car(c)))
sca=sortcar(ca 'lessp);=> does not create a new list. Altered the input list
if(i!=0 
out=reverse(nthcdr(i sca))
out=reverse(sca)
)
foreach(mapcar o out printf("%s\t=%s\n" cadr(o) aelSuffixNotation(car(o))))
out))

printf("sortOPpattern(\"^c\" \"/MP13\");<=defauld mode : Operating Point capa \n")
printf("sortOPpattern(\"^c\" \"/MP13\" 10);<= 10 first print of MP13 OP capa\n")
printf("sortOPpattern(\"^c\" nil 10) t ;<== print the 10 first OP capa of the selected instance\n")
