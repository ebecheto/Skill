prog((tech techLibName techFileName)
	techLibName = "TECH_C35B4"
	techFileName = "techfile.cds"
	tech = techOpenTechFile(techLibName techFileName "r")
	if(tech==nil then
		return(nil)
	)
	;The template name is : Newew2

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "Newew2"
		?layer	 list("MET2" "drawing")
		?width	 24.000000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?offsetSubPath	 list(
		 list(
			?layer	 list("MET2" "drawing")
			?width	 24.000000
			?choppable	 t
			?sep	 3.000000
			?justification	 "left"
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		 list(
			?layer	 list("MET2" "drawing")
			?width	 24.000000
			?choppable	 t
			?sep	 30.000000
			?justification	 "left"
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		)
		?subRect	 list(
		list(
			?layer	 list("MET2" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?beginOffset	 -10.000000
			?endOffset	 0.000000
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		list(
			?layer	 list("MET2" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 27.000000
			?justification	 "left"
			?space	 30.000000
			?beginOffset	 -10.000000
			?endOffset	 0.000000
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "distribute"
			)
		)
	) ; end of leDefineMPPTemplate procedure
) ; end of prog in ASCII file