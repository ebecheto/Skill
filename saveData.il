; load("saveData.il")
;; cross(VT("/Sync_10") 0.6 1 "falling"  t "time"  )
; 1/freq(VT(name dir) "rising" ?xName "time" ?mode "user" ?threshold 0.6)
;; dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc4_sim/spectre/schematic"
;; dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc5_sim/spectre/schematic"

unless(dir dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc6_sim/spectre/schematic")

dis="/group/validmgr/Sim/tdc/"

defun(i2s (i) cond((type(i)=='fixnum sprintf(nil "%d" i))(type(i)=='flonum sprintf(nil "%g" i))))

defun(ocnPrint3 (wave)
y=drGetWaveformYVec(wave)
x=drGetWaveformXVec(wave)
len=drVectorLength(y)
ys=foreach(mapcar i linRg(0 len-1 1) drGetElem(y i)) ;=>(7.45547e-08)
xs=foreach(mapcar i linRg(0 len-1 1) drGetElem(x i)) ;=>(7.45547e-08)
mapcar('list xs ys)
)

defun(cntVal (@optional (xt 7.45547e-08)(wave VT("/CNT<0:10>" dir)) (Vth 0.6)) let((i sum cnts) sum=0
cnts=ocnPrint3(value(wave xt)) ;=>(("/CNT<0>" 5.364274e-06) ("/CNT<1>" 3.640595e-07) ("/CNT<2>" 3.640879e-07) ("/CNT<3>" 1.2) ("/CNT<4>" 1.2) ("/CNT<5>" 2.454006e-07) ("/CNT<6>" 2.454006e-07) ("/CNT<7>" 2.454007e-07) ("/CNT<8>" 2.454007e-07) ("/CNT<9>" 2.454009e-07) ("/CNT<10>" 2.454355e-07))
i=-1 sum=apply('plus foreach(mapcar c cnts i++ if(cadr(c)>Vth 1 0)*2**i))
sum
))



Vth=0.6
Sf=VAR("Sf");=>1077
S=VAR("S");=>1199
L=11
bus="_"
bud=if(bus=="<" ">" "")


file=strcat(dis "/" "tdc_" i2s(S) "_" i2s(Sf) ".dat"); => "/home/validmgr/ebecheto/Work/IBMv18/tdc_15003_373.dat"
po=outfile(file "w")
fprintf(po ";saveData.il %s\n" getCurrentTime())


;; cross data
syncs='() for(i 0 L-1
name=strcat("Sync" bus i2s(i) bud)
wave=cross(VT(name dir) 0.6 1 "falling" t "time")
ys=when(wave 
y=drGetWaveformYVec(wave)
len=drVectorLength(y)
foreach(mapcar i linRg(0 len-1 1) drGetElem(y i)) ;=>(7.45547e-08)
)
syncs=append(syncs list(ys))
;fprintf(po "%s='%L\n" name ys)
)

; syncs;=>((8.15979e-08) (6.888739e-08) nil (4.521207e-08) (3.156215e-08) nil (4.276305e-08) (1.014031e-08) (6.972957e-08) nil (7.45547e-08))
; foreach(mapcar s syncs printf("%s\n" aelSuffixNotation(car(s)||0)))

; COUNRTER DATA
ycounts=foreach(mapcar xts syncs foreach(mapcar xt xts cntVal(xt))) ;<= prends un peu de tmps si longue simu
yfcounts=foreach(mapcar xts syncs foreach(mapcar xt xts cntVal(xt VT("/I0/CNT2<0:10>"))));<= idem
;outs=mapcar('list syncs ycounts)
outs='()
for(i 0 length(syncs) outs=append(outs list(list(nth(i syncs) nth(i ycounts) nth(i yfcounts)))))
outs

;; deltaCnt=foreach(mapcar sy syns 
;; x0=0 foreach(mapcar c cadr(sy)
;; d=c-x0 x0=c d))
;; deltaCnt


;; SAVE SYNC && COUNTER
i=-1 foreach(mapcar out outs i++  fprintf(po "%s='%L\n" strcat("Sync_" i2s(i)) out))


; freq data
;; cross data
foreach(sortie '("Qf" "Q")
fprintf(po "\n")
for(i 0 L-1
name=strcat("/I0/" sortie "<" i2s(i) ">")
wave=1/freq(VT(name dir) "rising" ?xName "time" ?mode "user" ?threshold 0.6)
fprintf(po "%s='%L\n" buildString(parseString(name "/<>") "_") value(wave -1))
))


close(po)

edit(eval(file))

;  e x i t ();<= c'est pour qu'ocean quitte en fin de fichier Attention ca tue virtuoso
