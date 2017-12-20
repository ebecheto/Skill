; load("/home/validmgr/ebecheto/Skill/plotGrr.il")

(ENC_PA3 = ((sqrt(iinteg((getData("out" ?result "PA3-noise")**2))) * -1 * VAR("Qin")) / 1.6e-19 / ((((VAR("Qin") - abs(VAR("Qin"))) / (2 * VAR("Qin"))) * (ymax(VT("PA3")) - VDC("PA3"))) - (((VAR("Qin") + abs(VAR("Qin"))) / (2 * VAR("Qin"))) * (VDC("PA3") - ymin(VT("PA3")))))))

plot(ENC_PA3)

(ENC_PA4 = ((sqrt(iinteg((getData("out" ?result "PA4-noise")**2))) * -1 * VAR("Qin")) / 1.6e-19 / ((((VAR("Qin") - abs(VAR("Qin"))) / (2 * VAR("Qin"))) * (ymax(VT("PA4")) - VDC("PA4"))) - (((VAR("Qin") + abs(VAR("Qin"))) / (2 * VAR("Qin"))) * (VDC("PA4") - ymin(VT("PA4")))))))

signals=list(ymax(ENC_PA3))
signals=append(signals list(ymax(ENC_PA4)))

sigNames=list("ENC3" "ENC4")
awvPlotWaveform(currentWindow() || newWindow() signals ?expr sigNames  ?stripNumber list(1 2))

peakTime=xmax(v("PA3" ?result "tran") 1 )-2u
plot(peakTime)


GconvPA3 = (-1 * ((((VAR("Qin") - abs(VAR("Qin"))) / 2 / (VAR("Qin")**2)) * 
(ymax(VT("PA3")) - VDC("PA3"))) - (((VAR("Qin") + abs(VAR("Qin"))) / 2 / (VAR("Qin")**2)) * 
(VDC("PA3") - ymin(VT("PA3"))))) * 1e-12)

plot(GconvPA3)

plot(VT("PA3"))

;; Fu=cross(db(mag(getData("loopGain" ?result "stb"))) 0 1 "either" nil nil  )
;; plot(Fu)

plot(db(mag(getData("loopGain" ?result "stb"))))


VOUT=ymax(VT("PA3")) - VDC("PA3")
plot(VOUT)

plot(VN2())


dname=sprintf(nil "%s/%s" pwd() "data.dat")
; ocnPrint(ENC_PA3 ?output dname ?format "engineering")
; ocnPrint(ymax(ENC_PA3) ?output dname ?format "engineering")


ineed('gplinFit)
gplinFit(ymax(ENC_PA3))
wave=clip(ymax(ENC_PA_1) 40p 250p )
gplinFit(wave)
gplinFit(ymax(ENCPA_1))
gplinFit((ymax(VT("/PA_1")) - VDC("/PA_1")))


gplinFit(ymax(ENC_PA_1))
