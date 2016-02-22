;; copyleft ebecheto

; load "~/../ebecheto/Skill/ocnPrint2list.il"
(defun flatten (list) (cond 
((null list) list) ((null (car list)) (flatten (cdr list))) ((atom (car list)) (cons (car list) (flatten (cdr list)))) (t (append (flatten (car list)) (flatten (cdr list))))))

defun(ocnPrint2 (data @optional nb) let((file OUT)
file=strcat(pwd() "/" "tata.tmp")
system(strcat("rm -f " file))
ocnPrint(data ?output file ?format "engineering")
OUT=ocnPrint2list(file)
when(numberp(nb) OUT=foreach(mapcar c OUT nth(nb c)))
OUT))

defun(ocnPrint3 (data @optional file)
unless(file file=strcat(pwd() "/" "tata.tmp"))
system(strcat("rm -f " file))
ocnPrint(data ?output file ?format "engineering")
ocnPrint2list(file)
)


defun(ocnPrint3 (wave)
; voir a faire une recursion sur type(y)=='symbol pour les params de params de ...
y=drGetWaveformYVec(wave)
x=drGetWaveformXVec(wave)
len=drVectorLength(y)
ys=foreach(mapcar i linRg(0 len-1 1) drGetElem(y i)) ;=>(7.45547e-08)
xs=foreach(mapcar i linRg(0 len-1 1) drGetElem(x i)) ;=>(7.45547e-08)
mapcar('list xs ys)
)

;; wave=caar(invbufL);=>defined symbol Like= tdi_L
;; lfile=ocnPrint3(eval(wave) sprintf(nil "%s_%s.wave" pwd() wave) )
;; set(concat('backup_ wave) list2wave(lfile))
;; ;=> backup_tdi_L=srrWave:0x2033f1c0

defun(saveRowColWaves (@optional (invbufL invbufL)(pwd pwd()) (verb t)) let((file)
foreach(mapcar row invbufL
foreach(mapcar wave row
file=sprintf(nil "%s/%s.wave" pwd wave)
when(verb printf("Saving curv:%s in file :%s\n" wave file))
ocnPrint3(eval(wave)  file)
))))
;saveRowColWaves()

defun(recallRowColWaves (@optional (tdib '(tdi_ tdb_)) (elist '("L" "1" "2" "3" "4" "6" "8")) (verb t)) let((file ibL)
ibL=foreach(mapcar e elist 
foreach(mapcar td tdib
file=sprintf(nil "%s/%s%s.wave" pwd() td e)
lfile=ocnPrint2list(file)
set(concat(td e) list2wave(lfile))
concat(td e)
))
set('invbufL ibL)
))

; invbufL='unbound
; recallRowColWaves();=> invbufL=((tdi_L tdb_L) ...)

procedure(ocnPrint2list(file @optional (num t) (verb nil))
let((OUT line nextLine OUTcadr)
when(verb printf("Opening %L\n" file))
myPort=infile(file)
OUT='()
; OUTcadr='()
; while(not(member("subckt" parseString( nextLine " "))) gets(nextLine myPort))
while(gets(nextLine myPort)
; OUTcadr=append(OUTcadr simStringsToList(nextLine))
; printf("Reading %LEOF\n" nextLine)
line=list(nextLine)
l=line
line=flatten(foreach(mapcar l line  parseString( l "\t")))
line=flatten(foreach(mapcar l line  parseString( l "\n")))
line=flatten(foreach(mapcar l line  parseString( l ";")))
line=flatten(foreach(mapcar l line  parseString( l " ")))
line=foreach(mapcar l line if(aelNumber(l) aelNumber(l) l))
while(last(line)=='("\\")
carl=remove("\\" line)
gets(nextLine myPort)
line=list(nextLine)
line=flatten(foreach(mapcar l line  parseString( l "\t")))
line=flatten(foreach(mapcar l line  parseString( l "\n")))
line=flatten(foreach(mapcar l line  parseString( l ";")))
line=flatten(foreach(mapcar l line  parseString( l " ")))
line=foreach(mapcar l line if(aelNumber(l) aelNumber(l) l))
line=append(carl line)
);; while \<= caracter
;printf("Reading %LEOF\n" line)
when(line
when(num&&numberp(car(line))
when(verb printf("Append %L\n" line))
OUT=append(OUT list(line))
))) close(myPort) ;list(OUT OUTcadr)
OUT ))
;; file=sprintf(nil "%s/%s" pwd() "comparatorIN.txt")
;; lfile=ocnPrint2list(file)
printf("     (ocnPrint      strcat(pwd() \"comparatorIN.txt\"))\n")
printf("lfile=ocnPrint2list(strcat(pwd() \"comparatorIN.txt\"))\n")


defun( list2wave (lfile) let((maxn X Y) 
maxn=length(lfile)
X=drCreateVec('double maxn-1)
Y=drCreateVec('double maxn-1) for( i 0 maxn-1
drSetElem(X i  car(nth(i lfile)))
drSetElem(Y i cadr(nth(i lfile))))
drCreateWaveform(X Y) ))


defun( plotList (lfile @optional (name "plotList")) plot(list2wave(lfile) ?expr list(name)))


defun( checkCounter (@optional (VTname "OUT_1_") (MIN 1) (MAX 40) (Vth 1.65) (verb nil))
file=strcat(pwd() "/tmp.txt")
for(i MIN MAX
net=sprintf(nil "%s%d" VTname i)
wave=value(VT(net) 2.5n  ?period 10n ?xName "time")
ocnPrint(wave ?output file ?format "engineering")
lfile=ocnPrint2list(file)
set(concat('data_ i) lfile) when(verb printf("Define data_%d\n"  i))
)
for(i 0 length(data_1)-1 set(concat('xy_ i) '())) ;=> xy_1=xy2...=nil ;<= definition a zero des listes
;double for loop
for(data MIN MAX for(i 0 length(data_1)-1
when(verb printf("xy_%2d data_%2d\n" i data))
xy=nth(i symeval(concat('data_ data)));=>ie xy=(2.25e-08 3.3)
set(concat('xy_ i) append(symeval(concat('xy_ i)) last(xy)));;xy_1=append(xy_1 (3.3))
))
resList=foreach(mapcar i linRg(0 length(data_1)-1 1) val=0
yVal=nth(val symeval(concat('xy_ i)))
while(yVal&&yVal>=Vth val++ yVal=nth(val symeval(concat('xy_ i)))) resOK=val
while(yVal&&yVal<=Vth val++ yVal=nth(val symeval(concat('xy_ i)))) isCNTok=val
list(car(nth(i data_1)) if(isCNTok resOK -1)) ; construit la list (x y) ; si erreur on evoie -1, ca sera facile a voir sur un graph
)) ; list2wave(checkCounter())
printf("checkCounter(VTname MIN MAX Vth verb)\n")
printf("list2wave(checkCounter(\"O_\"))\n")
printf("list2wave(checkCounter(\"OUT_\" 1 20))\n")

printf("file=strcat(pwd() \"/\" \"ENC500fF.data\")\n")
printf("ocnPrint(ENC_PA4 ?output file ?format \"engineering\")\n")
printf("listIn=ocnPrint2list(file)\n")
printf("plot(list2wave(listIn))\n")




;; out = outfile(fname=sprintf(nil "%s/%s" pwd() "linFit.gp"))
;; dname=sprintf(nil "%s/%s" pwd() "data.dat")
;; ocnPrint(ENC3 ?output dname ?format "engineering")

;; fprintf(myPort "f(x) = a*x + b")
;; fprintf(myPort "fit f(x) '%s' u 1:2  via a, b" dat)
;; close(out)

;; (system sprintf(nil "gnuplot < %s" fname))
