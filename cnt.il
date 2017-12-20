; load("cnt.il")
unless(fboundp('ocnPrint2list) load("ocnPrint2list.il"))

;; tmp=cross(VT("/S<1>") 1 1 "rising" t "time")
;; (system "rm -f tata.tmp")


;; ;a2d
;;S=awvAnalog2Digital(v("/S<1:10>" ?result "tran-tran") nil nil 0.9 1 "centre" )
;; S1=awvAnalog2Digital(v("/S<1>" ?result "tran-tran") nil nil 0.9 1 "centre" )
;; S2=awvAnalog2Digital(v("/S<2>" ?result "tran-tran") nil nil 0.9 1 "centre" )


;; ;;S1+S2
;; ocnPrint(S1)
;; ocnPrint(S2)
;; plot(S1)
;; plot(S2)
 plot(S)

;; res="" foreach(mapcar i linRg(1 10 1) when(i!=1 res=strcat(res "+"))
;; res=sprintf(nil "%s2**%d*VT(\"/S<%d>\")/1.8" res i-1 i))
;; printf(res)
;; Sum=evalstring(res)
;; plot(Sum) 

;; d=3n;delay
;; x=0
;; round(value(Sum d+x))

;; foreach(mapcar x linRg(3 599 1)
;; when(round(value(Sum x*1n))!=x-2 
;; printf("Error at time %s x-2=%d, value=%g\n" aelSuffixNotation(x*1n) x-2 value(Sum x*1n)))) t

;; ;;=> errors are only due to 2**i time adjustment of the swing not stable @~1.8V
;; ;This is not a 'real' error !
;; ;; I should use a2d


;; S1=awvAnalog2Digital(VT("/S<1>") nil nil 0.9 1 "centre")w

;; res="" foreach(mapcar i linRg(1 10 1) when(i!=1 res=strcat(res "+"))
;; res=sprintf(nil "%s2**%d*awvAnalog2Digital(VT(\"/S<%d>\") nil nil 0.9 1 \"centre\")/5" res i-1 i))
;; printf(res)
;; Sum=evalstring(res)
;; plot(Sum) 
;; ;; still having the visual problem when using the 'bus' display, the data is correct ! => filter with value(multiple) => 

;; ;value(v("/S<1>" ?result "tran-tran") 3n  ?period 1n ?xName "time"  )

;; res="" foreach(mapcar i linRg(1 10 1) when(i!=1 res=strcat(res "+"))
;; res=sprintf(nil "%s2**%d*awvAnalog2Digital(value(VT(\"/S<%d>\") 0 ?period 1n ?xName \"time\") nil nil 0.9 1 \"centre\")/5" res i-1 i))
;; printf(res)
;; Sum=evalstring(res)
;; plot(Sum) 

;; foreach(mapcar x linRg(3 599 1)
;; when(round(value(Sum x*1n))!=x-2 
;; printf("Error at time %s x-2=%d, value=%g\n" aelSuffixNotation(x*1n) x-2 value(Sum x*1n)))) t




res="" foreach(mapcar i linRg(1 10 1) when(i!=1 res=strcat(res "+"))
res=sprintf(nil "%s2**%d*value(VT(\"/S<%d>\") 0 ?period 1n ?xName \"time\")/1.8" res i-1 i))
printf(res)
Sum=evalstring(res)
plot(Sum) 

foreach(mapcar x linRg(3 599 1)
when(round(value(Sum x*1n))!=x-2 
printf("Error at time %s x-2=%d, value=%g" aelSuffixNotation(x*1n) x-2 value(Sum x*1n))
vals=foreach(mapcar i linRg(1 10 1) value(evalstring(sprintf(nil "VT(\"/S<%d>\")" i)) x*1n))
printf("vals%L\n" vals)
real=0
foreach(mapcar i linRg(1 10 1) real=real+2**(i-1)*round(value(evalstring(sprintf(nil "VT(\"/S<%d>\")" i)) x*1n)/1.8))
when(real==x-2 printf("real=%d=x=%d !=> not an error!\n" real x-2))
)) t




;; ;;Sum=VT("/S<1>")+VT("/S<2>")+VT("/S<3>")+VT("/S<4>")+VT("/S<5>")+VT("/S<6>")+VT("/S<7>")+VT("/S<8>")+VT("/S<9>")+VT("/S<10>")

;; value(S 150n)
;; ocnPrint(value(S 150n))
;; ;; bit               value((awvAnalog2Digital v("/S<1:10>" ?resultsDir "/home/validmgr/ebecheto/Work/h18/Sim/cnt10-bitHA_sim/spectre/schematic/psf" ?result "tran") 0.9 1 "centre") 1.5e-07) (V)

;; ;; /S<10>            0                 
;; ;; /S<1>             0                 
;; ;; /S<2>             0                 
;; ;; /S<3>             5                 
;; ;; /S<4>             0                 
;; ;; /S<5>             5                 
;; ;; /S<6>             0                 
;; ;; /S<7>             0                 
;; ;; /S<8>             5                 
;; ;; /S<9>             0           
