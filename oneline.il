cv = hiGetCurrentWindow()->cellView
cv~>instanceMasters~>instRefs~>cellName
hiGetCurrentWindow()~>cellView~>instanceMasters~>instRefs~>cellName
println(hiGetCurrentWindow()~>cellView~>instanceMasters~>instRefs~>cellName)
;; ==> (("rpoly2" "rpoly2" "rpoly2") ("cpoly" "cpoly" "cpoly" "cpoly") ("iopin" "iopin" "iopin" "iopin") ("gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd" "gnd") ("nmos4" "nmos4" "nmos4" "nmos4" "nmos4" "nmos4" "nmos4" "nmos4") ("vdd" "vdd" "vdd" "vdd" "vdd" "vdd" "vdd" "vdd" "vdd" "vdd") ("pmos4" "pmos4" "pmos4" "pmos4" "pmos4"))
