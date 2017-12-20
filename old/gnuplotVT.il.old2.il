defun( fileArrayToRow ( @optional (file "data_I_W.L.txt") (pwd pwd()) (check t))
let( (a myPort nextLine a xName yName zName secondRow xVals nbCol filename data yVal zVals header info OUT cmd)
myPort=infile(sprintf(nil "%s/%s" pwd() file));read a first time for size colum
a=0
while(gets(nextLine myPort) when(member("#" simStringsToList(nextLine)) a=a+1))
close(myPort)
printf("DOING %L\n" list(file check a myPort))
if(check&&a==2 then
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
 printf("writing/%s\n" outFile)
set(concat("pfile_" i) outfile(sprintf(nil "%s/%s%d" pwd() filename i))) )
;; gets(nextLine myPort)
;; gets(nextLine myPort)
while(gets(nextLine myPort)
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
else printf("CHECK %L %L %L\n" check a myPort )
cmd=sprintf(nil "head %s" cadr(parseString(sprintf(nil "%s" myPort) "\""))) (system cmd)
 );if check&&a
OUT
))


; output=car(asiGetOutputList(asiGetCurrentSession()))

defun( dataToGnuplot (@optional (pwd pwd()) (ADEsession asiGetOutputList(asiGetCurrentSession()))) let((output VorI file exprList expr cmd OUTED)
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
uneval=list(output~>expression)
printf("EXPR: %L\n" exprList) 
file=output~>name||output~>signal||apply(' strcat parseString(sprintf(nil "%L" output~>expression) "\""))
);end signal or explression
;when(exprList) ;=> simulation exist but no VT nor VDC ?=> parametric simulation one directory above ...
printf("UNEVAL: %L\n" uneval) 
foreach(element uneval ;;/!\ respect the './' otherwise awvPrint into another directory !! troublesome !!
; file=output~>name||apply(' strcat parseString( element "\"") )||output~>signal
file=apply(' strcat parseString( element "\"") )
rexCompile("/") file=rexReplace(file "_" 0)
rexCompile("(") file=rexReplace(file "_" 0)
rexCompile(")") file=rexReplace(file "_" 0)
printf( "element:%s:FILE:%s\npwd:%s\n" element file pwd)
file=sprintf(nil "data_%s.txt"  file )
printf("edit(\"%s/%s\");pwd()\n" pwd() file)
awvPrintWaveform( ?output sprintf(nil "%s/%s" pwd file) evalstring(element) ?format "engineering");; TODO a loop for multiple solution ('tran 'dc etc..),  with filenameList or an index
printf("awvPrintWaveform( ?output \"%s/%s\" %L ?format \"engineering\"\n"  pwd file evalstring(element) )
; cmd=sprintf(nil "cat %s|sed -e \"2s/.*/# &/\" > %s" cmd file file);=> replace second line as a comment
cmd=sprintf(nil "%s\n cat %s|sed \"s/^[a-z]\\|[A-Z]/# &/\" > %s.tmp\n mv %s.tmp %s" cmd file file file file)

(system cmd) cmd=""
OUTED=fileArrayToRow(file); transform file(.txt) into DONE_file(.txt)
printf("IN:%s. OUTED:%s:\n" file OUTED||"nothing")
fp=nil 
if(OUTED then fp=infile(sprintf(nil "%s/%s" pwd() OUTED)) 
gets(line fp) XYZ=simStringsToList(gets(line fp)) close(fp)
;("#" "vgg" "vdd" "IS(\"/MN0/D\")@0" "\n")
cmd=sprintf(nil "%s\n echo \"splot '%s/DONE_%s' with lines 1\nset grid\n\" > %s.gp" cmd pwd file file)
cmd=sprintf(nil "%s\n echo \"set xlabel '%s';set ylabel '%s';set zlabel '%s' offset 4,4;replot\npause -1 'pressReturn'\n\" >> %s.gp" cmd nth(1 XYZ) nth(2 XYZ) nth(3 XYZ) file)
printf("LABELs for %s. OUTED=%s= fp=%s= XYZ=%L=\n" file OUTED||"" fp||"" XYZ)
else printf("No label for %s. OUTED=%s= fp=%s=\n" file OUTED||"" fp||""));; custom for label from OUTED
cmd=sprintf(nil "%s\n echo \"set contour; replot\npause -1 'pressRet'\nset cntrparam levels auto 30; replot\npause -1 'pressReturn'\nunset contour;set view 90,90;replot;\npause -1 'Y axis'\nset view 90,0;replot;\npause -1 'X axis'\n \" >> %s.gp" cmd  file)(system cmd) 
when(OUTED (system sprintf(nil "echo \"gnuplot  %s/%s.gp\"" pwd file)))
if(OUTED printf("Got : %s\n " OUTED) printf("File ?! : fileArrayToRow%L\n " list(file) ))
when((not (system "which gnuplot 2>/dev/null")) (system sprintf(nil "gnuplot  %s/%s.gp&"  pwd file)))
OUTED=nil) exprList)
)))


;; ;; set contour; replot
;; ;; set cntrparam levels auto 30; replot
;; ;; set xlabel "Vds"; set ylabel "Vgs"; set zlabel "id"; replot


;; ; awvPrintWaveform( ?output "data__MN0_D.txt" car(asiGetOutputList(asiGetCurrentSession()))~>signal ?format "engineering")

;; ; when double parametric, do something with rep. name with a '='   
;; ; i("/MN0/D" ?result "dcOp-dc" ?resultsDir "/data/ebecheto/Sim/nmos_caract/spectre/schematic/vdd=2.56666666666667,vgg=2.475/psf")

;; ;; file="/home/validmgr/ebecheto/Work/IC6/data_I_W.L.txt"
;; ;; fileArrayToRow(file)

;; rexCompile("/psf$") rexReplace(openResults() "" 1)
;; openResults()
;; rexCompile("/psf$")
;; resultsDir( rexReplace(openResults() "" 1));<== to avoid PB with parametric, having multiple psf in ./schematic/param=x.xx
;; openResults(rexReplace(openResults() "" 1))

;; simulator(asiGetCurrentSession()~>parent~>name)
;; simulator(hiGetCurrentWindow()~>sevSession~>simulator)
;; ocnPrint( ?output sprintf(nil "%s/%s" pwd file) car(exprList) ?format "engineering");; TODO a loop for multiple solution ('tran 'dc etc..),  with filenameList or an index

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
