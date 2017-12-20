cv=geGetWindowCellView()
rot=sprintf(nil "R%d" 90*0)
inst=dbOpenCellViewByType("MatteoAMS" "g_padonly" "layout")

X=0
Y=0
; inst=dbCreateParamInst(cv inst nil X:Y rot 1 fPar);<= identique a dbCreateInst si fillPar=nil
pad1=dbCreateInst(cv inst nil X:Y rot 1)


dbCreateLabel(cv "text"  X+XP*(-1)**mod((norient+0)/2 2):Y+XP*(-1)**mod((norient+3)/2 2) instName "centerRight" sprintf(nil "R%d" mod(90*(norient+1) 360)) "stick" 40)