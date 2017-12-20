;; AN2D4 ;;tcb013ghp

ineed('dllGenMotifHA t)
ineed('getPropList) ; getPropList
ineed('array2sch)

; select the cell in a schematic
; css()~>instTerms~>name ;; getInstTermPoint(css())
; foreach(mapcar g getInstTermPoint(gss()) car(g)) ;<== order to follow
;; terms=reverse('("CP" "D" "QN" "Q" "VDD" "VSS"))
;; cells=list(list(list("DFD4" terms)))
;; cells='((("DFD4" ("CP" "D" "QN" "Q" "VDD" "VSS")))) ;[Ordered OK]
;; array2sch(cells "ED_TSMC130n" "SANDbox")
;; ;; array2sch('test "ED_TSMC130n" "SANDbox")

; array2sch('((("BUFFD1"))) "ED_TSMC130n" "SANDbox")
; foreach(mapcar g getInstTermPoint(css()) car(g)) ;<== order to follow
;=> ("VDD" "VSS" "Z" "I")

cells=dllGenMotifHA(8 '(("BUFFD1" (t "Q_")) ("DFD1" (t t "Q_" "Q_"))) 'tsmc)
;=> ((("BUFFD1" ("vdd!" "gnd!" t "Q_0")) ("DFD1" ("vdd!" "gnd!" t t "Q_0" "Q_0"))) (("BUFFD1" ("vdd!" "gnd!" t "Q_1")) ("DFD1" ("vdd!" "gnd!" t t "Q_1" "Q_1"))) (("BUFFD1" ("vdd!" "gnd!" t "Q_2")) ("DFD1" ("vdd!" "gnd!" t t "Q_2" "Q_2"))) (("BUFFD1" ("vdd!" "gnd!" t "Q_3")) ("DFD1" ("vdd!" "gnd!" t t "Q_3" "Q_3"))) (("BUFFD1" ("vdd!" "gnd!" t "Q_4")) ("DFD1" ("vdd!" "gnd!" t t "Q_4" "Q_4"))) (("BUFFD1" ("vdd!" "gnd!" t "Q_5")) ("DFD1" ("vdd!" "gnd!" t t "Q_5" "Q_5"))) (("BUFFD1" ("vdd!" "gnd!" t "Q_6")) ("DFD1" ("vdd!" "gnd!" t t "Q_6" "Q_6"))) (("BUFFD1" ("vdd!" "gnd!" t "Q_7")) ("DFD1" ("vdd!" "gnd!" t t "Q_7" "Q_7"))))

array2sch(cells "ED_TSMC130n" "SANDbox")


halfAdderList='(
("AN2D4" (("S<" 0) ("Qb" 0) ("Q" 0) ))
("XOR2D4"  (("Q" 0) t ("D<" 0) ("C<" 0) ))
("DFD2"  (t ("Qb" 0) ("Q" 0) ("C<" 0) ))
)

halfAdderList='(
("AN2D4" (("C_" 1 t) "C_" "S<" ))
("XOR2D4" ( "Sum_" "C_"  "S<"))			;C sur A, S sur B, Sum sur Z
("DFD4"  ("Q_" "Sb<" "Sum_" ("clk" nil) )) 
("mind")
("mind")
("AN2D4" ("S<" ("C_0" nil)  "Q_" ))
)

;foreach(mapcar h halfAdderList whereExistCell3(car(h) nil "symbol"));<== check

mdl='("gnd!"  "vdd!")
mde='("vdd!"  "gnd!")
HAL=foreach(mapcar h halfAdderList cond(
(rexMatchp("XOR" car(h)) append(list(car(h)) list(append(mde cadr(h)))))
(t  append(list(car(h)) list(append(mdl cadr(h)))))
))
L=11
cells=dllGenMotifHA(L HAL '())
cellName=sprintf(nil "COUNT_%d-bit" L)
pins=cons('("C_0" "clk") list(list((sprintf nil "S<0:%d>" L-1) (sprintf nil "Sb<0:%d>" L-1) (sprintf nil "C_%d" L))))
cv=array2sch(cells "ED_TSMC130n" cellName reverse(pins))
cv= geGetWindowCellView()
foreach(mapcar inst setof(c cv~>instances c~>cellName=="mind") dbDeleteObject(inst));<= remove spacer

ineed('schematic2symbol)
schs=schematic2symbol(cv t t)
