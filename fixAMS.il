; load("fixAMS.il")

defun( fixState (@optional (cv geGetWindowCellView())) let((artDir cellDir dirList files myPort line hDir change cmd)
;cv=geGetWindowCellView()
if(cv then
change=nil
artDir=sprintf(nil "~/.artist_states/%s/%s/spectre/state1/" cv~>libName cv~>cellName)
hArtDir=sprintf(nil "~/.artist_states/%s/%s/" cv~>libName cv~>cellName)
sArtDirL=foreach(mapcan x '("spectre" "spectreS" "UltraSim")  when(isDir(strcat(hArtDir x)) list(strcat(hArtDir x))))
artDirL=foreach(mapcan dir sArtDirL foreach(mapcan x ls(dir)  when(not(rexMatchp("^\\." x)) list(strcat(dir "/" x))))) ; remove "." ".." ".sevSaveDir"
;; artDirL=remove(nil foreach(mapcan dir sArtDirL remove(nil foreach(mapcar x ls(dir) printf("%s_%L\n" x strcat(dir "/" x)) if(rexMatchp("^\\." x) nil strcat(dir "/" x))))))
hDir=strcat("/" buildString(reverse(cdr(reverse(parseString( car(ddGetObj(cv~>libName)~>files~>readPath) "/")))) "/")) ; => "/home/validmgr/ebecheto/Work/IC6/T2K_V5" alors que dans le cds.lib c'est definit comme :  ./T2K_V5
;; hDir=sprintf(nil "%s/%s/%s/" pwd() cv~>libName cv~>cellName); hierarchy directory
cellDirL=foreach(mapcan dir ls(hDir) when(rexMatchp("state" dir) list(strcat(hDir "/" dir)) )) ; will take things like /spectre_state1 /UltraSim_state1 ...

; cellDir=sprintf(nil "%s/%s/%s/spectre_state1/" pwd() cv~>libName cv~>cellName)
; cellDir could be addapted to get cds.lib pwd. and going through all cellviews. is that necessary ?
dirList=append(artDirL cellDirL)
foreach( simDir dirList
when(isDir(simDir) printf("DIR:%s\n" simDir)
files=remove(".." remove("." ls(simDir)))
foreach( file files
iFile=strcat(simDir "/" file)
oFile=strcat(simDir "/" file ".fix")
when(isFile(iFile) ; printf("FILE:%s\n" file) printf("edit %L\n" iFile)
OUT=  outfile(oFile)
myPort=infile(iFile)
while( gets(nextLine myPort) rexLine=nextLine
line=parseString(nextLine " ")
rexLine=foreach(mapcar el line rexEl=el ; printf("EL:%L\n" el)
when(and( rexMatchp("ams" lowerCase(el)) rexMatchp("ibm" lowerCase(el)) ) printf("Heum heum which techno ams or ibm ? modify fixAMS.il\n"))
when(and(rexMatchp("ams" lowerCase(el)) not(rexMatchp("$AMS_DIR" el)) );prevent new modif
rexCompile("\".*/spectre")
rexEl=rexReplace(el "\"$AMS_DIR/spectre" 1) ;=> "((\"$AMS_DIR/spectre/c35/cmos53.scs\""
; printf("%L\n" line)
change=t
)
when(and(rexMatchp("ibm" lowerCase(el)) not(rexMatchp("$IBM_PDK" el)) );prevent new modif
rexCompile("\".*/IBM_PDK")
rexEl=rexReplace(el "\"$IBM_PDK/IBM_PDK" 1) ;=> $IBM_PDK/IBM_PDK/cmrf8sf/relDM/Spectre/models/allModels.scs
; printf("%L\n" line)
change=t
) rexEl
); fin des elements espaces
fprintf(OUT "%s" buildString(rexLine " "))
)
when(change cmd=sprintf(nil "mv %s %s" oFile iFile) (system cmd) printf("MODIFIED by :%s\n" cmd) change=nil)
close(myPort) close(OUT)
))))
else printf("Clicl on a shematic view\n")
)))
