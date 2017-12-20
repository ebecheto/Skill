;; cross(VT("/Sync_10") 0.6 1 "falling"  t "time"  )
dir="/home/validmgr/ebecheto/Work/IBMv18/Sim/tdc4_sim/spectre/schematic"

;; wave=cross(VT("/Sync_10" dir) 0.6 1 "falling"  t "time" )
;; wave=cross(VT("/Sync_2" dir) 0.6 1 "falling"  t "time" );=> nil

;; if(wave then
;; y=drGetWaveformYVec(wave)
;; len=drVectorLength(y)
;; ys=foreach(mapcar i linRg(0 len-1 1) subWave=drGetElem(y i)) ;=>(7.45547e-08)
;; else
;; ys=nil
;; )
;; fprintf(fp "%s='%L\n" name ys) 

Sf=373
S=15003
L=11
bus="_"
bud=if(bus=="<" ">" "")

;; ineed('ocnPrint2list)
;; srw='()
;; i=10
;; for(i 0 L-1
;; name=strcat("Sync" bus a2s(i) bud)
;; printf("name:%s\n" name )
;; sr=cross(VT(name dir) 0.6 1 "falling" t "time")
;; srw=cons(cross(VT(name) 0.6 1 "falling" t "time") srw)
;; )
;; rev=reverse(srw)
;; rev=append(rev list(?output fp ?format "engineering"))
;; ; (srrWave:0x18d2d118 srrWave:0x18d2d128 nil srrWave:0x18d2d138 srrWave:0x18d2d148 nil srrWave:0x18d2d158 srrWave:0x18d2d168 srrWave:0x18d2d178 nil srrWave:0x18d2d188 ?output "/home/validmgr/ebecheto/Work/IBMv18/tdc_15003_373.dat" ?format "engineering")
;; apply('ocnPrint rev)


file=strcat(pwd() "/" "tdc_" a2s(S) "_" a2s(Sf) ".dat"); => "/home/validmgr/ebecheto/Work/IBMv18/tdc_15003_373.dat"
po=outfile(file "w")

for(i 0 L-1
name=strcat("Sync" bus a2s(i) bud)
wave=cross(VT(name dir) 0.6 1 "falling" t "time")
if(wave then
y=drGetWaveformYVec(wave)
len=drVectorLength(y)
ys=foreach(mapcar i linRg(0 len-1 1) subWave=drGetElem(y i)) ;=>(7.45547e-08)
else
ys=nil
)
fprintf(po "%s='%L\n" name ys) 
)

outportp(po)

close(po)
edit(eval(file))
