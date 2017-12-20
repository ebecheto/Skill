prog((tech techLibName techFileName)
	techLibName = "TECH_S35D4"
	techFileName = "techfile.cds"
	tech = techOpenTechFile(techLibName techFileName "r")
	if(tech==nil then
		return(nil)
	)
	;The template name is : M4_d

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "M4_d"
		?layer	 list("MET4" "drawing")
		?width	 10.100000
		?choppable	 nil
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "center"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET4" "drawing")
			?width	 2.000000
			?length	 2.500000
			?choppable	 t
			?sep	 -6.050000
			?justification	 "center"
			?space	 20.150000
			?beginOffset	 0.000000
			?endOffset	 0.000000
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "minimum"
			)
		)
	) ; end of leDefineMPPTemplate procedure
	leDefineMPPTemplate(
		?techId	 tech
		?name	 "M4_b"
		?layer	 list("MET4" "drawing")
		?width	 10.100000
		?choppable	 nil
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "center"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET4" "drawing")
			?width	 2.000000
			?length	 2.500000
			?choppable	 t
			?sep	 6.050000
			?justification	 "center"
			?space	 20.150000
			?beginOffset	 0.000000
			?endOffset	 0.000000
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "minimum"
			)
		)
	) ; end of leDefineMPPTemplate procedure
) ; end of prog in ASCII file