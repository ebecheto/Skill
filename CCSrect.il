;; -------------------x Copy from here x-----------------
;; /*************************************************************************
;; * DISCLAIMER: The following code is provided for Cadence customers       *
;; * to use at their own risk. The code may require modification to         *
;; * satisfy the requirements of any user. The code and any modifications   *
;; * to the code may not be compatible with current or future versions of   *
;; * Cadence products. THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, *
;; * INCLUDING WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED         *
;; * WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.         *
;; *************************************************************************/
 
procedure(CCSrect()
let((cv techId pts)

pts=enterBox( ?prompts
      list( "Drag a Box.")
)
if(pts
then
printf("Points entered were %L.\n" pts)
cv=geGetWindowCellView()
techId=techGetTechFile(cv)
printf("techId : \n[******]\n %L.\n" techId)
printf("leGetValidLayerList(techId)  \n[******]\n %L.\n" leGetValidLayerList(techId))
foreach(LP leGetValidLayerList(techId)
        if( leIsLayerSelectable(LP)
printf("leIsLayerSelectable(LP)  \n[******]\n %L : %L .\n" leIsLayerSelectable(LP)  LP)
        dbCreateRect(cv LP pts)
         ) ; end if
 ) ; end foreach
else
println("Point entry aborted.")

);if
);let
);procedure



;; exemple of one step :
;pts = list(0:0 1:1)
;LP  = list("MET1" "drawing")
;cv=geGetWindowCellView()
;dbCreateRect(cv LP pts)

;or in one shot: 
;dbCreateRect(geGetWindowCellView() list("MET1" "drawing") list(0:0 1:1))

;dbCreateRect(geGetWindowCellView() list("MET1" "drawing") list(1.5:0 2.5:1.3))


;layerListe = leGetValidLayerList(techId)
; rexMatchAssocList("^drawing$" layerListe)
; rexMatchAssocList("MET.*" layerListe)

;dbCreateRect(geGetWindowCellView() list( 30 "drawing") list(0:0 1:1))
;dbCreateLabel(geGetWindowCellView() '("text" "drawing") 2:0 "cdsName()" "lowerLeft" "R0" "stick" 0.65  )
