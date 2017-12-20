out=getData("loopGain" ?result "stb-stb")
G0=value(mag(getData("loopGain" ?result "stb-stb")),0)
BW=cross(mag(getData("loopGain" ?result "stb-stb")) G0/2 1 "falling"  )
