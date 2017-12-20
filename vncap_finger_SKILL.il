pcDefinePCell(list(ddGetObj("cmhv7sf") "vncap_finger_SKILL" "layout") nil 
    let((pcMember pcStretchGroup stretchOffsetX stretchOffsetY pcLib
	    pcMaster pcInst pcTerm pcPin pcPinName
	    pcNet pcTermNet pcNetName pcTermNetName pcMosaicInst
	    pcParameters pcParamProp pcStep pcStepX pcStepY
	    pcRepeat pcRepeatX pcRepeatY pcIndexX pcIndexY
	    pcLayer pcPurpose pcLabelText pcLabelHeight pcPropText
	    pcParamText pcCoords pcPathWidth pcPolygonMargin
	) 
	(pcLib = (pcCellView~>lib)) 
	(pcParameters = ((pcCellView~>parameters)~>value)) 
	dbReplaceProp(pcCellView "defaultPinModel" "string" "strong") 
	(pcLayer = 12)
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((0.0:0.0) 
		    (2.0:0.36)
		)
	    )) 
	(pcLayer = 13) 
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((1.22:0.04) 
		    (1.5:0.32)
		)
	    ))
	(pcLayer = 15) 
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((0.0:0.0) 
		    (2.0:0.36)
		)
	    )) 
	(pcLayer = 16) 
	(pcPurpose = "drawing")
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((1.22:0.04) 
		    (1.5:0.32)
		)
	    )) 
	(pcLayer = 18) 
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((0.0:0.0) 
		    (2.0:0.36)
		)
	    )) 
	(pcLayer = 19)
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((1.22:0.04) 
		    (1.5:0.32)
		)
	    )) 
	(pcLayer = 21) 
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((0.0:0.0) 
		    (2.0:0.36)
		)
	    ))
	(pcLayer = 22) 
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((1.22:0.04) 
		    (1.5:0.32)
		)
	    )) 
	(pcLayer = 25) 
	(pcPurpose = "drawing")
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((0.0:0.0) 
		    (2.0:0.36)
		)
	    )) t
    )
)
