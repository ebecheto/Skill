;; cross(VT("/Sync_10") 0.6 1 "falling"  t "time"  )
; 1/freq(VT(name dir) "rising" ?xName "time" ?mode "user" ?threshold 0.6)
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc4_sim/spectre/schematic"

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

; ycounts=foreach(mapcar xts syncs foreach(mapcar xt xts cntVal(xt)))


;; wave=VT("/CNT<0:10>" dir)
;; y=drGetWaveformYVec(wave)
;; len=drVectorLength(y)
;; ycnt=foreach(mapcar i linRg(0 len-1 1) drGetElem(y i)) ;=>(7.45547e-08)
;; cnt=caar(syncs);=>  7.45547e-08
;; cnts=ocnPrint3(value(VT("/CNT<0:10>" dir) cnt))
;; cnts=ocnPrint3(value(VT("/CNT<0:10>" dir) car(nth(1 syncs))))
;; ;=>(("/CNT<0>" 5.364274e-06) ("/CNT<1>" 3.640595e-07) ("/CNT<2>" 3.640879e-07) ("/CNT<3>" 1.2) ("/CNT<4>" 1.2) ("/CNT<5>" 2.454006e-07) ("/CNT<6>" 2.454006e-07) ("/CNT<7>" 2.454007e-07) ("/CNT<8>" 2.454007e-07) ("/CNT<9>" 2.454009e-07) ("/CNT<10>" 2.454355e-07))
;; i=-1 sum=apply('plus foreach(mapcar c cnts i++ if(cadr(c)>Vth 1 0)*2**i))
;; sum


Vth=0.6
Sf=373
S=15003
L=11
bus="_"
bud=if(bus=="<" ">" "")


file=strcat(pwd() "/" "tdc_" a2s(S) "_" a2s(Sf) ".dat"); => "/home/validmgr/ebecheto/Work/IBMv18/tdc_15003_373.dat"
po=outfile(file "w")
fprintf(po ";saveData.il %s\n" getCurrentTime())


;; cross data
syncs='()
for(i 0 L-1
name=strcat("Sync" bus a2s(i) bud)
wave=cross(VT(name dir) 0.6 1 "falling" t "time")
if(wave then
y=drGetWaveformYVec(wave)
len=drVectorLength(y)
ys=foreach(mapcar i linRg(0 len-1 1) drGetElem(y i)) ;=>(7.45547e-08)
else
ys=nil
)
syncs=append(syncs list(ys))
;fprintf(po "%s='%L\n" name ys)
)

syncs;=>((8.15979e-08) (6.888739e-08) nil (4.521207e-08) (3.156215e-08) nil (4.276305e-08) (1.014031e-08) (6.972957e-08) nil (7.45547e-08))
; foreach(mapcar s syncs printf("%s\n" aelSuffixNotation(car(s)||0)))

; COUNRTER DATA
ycounts=foreach(mapcar xts syncs foreach(mapcar xt xts cntVal(xt)))
outs=mapcar('list syncs ycounts)

;; SAVE SYNC && COUNTER
i=-1 foreach(mapcar out outs i++  fprintf(po "%s='%L\n" strcat("Sync_" a2s(i)) out))


for(i 0 L-1
yc=foreach(mapcar cnt ys
wave=value(VT("/CNT<0:10>" dir) cnt)
y=drGetWaveformYVec(wave)
x=drGetWaveformXVec(wave)
len=drVectorLength(y)
ys=foreach(mapcar i linRg(0 len-1 1) drGetElem(y i)) ;=>(7.45547e-08)



; freq data
;; cross data
foreach(sortie '("Qf" "Q")
fprintf(po "\n")
for(i 0 L-1
name=strcat("/I0/" sortie "<" a2s(i) ">")
wave=1/freq(VT(name dir) "rising" ?xName "time" ?mode "user" ?threshold 0.6)
fprintf(po "%s='%L\n" buildString(parseString(name "/<>") "_") value(wave -1))
))


outportp(po)
close(po)
edit(eval(file))
