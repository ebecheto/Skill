ineed('abConcatWaveforms)
; load "~/cadence/skill/abConcatWaveforms.il"

; simu ac en boucle ouvert ou simu stb


lg = VF("OL")
; lg = -getData("loopGain" ?result "stb")
; abConcatWaveforms externally defined
lg2 = abConcatWaveforms(flip(conjugate(lg)) lg)
w = newWindow()
ocnYvsYplot(?wavex real(lg2) ?wavey imag(lg2))
stb_x = xmin(abs(lg2-complex(-1.0,0.0))**2)
stb_margin = value(lg2, stb_x)
addTitle(sprintf(nil "stb_margin = %f dB" -dB20(stb_margin)))
xLimit( list(-1.6 0.2) )
yLimit( list(-0.5 0.5) )


