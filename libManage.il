; load("libManage.il")

defun( enableLib (@optional (lib "CORELIB") (dir "$AMS_DIR/cds/HK_C35/CORELIB") ) let((pLib cmd)
pLib=strcat(" " lib " ")
cmd=sprintf(nil "dir=$(cat ./cds.lib | grep '%s' |sed  's/.*DEFINE[ \\t]*%s[ \\t]*\\([^ .]*\\)\\([ \t#].*\\)/\\1/')" pLib lib)
cmd=sprintf(nil "%s; echo \"DIR:\" $dir" cmd)
cmd=sprintf(nil "%s; if [ -z  $dir ]; then dir='%s' ;echo 'SETTING dir=' $dir;else echo 'CATCHED from cds.lib:' $dir;fi" cmd dir)
cmd=sprintf(nil "%s; if [ -d  $(echo $(eval $dir 2>/dev/null)) ]; then echo 'DIRECTORY exist' $dir;else echo \"$dir does not exist ?\" ; echo \"$dir\\nAMS ? $AMS_DIR\";ls $(eval $dir);fi" cmd dir)
cmd=sprintf(nil "%s;cat ./cds.lib |sed -e \"s,\\(^[ \\t]*\\)#\\([ \\t]*\\)DEFINE\\([ \\t]*\\)%s\\([ \\t]*\\)$dir\\(.*\\),DEFINE %s $dir\\5,\" > ./cds.lib.uncomment; cp ./cds.lib.uncomment ./cds.lib" cmd lib lib )
(system cmd)
printf("%s\n" cmd)
ddUpdateLibList()
))




defun( disableLib (@optional (lib "CORELIB") ) let((pLib cmd)
pLib=strcat(" " lib " ")
cmd=sprintf(nil "dir=$(cat ./cds.lib |grep '%s'|sed 's,DEFINE[ \\t]*\\([^ .]*\\)[ \\t]*\\([^ .]*\\)\\([ \\t#].*\\),\\2,')" pLib lib)
;; cmd=sprintf(nil "dir=$(cat ./cds.lib |grep '%s' |sed -e 's/ //g' |sed  's,DEFINE[ \\t]*\\([^ .]*\\)[ \\t]*\\([^ .]*\\)\\([ \\t#].*\\),\\2,')" pLib lib)
;; cmd=sprintf(nil "dir=`cat ./cds.lib |grep '%s' |sed -e 's/ //g' |sed  's/^DEFINE%s//'`" pLib lib)
cmd=sprintf(nil "%s;echo 22" cmd)
cmd=sprintf(nil "%s; if [ -z  $dir ]; then echo 'dir empty?' $dir ;else cat ./cds.lib |sed -e \"s,\\([ \\t]*\\)DEFINE\\([ \\t]*\\)%s\\([ \\t]*\\)$dir,#&,\" > ./cds.lib.comment; cp ./cds.lib.comment ./cds.lib;fi" cmd lib)
cmd=sprintf(nil "%s;echo 'Modifing %s in :' \"$dir\"" cmd lib)
printf("%s" cmd)
(system cmd)) ddUpdateLibList()
)



defun( commentedLib ( ) let((pLib cmd file myPort nextLine cLib nl line1)
file=strcat(pwd() "/cds.lib")
myPort=infile(file)  cLib='() 
printf("FILE:%s\n" file)
while( gets(nextLine myPort) ; printf("%s" nextLine)
rexCompile("\n")
nl=parseString(rexReplace(nextLine "" 0) " ")
when(nl
if(rexMatchp("#" nth(0 nl)) then
line1=parseString( nth(0 nl) "#")
when(car(line1)=="DEFINE" printf("#COMMENT%L\n" nl) cLib=append(cLib list(nth(2 nl))))
when(nth(1 nl)=="DEFINE"  printf("# COMMENT%L\n" nl) cLib=append(cLib list(nth(3 nl))))
) )) ;ddUpdateLibList()
cLib ))


