ocnPrint(VT("/OUT_1") ?output strcat(pwd() "/tata.txt") ?from 0 ?to 10u ?format "engineering" ?step 10n)
ocnPrint(VT("/I0/PA1") ?output strcat(pwd() "/PA1.txt") ?from 0 ?to 10u ?format "engineering" ?step 10n)
paramLine2Row("PA1.txt")

paramTrans2Row("PA1.txt")

paramLine2Row()

defun( paramLine2Row ( @optional (file "tata.txt") (pwd pwd()) )
let( (a myPort nextLine dataName hach hachN key keyH Ydat) 
a=0 dataName=nil
hach=nil params=nil hachN=1 
when(inportp(myPort) close(myPort) )
myPort=infile(sprintf(nil "%s/%s" pwd() file));read a first time for size colum

while(
gets(nextLine myPort)  sn=simStringsToList(nextLine)
cond(
(nextLine=="\n" t);on ne traite pas les lignes vides
(member("#" sn) a=a+1 ); on ne traite pas les comments
(not(dataName)|| dataName==nth(2 sn) dataName=nth(2 sn)); au premiers time (suppose transient)
("="==cadr(sn) key=nth(2 sn)
if(or(not(member(car(sn) params))&&params hach==nil car(sn)==car(hach)) then ;ie nth(0 sn)=temp
keyH=key
cond(
( hach==nil hach=list(nth(0 sn) list(keyH hachN++)) 
when(inportp(outF ) close(outF)) outF=outfile(sprintf(nil "%s/file_%s_%s.dat" pwd() car(hach) keyH)))
( assoc(keyH cdr(hach)) t); nothing to do
( nth(0 sn)==car(hach) hach=append(hach list(list(keyH hachN++) ))
when(inportp(outF ) close(outF)) outF=outfile(sprintf(nil "%s/file_%s_%s.dat" pwd() car(hach) keyH)))
( t printf("GRAB = equal with no key while not a param and hach not nil:%L\n" nextLine))
) ; end cond
else ; ie nth(0 sn)=tp key=10e-9
Ydat=key when(outportp(outF) fprintf(outF "\n"))
)
); end =
(t  ;default = 
line=sn
when(outportp(outF) fprintf(outF "%s %s %s \n" car(line) Ydat nth(1 line)))
)
)
); while
close(myPort)
close(outF)
foreach(f cdr(hach)
printf("edit(\"%s\")\n" sprintf(nil "%s/file_%s_%s.dat" pwd() car(hach) car(f)))
)
foreach(f cdr(hach)
printf("splot '%s'\n" sprintf(nil "%s/file_%s_%s.dat" pwd() car(hach) car(f)))
)
))

; (setq file "tata.txt")

defun( paramTrans2Row ( @optional (file "tata.txt") (pwd pwd()) )
let( (a myPort nextLine dataName hach hachN key keyH Ydat outF) 
a=0 dataName=nil outF=nil
hach=nil params=nil hachN=1 Xlist=nil Zlist=nil
when(inportp(myPort) close(myPort) )
myPort=infile(sprintf(nil "%s/%s" pwd() file));read a first time for size colum

while(
gets(nextLine myPort)  sn=remove("\n" simStringsToList(nextLine))
cond(
(nextLine=="\n" t);on ne traite pas les lignes vides
(member("#" sn) a=a+1 ); on ne traite pas les comments
(not(dataName)|| dataName==nth(2 sn) dataName=nth(2 sn)
when(Xlist transposeArray2GP() Xlist=nil Zlist=nil)
); au premiers time (suppose transient)
("="==cadr(sn) key=nth(2 sn)
if(or(not(member(car(sn) params))&&params hach==nil car(sn)==car(hach)) then ;ie nth(0 sn)=temp
keyH=key
cond(
( hach==nil hach=list(nth(0 sn) list(keyH hachN++)) 
when(inportp(outF ) close(outF)) outF=outfile(sprintf(nil "%s/file_%s_%s.dat" pwd() car(hach) keyH)))
( assoc(keyH cdr(hach)) t); nothing to do
( nth(0 sn)==car(hach) hach=append(hach list(list(keyH hachN++) ))
when(inportp(outF ) close(outF)) outF=outfile(sprintf(nil "%s/file_%s_%s.dat" pwd() car(hach) keyH)))
( t printf("GRAB= equal with no key while not a param and hach not nil:%L\n" nextLine))
) ; end cond
else printf("not more equal was expeced.!!*@$\n")))
(not(params)  params=list(car(sn) cdr(sn)))
(member(car(sn) params) when(cadr(params)!=cdr(sn) printf("WARNING no fitted data\n")))
(t ;default case
Xlist=append(Xlist list(car(sn))) Zlist=append(Zlist list(cdr(sn)))
)
)
);end while
when(Xlist transposeArray2GP() Xlist=nil Zlist=nil) 
when(inportp(myPort) close(myPort) )
));end let defun

cXlist=Xlist
cYlist=Ylist

defun( transposeArray2GP ( @optional (Xlist Xlist) (Ylist cadr(params)) (Zlist Zlist) )
;printf("Transpose :\n%L\n%L\n%L\n" Xlist Ylist Zlist)
printf("Transpose :\n%L\n%L\n%L\n" length(Xlist) length(Ylist) length(Zlist))
trZlist=transpose(Zlist)
Ylist=cadr(params) Yc=Ylist t
aa=foreach(mapcar tr trZlist
Xc=Xlist Y=car(Yc) Yc=cdr(Yc)
foreach(mapcar zij tr X=car(Xc) Xc=cdr(Xc) list(X Y zij)))

foreach(b aa foreach(a b
fprintf(outF "%s %s %s\n" car(a) cadr(a) caddr(a)) ) fprintf(outF "\n"))
; close(outF)
; outF=outfile(sprintf(nil "%s/file_%s_%s.dat" pwd() car(hach) keyH))
)

; from :http://cybertiggyr.com/lid/ (defun transpose (x)   (apply #'mapcar (cons #'list x)))
(defun transpose (x)(apply 'mapcar (cons 'list x)))

;; Ylist=cadr(params) Yc=Ylist t
;; bb=foreach(mapcan tr trZlist
;; Xc=Xlist
;; Y=car(Yc) Yc=cdr(Yc)
;; foreach(mapcar zij tr 
;; X=car(Xc) Xc=cdr(Xc)
;; list(X Y zij)))
