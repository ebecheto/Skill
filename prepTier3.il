tierDir="/group/validmgr/Sim"
netDir=asiGetNetlistDir(asiGetCurrentSession())
; asiGetAnalogRunDir(asiGetCurrentSession());=> idem
;=> "/home/validmgr/ebecheto/Work/h18/Sim/osc_matrix_sim/UltraSim/schematic/netlist"
; asiGetSimExecName(asiGetCurrentSession());=> ultrasim
;; aa=lf("asiGet")
;; foreach(mapcar l aa println(apply(l list(asiGetCurrentSession() )))) ;=> marche pas bien
; envGetVal( "asimenv.startup"  "projectDir" 'string );=> "./Sim"

dir=asiGetAnalogRunDir(asiGetCurrentSession())
pd=parseString(dir "/")
rd=reverse(pd)
end='() beg='()
for(i 0 3 end=append(end list(car(rd))) rd=cdr(rd))
rend=reverse(end)
send=reverse(cdr(end))
rbeg=reverse(rd)
bend=buildString(rend "/")
bsend=buildString(send "/")
bbeg=strcat("/" buildString(rbeg "/"))
;; TIERDATA
tierData=strcat(tierDir "/" bend)


;NETLISTNAME: 
runSim=strcat(tierData "/" "runSimulation")
ip=infile(runSim)
netlistName = cadr(parseString(gets(nextLine ip)  " "))
close(ip)

;; TOMODIF FOR DIFFERENT STUFF
tempList='(10 20 30 40 50)
pattern=" temp="
system(sprintf(nil "grep %L %s/%s;echo $?> .tmp" pattern netDir netlistName))
ip=infile(".tmp")
patternp = car(parseString(gets(nextLine ip)  " "))
close(ip)
if(patternp=="0\n" then
printf("Preparing data for %L\n" tempList)
else printf("Setup->Temperature->change to 30 par exemple\n")
tempList=car(tempList)
printf("Preparing data for %L\n" tempList)
)

;; DATA
system(sprintf(nil "mkdir -p %s" tierData))
system(sprintf(nil "cp -r %s/* %s/." netDir tierData))
system(sprintf(nil "chmod -R 777  %s" tierDate))

i=0 foreach( tmp tempList
system(sprintf(nil "mkdir -p  %s/../psf%d" tierData i))
system(sprintf(nil "chmod 777 %s/../psf%d" tierData i))
netp=parseString(netlistName ".") input=car(netp) ext=cadr(netp)
inputi=sprintf(nil "%s%d.%s" input i ext)
seds=sprintf(nil "s/%s/%s/;s,../psf,../psf%d,g" netlistName inputi i) 
runi=sprintf(nil "%s%d.sh" runSim i)
;; runSimulation[1-5].sh
system(sprintf(nil "cat %s | sed %L > %s;chmod 777 %s" runSim seds runi runi))
;; check later for spectre if temp ie written the same way
seds=sprintf(nil "s/%s.*/%s%L/" pattern pattern tmp) 
tnetlist=strcat(tierData "/" netlistName)
tinputi=strcat(tierData "/" inputi)
system(sprintf(nil "cat %s | sed %L > %s;chmod 777 %s" tnetlist seds  tinputi tinputi))
i++ )

;; JDL
jdlTemplate=strcat(tierDir "/" "templateJDL.txt")
jdl=strcat(tierData "/" "jdl.jdl")
pf = outfile(jdl "a")
fprintf(pf "# glite-wms-job-submit -a -o JID %s\n" jdl)
printf( "# glite-wms-job-submit -a -o JID %s\n" jdl)
close(pf)
system(sprintf(nil "cat %s >> %s" jdlTemplate jdl))

;; RUN
runTemplate=strcat(tierDir "/" "templateRUN.txt")
runs=strcat(tierData "/" "run.sh")
pf = outfile(runs) fprintf(pf "dir=%s\n" tierData) close(pf)
printf( "dir=%s\n" tierData)
system(sprintf(nil "cat %s >> %s;chmod 777 %s" runTemplate runs runs))



;; RESULT ANALYSE
i=0 foreach( tmp tempList
printf( "rdir=\"%s/../psf%d\"\n" tierData i)
rdir=sprintf(nil "%s/../psf%d" tierData i)
load("osc.il")
i++)


logFile=strcat(pwd() "/" "tier3.il")
pf = outfile(logFile "a")
fprintf(pf "t_dirName=%L\nload(%L)" tierData "osc.il")
close(pf)

;; t_dirName="/group/validmgr/ebecheto/Sim/ADC_tb1/UltraSim/schematic"
;; resultsDir( t_dirName )
;; openResults(t_dirName ) ;=> "/data/ebecheto/Sim/ADC_tb1/UltraSim/schematic"
;; results ;=> (dcOpInfo dcOp variables tran)
;; selectResults('tran)
