;;load("/home/validmgr/ebecheto/Skill/TECH_C35B4.mpp.templates2.il")
prog((tech techLibName techFileName)
	techLibName = "TECH_C35B4"
	techFileName = "techfile.cds"
	tech = techOpenTechFile(techLibName techFileName "r")
	if(tech==nil then
		return(nil)
	)
	;The template name is : met1_poly1

leDefineMPPTemplate(?techId tech ?name "met1_poly1" ?layer list("POLY1" "drawing") ?width 1.1 ?choppable nil ?endType "flush"
?beginExt 0.0 ?endExt 0.0 ?justification "center" ?offset 0.0 ?encSubPath list(
list(
?layer list("MET1" "drawing") ?enclosure 0.2 ?choppable t ?beginOffset -0.2 ?endOffset -0.2)
)
?subRect list(
list(?layer list("CONT" "drawing") ?width 0.4 ?length 0.4 ?choppable t ?sep 0.0 ?justification "center" ?space 0.4 ?beginOffset -0.35
?endOffset -0.35 ?beginSegOffset 0.0 ?endSegOffset 0.0 ?gap "distribute")
)
) ; end of leDefineMPPTemplate procedure

leDefineMPPTemplate(?techId tech ?name "met1_poly1_08" ?layer list("POLY1" "drawing") ?width 0.8 ?choppable nil ?endType "flush"
?beginExt 0.0 ?endExt 0.0 ?justification "center" ?offset 0.0 ?encSubPath list(
list(
?layer list("MET1" "drawing") ?enclosure 0.05 ?choppable t ?beginOffset -0.05 ?endOffset -0.05)
)
?subRect list(
list(?layer list("CONT" "drawing") ?width 0.4 ?length 0.4 ?choppable t ?sep 0.0 ?justification "center" ?space 0.4 ?beginOffset -0.2
?endOffset -0.2 ?beginSegOffset 0.0 ?endSegOffset 0.0 ?gap "distribute")
)
) ; end of leDefineMPPTemplate procedure


leDefineMPPTemplate(?techId tech ?name "met1_poly1_08sqrt2" ?layer list("POLY1" "drawing") ?width 0.8*sqrt(2) ?choppable nil ?endType "flush"
?beginExt 0.0 ?endExt 0.0 ?justification "center" ?offset 0.0 ?encSubPath list(
list(
?layer list("MET1" "drawing") ?enclosure 0.05*sqrt(2) ?choppable t ?beginOffset 0 ?endOffset 0)
)
?subRect list(
list(?layer list("CONT" "drawing") ?width 0.4 ?length 0.4 ?choppable t ?sep 0.0 ?justification "center" ?space 0.4/sqrt(2) ?beginOffset -0.5-0.4*sqrt(2) ?endOffset -0.5-0.4*sqrt(2) ?beginSegOffset 0.0 ?endSegOffset 0.0 ?gap "distribute" ?diagonal t)
)
) ; end of leDefineMPPTemplate procedure


leDefineMPPTemplate(?techId tech ?name "met1_poly2_08sqrt2" ?layer list("POLY2" "drawing") ?width 0.8*sqrt(2) ?choppable nil ?endType "flush"
?beginExt 0.0 ?endExt 0.0 ?justification "center" ?offset 0.0 ?encSubPath list(
list(
?layer list("MET1" "drawing") ?enclosure 0.05*sqrt(2) ?choppable t ?beginOffset 0 ?endOffset 0)
)
?subRect list(
list(?layer list("CONT" "drawing") ?width 0.4 ?length 0.4 ?choppable t ?sep 0.0 ?justification "center" ?space 0.4/sqrt(2) ?beginOffset -0.5-0.4*sqrt(2) ?endOffset -0.5-0.4*sqrt(2) ?beginSegOffset 0.0 ?endSegOffset 0.0 ?gap "distribute" ?diagonal t)
)
) ; end of leDefineMPPTemplate procedure






) ; end of prog in ASCII file