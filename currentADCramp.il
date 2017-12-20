
awvGetWaveNameList(w_id=awvGetCurrentWindow())
procedure(currentADCramp(@optional (T1 1.8m) (T2 3.7m))
(let ( f_fr t_step dt tr net pn name i pf netName bitList T1s T2s)
Td=5u ; T1=1.8m T2=3.7m
f_fr=25M t_step=1.0/f_fr
T1s=aelSuffixNotation(I1)
T2s=aelSuffixNotation(I2)
(set 'dt 0n)    ;; deltaTime variable temps
tr= 0.1n ;; rise time
tr=t_step/100 ;; rise time
net="ADC_IN" pn='("n" "p") name="idc" i=0
while( isFile( filename=sprintf(nil "%s/%s_%s-%s_%d%s" pwd() name T1s T2s i ".scs")) i++)
pf=outfile(filename)
foreach(pol pn 
dt=0
netName=strcat(net pol)
fprintf(pf "I_%s (%s 0) isource type=pwl delay=0 wave=[ \\\n" netName netName)
bitList=linRg( T1 T2 Td)
when(pol=="p" bitList=reverse(bitList))
foreach(bit bitList
fprintf(pf "%g %g %g %g\\\n" dt+tr bit dt+t_step bit)
dt=dt+t_step) ""
fprintf(pf "]\n\n"))
printf("saved in %s\n" filename) close(pf) edit(eval(filename))
printf("From %g to %g with %g step in %g seconds.\n" T1 T2 Td dt )
))
;; ;; ^^^^^^^Not needed anymore, now using schematic ipwl as a ramp : 2 points
;; I1=1.5m ;=> 0.0019men
;; I2=3.5m ;=> 0.0029
;; currentADCramp(I1 I2)
I1=2.5m ;=> 0.0019
I2=4.5m ;=> 0.0029
currentADCramp(I1 I2)
