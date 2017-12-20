;;load("~/Skill/GS_WORK.il")
;list(ddGetObj("GS_WORK") "rect" "layout")

pcDefinePCell(
list(ddGetObj("Ed") "rect" "layout")
( (width float 1.0) (height float 1.0) )
let( ( rect rectBorder pcInst )

;rect =rodCreateRect(
;?name "rect"
;?cvId pcCellView
;?layer "MET1"; "poly"
;?bBox list(0:0 width:height)
;)

;; ** definition des differents elements : rect, path etc...  **

	(pcInst  = rodCreateRect(?cvId pcCellView ?layer 35
		?bBox list((-5.0:255.7) ((35.0 + width):258.6))))
	(pcInst = rodCreateRect(?cvId pcCellView ?layer 42
		?bBox list((0.0:106.25) ((30.0 + width):141.2))))
	(pcInst = rodCreateRect(?cvId pcCellView ?layer 42
		?bBox list((0.0:144.2) ((30.0 + width):179.15))))
	(pcInst = rodCreateRect(?cvId pcCellView ?layer 42
		?bBox list((0.0:183.85) ((30.0 + width):218.8))))
	(pcInst = rodCreateRect(?cvId pcCellView ?layer 42
		?bBox list((0.0:221.8) ((30.0 + width):256.75))))
	(pcInst = rodCreateRect(?cvId pcCellView ?layer 39
		?bBox list((0.0:105.35) ((30.0 + width):129.25))))
	(pcInst = rodCreateRect(?cvId pcCellView ?layer 39
		?bBox list((0.0:132.25) ((30.0 + width):153.15))))
	(pcInst = rodCreateRect(?cvId pcCellView ?layer 39
		?bBox list((0.0:156.15) ((30.0 + width):180.05))))
	(pcInst = rodCreateRect(?cvId pcCellView ?layer 35
		?bBox list((-5.0:177.95) ((35.0 + width):180.85))))

rectBorder = rodCreateRect(?cvId pcCellView ?layer 35
		?bBox list((0.0:0.0) ((30.0 + width):0.5))
	    )



;; ** definition des rod handles  **

rodAssignHandleToParameter(
	?parameter "width"
	?rodObj rectBorder
	?handleName list("centerRight" "centerLeft")
	?displayName "width"
	;[?displayExpression S_displayExpression]
	?stretchDir "x"
	?stretchType "relative"
	?moveOrigin t
	;[?updateIncrement f_updateIncrement]
	;[?userData g_userData]
	;[?userFunction Sl_userFunction]
) ; end rodAssignHandleToParameter

rodAssignHandleToParameter(
	?parameter "height"
	?rodObj rectBorder
	?handleName list("upperCenter" "lowerCenter")
	?displayName "height"
	?stretchDir "y"
	?stretchType "relative"
	?moveOrigin t
) ; end rodAssignHandleToParameter
t
); end let
); end procedure