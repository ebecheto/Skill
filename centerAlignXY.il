;; copyleft ebecheto
/**************************************************
* contient 2 fonctions
* centerAlignXY() 
* touche()
* a label for ASSURA                              *
*                                                 *
* Authors : Edouard BECHETOILLE 	  *
*			IPNL (IN2P3-CNRS )	  *
* Version : 1.0   mars 2008                   *
*                                        *
***************************************************/

;; load "~/Skill/centerAlignXY.il"

;; projection sur un droite de pente : 'steepness' centré sur l'ensemble des objets selectionnés
;; steepness : pente de la pente à suivre pour ecarter le objets
procedure(centerAlignXY( @optional  (steepness 1) (XY "Y") (cc geGetSelectedSet()) )
let( (xmin ymin xmax ymax csbBox step liste xn yn x0 y0) ; to use later with layerOffset(pcMaster)
xmin=caar(car(cc)~>bBox)
ymin=cadar(car(cc)~>bBox)
xmax=caadr(car(cc)~>bBox)
ymax=cadadr(car(cc)~>bBox)
foreach( obj cc 
;;		(printf "bBox = %L\n" obj~>bBox)
		xmin=min(caar(obj~>bBox) xmin)
		ymin=min(cadar(obj~>bBox) ymin)
		xmax=max(caadr(obj~>bBox) xmax)
		ymax=max(cadadr(obj~>bBox) ymax)
	         );foreach
csbBox = list(xmin:ymin xmax:ymax);;<== centre de l'ensemble des objects selectinonnés
cC = centerBox(csbBox)
xc = car(cC)
yc = cadr(cC)
;;(printf "steepness = %L\n" steepness)
if( (XY=="X") then ;;; alignement en X 
foreach( obj cc 
when( (steepness==0)  steepness=1 printf("1/0 ?! ==> steepness re-affected to 1\n"))
	x0 = car(centerBox(obj~>bBox))
	y0 = cadr(centerBox(obj~>bBox))
	xn=(y0-yc+steepness*xc)/steepness
	dbMoveFig(obj nil list(xn-x0:0 "R0"))
);end foreach
else ;; alignement en Y ;; obj=car(cc) ; PB pas de grille ...
;;a=2  list(xc yc)
foreach( obj cc 
	x0 = car(centerBox(obj~>bBox))
	y0 = cadr(centerBox(obj~>bBox))
	yn=steepness*x0 + (yc-steepness*xc)
	dbMoveFig(obj nil list(0:yn-y0 "R0"))
);end foreach steepness=1
);end if
);fin du let
t
);fin procedure. 
; USAGE : centerAlignXY(2)
; USAGE : centerAlignXY(2 "X")
; USAGE : centerAlignXY( 0.5 "X")
; USAGE : centerAlignXY(1 "Y")
; USAGE : centerAlignXY(1 "Y" geGetSelectedSet())
; USAGE : centerAlignXY(0)  ;  <== aligne horizontalement



;; fonction 'touche' colle à touche-touche avec une superposition (offset) l'ensemble des elements selectionnés
;; ca peut être fait par le menu Align, mais ca donne un exemple de script de comment c'est fait.
;; SELECTIONNER DANS l'ORDRE avec SHIFT
;; gg=geGetSelectedSet()
procedure(
touche( @optional  (offset 10) (XY "X")  (cc geGetSelectedSet()) )
let( (xmin ymin xmax ymax X0 w Xpad move)
X0 = car(css()~>xy)
Y0 = cadr(css()~>xy)
if( (XY=="X") 
    foreach(pad geGetSelectedSet()
		xmin=caar(pad~>bBox)
		xmax=caadr(pad~>bBox)
		w = xmax-xmin
		Xpad = car(pad~>xy)
		move = w+(X0-Xpad)-offset
		when( (X0 != Xpad)
		      dbMoveFig(pad nil list(move:0 "R0"))
		      (printf "inst %L moving from %L to : %L \n" pad~>name pad~>xy move)
		      )
		)
    )					; end if
if( (XY =="Y") 
    foreach(pad geGetSelectedSet()
		ymin=cadar(pad~>bBox)
		ymax=cadadr(pad~>bBox)
		w = ymax-ymin
		Ypad = cadr(pad~>xy)
		move = (Y0-Ypad)-w+offset
		when( (Y0 != Ypad)
		      dbMoveFig(pad nil list(0:move "R0"))
		      (printf "inst %L moving from %L to : %L \n" pad~>name pad~>xy move)
		      )
		)
    )					; end if
)					;end let
)

;; USAGE   : touche
;; USAGE   : touche( 10)
;; USAGE   : touche(20)
;; USAGE   : touche(5 "Y")  
;; GND SUB : touche(10 "Y")




procedure(centerAlignXYHelp() printf("
[ ** USAGE on Functions centerAlignXY() and touche() **]\n
centerAlignXY(2)\n
centerAlignXY(2 \"X\")			; align with steepness 2\n
centerAlignXY( 0.5 \"X\")		; align with steepness 1/2\n
centerAlignXY(1 \"Y\")			; align with steepness 1\n
centerAlignXY(1 \"Y\" geGetSelectedSet())\n
centerAlignXY(0) ; align horizontally\n
touche		 ; make the selected set to touch\n
touche(10)	 ; make the selected set to touch with 10 spacing\n
touche(20)\n
touche(5 \"Y\")  \n
touche(10 \"Y\") \n
"   ))