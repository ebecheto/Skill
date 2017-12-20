getData("/out" ?result "tran_noise-tran_noise")
className(getData("/out" ?result "tran_noise-tran_noise"));=> srrifWave


wave=getData("/out" ?result "tran_noise-tran_noise")

sweepNames(wave);=> ("time" "freq")
famGetSweepName(wave);=> "time"
famIsFamily();=> "time"
famMap();=> "time"





elem=""
strip=0
x=drGetWaveformXVec(wave)
y=drGetWaveformYVec(wave)
len=drVectorLength(x)
for(i 0 len-1
printf("First wave is at x value %g\n" elem=drGetElem(x i))
label=sprintf(nil "%L_" list(elem)) strip=strip+1
subWave=drGetElem(y i)
printf("Sub wave x-axis name is %L\n" drGetWaveformXVec(subWave)~>name)
printf("Sub wave y-axis expression is %L\n" drGetWaveformYVec(subWave)~>expression)
awvPlotWaveform(currentWindow() || newWindow() list(subWave) ?expr list(label) ?stripNumber list(strip))
; plot(subWave)
)

wave1=value(getData("/out" ?resultsDir "/home/validmgr/ebecheto/Work/IC6/Sim/CSA_24mai_sim2/spectre/schematic/psf" ?result "noise") "time" 0.0)


awvPlotWaveform(currentWindow() || newWindow() list(wave1) ?expr list("Q1") ?stripNumber list(strip))
