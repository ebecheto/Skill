;copyleft ebecheto
ineed('pointInbBox)


defun(bBox_lpp_check (@optional (lpp '("METAL1" "pin")) (bBox css()~>bBox) (cv css()~>cellView) (debug nil))
let((flag objs checks egal)
unless(cv css()~>cellView)
unless(lpp lpp='("METAL1" "pin"))
;unless(bBox '((-13.685 -4.005) (-13.455 -3.29)))
setof(s cv~>shapes s~>objType=="rect")~>bBox
objs=setof(s cv~>shapes s~>objType=="rect")
checks=foreach(mapcar fig objs
egal=and(fig~>lpp==lpp pointInbBox(fig~>bBox bBox))
when(egal flag=t) egal
)
if(debug checks flag)
)
)


;; defun(bBox_lpp_checks (@optional (lpp '("METAL1" "pin")) (bBox css()~>bBox) (cv css()~>cellView) (debug nil))
;; let((flag objs checks egal)
;; unless(cv css()~>cellView)
;; unless(lpp lpp='("METAL1" "pin"))
;; unless(bBox '((-13.685 -4.005) (-13.455 -3.29)))
;; objs=setof(s cv~>shapes s~>objType=="rect")
;; foreach(mapcar fig objs printf("%L\n" list(fig~>lpp lpp fig~>bBox bBox fig~>bBox==bBox pointInbBox(fig~>bBox bBox))))
;; ))

;; rounding issue ??
;; TODO : if centerBox is include in the bounding box => pass

;; bBox='((-6.325 -4.41) (-6.115 -2.15))
;; point=centerBox(bBox)
;; ;=> (-6.22 -3.28)

;; ineed('pointInbBox)
;; fig~>bBox;=> ((2.315 -4.005) (2.545 -3.29))
;; centerBox(fig~>bBox);=> (2.43 -3.6475)

;; pointInbBox(centerBox(fig~>bBox) bBox)


; ineed('flatten)
;; defun(bBox_lpp_check2 (@optional (lpp '("METAL1" "pin")) (bBox css()~>bBox) (cv css()~>cellView))
;; let((objs)
;; unless(bBox '((-13.685 -4.005) (-13.455 -3.29)))
;; ;; bBox;=> ((-13.685 -4.005) (-13.455 -3.29))
;; ;; lpp;=> ("METAL1" "pin")
;; ;; lpp== '("METAL1" "pin");=> t
;; ;; lpp== '("METAL2" "pin");=> nil
;; ;;cv~>conns~>term~>pins~>figs~>??
;; ;;fig=caaar(cv~>conns~>term~>pins~>figs);=> db:0x2e6ce6a0
;; ;;objs=flatten(cv~>conns~>term~>pins~>figs)
;; setof(s cv~>shapes s~>objType=="rect")~>bBox
;; objs=setof(s cv~>shapes s~>objType=="rect")
;; ;; obj=car(objs)
;; ;; obj~>lpp
;; ;; obj~>bBox
;; car(remove(nil foreach(mapcan fig objs
;; ; fig~>bBox;=> ((2.315 -4.005) (2.545 -3.29))
;; ; fig~>lpp;=> ("METAL1" "pin")
;; list(and(fig~>lpp==lpp fig~>bBox==bBox))))
;; )))

;; ;select rectangle pin in layout and try
;; unless(bBox_lpp_check() printf("no pins here. OK?!"))

;; cv~>conns~>term~>??
;; cv~>conns~>term~>name
;; cv~>conns~>term~>pins~>fig~>??
;; setof(s cv~>shapes s~>objType=="rect")~>bBox

;; (setq bBox css()~>bBox)
;; foreach(mapcar bb objs~>bBox bb=='((-13.685 -4.005) (-13.455 -3.29)))
;; foreach(mapcar bb objs~>lpp bb==lpp)

;; lpp='("METAL1" "pin") 
;; bBox='((-6.325 -4.41) (-6.115 -2.15)))
;; bBox_lpp_checks(lpp bBox)
