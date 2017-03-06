;; defun( terminalSch (@optional (pins '("A" "B" "C" ("D" "ipin") "E")) (Ys t) (lbl t) (bus nil) (cv t)) let((dir aPin XY label labels)
;; when(cv=='t cv=geGetWindowCellView())
;; cond((pinName=='t pinName="OUT")(listp(pinName) labels=pinName))
;; when(io=='t io="iopin")
;; when(io=='nil io="opin")
;; when(Ys=='t Ys=0.125)
;; cond(
;; (io=="ipin"  dir="input"       )
;; (io=="opin"  dir="output"      )
;; (io=="iopin" dir="inputOutput" )
;; (t          dir="inputOutput" )
;; )
;; XY=car(cv~>bBox)
;; aPin = dbOpenCellViewByType("basic" io  "symbol")
;; ; Ys=(cadadr(aPin~>bBox)-cadar(aPin~>bBox))
;; ;Ys=0.225
;; unless(labels
;; for(N N1 N2
;; if(!bus 
;; label=sprintf(nil "%s_%d" pinName N)
;; label=sprintf(nil "%s<%d>" pinName N)
;; )
;; labels=append(labels list(label))))

;; foreach(mapcar label labels
;; schCreatePin( cv aPin label dir nil XY "R0")
;; when(lbl
;; wid=schCreateWire( cv "draw" "direct" list(rodAddPoints(XY 0.3:0) rodAddPoints(XY 0.5:0)) 0.0625 0.0625 0)
;; schCreateWireLabel(cv car(wid) rodAddPoints(XY 0.4:0.1) label "centerCenter" "R0" "euroStyle" 0.0625 nil )
;; )
;; XY=list(car(XY) cadr(XY)+Ys)
;; );forloop
;; ))
