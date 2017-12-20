; values printed at -150°C
aa=foreach(mapcar i linRg(1 7 1) VDC(sprintf(nil "Cb%d" i)))
;=>(2.31271 2.310301 2.305562 2.29632 2.278763 2.246797 2.193614)
ba=foreach(mapcar i linRg(1 7 1) VDC(sprintf(nil "Cm%d" i)))
(println ba)
aba=append(reverse(ba) aa)
println(foreach(mapcar a aba printf("%.4g\n" a)))

aa=foreach(mapcar i linRg(1 6 1) VDC(sprintf(nil "Cb%d" i))-VDC(sprintf(nil "Cb%d" i+1)))
(println aa);=> (-0.0015 -0.003000001 -0.006000001 -0.012 -0.024 -0.04800001)
aa=foreach(mapcar i linRg(1 6 1) VDC(sprintf(nil "Cm%d" i))-VDC(sprintf(nil "Cm%d" i+1)))
(println aa);=> (0.0015 0.003000001 0.006000001 0.012 0.024 0.04800001)

aa=foreach(mapcar i linRg(1 6 1) VDC(sprintf(nil "Rp%d" i))-VDC(sprintf(nil "Rp%d" i+1)))
(println aa)
println foreach(mapcar a aa aelSuffixNotation(a))
;=>("-1.22m" "-2.468m" "-4.983m" "-10.26m" "-21.71m" "-48.96m")

aa=foreach(mapcar i linRg(1 6 1) VDC(sprintf(nil "Rm%d" i))-VDC(sprintf(nil "Rm%d" i+1)))
(println aa)
println foreach(mapcar a aa aelSuffixNotation(a))
;=>("1.206m" "2.399m" "4.721m" "9.207m" "17.49m" "31.85m")

 
foreach(mapcar i linRg(1 7 1) printf("Rm%d " i))
foreach(mapcar i linRg(1 7 1) printf("Rp%d " i))
;; 2.534
;; 2.406
;; 2.357
;; 2.335
;; 2.325
;; 2.32
;; 2.318
;; VDC("/VDCPA")=2.3125
;; 2.313
;; 2.31
;; 2.306
;; 2.296
;; 2.279
;; 2.247
;; 2.194