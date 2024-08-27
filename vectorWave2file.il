;ineed('vectorWave2file t)
defun(vectorWave2file (@optional (wave VT("/VOUTNP1xx")) (PWD "./") (pattern "pattern"))
let((x y len subWave subElems subElem name)

name=if(name=famGetSweepName(wave) name "") ;=>"IDC" or "temp"
x=drGetWaveformXVec(wave);=> srrVec:0x25f62750
y=drGetWaveformYVec(wave)
len=drVectorLength(x);=> 10
subElems='()
for(i 0 len-1
; printf("First wave is at x value %g\n" drGetElem(x i))
 subElem=drGetElem(x i)
 subWave=drGetElem(y i)
subElems=append(subElems list(subElem))
 ;; printf("Sub wave x-axis name is %L\n" drGetWaveformXVec(subWave)~>name)
 ;; printf("Sub wave y-axis expression is %L\n" drGetWaveformYVec(subWave)~>expression)
;  plot(subWave)
 ocnPrint(subWave ?output sprintf(nil "%s/%s_%s_%g.csv" PWD pattern name subElem) ?format "engineering")
)
println( sprintf(nil "%s/%s_%g.csv" PWD pattern subElem))
subElems
))

;vectorWave2file(VT("/VOUTNP1xx") "./" "pattern")
;vectorWave2file(VT("/VOUTNP1xx") PWD "VOUT_X_27deg_")
