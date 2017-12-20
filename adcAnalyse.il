; load "adcAnalyse.il"
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
when(dir resultsDir(dir) openResults(dir) selectResults('tran)  ); Avoid every :[?resultsDir dir ?result "tran"] in v(...) , simulator('spectre)
printf("dir:%s\nAvalable Results : %L\n" dir results())
;; ocnPrint( v("/OUT_PAD<0>")  v("/OUT_PAD<1>") v("/OUT_PAD<2>")  v("/OUT_PAD<3>")           ?output  afile ?from 6n ?to 15.24u ?step 4n ?format "engineering")
ocnPrint( v("/ADC_INp")  v("/ADC_INn") i("/I0/ADC_INp") i("/I0/ADC_INn")  ?output inFile ?from 5n ?to 15u ?step 4n ?format "engineering")
ocnPrint( v("/ADC_OUT<0>")  v("/ADC_OUT<1>") v("/ADC_OUT<2>")  v("/ADC_OUT<3>")     
v("/I0/C00_p")-v("/I0/C00_n") v("/I0/C01_p")-v("/I0/C01_n") v("/I0/C02_p")-v("/I0/C02_n") v("/I0/C03_p")-v("/I0/C03_n") v("/I0/C04_p")-v("/I0/C04_n") v("/I0/C05_p")-v("/I0/C05_n") v("/I0/C06_p")-v("/I0/C06_n") v("/I0/C07_p")-v("/I0/C07_n") v("/I0/C08_p")-v("/I0/C08_n") v("/I0/C09_p")-v("/I0/C09_n") v("/I0/C10_p")-v("/I0/C10_n") v("/I0/C11_p")-v("/I0/C11_n") v("/I0/C12_p")-v("/I0/C12_n") v("/I0/C13_p")-v("/I0/C13_n") v("/I0/C14_p")-v("/I0/C14_n") 
      ?output  afile ?from 5n ?to 15u ?step 4n ?format "engineering")
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

; for(i 0+4 14+4 printf("a%d=atof(nth(%d line)) d%d=if(a%d>0 1 0)\n" i i+1 i i))
a4=atof(nth(5 line)) d4=if(a4>0 1 0)
a5=atof(nth(6 line)) d5=if(a5>0 1 0)
a6=atof(nth(7 line)) d6=if(a6>0 1 0)
a7=atof(nth(8 line)) d7=if(a7>0 1 0)
a8=atof(nth(9 line)) d8=if(a8>0 1 0)
a9=atof(nth(10 line)) d9=if(a9>0 1 0)
a10=atof(nth(11 line)) d10=if(a10>0 1 0)
a11=atof(nth(12 line)) d11=if(a11>0 1 0)
a12=atof(nth(13 line)) d12=if(a12>0 1 0)
a13=atof(nth(14 line)) d13=if(a13>0 1 0)
a14=atof(nth(15 line)) d14=if(a14>0 1 0)
a15=atof(nth(16 line)) d15=if(a15>0 1 0)
a16=atof(nth(17 line)) d16=if(a16>0 1 0)
a17=atof(nth(18 line)) d17=if(a17>0 1 0)
a18=atof(nth(19 line)) d18=if(a18>0 1 0)

; OUT=d0+2*d1+4*d2+8*d3
OUT=d3+2*d2+4*d1+8*d0

;for(i 0+4 14+4 printf("d%d*%d+" i i-4+1 i-4+1))
; INCOMP=d4*1+d5*2+d6*3+d7*4+d8*5+d9*6+d10*7+d11*8+d12*9+d13*10+d14*11+d15*12+d16*13+d17*14+d18*15
;for(i 0+4 14+4 printf("d%d+" i i-4+1 i-4+1))
INCOMP=15-(d4+d5+d6+d7+d8+d9+d10+d11+d12+d13+d14+d15+d16+d17+d18)
; printf("%d %d %d %d _ %g %g %g %g \n" d0 d1 d2 d3 a0 a1 a2 a3)
fprintf(pf "%10s;%d;%s;%s;%s;%s;%d;;" car(line) OUT nth(1 inLine) nth(2 inLine) nth(3 inLine) nth(4 inLine) INCOMP)
;; for(i 0+4 14+4 printf(";%sd" "%"))
;; for(i 0+4 14+4 printf(" d%d" i))
fprintf(pf ";%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d" d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17 d18)
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
t_dirName="/group/validmgr/ebecheto/Sim/ADC_tb1/spectre/schematic"
; t_dirName="/group/validmgr/ebecheto/Sim/ADC_tb1/UltraSim/schematic"
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

;; why is that so slow ? Too much data ? : 24Go database !
;; ocnPrint( i("/I0/ADC_INp" ?resultsDir "/group/validmgr/ebecheto/Sim/ADC_tb1/spectre/schematic/psf" ?result "tran") i("/I0/ADC_INn" ?resultsDir "/group/validmgr/ebecheto/Sim/ADC_tb1/spectre/schematic/psf" ?result "tran") ?output "./myOutFile")


a=value(v("/S<0>" ?result "tran") 11.5n ?period 1n ?xName "time")
a=value(v("/S<0:10>" ?result "tran") 10.5n ?period 1n ?xName "time")
ocnPrint(a)
ocnPrint(a ?output strcat(pwd() "/tata.txt")  ?format "engineering" )
ineed('ocnPrint2list)
alist=ocnPrint2list(strcat(pwd() "/tata.txt"))
;=> list(list(temps S0 S1 S2 ...))

sommes=foreach(mapcar bits alist i=-1 sum=0
apply('plus foreach(mapcar bit cdr(bits) i=i+1 round(bit)*2**i)))
length(sommes)
;=> 2038

ineed('nthcdr2)

test=nthcdr2(0 20 sommes)
sommes='(0 1 2 4 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 22)
i=-1 remove(nil foreach(mapcan s sommes i++ if(i==s nil list(list(i s)))))
; [looks OK]
defun(checkCounterList (l_123) let((i)
"check if there are some erronous bits"
i=-1 remove(nil foreach(mapcan s l_123 i++ if(i==s nil list(list(i s)))))
))




b=(a-0.6)-abs(a-0.6)/(a-0.6)
b=(a-0.6)+abs(a-0.6)/2.0/(a-0.6)
plot(b)
ocnPrint(b)

bus=awvAnalog2Digital(v("/S<0:10>" ?result "tran") nil nil 0.6 1 "centre" )
; ocnPrint(bus);<= fail
