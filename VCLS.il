load "~/../ebecheto/Skill/ocnPrint2list.il"
dir="/group/validmgr/deng/Sim/VCDL_2_sim/spectre/config/"
; OUTc=cross(v("/COUT" ?result "tran") 1.25 1 "rising" nil nil)
when(dir resultsDir(dir) openResults(dir) selectResults('tran)  )


OUT=cross(VT("/OUT") 1.65 1 "rising"  t "time" )
file=sprintf(nil "%s/%s" pwd() "OUT.txt")
ocnPrint(OUT ?output file)
lfile=ocnPrint2list(file)



cross(VT("/C00plus_bit_n")-VT("/C14minus_bit_p") 0 1 "falling" nil nil  )
IN=cross(VT("/C14minus_bit_p")-VT("/C00plus_bit_n") 0 1 "rising" nil nil  )

file=sprintf(nil "%s/%s" pwd() "comparatorIN.txt")
ocnPrint(IN ?output file)
lfile=ocnPrint2list(file)

x1=0 x2=0 res=cdr(foreach(mapcar line lfile x1=x2 x2=cadr(line) x2-x1 ))

foreach(mapcar r res aelSuffixNotation(r))



;; plot(expr( x nth(x res) linRg(0 13 1) ) ?expr '("deltaStep (us)"))

;; ; I1=1.8m I2=3.7m
;; I1=value(VAR("I1"),0); VAR("I1")
;; I2=value(VAR("I2"),0); VAR("I2")
;; ; duree=VAR("endTime")
;; duree=value(VAR("endTime"),0)
;; mAus=(I1-I2)/duree

;; plot(expr( x nth(x res)*mAus linRg(0 13 1) ) ?expr '("deltaStep (A)"))

;; compWid=awvCreatePlotWindow()
;; awvGetSubwindowList(compWid)
;; pos = list(0.5 0.95)
;; hi = 10
;; awvDisableRedraw( compWid t )
;; for(i 0 14 
;; when(i!=0 x_subwindow = awvAddSubwindow( compWid ) )
;; Title=sprintf(nil "bit-%d" i)
;; awvPlaceWindowLabel(compWid pos Title nil ?height hi )
;; plot(value(v("/C00plus_bit_n"),"bit" i))
;; plot(value(v("/C14minus_bit_p"),"bit" i))
;; )
;; awvDisableRedraw( compWid nil )


;; VIN='() VINp='()
;; for(i 0 14 
;; valn=value(value(v("/C00plus_bit_n"),"bit" i) cadr(nth(i lfile)))
;; valp=value(value(v("/C14minus_bit_p"),"bit" i) cadr(nth(i lfile)))
;; printf("%f\t%f\n" valn valp)
;; VIN=append(VIN list(valn valp))
;; VINp=append(VINp list(valp))
;; )

;; plot(expr( x nth(x VINp) linRg(0 14 1) ) ?expr '("Input Vp (V)"))
;; ; Input Vp will depend obviously of the IDC current (I2+I1)/2
