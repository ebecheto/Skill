; ineed('rectangleLabel2pin t)
;; copyleft ebecheto
ineed('(bBoxHeight isPointInBbox createPinLPPcv))
;ineed('( getInstTermPoint geOpenOrRaisecv routePath viaGenerateViasInArea2 addValidVia getNassoc createPinLPPcv getInstTermPointLPP3 routeL routeL_paires ))

defun(rectangleLabel2pin (@optional (cv nil))
;; i have a layout with rectangle and a label onto it
;; i want to create a pin at the same place of the rectangle with the label sticked to it
let((labs rect pairs pinName lpp pinW rot pin)
unless(cv cv=geGetWindowCellView())
;; csa =dbOpenCellViewByType( "ANALOG_lay" "CSA4" "layout" "maskLayout" "r")
;; cv=csa
labs=setof(c cv~>shapes c~>objType=="label")
;lab=car(labs)
;setof(c cv~>shapes c~>objType=="label")~>theLabel
;=> ("cra<7>" "CSA_ibsV" "VRF" "Vpcasc" "VDDA" "Comp_vref" "DIS_CSA" "Comp_vout" "iin" "Vbscasc" "VSSA" "VRA" "CSA_vout" "cra<2>" "cra<1>" "cra<3>" "cra<4>" "cra<5>" "cra<6>" "cra<0>")
rect=setof(c cv~>shapes c~>objType=="rect")
;length(rect);=> 376
;rec=setof(c rect or(c~>layerName=="M1" c~>layerName=="M2"))
;r=car(rec)
;; TODO  ; faire xy belongs to bBox, not equal centerbox DONE
pairs=remove(nil foreach(mapcar r rect remove(nil foreach(mapcar lab labs when(isPointInBbox(lab~>xy r~>bBox) when( r~>layerName==lab~>layerName list(r lab)))))))
;length(pairs);=> 14

foreach(mapcar pp pairs p=car(pp) r=car(p) lab=cadr(p)
pinName=lab~>theLabel
lpp=r~>lpp
pinW=bBoxHeight(r~>bBox)
rot="R0"
pin=createPinLPPcv(pinName r~>bBox lpp nil cv t "centerLeft" pinW rot)
)
))

;pinxysp=getInstTermPoint(icsa)


;; length(rec);=> 32

;; c~>layerName==
;; r=car(rect)
;; r~>??

;=> (db:0x3fefa91a cellView db:0x3ff1d89a objType "rect" prop nil bBox ((7.89 7.97) (8.94 8.15)) children nil groupMembers nil isAnyInst nil isShape t matchPoints nil net nil parent nil pin nil purpose "drawing" textDisplays nil assocTextDisplays nil markers nil figGroup nil isUnshielded nil shieldedNet1 nil shieldedNet2 nil layerName "GC" layerNum 8 lpp ("GC" "drawing") connRoutes nil routeStatus "normal")


;foreach(lab setof(c cv~>shapes c~>objType=="label") )
; csa =dbOpenCellViewByType( "ANALOG_lay" "CSA4" "layout" "maskLayout" "r")
;; cv=csa
;geOpenOrRaisecv(csa)