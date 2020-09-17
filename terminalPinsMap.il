;; copyleft : ebecheto

ineed('(angleBox getInstTermPoint schCreatePinEd))

unless(fboundp('a2s) ineed('itos) alias(a2s itos))
; *Error* eval: undefined function - a2s
; pourtant :pp : a2s is a binary function and cannot be pretty printed



defun(terminalPinsMap (@optional (pins nil) (inst css()))
let((tmp cv xy label rot xyt wid anglePins)
cv=inst~>cellView
anglePins=angleBoxg(inst)
tmp=if(pins pins mapcar('cadr anglePins)) ;=> pas bon : inst~>terminals~>name
foreach(mapcar g anglePins
xy=caddr(g) ;=>(0.0 -0.125)
label=car(tmp) tmp=cdr(tmp)
when(label
rot=strcat("R" a2s(mod(90*(car(g)+3) 360)));"R270""R270""R180"
xyt=dbTransformPoint('(0.2 0)  list(xy rot 1) );=>(0.0 -0.4)
wid=schCreateWire( cv "draw" "direct" list(xy xyt) 0.0625 0.0625 0)
schCreateWireLabel(cv car(wid) xyt label "leftCenter" rot "euroStyle" 0.0625 nil )
))))

printf("terminalPinsMap();=> par defaut, remets les memes pins\n")
printf("terminalPinsMap('%L css());<= mets les labels suivants autour de l'element selectionne\n" '("Qf<1>" "Qf<2>" "Qf<3>" "Qf<4>" "Qf<5>" "Qf<6>" "Qf<7>" "Qf<8>" "Qf<9>" "Q<0>" "Q<1>" "Q<2>" "Q<3>" "Q<4>" "Q<5>" "Q<6>" "Q<7>" "Q<8>" "Q<9>"))

; terminalPinsMap() 
; terminalPinsMap('("Qf<1>" "Qf<2>" "Qf<3>" "Qf<4>" "Qf<5>" "Qf<6>" "Qf<7>" "Qf<8>" "Qf<9>" "Q<0>" "Q<1>" "Q<2>" "Q<3>" "Q<4>" "Q<5>" "Q<6>" "Q<7>" "Q<8>" "Q<9>") css())


;REMARQUE IMPORTANTE : ~>name et ce que je dois utiliser ne sont pas dans le meme sens :!! 
;; inst~>terminals~>name;=> ("S<10>" "S<9>" "S<8>" "S<7>" "S<6>" "S<5>" "S<4>" "S<3>" "S<2>" "S<1>" "S<0>" "Sf<10>" "Sf<9>" "Sf<8>" "Sf<7>" "Sf<6>" "Sf<5>" "Sf<4>" "Sf<3>" "Sf<2>" "Sf<1>" "Sf<0>" "CNT<0:10>" "Sync_10" "Sync_9" "Sync_8" "Sync_7" "Sync_6" "Sync_5" "Sync_4" "Sync_3" "Sync_2" "Sync_1" "Sync_0")
;; mapcar('car getInstTermPoint());=> ("Sync_0" "Sync_1" "Sync_2" "Sync_3" "Sync_4" "Sync_5" "Sync_6" "Sync_7" "Sync_8" "Sync_9" "Sync_10" "CNT<0:10>" "Sf<0>" "Sf<1>" "Sf<2>" "Sf<3>" "Sf<4>" "Sf<5>" "Sf<6>" "Sf<7>" "Sf<8>" "Sf<9>" "Sf<10>" "S<0>" "S<1>" "S<2>" "S<3>" "S<4>" "S<5>" "S<6>" "S<7>" "S<8>" "S<9>" "S<10>")

;; ineed('netMakeBus)
;; netMakeBus("S" 11);=>("S<0>" "S<1>" "S<2>" "S<3>" "S<4>" "S<5>" "S<6>" "S<7>" "S<8>" "S<9>" "S<10>")
;; pins=append(netMakeBus("S" 11) append(netMakeBus("Sf" 11) append(list("CNT<0:10>") netMakeBus("Sync" 11))))

;; mapcan('list netMakeBus("Sync" 11) netMakeBus("S" 11) )

;; pins='()
;; pins=append(pins netMakeBus("Sync" 11))
;; pins=append(pins list("CNT<0:11>" ))
;; pins=append(pins netMakeBus("Sf" 11) )
;; pins=append(pins netMakeBus("S" 11) )

;; terminalPinsMap(pins) 

defun(setInstTermPins (@optional (pins nil) (inst css()))
let((tmp cv xy label rot xyt wid anglePins)
cv=inst~>cellView
anglePins=angleBoxg(inst)
tmp=if(pins pins mapcar('cadr anglePins)) ;=> pas bon : inst~>terminals~>name
foreach(mapcar it inst~>instTerms
label=it~>name
;it=car(inst~>instTerms)
;g=assoc(label mapcar('cdr anglePins))
g=car(setof(a anglePins cadr(a)==it~>name))
xy=caddr(g) ;=>(0.0 -0.125)
when(label && not(it~>net~>figs)
rot=strcat("R" a2s(mod(90*(car(g)+3) 360)));"R270""R270""R180"
xyt=dbTransformPoint('(0.2 0)  list(xy rot 1) );=>(0.0 -0.4)
wid=schCreateWire( cv "draw" "direct" list(xy xyt) 0.0625 0.0625 0)
; schCreateWireLabel(cv car(wid) xyt label "leftCenter" rot "euroStyle" 0.0625 nil )
; schCreateSymbolPin(cvs symPin pinName term~>direction termXY "R0" ) ;; pin for the symbol
pinId=schCreatePinEd(cv label it~>term~>direction xyt rot)
))))


; it~>term~>direction;=>"inputOutput"
; foreach(mapcar i inst~>instTerms list(i~>name i~>net~>figs))
