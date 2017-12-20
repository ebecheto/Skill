procedure(frameRW(@optional 
(data "0001 1101") 
(register "0000 0000")
(chip "1000 0011")
(RW 0) (dt 200n))

;; start
printf("%g h %g d\\\n" dt dt+1n )
dt=dt+30n oldbit="0"
;write chip
foreach(bit remove(" " parseString( chip ""))
;; printf("BIt %d is up_Oldbit=%s\n" i oldbit)
if( bit=="1" then when(oldbit=="0" printf("%g d %g h\\\n" dt dt+1n))
else              when(oldbit=="1" printf("%g h %g d\\\n" dt dt+1n )))
dt=dt+40n oldbit=bit)

;; Read or Write bit + ack du chip adresse
if(RW==0 then when(oldbit=="1" printf("%g h %g d\\\n" dt dt+1n));<=write bit
else            when(oldbit=="0" printf("%g d %g h\\\n" dt dt+1n)));<=read bit
dt=dt+40n oldbit=sprintf(nil "%d" RW)
;; acknowledge du chip
when(oldbit=="0" printf("%g d   %g h\\\n" dt dt+1n)) dt=dt+40n oldbit="1"

foreach(bit remove(" " parseString( register ""))
if( bit=="1" then when(oldbit=="0" printf("%g d %g h\\\n" dt dt+1n))
else              when(oldbit=="1" printf("%g h %g d\\\n" dt dt+1n )))
dt=dt+40n oldbit=bit) 

;; acknowledge du registre
when(oldbit=="0" printf("%g d   %g h\\\n" dt dt+1n)) dt=dt+40n oldbit="1"


;; write data si RW==0
foreach(bit remove(" " parseString( data ""))
when(RW==0
if( bit=="1" then when(oldbit=="0" printf("%g d %g h\\\n" dt dt+1n))
else              when(oldbit=="1" printf("%g h %g d\\\n" dt dt+1n )))
oldbit=bit);;changer les valeur que si ecriture
dt=dt+40n)

;; when RW=1 => oldbit=1 ack not to change
;; acknowledge de data + stop
when(oldbit=="0" printf("%g d    %g h\\\n" dt dt+1n)) dt=dt+40n;<= ack bit
printf("%g h    %g d\\\n" dt dt+1n);<= stop  bit down
dt=dt+40n ; oldbit="0"
printf("%g d %g h\\\n" dt dt+1n);<= stop  bit release

);end proc


