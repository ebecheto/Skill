;; copyleft ebecheto

; load("gnuplotVT.il")

; see also paramLine2row.il
defun( fileArrayToRow ( @optional (file "data_I_W.L.txt") (pwd pwd()) (check t))
let( (a myPort nextLine a xName yName zName secondRow xVals nbCol filename data yVal zVals header info OUT cmd OUTs OUT3 row setNo )
a=0 OUTs='() OUT3='() setNo=t
myPort=infile(sprintf(nil "%s/%s" pwd() file));read a first time for size colum
printf("fileArrayToRow%L\nmyPort:\n%s\n" file myPort)
while(gets(nextLine myPort) when(member("#" simStringsToList(nextLine)) a=a+1 
;; printf("%2d _ Get # in : %L\n" a simStringsToList(nextLine))
) 
when(rexMatchp("# Set No." nextLine)  setNo=nil )
)
close(myPort)
printf("DOING %L\n" list(file check a myPort))
;if(check&&a==2 then ;)
if(a==2 then 
printf("***\nGOINGTHROUGH two? %3d variable FILE\n***\n" a)
myPort = infile(sprintf(nil "%s/%s" pwd() file))
nextLine = nil
gets(nextLine myPort);empty
gets(nextLine myPort);first row ie: "#" "vdd"               "(IS(\"/MN0/D\")" ...
yName=nth(1 simStringsToList(nextLine))
zName=nth(2 simStringsToList(nextLine))
gets(nextLine myPort);empty
gets(nextLine myPort);second row ie: "#" "vgg" "0" "825e-3" "1.65" "2.475" "3.3" "\n"
secondRow=remove("#" remove("\n" simStringsToList(nextLine)))
xName=car(secondRow)
xVals=cdr(secondRow)
nbCol=length(xVals)
filename="split_"
for(i 0 nbCol-1 
outFile=sprintf(nil "%s/%s%d" pwd() filename i)
;  printf("writing/%s\n" outFile)
set(concat("pfile_" i) outfile(sprintf(nil "%s/%s%d" pwd() filename i))) )
;; gets(nextLine myPort)
;; gets(nextLine myPort)
while(gets(nextLine myPort) while(nextLine=="\n" gets(nextLine myPort) )
data=remove("\n" simStringsToList(nextLine))
yVal=car(data) zVals=cdr(data)
for(i 0 length(zVals)-1
;printf( "Print2%s %s\t%s\t%s\n" sprintf(nil "%s%d" filename i) nth(i xVals) yVal nth(i zVals))
fprintf(eval(concat("pfile_" i)) "%s\t%s\t%s\n" nth(i xVals) yVal nth(i zVals))
));end while
for(i 0 nbCol-1 close(eval(concat("pfile_" i)))) ; close(pfile)
header="# X\tY\tZ" cmd=""
info=sprintf(nil "# %s\t%s\t%s\t" xName yName zName)
OUT=sprintf(nil "DONE_%s" file)
cmd=sprintf(nil "%s\n echo -e %L > %s" cmd header OUT)
cmd=sprintf(nil "%s\n echo -e %L >> %s" cmd info OUT)
for(i 0 nbCol-1 cmd=sprintf(nil "%s\n cat %s%d >> %s\n echo  >> %s " cmd filename i OUT OUT) )
for(i 0 nbCol-1 cmd=sprintf(nil "%s\n rm -f %s/%s%d" cmd pwd() filename i) )
printf("edit(\"%s/%s\")\n" pwd() OUT) (system cmd) OUT
else if(a>=3&&setNo then
printf("***\nGOINGTHROUGH >= three? %3d variable FILE\n***\n" a)
;HERE!

myPort = infile(sprintf(nil "%s/%s" pwd() file))
gets(nextLine myPort)  while(nextLine=="\n" gets(nextLine myPort) )
row=remove("#" remove("\n" simStringsToList(nextLine)))
yName=car(row) zName=cadr(row) printf("yName:%s zName:%s\n" yName zName||"")
gets(nextLine myPort) while(nextLine=="\n" gets(nextLine myPort) )
row=remove("#" remove("\n" simStringsToList(nextLine)))
xName=car(row) xVal=nth(2 row) ; ("vgg" "=" "0")
; nbCol=length(xVals)
gets(nextLine myPort) row=remove("#" remove("\n" simStringsToList(nextLine))) ;; TODO, check \ before \n => continue next line...!
wName=car(row)
wVals=cdr(row)
nbCol=length(wVals)
printf("xName:%s_%s yName:%s zName:%s wName:%s nbCol:%d\n" xName xVal yName zName||"zZzz" wName nbCol)

i=0
header="# X\tY\tZ" 
info=sprintf(nil "# %s\t%s\t%s\t" xName yName zName||"")
OUT3=foreach(mapcar wVal remove( "=" wVals )
printf("wVal:%s %L\n" wVal wVals )
filename=sprintf(nil "file_%s_%s.txt" wName wVal)
rexCompile("\\-") wFile=concat("pfile_" rexReplace( wVal  "_" 1))
set(wFile outfile(sprintf(nil "%s/%s" pwd() filename)))
fprintf(eval(wFile) "%s\n%s\n" header info)
filename)
;set file pointer
printf("Files set%L\n" OUT3||"OUT3nil??")

while(gets(nextLine myPort) while(nextLine=="\n" gets(nextLine myPort) )
when(nextLine
row=remove("#" remove("\n" simStringsToList(nextLine)))
printf("ROW.%s:%L\n" xVal||"xValERROR" row||"rowERROR")
cond(
((car(row)==xName) xVal=nth(2 row) printf("xName:\n")   
;gnuplot needs a blankline between two arrays 
foreach(mapcar wVal remove("=" wVals) fprintf(eval(wFile) "\n"))
)
((car(row)==yName) t||"donothing"  printf("yName:\n")   )
((car(row)==wName) wVals=cdr(row)  printf("zName:\n")   )
(t  printf("Data:\n") wVal="nil"
yVal=car(row) zVals=cdr(row)
for(i 0 length(zVals)-1
; printf("zVal:%d.x:%s:zVals%L\n" length(zVals) xVal zVals)
filename=sprintf(nil "file_%s_%s.txt" wName wVal||"nil")
rexCompile("\\-") xwVal=rexReplace( wVal||"nil"  "_" 1) iwFile=concat("pfile_" "i" xwVal)
outfile(sprintf(nil "%s/file_%d_%s" pwd() i xwVal))
iwFileName=sprintf(nil "%s/file_%d_%s" pwd() i xwVal)
set(iwFile outfile(iwFileName))
printf("%s\t%s\t%s\n" eval(iwFile)||"EVAL?" xVal yVal nth(i zVals))
fprintf(eval(iwFile) "%s\t%s\t%s\n" xVal yVal nth(i zVals)))
);end t case; printf("Data\n")
);end cond
));end while
foreach(wVal wVals close(eval(wFile))) ; close(pfile)
else
printf("CHECK %L %L %L\n" check a myPort )
cmd=sprintf(nil "head %s" cadr(parseString(sprintf(nil "%s" myPort) "\""))) (system cmd)
) );if check&&a
when(OUT OUTs=append(OUTs list(OUT)))
when(OUT3 OUTs=append(OUTs OUT3))
OUTs
))
; fileArrayToRow("data_ymaxENC_PA6.txt")


