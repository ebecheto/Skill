;; AN2D4 ;;tcb013ghp

ineed('dllGenMotifHA t)
ineed('getPropList) ; getPropList
ineed('array2sch)

; select the cell in a schematic
; foreach(mapcar g getInstTermPoint(css()) car(g)) ;<== order to follow
;=> ("VSS" "VDD" "Q" "QN" "D" "CP" "CDN")

pinouts=foreach(mapcar i linRg(0 8 1)
;list("VSS" "VDD" sprintf(nil "DATA_%d<0:10>" i) t sprintf(nil "CNT_%d<0:10>" i)  sprintf(nil "TRIG_%d<0:8>" i))
list("VDD" "RST"  sprintf(nil "TRIG<%d>" i)  "CNT<0:10>" sprintf(nil "DATA_%d<0:10>" i) "VSS" )
)
datas=foreach(mapcar i linRg(0 8 1) sprintf(nil "DATA_%d<0:10>" i))
;=> ("DATA_0<0:10>" "DATA_1<0:10>" "DATA_2<0:10>" "DATA_3<0:10>" "DATA_4<0:10>" "DATA_5<0:10>" "DATA_6<0:10>" "DATA_7<0:10>" "DATA_8<0:10>")

cells=list(foreach(mapcar p pinouts list("bloc" p)))
cellName="MEMOIRE"
pins=append(list("CNT<0:10>" "TRIG<0:8>" "VDD" "VSS" "RST") datas)
;pins=cons('("C_0" "clk") list(list((sprintf nil "S<0:%d>" L-1) (sprintf nil "Sb<0:%d>" L-1) (sprintf nil "C_%d" L))))
cv=array2sch(cells "ED_TSMC130n" cellName reverse(pins))
cv= geGetWindowCellView()

;; ineed('schematic2symbol)
;; schs=schematic2symbol(cv t t)
