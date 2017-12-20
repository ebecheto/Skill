
;;load("/home/validmgr/ebecheto/Skill/TECH_C35B4.mpp.templates.il")
prog((tech techLibName techFileName)
	techLibName = "TECH_C35B4"
	techFileName = "techfile.cds"
	tech = techOpenTechFile(techLibName techFileName "r")
	if(tech==nil then
		return(nil)
	)
	;The template name is : met1_poly2

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "Met1_poly2_cap"
		?layer	 list("POLY2" "drawing")
		?width	 1.600000
		?choppable	 nil
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "center"
		?offset	 0.000000
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
			?sep	 0.000000
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.600000
			?endOffset	 -0.600000
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "distribute"
			)
		)
	) ; end of leDefineMPPTemplate procedure
) ; end of prog in ASCII file