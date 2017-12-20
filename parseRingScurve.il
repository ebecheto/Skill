;; ; edit("/home/validmgr/ebecheto/group/Asic/HSL/Test_HSL_HM/ADC_1Mhz_3MSB_finestep500n.csv")

;; pwd="/home/validmgr/ebecheto/group/Asic/HSL/Test_HSL_HM/"
;; file="ADC_1Mhz_3MSB_finestep500n.csv"
;; Scurve(file pwd 2)

;; pwd=pwd()
;; I1=VAR("I1")   I1s=aelSuffixNotation(I1)
;; I2=VAR("I2")   I2s=aelSuffixNotation(I2)
;; file=  sprintf(nil "./ADC_OUTd_%s-%s.txt" I1s I2s)
;; Scurve(file)

(defun flatten (list) (cond 
((null list) list) ((null (car list)) (flatten (cdr list))) ((atom (car list)) (cons (car list) (flatten (cdr list)))) (t (append (flatten (car list)) (flatten (cdr list))))))

procedure(Scurve(file @optional (pwd pwd()) (skip 0))
let( (myport i i1 i2 i3 L1 L2 after ring pos oldLine line nextLine pf ck_ring ring jump cmd)
myPort=infile(sprintf(nil "%s/%s" pwd file)) 
;; gets(nextLine myPort) ;dont take first
i=0 i1=0 i2=0 i3=0
L1='() L2='() after=nil ring=nil jump='()
;i1=evalstring(nth(0 line)) 
i2=i1+1 i3=i1+2
psf=car(parseString(car(last(parseString(file "_"))) ".")) printf("psf : %s\n" psf)
(while skip>0 gets(nextLine myPort) skip--)
;; ;; line=remove("\n" simStringsToList(nextLine))
;; ;; line=parseString( line "\n") 
;; ;; line=parseString(car(parseString(nextLine "\n")) ";")
;; line=list(nextLine)
;; line=flatten(foreach(mapcar l line  parseString( l "\t")))
;; line=flatten(foreach(mapcar l line  parseString( l "\n")))
;; line=flatten(foreach(mapcar l line  parseString( l ";")))
;; line=flatten(foreach(mapcar l line  parseString( l " ")))
;pos=0
pos=1
while(gets(nextLine myPort) i++
; printf("Read %s" nextLine)
oldLine=line
line=list(nextLine)
line=flatten(foreach(mapcar l line  parseString( l "\t")))
line=flatten(foreach(mapcar l line  parseString( l "\n")))
line=flatten(foreach(mapcar l line  parseString( l ";")))
line=flatten(foreach(mapcar l line  parseString( l " ")))
;line=parseString(car(parseString(nextLine "\n")) ";")
ck_ring=ring
; printf("I123=%L. Read %d\n" list(i i1 i2 i3) evalstring(nth(0 line)))
when(evalstring(nth(pos line))==i2||ring ring=t L1=append(L1 list(line))
; printf("Into ring %L at %4d : %d%d%d:line %L\n" list(ck_ring ring) i i1 i2 i3 line)
)
; when(ck_ring!=ring printf("Changing ring %L at %4d : %d%d%d\n" list(ck_ring ring) i i1 i2 i3))
when(not(ring) L1=list(line))
when(after after=nil L2=L1 )
when(evalstring(nth(pos line))==i1 after=t)
when(evalstring(nth(pos line))>=i3 ring=t L1=list(oldLine line)
when(evalstring(nth(pos line))>i3 printf("Jumps %3d %3s:\t%d\n" i2 nth(pos line) length(L2)) jump=append(jump list(list(i2 evalstring(nth(pos line)))))
; printf("L1=%L\nL2=%L\n" L1 L2)
; L2=L1
)
pf = outfile(sprintf(nil "%s/curve_%d_%d_%s.txt" pwd() i1 i2 psf))
when(length(L2)>2 foreach(mapcar ligne L2 string2print=apply('strcat foreach(mapcar elt ligne strcat(elt ";"))  )
fprintf(pf "%s\n" string2print)))
printf("Error %3d %3d:\t%d\n" i1 i2 if(L2 length(L2)-2 0)) L2='()
close(pf)
i1++ i2++ i3++);when last
);end while
pf = outfile(sprintf(nil "%s/curve_%d_%d_%s.txt" pwd() i1 i2 psf))
foreach(mapcar ligne L2 string2print=apply('strcat foreach(mapcar elt ligne strcat(elt ";"))  )
fprintf(pf "%s\n" string2print))
printf("Error %3d %3d:\t%d\n" i1 i2 if(L2 length(L2)-2 0)) L2='()
close(pf)
cmd=""
foreach(mapcar j jump up=cadr(j) while(up>car(j) cond(
(up==car(j)+1 cmd=sprintf(nil "%s\nmv %s/curve_%d_%d_%s.txt  %s/curve_%d_%d_%s.txt \n" cmd pwd up-1 up psf pwd car(j) cadr(j) psf) up--)
('t cmd=sprintf(nil "%s\nrm %s/curve_%d_%d_%s.txt \n" cmd pwd up-1 up psf) up--)
)))
printf("%s" cmd) system( cmd)
jump))

;; csv=foreach(mapcar elt line strcat(elt ";"))
;; apply('strcat csv)