; output=car(asiGetOutputList(asiGetCurrentSession()))

defun( dataToGnuplot (@optional (pwd pwd()) (ADEsession asiGetOutputList(asiGetCurrentSession()))) let((output VorI file exprList expr cmd OUTED)
when(not(ADEsession) ADEsession=asiGetOutputList(hiGetCurrentWindow()~>sevSession~>simID))
unless(asiGetCurrentSession() printf("Click on a schematic window associated to an ADE\n"))
foreach( mapcar output ADEsession
when(output~>plot ;evalstring(sprintf(nil "%sDC%L" "I" list(output~>signal)))
VorI=nil cmd=""
cond(
(output~>type=='terminal VorI="I")
(output~>type=='net      VorI="V"))
if(VorI then
; file=output~>name||output~>signal
uneval='() exprList='()
exprList=remove(nil foreach(mapcar TDC '("T" "DC" "S")
when(evalstring(expr=sprintf(nil "%s%s%L" VorI TDC list(output~>signal))) uneval=append(uneval list(expr)))))
printf("LISTING:\n%L\nLISTED\n" remove(nil foreach(mapcar TDC '("T" "DC" "S") sprintf(nil "%s%s%L" VorI TDC list(output~>signal)))))
else
exprList=list(eval(output~>expression))
; uneval=list(output~>expression)
uneval=list(sprintf(nil "%L" output~>expression))
printf("EXPR: %L\nNOTEVAL: %L\n" exprList TOTO=output~>expression)
; file=output~>name||output~>signal||apply(' strcat parseString(sprintf(nil "%L" output~>expression) "\""))
);end signal or explression
;when(exprList) ;=> simulation exist but no VT nor VDC ?=> parametric simulation one directory above ...
printf("UNEVAL: %L\n" uneval) 
foreach(element uneval ;;/!\ respect the './' otherwise awvPrint into another directory !! troublesome !!
; file=output~>name||apply(' strcat parseString( element "\"") )||output~>signal
; file=apply(' strcat parseString( element "\"") )
rexCompile("\"") file=rexReplace(element "" 0)
rexCompile(" ") file=rexReplace(file "" 0)
rexCompile("/") file=rexReplace(file "" 0)
rexCompile("(") file=rexReplace(file "" 0)
rexCompile(")") file=rexReplace(file "" 0)
rexCompile("?") file=rexReplace(file "" 0)
rexCompile("-") file=rexReplace(file "" 0)
rexCompile("\\+") file=rexReplace(file "" 0)
rexCompile("\\*") file=rexReplace(file "" 0)
rexCompile("=") file=rexReplace(file "" 0)
printf( "element:%s:FILE:%s\npwd:%s\n" element file pwd)
file=sprintf(nil "data_%s.txt"  file )
printf("edit(\"%s/%s\");pwd()\n" pwd() file)
ocnPrint( ?output sprintf(nil "%s/%s" pwd file) evalstring(element) ?format "engineering");; save to file simulation data
printf("awvPrintWaveform( ?output \"%s/%s\" %L ?format \"engineering\"\n"  pwd file evalstring(element) )
; cmd=sprintf(nil "cat %s|sed -e \"2s/.*/# &/\" > %s" cmd file file);=> replace second line as a comment
cmd="" cmd=sprintf(nil "%s\n cat %s|sed \"s/^[a-z]\\|[A-Z]/# &/\" > %s.tmp\n mv %s.tmp %s" cmd file file file file)
(system cmd) cmd=""
OUTEDs=fileArrayToRow(file); transform file(.txt) into DONE_file(.txt)
printf("IN:%s. OUTED:%L:\n" file OUTEDs||'())
fp=nil 
GP=sprintf(nil "%s.gp" file)
printf("Creating %s/%s\n" pwd GP)
if(OUTEDs then fp=infile(sprintf(nil "%s/%s" pwd() car(OUTEDs)))
gets(line fp) XYZ=simStringsToList(gets(line fp)||"nil") close(fp)
;("#" "vgg" "vdd" "IS(\"/MN0/D\")@0" "\n")
(system sprintf(nil "rm -f %s/%s" pwd GP))
nb=1 
cmd=sprintf(nil "%s\n echo -n \"splot \" >> %s" cmd GP)
foreach(OUTED OUTEDs
printf("Treating %L\n" OUTED)
;cmd=sprintf(nil "%s\n echo -n \" '%s/%s' with lines %d\" >> %s" cmd pwd OUTED nb GP)
cmd=sprintf(nil "%s\n echo -n \" '%s/%s' with lines \" >> %s" cmd pwd OUTED GP)
when(nb!=length(OUTEDs) cmd=sprintf(nil "%s\necho -n \",\" >> %s" cmd GP))
nb=nb+1) 
cmd=sprintf(nil "%s\n echo \"\nset grid\nset xlabel '%s';set ylabel '%s';set zlabel '%s' offset 4,4;replot\npause -1 'pressReturn'\n\" >> %s" cmd nth(1 XYZ) nth(2 XYZ) nth(3 XYZ) GP)
printf("LABELs for %s. OUTEDs=%L= fp=%s= XYZ=%L=\n" file OUTEDs||"" fp||"" XYZ)
else printf("No label for %s. OUTED=%L= fp=%s=\n" file OUTEDs||"" fp||""));; custom for label from OUTED
cmd=sprintf(nil "%s\n echo \"set contour; replot\npause -1 'pressRet'\nset cntrparam levels auto 30; replot\npause -1 'pressReturn'\nunset contour;set view 90,90;replot;\npause -1 'Y axis'\nset view 90,0;replot;\npause -1 'X axis'\n \" >> %s" cmd  GP)(system cmd) 
when(GP (system sprintf(nil "echo \"gnuplot  %s/%s\"" pwd GP)))
when((not (system "which gnuplot 2>/dev/null")) (system sprintf(nil "gnuplot  %s/%s&"  pwd GP)))
OUTED=nil OUTEDs='() GP=nil) uneval)
)))


;; ;; set contour; replot
;; ;; set cntrparam levels auto 30; replot
;; ;; set xlabel "Vds"; set ylabel "Vgs"; set zlabel "id"; replot


;; ; awvPrintWaveform( ?output "data__MN0_D.txt" car(asiGetOutputList(asiGetCurrentSession()))~>signal ?format "engineering")

;; ; when double parametric, do something with rep. name with a '='   
;; ; i("/MN0/D" ?result "dcOp-dc" ?resultsDir "/data/ebecheto/Sim/nmos_caract/spectre/schematic/vdd=2.56666666666667,vgg=2.475/psf")

;; ;; file="/home/validmgr/ebecheto/Work/IC6/data_I_W.L.txt"
;; ;; fileArrayToRow(file)

; 
;; rexCompile("/psf$") rexReplace(openResults() "" 1)
;; openResults()
;; rexCompile("/psf$")
;; resultsDir( rexReplace(openResults() "" 1));<== to avoid PB with parametric, having multiple psf in ./schematic/param=x.xx
;; openResults(rexReplace(openResults() "" 1))

;; file="test" element="IS(\"/MN0/D\")"
;; simulator(asiGetCurrentSession()~>parent~>name)
;; simulator(hiGetCurrentWindow()~>sevSession~>simulator)
;; ocnPrint( ?output sprintf(nil "%s/%s" pwd() file) evalstring(element) ?format "engineering");; TODO a loop for multiple solution ('tran 'dc etc..),  with filenameList or an index
;; cat tata |sed "s/^[a-z]\|[A-Z]/# &/"

;; hiGetCurrentWindow()~>sevSession~>existPlottableSignals


;; element="IT(\"/MN0/D\")"


;; ;; PAS BON : parseString(sprintf(nil "%L" element) "\"")
;; file=apply(' strcat parseString(sprintf(nil "%L" element) "\""))
;; file=apply(' strcat parseString(sprintf(nil "%L" element) "\""))
;; rexCompile("/") file=rexReplace(file "_" 0)
;; rexCompile("(") file=rexReplace(file "_" 0)
;; rexCompile("\\") file=rexReplace(file "_" 0)
;; rexCompile("\\") file=rexReplace(file "_" 0)
;; rexCompile("\\\\") file=rexReplace(file "_" 0)


;; ; _____________________________________________________________________________
;; ;; simulator(hiGetCurrentWindow()~>sevSession~>simulator)
;; simulator('spectre)
;; openResults(resultsDir(dir="/home/validmgr/ebecheto/Work/ams400/Sim/nmos_caract/spectre"))
;; ;; openResults(resultsDir(dir="/group/validmgr/ebecheto/Sim/nmos_caract/spectre/schematic"))
;; element="IS(\"/MN0/D\")"
;; file="MN0_D.txt"
;; ocnPrint( evalstring(element) ?output sprintf(nil "%s/%s" pwd() file)  ?format "engineering")
;; ; edit(eval(file))
;; ; fileArrayToRow()


;; myPort = infile(sprintf(nil "%s/%s" pwd() file))
;; gets(nextLine myPort)  while(nextLine=="\n" gets(nextLine myPort) )
;; row=remove("#" remove("\n" simStringsToList(nextLine)))
;; yName=car(row) zName=cadr(row) printf("yName:%s zName:%s\n" yName zName)
;; gets(nextLine myPort) while(nextLine=="\n" gets(nextLine myPort) )
;; row=remove("#" remove("\n" simStringsToList(nextLine)))
;; xName=car(row) xVal=nth(2 row) ; ("vgg" "=" "0")
;; ; nbCol=length(xVals)
;; gets(nextLine myPort) row=remove("#" remove("\n" simStringsToList(nextLine))) ;; TODO, check \ before \n => continue next line...!
;; wName=car(row)
;; wVals=cdr(row)
;; nbCol=length(wVals)
;; printf("xName:%s_%s yName:%s zName:%s wName:%s nbCol:%d\n" xName xVal yName zName wName nbCol)

;; i=0
;; header="# X\tY\tZ" 
;; info=sprintf(nil "# %s\t%s\t%s\t" xName yName zName)
;; OUT3=foreach(mapcar wVal wVals 
;; filename=sprintf(nil "file_%s_%s.txt" wName wVal)
;; set(concat("pfile_" wVal) outfile(sprintf(nil "%s/%s" pwd() filename)))
;; fprintf(eval(concat("pfile_" wVal)) "%s\n%s\n" header info )
;; filename)
;; ;set file pointer

;; while(gets(nextLine myPort)
;; row=remove("\n" simStringsToList(nextLine))
;; cond(
;; ((car(row)==xName) xVal=nth(2 row))
;; ((car(row)==yName) t||"donothing")
;; ((car(row)==wName) wVals=cdr(row))
;; (t  
;; yVal=car(row) zVals=cdr(row)
;; for(i 0 length(zVals)-1
;; fprintf(eval(concat("pfile_" nth(i wVals))) "%s\t%s\t%s\n" xVal yVal nth(i zVals))
;; )
;; ; printf("Data\n"))
;; );end cond
;; );end while
;; foreach(wVal wVals close(eval(concat("pfile_" wVal)))) ; close(pfile)
;; ; _____________________________________________________________________________




; simulator('spectre)
; openResults(resultsDir(dir="/group/validmgr/ebecheto/Sim/nmos_caract/spectre/schematic"))

dataToGnuplot()


