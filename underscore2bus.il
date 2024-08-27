;; copyleft : ebecheto

ineed('string2bus)

defun( _2bus (@optional (gss geGetSelectedSet())) underscore2bus(gss))


;; TODO : a modifier pour prendre en compte les pins layout css()~>net~>term~>name="TOTO"
; pour le schematic: css()~>net~>term~>name="TOTO" ;=> nil
; pour le schematic: css()~>pin~>net~>term~>name="TOTO" ;=> nil


defun( underscore2bus (@optional (gss geGetSelectedSet()))
let((tochange)
; gss=setof(g gss g~>objType=="label")
foreach(mapcar g gss tochange=nil
;g=car(gss)
cond(
(g~>objType=="label"||g~>objType=="textDisplay" printf("labORtxt_2<%L>)\n" g~>??) when(g~>theLabel g~>theLabel=string2bus(g~>theLabel)))
(g~>objType=="inst"||g~>objType=="rect" printf("instORrect_2<%L>)\n" g~>??) when(g~>pin~>term~>name g~>pin~>term~>name=string2bus(g~>pin~>term~>name)))
(t printf("not prevu yet\n"))
)
; when(tochange  printf("CHANGING:\n") tochange=string2bus(tochange))
)))

defun( bus2_ (@optional (gss geGetSelectedSet()))
foreach(mapcar s setof(g gss g~>objType=="label"||"textDisplay") s~>theLabel=buildString( parseString(s~>theLabel "<>") "_")))


printf("_2bus change les label selectionnes %L en %L\n" '("Vref" "IN_9" "T1_9" "ENA2" "IN_11") '("Vref" "IN<9>" "T1<9>" "ENA2" "IN<11>"))
printf("bus2_ change les label selectionnes %L en %L\n" '("Vref" "IN<9>" "T1<9>" "ENA2" "IN<11>") '("Vref" "IN_9" "T1_9" "ENA2" "IN_11"))


;; css()~>pin~>term~>name=css()~>pin~>term~>name

;; css()~>pin~>term~>name=string2bus(css()~>pin~>term~>name);=> "toto<3>"
