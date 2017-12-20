; IT("/R8/MINUS")

itlist='(1 8 10 15 19 20)
i=0
foreach(mapcar it itlist 
i++
printf( "plot(IT(\"/R%d/MINUS\") ?expr list(\"y%d\"))\n" it i)
; plot(IT(sprintf(nil "/R%d/MINUS" it)) ?expr list(sprintf(nil "y%d" it)))
)


itlist='(6 12 13 14 18 21)
i=0
foreach(mapcar it itlist 
i++
printf( "plot(IT(\"/R%d/MINUS\") ?expr list(\"yb%d\"))\n" it i)
; plot(IT(sprintf(nil "/R%d/MINUS" it)) ?expr list(sprintf(nil "y%d" it)))
)




vtlist='(net0308 net155 net0324 net0306 net159 net0314)
i=0
foreach(mapcar vt vtlist
i++
printf( "plot(VDC(\"/%L\") ?expr list(\"vdc%d\"))\n" vt i)
aelSuffixNotation(VDC(vt)-VDC("OUTSF"))
; plot(VT(sprintf(nil "/R%d/MINUS" vt)) ?expr list(sprintf(nil "y%d" vt)))
)
;=> ("3.863m" "7.528m" "14.9m" "30.05m" "61.97m" "133.2m") @30°C
;=> ("3.54m" "6.903m" "13.67m" "27.6m" "56.97m" "122.7m") @-30°C
;=> ("3.149m" "6.137m" "12.16m" "24.55m" "50.73m" "109.5m")@-90°C

vtlist='(net0322 net0319 net0325 net0307 net0311 net0315 )
i=0
foreach(mapcar vt vtlist
i++
printf( "plot(VDC(\"/%L\") ?expr list(\"vdc%d\"))\n" vt i)
aelSuffixNotation(VDC(vt)-VDC("OUTSF"))
; plot(VT(sprintf(nil "/R%d/MINUS" vt)) ?expr list(sprintf(nil "y%d" vt)))
)
;=> ("-3.337m" "-6.903m" "-13.91m" "-27.62m" "-53.76m" "-101.8m") @30°C
;=> ("-3.069m" "-6.341m" "-12.77m" "-25.34m" "-49.29m" "-93.19m") @-30°C
;=> ("-2.725m" "-5.631m" "-11.35m" "-22.5m" "-43.73m" "-82.53m") @-90°C

;; vts=list("-3.069m" "-6.341m" "-12.77m" "-25.34m" "-49.29m" "-93.19m")
;; ; int(awvAnalog2Digital(3.3-VT("/ysf_1b") nil nil 0.5 1 "centre" ))/5
;; its=foreach(mapcar vt vts aelSuffixNotation(aelNumber(vt)/333k))
;; i=0
;; itas=foreach(mapcar vt vts i++ list(sprintf(nil "ybi_%d" i) aelSuffixNotation(aelNumber(vt)/333k)))

;; wave=VT("/ysf_1b")
;; wave=wave+VT("/ysf_2b")
;; wave=wave+VT("/ysf_3b")
;; plot(wave)


vtn='(net0308 net155 net0324 net0306 net159 net0314)
vtnb='(net0322 net0319 net0325 net0307 net0311 net0315) 
i=0 wave=0
foreach(mapcar vt vtn i++
wave=wave+(VDC(vt)-VDC("OUTSF"))/333k*(3.3-VT(sprintf(nil "/ysf_%d" i)))
wave=wave+(VDC(nth(i-1 vtnb))-VDC("OUTSF"))/333k*(3.3-VT(sprintf(nil "/ysf_%db" i)))
; plot(VT(sprintf(nil "/R%d/MINUS" vt)) ?expr list(sprintf(nil "y%d" vt)))
)

plot(wave)
aa=iinteg(wave)
plot(aa)
aa=iinteg(wave)/xval(wave)
plot(aa)


