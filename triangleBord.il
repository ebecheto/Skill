; load("~/Skill/PICMIC/triangleBord.il")


;; x--------|--------x
;; |  ~          -   |
;; |      ~  -       |
;; |     -    ~      |
;; | -            ~  |
;; x--------|--------x
;;
;; 60° angle triangle 


ineed('(rotationCir leftShift))


;; rotationCir( 0:1 30 0:0);=> (-0.5 0.8660254)
;; rotationCir( 0:1 150 0:0);=> (-0.5 -0.8660254)
;; rotationCir( 0:1 210 0:0);=> (0.5 -0.8660254)
;; rotationCir( 0:1 330 0:0);=> (0.5 0.8660254)
;; rotationCir( 0:4 330 0:0);=> (2.0 3.464102)

;; rotationCir( 0:sqrt(3) 30 0:0 );=> (-0.8660254 1.5)

;; XY1=0:0
;; XY1=0:2
;; cv= geGetWindowCellView()
;; (setq radius sqrt(3)) (setq XY1 0:0) (setq nedge 0)


;; angleList='(30 150 210 330)
;; nedge=1

defun( triangleBord (@optional (cv nil)(radius sqrt(3)) (XY1 0:0) (nedge 0)(lpp "M4"))
let((angleList angles ptsTri angle ptsTrr)
unless(cv cv=geGetWindowCellView())
angleList='(30 150 210 330)
angles=leftShiftn(angleList nedge);=> (150 210 330 30)
;printf("angle %L %L %L\n" angles nedge angleList)
; i=0
ptsTri=foreach(mapcar i linRg(0 2 1) angle=nth(i angles) rotationCir(radius:0 angle 0:0))
;pt=car(ptsTri)
ptsTrr=foreach(mapcar pts ptsTri (mapcar 'plus XY1 pts))
dbCreatePolygon(cv lpp  ptsTrr)
))

;            cv radiue XY1 rotation-like
;; triangleBord(nil 1 0:1 1)
;; triangleBord(nil 1 0:1 0)
;; triangleBord(nil 1 0:3 0 "M3")
;; triangleBord(cv 1 0:3 0 "M3")
; triangleBord(nil 4 0:3 0 "M3")

; foreach(mapcar nb linRg(1 5 1) triangleBord(nil 1 0:nb nb sprintf(nil "M%d" nb)))

; foreach(mapcar nb linRg(0 3 1) triangleBord(nil 1 0:0 nb))
;; foreach(mapcar nb linRg(0 3 1) triangleBord(nil 1 0:1 nb))
;; foreach(mapcar nb linRg(0 3 1) triangleBord(nil 1 2:0 nb))



;; pw3=pw/4*sqrt(3);=> 1.5

;; ;; DEALING WITH TRIANGLE BORDERS
;; when(or( and(row==0 pair==0) and(col==0 pair==0)) when(i==1 ;== bas et Gauche
;; ptsTri=list(mapcar('plus XY1 pw3:-pw/4) mapcar('plus XY1 -pw3:pw/4) mapcar('plus XY1 -pw3:-pw/4))
;; dbCreatePolygon(cv list("M4" "drawing")  ptsTri) ));cas "B" "Red" "Rising" "M4" path
;; when(and(pair==1 i==2 or(row==NX-1 col==NY-1));<= Haut & Droit
;; XY2=mapcar('plus wxy 0:5*yStep)
;; ptsTri=list(mapcar('plus XY2 pw3:-pw/4) mapcar('plus XY2 -pw3:pw/4) mapcar('plus XY2  pw3:pw/4))
;; dbCreatePolygon(cv list("M4" "drawing")  ptsTri));cas "B" "Red" "Rising" "M4" path
;; when(and(pair==0 i==2 or(row==0 col==NY-1)) ;<= gauche & Haut
;; ptsTri=list(mapcar('plus XY1 -pw3:pw/4) mapcar('plus XY1 pw3:pw/4) mapcar('plus XY1 -pw3:-pw/4))
;; dbCreatePolygon(cv list("M5" "drawing")  ptsTri));cas "C" "Bleu" "Bending" "M5" path
;; when(and(pair==1 i==0 or(row==NX-1 col==0)) ;<= Droit & bas
;; XY3=mapcar('plus X:Y xStep:-2.5*yStep)
;; ptsTri=list(mapcar('plus XY3 pw3:-pw/4) mapcar('plus XY3 pw3:pw/4) mapcar('plus XY3 -pw3:-pw/4))
;; dbCreatePolygon(cv list("M5" "drawing")  ptsTri));cas "C" "Bleu" "Bending" "M5" path

;; ;; DEALING WITH TRIANGLE BORDERS END
