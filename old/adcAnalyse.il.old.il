; load "adcAnalyse.il.old.il"
load "parseRingScurve.il"

;; I1=VAR("I1") I1s=aelSuffixNotation(I1)
;; I2=VAR("I2") I2s=aelSuffixNotation(I2)


procedure(printADC(@key (I1s aelSuffixNotation(VAR("I1"))) (I2s aelSuffixNotation(VAR("I2"))) (dir nil) )
let((afile file inFile myPort Vth pf a0 a1 a2 a3 OUT cmd)
Vth=0.8  
when(!I1s I1s="def") when(!I2s I2s="def")
; "/ADC_INn" 
; awvPrintWaveform( ?output "./ADC_INp.txt" VT("/ADC_INp") ?from 6n ?to 15.24u ?step 4n ?format "engineering")
afile= sprintf(nil  "./ADC_OUT_%s-%s_%s.txt" I1s I2s if(dir car(last(parseString(dir "/"))) ""))
file=  sprintf(nil "./ADC_OUTd_%s-%s_%s.csv" I1s I2s if(dir car(last(parseString(dir "/"))) ""))
inFile=sprintf(nil   "./ADC_IN_%s-%s_%s.txt" I1s I2s if(dir car(last(parseString(dir "/"))) ""))
when(dir resultsDir( dir) openResults(dir) selectResults('tran)  ; Avoid every :[?resultsDir dir ?result "tran"] in v(...)
printf("dir:%s\nAvalable Results : %L\n" dir results()) )
;; ocnPrint( v("/OUT_PAD<0>")  v("/OUT_PAD<1>") v("/OUT_PAD<2>")  v("/OUT_PAD<3>")           ?output  afile ?from 6n ?to 15.24u ?step 4n ?format "engineering")
ocnPrint( v("/ADC_INp")  v("/ADC_INn") i("/I0/ADC_INp") i("/I0/ADC_INn")  ?output inFile ?from 5n ?to 15u ?step 4n ?format "engineering")
;; myPort=infile(sprintf(nil "%s/%s" pwd file)) 
myPort=infile(afile);analog file
inPort=infile(inFile)
gets(nextLine myPort) gets(inLine inPort) ;dont take first
gets(nextLine myPort) gets(inLine inPort) ;dont take second
gets(nextLine myPort) gets(inLine inPort) ;dont take third
;gets(nextLine myPort) ;=> nextLine="    6e-9            -23.1308e-6       -23.1308e-6       -23.1308e-6       -23.1308e-6     \n"
;line=simStringsToList(car(parseString(nextLine "\n")))  ;=> ("6e-9" "-23.1308e-6" "-23.1308e-6" "-23.1308e-6" "-23.1308e-6")
;atof(car(line)) ;=> 6e-9
pf = outfile( file)
while(gets(nextLine myPort) gets(inLine inPort) inLine=simStringsToList(inLine)
line=simStringsToList(car(parseString(nextLine "\n")))  ;=> ("6e-9" "-23.1308e-6" "-23.1308e-6" "-23.1308e-6" "-23.1308e-6")
a0=atof(nth(1 line)) d0=if(a0>Vth 1 0)
a1=atof(nth(2 line)) d1=if(a1>Vth 1 0)
a2=atof(nth(3 line)) d2=if(a2>Vth 1 0)
a3=atof(nth(4 line)) d3=if(a3>Vth 1 0)

; OUT=d0+2*d1+4*d2+8*d3
OUT=d3+2*d2+4*d1+8*d0

fprintf(pf "%10s;%d;%s;%s;%s;%s;;" car(line) OUT nth(1 inLine) nth(2 inLine) nth(3 inLine) nth(4 inLine) )
fprintf(pf "\n")
)
close(pf)
; edit(eval(file)) 
;; sed '1,3d'
cmd=sprintf(nil "cp \"%s\" ~/group/Asic/HSL/Test_HSL_HM\n" file)
(system cmd)
(print cmd)
;; cmd=sprintf(nil "cp \"%s\" ~/group/Asic/HSL/Test_HSL_HM\n" afile)
;; (system cmd)
;; cmd=sprintf(nil "cp \"%s\" ~/group/Asic/HSL/Test_HSL_HM\n" inFile)
;; (system cmd)
file ))

;; printADC("1.8m" "3.4m") 
;; I1s=aelSuffixNotation(VAR("I1"))
;; I2s=aelSuffixNotation(VAR("I2"))
;; file=  sprintf(nil "./ADC_OUTd_%s-%s.txt" I1s I2s)

;; ; simulator('spectre)
;; ; dir="/group/validmgr/ebecheto/Sim/ADC_tb1/spectre/schematic/psf"
;; simulator('UltraSim)
;; t_dirName="/group/validmgr/ebecheto/Sim/ADC_tb1/UltraSim/schematic"
;; resultsDir( t_dirName )
;; psfDir=strcat(t_dirName "/psf" )
;; resultsDir( psfDir) openResults(psfDir) selectResults('tran);<= marche aussi avec psf.
;; results ;=> (dcOpInfo dcOp variables tran)
;; openResults(t_dirName) ;=> "/data/ebecheto/Sim/ADC_tb1/UltraSim/schematic"
;; selectResults('tran)
;; ; and chekc license



simulator('spectre)
; t_dirName="/group/validmgr/ebecheto/Sim/ADC_tb1/spectre/schematic"
t_dirName="/group/validmgr/ebecheto/Sim/ADC_tb1/UltraSim/schematic"
dir=strcat(t_dirName "/psf")
file=printADC(?dir dir)
Scurve(file)
edit(eval(file))

;; ADEdir="/group/validmgr/ebecheto/Sim/ADC_tb1/UltraSim/schematic/"
;; for( i 0 6 
;; dir=sprintf(nil "%s%s%d" ADEdir "psf" i )
;; file=printADC(?dir dir)
;; Scurve(file)
;; )


;; ; ocnPrint(list( v("/ADC_OUT<0>")  v("/ADC_OUT<1>") v("/ADC_OUT<2>")  v("/ADC_OUT<3>"))        ?from 5n ?to 15u ?step 4n ?format "engineering")
;; a=list( v("/ADC_OUT<0>")  v("/ADC_OUT<1>") v("/ADC_OUT<2>")  v("/ADC_OUT<3>"))
;; ocnPrint(sprintf(nil "%L" a)        ?from 5n ?to 15u ?step 4n ?format "engineering")

;; for(i 0 14 printf("v(%L)-v(%L) " sprintf(nil "/I0/C%2.2d_p"  i) sprintf(nil "/I0/C%2.2d_n"  i) ));=> ok pour la copie manuelle
