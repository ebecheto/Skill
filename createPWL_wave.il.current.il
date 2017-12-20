procedure(currentWave(@optional 
(netName "ADC_INp")
(data list(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) ); linRg( 0 15 1 )
(rise -1)  ;; si croissant:1 si decroissant -1
(istep 100u)
(dt 0n)    ;; deltaTime variable temps
(tr 0.01n) ;; rise time
(f_fr 250M)
)
t_step=1.0/f_fr
IDC0=istep*15.0/2
;; variable IDC a mettre dans ADE et sur schema dans un idc
printf("I_%s (%s 0) isource type=pwl delay=t_delay 
wave=[ \\\n" 
netName netName)
foreach(bit data 
IN=rise*IDC0-rise*bit*istep
printf("%g %g %g %g\\\n" dt+tr IN dt+t_step IN)
dt=dt+t_step
); end foreach
printf("]\n")
); fin proc

; load("createPWL_wave.il")
; "USAGE : currentWave("ADC_INp" list(0 1 2 3) 1 100u)
printf("currentWave(\"ADC_INp\" list(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0)  1)\n")
printf("currentWave(\"ADC_INn\" list(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0) -1)\n")


procedure(currentADC(@optional 
(netName "ADC_INp")
(data list(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) )
(rise -1)  ;; si croissant:1 si decroissant -1
(istep 100u)
(dt 0n)    ;; deltaTime variable temps
(tr 0.01n) ;; rise time
(f_fr 250M)
)

;; variable IDC a mettre dans ADE et sur schema dans un idc
printf("I_%s (%s 0) isource type=pwl delay=t_delay 
wave=[ \\\n" 
netName netName)

foreach(bit data 
IN=rise*IDC0-rise*bit*istep
printf("%g %g %g %g\\\n" dt+tr IN dt+t_step IN)
dt=dt+t_step
); end foreach

printf("]\n")
); fin proc


procedure(currentADC()
(set 'istep 100u)
(set 'dt 0n)    ;; deltaTime variable temps
(set 'tr 0.01n) ;; rise time
(set 'netName "ADC_INp")
printf("I_%s (%s 0) isource type=pwl delay=0 
wave=[ \\\n" 
netName netName)
foreach(bit linRg( 1.8m 3.8m 5u )
printf("%g %g %g %g\\\n" dt+tr bit dt+t_step bit)
dt=dt+t_step) ""
printf("]\n")
)



(set 'f_fr 250M)
t_step=1.0/f_fr

procedure(currentADC()
(set 'dt 0n)    ;; deltaTime variable temps
(set 'tr 0.01n) ;; rise time
(set 'netName "ADC_INp")
printf("I_%s (%s 0) isource type=pwl delay=0 
wave=[ \\\n" 
netName netName)
foreach(bit reverse(linRg( 1.8m 3.7m 5u ))
printf("%g %g %g %g\\\n" dt+tr bit dt+t_step bit)
dt=dt+t_step) ""
printf("]\n")
)



procedure(currentADCramp()
f_fr=250M t_step=1.0/f_fr
(set 'dt 0n)    ;; deltaTime variable temps
(set 'tr 0.01n) ;; rise time
net="ADC_IN_"
pn='("n" "p")
name="idc_" i=0
while( isFile( filename=sprintf(nil "%s/%s%d%s" pwd() name i ".scs")) i++)
pf = outfile(filename)
foreach(pol pn 
netName=strcat(net pol)
fprintf(pf "I_%s (%s 0) isource type=pwl delay=0 
wave=[ \\\n" 
netName netName)
bitList=linRg( 1.8m 3.7m 5u )
when(pol=="p" bitList=reverse(bitList))
foreach(bit bitList
fprintf(pf "%g %g %g %g\\\n" dt+tr bit dt+t_step bit)
dt=dt+t_step) ""
fprintf(pf "]\n\n")
)
printf("saved in %s\n" filename)
close(pf)
edit(eval(filename))
)