procedure(creatPWL_wave( @optional 
(data "0001 1101") 
(register "1000 0000")
(chip "1000 0011")
)
; si tdelay=200, t0=220 => debut trame a t0+delay=420
t0=230n; temps de depart. en simu, rajouter t_delay
dt=t0 ;<=delta time
oldbit="0" i=0
rexCompile(" ") name=rexReplace(data "_" 1)
printf("V_%s (net_%s 0) vsource dc=3.3 type=pwl delay=t_delay 
wave=[ \\\n0 0 t_on h\\\n" 
name name)

frameRW(data register chip 0 200n)
frameRW(data register chip 1 1500n)

printf("]\n")
); fin proc

procedure(creatPWL_wave_write_data12( @optional 
(data1 "1000 1000")
(data2 "0101 0001") 
(chip "1000 0011")
)
; si tdelay=200, t0=220 => debut trame a t0+delay=420
t0=230n; temps de depart. en simu, rajouter t_delay
dt=t0 ;<=delta time
oldbit="0" i=0
rexCompile(" ") name=rexReplace(data1 "_" 1)
printf("V_%s (SetDA_%s 0) vsource dc=3.3 type=pwl delay=t_delay 
wave=[ \\\n0 0 t_on h\\\n" 
name name)

frameRW(data1 "0000 0000" chip 0 200n)
frameRW(data2 "0000 0001" chip 0 1500n)

printf("]\n")
); fin proc


; load("createPWL_wave.il")
; USAGE : creatPWL_wave(  data        register    chip     )
; USAGE : creatPWL_wave("0001 1101" "0000 0000" "1000 0011")
; USAGE : creatPWL_wave("0001 1101" "0000 0000")
printf("USAGE : creatPWL_wave(\"1000 0100\" \"0000 0000\")\n")
printf("USAGE : creatPWL_wave(\"1010 1001\" \"0000 0001\")\n")
printf("USAGE : creatPWL_wave_write_data12(\"1010 1000\" \"0000 0110\")\n")


procedure(currentADCramp(@optional (T1 1.8m) (T2 3.7m) @rest rest)
(let ( t_step dt tr net pn name i pf netName bitList lr)
if(lr=assoc('f_fr rest) then _fr=eval(cadr(lr)) else _fr=25M)
if(lr=assoc('Td rest) then  _Td=eval(cadr(lr)) else  _Td=5u)
; _Td=5u ; T1=1.8m T2=3.7m
t_step=1.0/_fr
(set 'dt 0n)    ;; deltaTime variable temps
; tr= 0.1n ;; rise time
tr=t_step/100 ;; rise time
net="ADC_IN" pn='("n" "p") name="idc_" i=0
while( isFile( filename=sprintf(nil "%s/%s%d%s" pwd() name i ".scs")) i++)
pf=outfile(filename)
foreach(pol pn 
dt=0
netName=strcat(net pol)
fprintf(pf "I_%s (%s 0) isource type=pwl delay=0 wave=[ \\\n" netName netName)
bitList=linRg( T1 T2 _Td)
when(pol=="p" bitList=reverse(bitList))
foreach(bit bitList
fprintf(pf "%g %g %g %g\\\n" dt+tr bit dt+t_step bit)
dt=dt+t_step) ""
fprintf(pf "]\n\n"))
printf("saved in %s\n" filename) close(pf) edit(eval(filename))
printf("From %g to %g with %g step in %g seconds.\n" T1 T2 _Td dt )
))

"/ADC_INn" 
awvPrintWaveform( ?output "./ADC_INp.txt" VT("/ADC_INp") ?from 6n ?to 15.24u ?step 4n ?format "engineering")
ocnPrint( VT("/ADC_INp")  VT("/ADC_INn")  ?output "./ADC_INp.txt" ?from 6n ?to 15.24u ?step 4n ?format "engineering")
ocnPrint( VT("/ADC<0>")  VT("/ADC<1>") VT("/ADC<2>")  VT("/ADC<3>")  ?output "./ADC_OUT.txt" ?from 6n ?to 15.24u ?step 4n ?format "engineering")

;; myPort=infile(sprintf(nil "%s/%s" pwd file)) 
myPort=infile("./ADC_OUT.txt")
gets(nextLine myPort) ;dont take first
gets(nextLine myPort) ;dont take second
gets(nextLine myPort) ;dont take third
;gets(nextLine myPort) ;=> nextLine="    6e-9            -23.1308e-6       -23.1308e-6       -23.1308e-6       -23.1308e-6     \n"
;line=simStringsToList(car(parseString(nextLine "\n")))  ;=> ("6e-9" "-23.1308e-6" "-23.1308e-6" "-23.1308e-6" "-23.1308e-6")
;atof(car(line)) ;=> 6e-9
Vth=0.8
file="./ADC_OUTd.txt" 
pf = outfile( file)
while(gets(nextLine myPort) i++
line=simStringsToList(car(parseString(nextLine "\n")))  ;=> ("6e-9" "-23.1308e-6" "-23.1308e-6" "-23.1308e-6" "-23.1308e-6")
a0=atof(nth(1 line)) d0=if(a0>Vth 1 0)
a1=atof(nth(2 line)) d1=if(a1>Vth 1 0)
a2=atof(nth(3 line)) d2=if(a2>Vth 1 0)
a3=atof(nth(4 line)) d3=if(a3>Vth 1 0)
; OUT=d0+2*d1+4*d2+8*d3
OUT=d3+2*d2+4*d1+8*d0
printf("%d %d %d %d _ %g %g %g %g \n" d0 d1 d2 d3 a0 a1 a2 a3)
fprintf(pf "%10s\t%d\n" car(line) OUT)
)
close(pf)
edit(eval(file))


procedure(currentPulseRamp(@optional (T1 1.8m) (T2 3.7m) @rest rest)
(let ( t_step dt tr net pn name i pf netName bitList lr _duty Td f_ft _fr)
if(lr=assoc('f_fr rest) then _fr=eval(cadr(lr)) else _fr=25M)
if(lr=assoc('Td rest) then  _Td=eval(cadr(lr)) else  _Td=5u)
if(lr=assoc('duty rest) then  _duty=eval(cadr(lr)) else  _duty=0.5)
; _Td=5u ; T1=1.8m T2=3.7m
t_step=1.0/_fr
(set 'dt 0n)    ;; deltaTime variable temps
; tr= 0.1n ;; rise time
tr=t_step/100 ;; rise time
net="ADC_IN" pn='("n" "p") name="idc_" i=0
while( isFile( filename=sprintf(nil "%s/%s%d%s" pwd() name i ".scs")) i++)
pf=outfile(filename)
foreach(pol pn 
dt=0.0
netName=strcat(net pol)
fprintf(pf "I_%s (%s 0) isource type=pwl delay=0 wave=[ \\\n" netName netName)
bitList=linRg( T1 T2 _Td)
when(pol=="p" bitList=reverse(bitList))
foreach(bit bitList
fprintf(pf "%g %g %g %g\\\n" dt 0.0 dt+tr bit)
fprintf(pf "%g %g %g %g\\\n" dt+t_step*_duty bit dt+tr+t_step*_duty 0.0)
dt=dt+t_step) ""
fprintf(pf "]\n\n"))
printf("saved in %s\nDuty cycle : %g\n" filename _duty) close(pf) edit(eval(filename))
printf("From %s to %s with %s step in %s seconds.\n" aelSuffixNotation(T1) aelSuffixNotation(T2) aelSuffixNotation(_Td) aelSuffixNotation(dt) )
))
; currentPulseRamp(100n 10u '(Td 100n) '(f_fr 40M) '(duty 0.4))
; currentPulseRamp(100n 10u '(Td 50n) '(f_fr 40M) '(duty 0.4))
; currentPulseRamp(1n 1u '(Td 1n) '(f_fr 40M) '(duty 0.4)) ;=> 25us
; currentPulseRamp(1n 160n '(Td 0.05n) '(f_fr 40M) '(duty 0.4));=>79.53utoolong
;; currentPulseRamp(1n 160n '(Td 0.1n) '(f_fr 40M) '(duty 0.4)) ;=>37.28us
;; currentPulseRamp(1n 200n '(Td 0.1n) '(f_fr 40M) '(duty 0.4)) ;=>49.78u
;currentPulseRamp(10n 200n '(Td 0.2n) '(f_fr 40M) '(duty 0.4)) ;=>
; currentPulseRamp(10n 200n '(Td 0.4n) '(f_fr 40M) '(duty 0.4)) ;=>11.9us
currentPulseRamp(10n 400n '(Td 0.8n) '(f_fr 40M) '(duty 0.4)) ;=>11.9us

