; load("~/Skill/bottomLess.il")

prog( ( tech techLibName techFileName)
	techLibName = techGetTechFile(geGetWindowCellView())~>libName
;	techLibName = "TECH_C35B4"
	techFileName = techGetTechFile(geGetWindowCellView())~>fileName
;	techFileName = "techfile.cds"
tech = techOpenTechFile( techLibName techFileName "r" )
if(tech==nil then return(nil)) ; end if

leDefineMPPTemplate(
		?techId	 tech
		?name	 "botmles"
		?layer	 list("DIFF" "drawing")
		?width	 1.25
		?choppable	 nil
		?endType	 "truncate"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0
		?subRect	 list(
		list(   ?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?sep	 -0.625
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.40
			?endOffset	 -0.40
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "minimum"
			)
		list(   ?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?sep	 0.275
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.4
			?endOffset	 -0.4
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "minimum"
			)
		)
		?offsetSubPath   list(
                            list( ?layer           list("MET1" "drawing")
                                  ?width           1.6
                                  ?choppable       t
                                  ?sep             -0.175
				?beginOffset	 -0.25
				?endOffset	 -0.25
				  ?justification	 "center"
                            ) ; 
                            list( ?layer           list("PPLUS" "drawing")
				  ?beginOffset	 0.25
                                  ?width           0.2
                                  ?choppable       t
                                  ?sep             -0.275
				  ?justification	 "center"
                            ) ; 
                            list( ?layer           list("NPLUS" "drawing")
				  ?beginOffset	   0.25
                                  ?width           1.05
                                  ?choppable       t
                                  ?sep             0.35
				  ?justification	 "center"
                            ) ; 
                            list( ?layer           list("NTUB" "drawing")
				  ?beginOffset	   1.2
                                  ?width           1.25
                                  ?choppable       t
                                  ?sep             -0.05
;                                  ?sep             0.2
				  ?justification	 "left"
                            ) ; 
		)

	);end pdiff_subCont
);end prog