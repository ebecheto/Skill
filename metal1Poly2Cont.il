;; load("~/Skill/metal1Poly2Cont.il")

let( (library)
;;library="PAD_cell_S35D4"
library="Ed"

pcDefinePCell(list(ddGetObj(library) "metal1Poly2Cont" "layout")  ((length float 5.0) ) 
    let(( masterPath)

masterPath =  rodCreatePath(
;;	?cvId	pcCellView
	?layer	list("POLY2" "drawing")
	?width	 1.600000
	?pts list(0:0 0:length)
	?endType	 "flush"
	?justification	 "center"
	?encSubPath	 list(
		list(
			?layer	 list("MET1" "drawing")
			?enclosure	 0.450000
			?choppable	 t
			?beginOffset	 -0.450000
			?endOffset	 -0.450000
			)
		)
	?subRect	 list(
		list(
			?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.600000
			?endOffset	 -0.600000
			?gap	 "distribute"
			)
		)
	)
rodAssignHandleToParameter(
	?parameter "length"
	?rodObj masterPath
	?handleName list("upperCenter" "lowerCenter")
	?displayName "length"
	?stretchDir "y"
	?stretchType "relative"
	?moveOrigin t
) ; end rodAssignHandleToParameter
t
);end let
);end pcDef





pcDefinePCell(list(ddGetObj(library) "pdiff_sub" "layout") 
    (	(length float 5.0)
    ) 
    let((  masterPath)

masterPath =  rodCreatePath(
		?layer	 list("DIFF" "drawing")
		?width	 0.700000
		?pts list(0:0 0:length)
		?endType	 "flush"
		?justification	 "center"
		?encSubPath	 list(
		list(
			?layer	 list("MET1" "drawing")
			?enclosure	 0.000000
			?choppable	 t
			)
		list(
			?layer	 list("PPLUS" "drawing")
			?enclosure	 -0.250000
			?beginOffset	 0.250000
			?endOffset	 0.250000
			)
		)
		?subRect	 list(
		list(
			?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.150000
			?endOffset	 -0.150000
			?gap	 "distribute"
			)
		)
	) ; end of leDefineMPPTemplate procedure

rodAssignHandleToParameter(
	?parameter "length"
	?rodObj masterPath
	?handleName list("upperCenter" "lowerCenter")
	?displayName "length"
	?stretchDir "y"
	?stretchType "relative"
	?moveOrigin t
) ; end rodAssignHandleToParameter




t

);end let
);end pcDef

pcDefinePCell(list(ddGetObj(library) "ndiff_ntub" "layout") 
    (	(length float 5.0)
    ) 
    let((  masterPath)

masterPath =  rodCreatePath(
		?name	 "ndiff_ntub"
		?layer	 list("DIFF" "drawing")
		?pts list(0:0 0:length)
		?width	 0.700000
		?endType	 "flush"
		?justification	 "center"
		?encSubPath	 list(
		list(
			?layer	 list("MET1" "drawing")
			?enclosure	 0.000000
			?choppable	 t
			)
		list(
			?layer	 list("NPLUS" "drawing")
			?enclosure	 -0.250000
			?beginOffset	 0.250000
			?endOffset	 0.250000
			)
		list(
			?layer	 list("NTUB" "drawing")
			?enclosure	 -0.200000
			?beginOffset	 0.200000
			?endOffset	 0.200000
			)
		)
		?subRect	 list(
		list(
			?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.150000
			?endOffset	 -0.150000
			?gap	 "distribute"
			)
		)
	) ; end of leDefineMPPTemplate procedure --> now a pcDefinePCell

rodAssignHandleToParameter(
	?parameter "length"
	?rodObj masterPath
	?handleName list("upperCenter" "lowerCenter")
	?displayName "length"
	?stretchDir "y"
	?stretchType "relative"
	?moveOrigin t
) ; end rodAssignHandleToParameter
t
);end let
);end pcDef



pcDefinePCell(list(ddGetObj(library) "met1_poly1" "layout") 
    (	(length float 5.0)
    ) 
    let((  masterPath)

masterPath =  rodCreatePath(
		?layer	 list("POLY1" "drawing")
		?width	 0.800000
		?pts list(0:0 0:length)
		?endType	 "flush"
		?justification	 "center"
		?encSubPath	 list(
		list(
			?layer	 list("MET1" "drawing")
			?enclosure	 0.0500000
			?choppable	 t
			?beginOffset	 -0.050000
			?endOffset	 -0.050000
			)
		)
		?subRect	 list(
		list(
			?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?sep	 0.000000
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.20000
			?endOffset	 -0.20000
			?gap	 "distribute"
			)
		)
	) ; end of leDefineMPPTemplate procedure


rodAssignHandleToParameter(
	?parameter "length"
	?rodObj masterPath
	?handleName list("upperCenter" "lowerCenter")
	?displayName "length"
	?stretchDir "y"
	?stretchType "relative"
	?moveOrigin t
) ; end rodAssignHandleToParameter
t
)
)
); end let