defun( enableLibDir (@optional (dir "$AMS_DIR/cds/HK_C35/CORELIB") (libName nil) ) let((cmd pos enable inF outF file efile exist i line1 line2)
file=strcat(pwd() "/cds.lib") i=0
inF=infile(file) enable=nil exist=nil
efile=strcat(pwd() "/cds.lib.enable")
outF=outfile(efile "w")
; while( gets(nextLine inF) i++ ) printf("%d lines in %s\n" i file) i=0 close(inF) inF=infile(file)
while( gets(nextLine inF) outLine=nextLine ; printf("%s" nextLine)
rexCompile("\n")
nl=parseString(rexReplace(nextLine "" 0) " ")
when(nl&&!enable; could be nil when nothing in the line
when(and( length(nl)>=3 rexMatchp("CORELIB" nth(2 nl)) ) printf("CORELIB ?%L\n" nl))
when((and not(rexMatchp("#" nth(0 nl))) nth(2 nl)==dir) exist=t);<== lib exist and is not commented
if(rexMatchp("#" nth(0 nl)) then
line1=parseString( nth(0 nl) "#")
when(car(line1)=="DEFINE" pos=2 line2=append(line1 cdr(nl)))
when(nth(1 nl)=="DEFINE"  pos=3 line2=cdr(nl))
when(remove(nil list(exist pos enable)) printf("commented %L:%L\n" list(exist pos enable) nl))
when((and not(exist) pos equal(nth(pos nl) dir)) enable=t 
if(libName 
then outLine=strcat("DEFINE " libName " " dir  "\n")
else outLine=strcat(buildString(line2 " " ) "\n")
)
) pos=nil
printf("%3d:%s" i++ outLine)
))
; printf("%3d:%s" i++ outLine)
fprintf(outF "%s" outLine)
);EOF
when(and(!enable !exist) 
; added it at the end when not commented and not existing
when(!libName libName=car(last(parseString(dir "/"))))
fprintf(outF "DEFINE %s %s #Added by enaleLibDir\n" libName dir))
close(inF) close(outF)
cmd=sprintf(nil "cp %s %s" efile file)
(system cmd) printf("CMD:\n%s\n" cmd)
ddUpdateLibList()
))

; DEFINE CORELIB_H18   /soft/cadence/AMS/AMS401/cds/HK_H18/CORELIB
defun( disableLibDir (@optional (dir "/soft/cadence/AMS/AMS401/cds/HK_H18/CORELIB") ) let((cmd pos disable inF outF file efile exist i line1 line2)
file=strcat(pwd() "/cds.lib") i=0
inF=infile(file) disable=nil exist=nil
efile=strcat(pwd() "/cds.lib.disable")
outF=outfile(efile "w")
; while( gets(nextLine inF) i++ ) printf("%d lines in %s\n" i file) i=0 close(inF) inF=infile(file)
while( gets(nextLine inF) outLine=nextLine
rexCompile("\n")
nl=parseString(rexReplace(nextLine "" 0) " ")
when(nl&&!disable; could be nil when nothing in the line
when(and(not(rexMatchp("#" nth(0 nl))) length(nl)>=3 rexMatchp(dir nth(2 nl)) )
printf("Commenting : ?%L\n" nl)
disable=t outLine=strcat("# " nextLine)
))
; printf("%3d:%s" i++ outLine)
fprintf(outF "%s" outLine)
);EOF
close(inF) close(outF)
cmd=sprintf(nil "cp %s %s" efile file)
(system cmd) printf("CMD:\n%s\n" cmd)
ddUpdateLibList()
))


;; disableLibDir("/soft/cadence/AMS/AMS401/cds/HK_H18/CORELIB")
;; enableLibDir("/soft/cadence/AMS/AMS401/cds/HK_H18/CORELIB" "CORELIB")

;; disableLibDir("/soft/cadence/AMS/AMS401/cds/HK_H18/CORELIB")
;; enableLibDir("/soft/cadence/AMS/AMS401/cds/HK_H18/CORELIB" "CORELIB_H18")

;; disableLibDir("$AMS_DIR/cds/HK_C35/CORELIB")
;; enableLibDir("/soft/cadence/AMS/AMS401/cds/HK_H18/CORELIB")

;; disableLibDir("/soft/cadence/AMS/AMS401/cds/HK_H18/CORELIB")
;; enableLibDir("$AMS_DIR/cds/HK_C35/CORELIB")
