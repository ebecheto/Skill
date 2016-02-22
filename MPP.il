;; copyleft ebecheto
;; This procedure identifies the technology library and technology file names, and
;; opens the technology file in read-only mode.If the technology library does not
;; open, the procedure displays an error message and exits.If the technology library
;; opens,the procedure continues, and reads the leDefineMPPTemplate functions, 
;; each of which define the fields and values for a multipart path (MPP).

;; load("~/Skill/MPP.il")

prog( 
   	 ( tech techLibName techFileName)

	techLibName = techGetTechFile(geGetWindowCellView())~>libName
;	techLibName = "TECH_C35B4"
	techFileName = techGetTechFile(geGetWindowCellView())~>fileName
;	techFileName = "techfile.cds"
   	    	 tech = techOpenTechFile( techLibName techFileName "r" )

   	    	 if(tech==nil 
   	    	 then
   	    	    	 return(nil)
   	    	 ) ; end if

   	 ; Template1 defines an MPP consisting of only a master path.

   	 leDefineMPPTemplate(
   	    	 ?techId            tech
   	    	 ?name             "template1"
   	    	 ?layer             list("MET1" "drawing")
   	    	 ?width             0.600000
   	    	 ?choppable         t
   	    	 ?endType           "flush"
   	    	 ?justification     "center"
   	    	 ?offset            0.700000
   	    	 ?termIOType        "switch"
   	    	 ?pin               t
   	    	 ?pinAccessDir      list( "bottom" "left" "right" )

   	 ) ; end leDefineMPPTemplate function for template1

   	 ; Template2 defines an MPP consisting of a master path, three offset subpaths, 
   	 ; three enclosure subpaths, and three sets of subrectangles.

   	 leDefineMPPTemplate(
   	    	    	    	    	 ; Master path
   	    	    	    	    	 ?techId          tech
   	    	    	    	    	 ?name            "Template2"
   	    	    	    	    	 ?layer           "prBoundary"
   	    	    	    	    	 ?width           0.600000

   	    	    	 ; Three offset subpaths

   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("NPLUS" "drawing")
                                  ?width           1.000000
                                  ?choppable       t
                                  ?sep             2.000000
                            ) ; end of first sublist
                            list(
                                  ?layer           list("DIFF" "drawing")
                                  ?width           1.000000
                                  ?choppable       t
                                  ?sep             4.000000
                            ) ; end of second sublist
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           1.000000
                                  ?choppable       t
                                  ?sep             6.000000
                            ) ; end of third sublist
                ) ; end of offset subpath lists

   	    	    	 ; Three enclosure subpaths

   	    	    	 ?encSubPath      
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?enclosure       0.100000
                                  ?choppable       t
                                  ?beginOffset     0.100000
                                  ?endOffset       0.200000
                ) ; end of first sublist
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?enclosure       0.150000
                                  ?choppable       t
                                  ?beginOffset     0.200000
                                  ?endOffset       0.300000
                ) ; end of second sublist
                            list(
                                  ?layer           list("DIFF" "drawing")
                                  ?enclosure       0.180000
                                  ?choppable       t
                                  ?beginOffset     0.300000
                                  ?endOffset       0.400000
                            ) ; end of third sublist
                ) ; end of enclosure subpath lists

   	    	    	 ; Three sets of subrectangles

   	    	    	 ?subRect         
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("PPLUS" "drawing")
                                  ?width           0.500000
                                  ?length          0.600000
                                  ?choppable       t
                                  ?sep             0.200000
                                  ?space           1.000000
                            ) ; end of first sublist
                            list(
                                  ?layer           list("MET1" "drawing")
                                  ?width           0.600000
                                  ?length          0.800000
                                  ?choppable       t
                                  ?sep             0.500000
                                  ?space           3.000000
                            ) ; end of second sublist
                            list(
                                  ?layer           list("POLY1" "drawing")
                                  ?width           0.800000
                                  ?length          1.000000
                                  ?choppable       t
                                  ?sep             2.000000
                                  ?space           5.000000
                            ) ; end of third list
                ) ; end of subrectangle lists
   	 ) ; end leDefineMPPTemplate function for template2

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
		?subRect	 list(
		list(
			?layer	 list("MET2" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
                        ?beginOffset     -10.000000
                        ?endOffset     0.000000
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		list(
			?layer	 list("MET2" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
                        ?beginOffset     -10.000000
                        ?endOffset     0.000000
			?sep	 27.0
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)

		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             30.000000
				  ?justification	 "left"
                            ) ; end of second sublist
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function Newew

;;load("~/Skill/MPP.il")
	leDefineMPPTemplate(
		?techId	 tech
		?name	 "gnd3strip"
		?layer	 list("MET3" "drawing")
		?width	 20.450000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET3" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
                        ?beginOffset     -30.000000
                        ?endOffset     -30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		list(
			?layer	 list("MET3" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 27.0
			?justification	 "left"
			?space	 30.000000
                        ?beginOffset     -30.000000
                        ?endOffset     -30.000000
			?gap	 "distribute"
			?diagonal	 t
			)

		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           20.450000
                                  ?choppable       t
                                  ?sep             30.000000
				  ?justification	 "left"
                            ) ; end of second sublist
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function gnd3strip

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "gnd2strip"
		?layer	 list("MET3" "drawing")
		?width	 20.450000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET3" "drawing")
			?width	 3.000000
			?length	 30.000000
			?choppable	 t
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           20.450000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function gnd2strip

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "gnd2stripM2"
		?layer	 list("MET2" "drawing")
		?width	 24.0
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET2" "drawing")
			?width	 3.000000
			?length	 30.000000
			?choppable	 t
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
                        ?beginOffset    -30.00000
                        ?endOffset     -30.00000
			?diagonal	 t
			)
		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?width           24.0
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function gnd2strip


	leDefineMPPTemplate(
		?techId	 tech
		?name	 "gndM1"
		?layer	 list("MET1" "drawing")
		?width	 24.000000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET1" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		list(
			?layer	 list("MET1" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 27.0
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)

		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET1" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET1" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             30.000000
				  ?justification	 "left"
                            ) ; end of second sublist
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function gndM1

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "gndM2"
		?layer	 list("MET2" "drawing")
		?width	 24.000000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET2" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
                        ?beginOffset     -30.000000
                        ?endOffset     30.000000
			)
		list(
			?layer	 list("MET2" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 27.0
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
                        ?beginOffset     -30.000000
                        ?endOffset     30.000000
			)

		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             30.000000
				  ?justification	 "left"
                            ) ; end of second sublist
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function gndM1


; defW=23.9 foreach(mapcar sep list(23.1+3 23.1+3+23.9 ) sep-defW )
leDefineMPPTemplate(?techId  tech ?name "gndM2_3R" ?layer list("MET2" "drawing") ?width	 23.9
?choppable t ?endType "flush" ?beginExt 0 ?endExt 0 ?justification "right" ?offset 0 
?subRect list(
list(?layer list("MET2" "drawing") ?width 3.0 ?length 10.0 ?choppable t ?sep 0.0 ?justification "left" 
?space	 30.0 ?gap "distribute" ?diagonal t ?beginOffset -30.0 ?endOffset 0.0 )
list(?layer list("MET2" "drawing") ?width 3.0 ?length 10.0 ?choppable t ?sep 26.1 ?justification "left"
?space 30.0 ?gap "distribute" ?diagonal t ?beginOffset -30.0 ?endOffset 0.0 )
); end subrect
?offsetSubPath list(
list(?layer list("MET2" "drawing") ?width 23.1 ?choppable t ?sep 3.0 ?justification "left" );1st sublist
list(?layer list("MET2" "drawing") ?width 23.9 ?choppable t ?sep 29.1 ?justification "left" );2nd sublist
); end of offset subpath lists
); end GNDM23R

leDefineMPPTemplate(?techId  tech ?name "gndM1_RR" ?layer list("MET1" "drawing") ?width	 10.0
?choppable t ?endType "flush" ?beginExt 0 ?endExt 0 ?justification "right" ?offset 0 
?subRect list(
list(?layer list("MET1" "drawing") ?width 3.0 ?length 10.0 ?choppable t ?sep 0.0 ?justification "left" 
?space 30.0 ?gap "distribute" ?diagonal t ?beginOffset 0.0 ?endOffset 0.0 )
); end subrect
?offsetSubPath list(
list(?layer list("MET1" "drawing") ?width 10.0 ?choppable t ?sep 3.0 ?justification "left" );1st sublist
); end of offset subpath lists
); end gndM1_RR


leDefineMPPTemplate(
		?techId	 tech
		?name	 "gndM2noSubRect"
		?layer	 list("MET2" "drawing")
		?width	 24.000000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             30.000000
				  ?justification	 "left"
                            ) ; end of second sublist
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function gndM1


	leDefineMPPTemplate(
		?techId	 tech
		?name	 "halfM1"
		?layer	 list("MET2" "drawing")
		?width	 24.000000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET2" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
                        ?beginOffset     -10.000000
                        ?endOffset     0.000000
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)

		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET2" "drawing")
                                  ?width           12.000000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function halfM1
	leDefineMPPTemplate(
		?techId	 tech
		?name	 "M4_Wide"
		?layer	 list("MET4" "drawing")
		?width	 24.000000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET4" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
                        ?beginOffset    -30.00000
                        ?endOffset     -30.00000
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function M4_Wide

; foreach(mapcar sep list(214.05 182.2  155.3  115.55 77.6  37.95) sep-34.95 )
;			 (179.1  147.25 120.35 80.6   42.65 3.0 ) ;80.6-3=77.6

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "M4_7R"
		?layer	 list("MET4" "drawing")
		?width	 34.95
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET4" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
                        ?beginOffset    0; -50.00000
                        ?endOffset     -30.00000
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		list(
			?layer	 list("MET4" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
                        ?beginOffset    0; -50.00000
                        ?endOffset     -30.00000
			?sep	 77.6
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           34.95
                                  ?choppable       t
                                  ?sep             3.0
				  ?justification	 "left"
                            ) ; end of 2nd (1+master)
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           34.95
                                  ?choppable       t
                                  ?sep             42.65
				  ?justification	 "left"
                            ) ; end of 3rd
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           34.95
                                  ?choppable       t
                                  ?sep             80.6
				  ?justification	 "left"
                            ) ; end of 4th
list(?layer list("MET4" "drawing") ?width 34.95 ?choppable t ?sep 80.6   ?justification "left") ; end of 4th
list(?layer list("MET4" "drawing") ?width 24.1 ?choppable t ?sep 120.35 ?justification "left") ; end of 5th
list(?layer list("MET4" "drawing") ?width 29.1 ?choppable t ?sep 147.25 ?justification "left") ; end of 6th
list(?layer list("MET4" "drawing") ?width 19.1 ?choppable t ?sep 179.1 ?justification "left") ; end of 7th
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function M4_7R


	leDefineMPPTemplate(
		?techId	 tech
		?name	 "diff_cont"
		?layer	 list("DIFF" "drawing")
		?width	 0.700000
		?choppable	 nil
		?endType	 "truncate"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "center"
		?offset	 0.000000
		?encSubPath	 list(
		list(
			?layer	 list("MET1" "drawing")
			?enclosure	 0.000000
			?choppable	 t
			?beginOffset	 0.000000
			?endOffset	 0.000000
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
			?gap	 "distribute"
			)
		)

	) ; end of leDefineMPPTemplate procedure

leDefineMPPTemplate(
		?techId	 tech
		?name	 "pdiff_subCont"
		?layer	 list("MET1" "drawing")
		?width	 0.700000
		?choppable	 nil
		?endType	 "truncate"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0
		?encSubPath	 list(
		list(   ?layer	 list("DIFF" "drawing")
			?enclosure	 0.000000
			?choppable	 t
			?beginOffset	 0.250000
			?endOffset	 0.250000
			)
		list(   ?layer	 list("NPLUS" "drawing")
			?enclosure	 0.0500
			?choppable	nil
			?beginOffset	 0.50000
			?endOffset	 0.50000
			)
		)
		?subRect	 list(
		list(   ?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?sep	 0.000000
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.150000
			?endOffset	 -0.150000
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "minimum"
			)
		list(   ?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?sep	 0.800000
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.150000
			?endOffset	 -0.150000
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "minimum"
			)
		)
		?offsetSubPath   list(
                            list( ?layer           list("MET1" "drawing")
                                  ?width           0.7
                                  ?choppable       t
                                  ?sep             0.8
				  ?justification	 "center"
                            ) ; 
                            list( ?layer           list("DIFF" "drawing")
				  ?beginOffset	 1.250000
                                  ?width           0.2
                                  ?choppable       t
                                  ?sep             -0.05
				  ?justification	 "left"
                            ) ; 
                            list( ?layer           list("PPLUS" "drawing")
				  ?beginOffset	 0.50000
                                  ?width           0.2
                                  ?choppable       t
                                  ?sep             0
				  ?justification	 "left"
                            ) ; 
                            list( ?layer           list("NPLUS" "drawing")
				  ?beginOffset	 0.50000
                                  ?width           0.4
                                  ?choppable       t
                                  ?sep             -0.05
				  ?justification	 "left"
                            ) ; 
                            list( ?layer           list("NTUB" "drawing")
				  ?beginOffset	 1
                                  ?width           0.4
                                  ?choppable       t
                                  ?sep             1.2
				  ?justification	 "left"
                            ) ; 
		)

	);end pdiff_subCont

leDefineMPPTemplate(
		?techId	 tech
		?name	 "bottomLess"
		?layer	 list("MET1" "drawing")
		?width	 0.700000
		?choppable	 nil
		?endType	 "truncate"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "center"
		?offset	 0
		?subRect	 list(
		list(   ?layer	 list("CONT" "drawing")
			?width	 0.400000
			?length	 0.400000
			?choppable	 t
			?sep	 0.000000
			?justification	 "center"
			?space	 0.400000
			?beginOffset	 -0.150000
			?endOffset	 -0.150000
			?beginSegOffset	 0.000000
			?endSegOffset	 0.000000
			?gap	 "minimum"
			)
		)
		?offsetSubPath   list(
                            list( ?layer           list("MET1" "drawing")
                                  ?width           0.2
                                  ?choppable       t
                                  ?sep             0.0
				  ?justification	 "right"
                            ) ; 
                            list( ?layer           list("DIFF" "drawing")
				  ?beginOffset	 0.250000
                                  ?width           0.2
                                  ?choppable       t
                                  ?sep             0.0
				  ?justification	 "right"
                            ) ; 
                            list( ?layer           list("NPLUS" "drawing")
				  ?beginOffset	 0.50000
                                  ?width           0.4
                                  ?choppable       t
                                  ?sep             -0.05
				  ?justification	 "left"
                            ) ; 
                            list( ?layer           list("NTUB" "drawing")
				  ?beginOffset	 1
                                  ?width           0.4
                                  ?choppable       t
                                  ?sep             0
				  ?justification	 "left"
                            ) ; 
		)

	)



	leDefineMPPTemplate(
		?techId	 tech
		?name	 "gnd3stripM1"
		?layer	 list("MET1" "drawing")
		?width	 20.450000
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list("MET1" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
                        ?beginOffset     -30.000000
                        ?endOffset     -30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		list(
			?layer	 list("MET1" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 27.0
			?justification	 "left"
			?space	 30.000000
                        ?beginOffset     -30.000000
                        ?endOffset     -30.000000
			?gap	 "distribute"
			?diagonal	 t
			)

		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET1" "drawing")
                                  ?width           24.000000
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET1" "drawing")
                                  ?width           20.450000
                                  ?choppable       t
                                  ?sep             30.000000
				  ?justification	 "left"
                            ) ; end of second sublist
                ) ; end of offset subpath lists

	) ; end of leDefineMPPTemplate for function gnd3strip



;;; VIA P1C
leDefineMPPTemplate(?techId tech ?name "viaP1C" ?layer list("POLY1" "drawing")
?width 0.8 ?endType "truncate" ?justification "center" 
?encSubPath list(
list(?layer list("MET1" "drawing") ?enclosure 0.05 ?beginOffset -0.05 ?endOffset -0.05)
); end subPath
?subRect list(
list(?layer list("CONT" "drawing") ?width 0.4 ?length 0.4 ?justification "center" ?space 0.4 ?gap "minimum" ?beginOffset -0.2 ?endOffset -0.2)
); end subRect
) ; end of leDefineMPPTemplate procedure

;;; VIA stack P1C && VIA1
leDefineMPPTemplate(?techId tech ?name "stack_P1C_VIA1" 
?layer list("MET1" "drawing") ?width 0.9 ?endType "truncate" ?justification "center" 
?encSubPath list(
list(?layer list("POLY1" "drawing") ?enclosure 0.05 ?beginOffset -0.2  ?endOffset -0.2)
list(?layer list("MET2" "drawing") ?enclosure 0.05  ?beginOffset -0.05 ?endOffset -0.05)
); end subPath
?subRect list(
list(?layer list("CONT" "drawing") ?width 0.4 ?length 0.4 ?justification "center" ?space 0.4  ?gap "minimum" ?beginOffset -0.4 ?endOffset -0.4)
;list(?layer list("VIA1" "drawing") ?width 0.5 ?length 0.5 ?justification "center" ?space 0.45 ?gap "minimum" ?beginOffset -0.2 ?endOffset -0.2)
list(?layer list("VIA1" "drawing") ?width 0.5 ?length 0.5 ?justification "center" ?space 0.45 ?gap "minimum" ?beginOffset -0.2 ?endOffset -0.65)
); end subRect
) ; end of leDefineMPPTemplate procedure


;;; VIA stack P1C && VIA1
leDefineMPPTemplate(?techId tech ?name "mpp_VIA1" 
?layer list("MET1" "drawing") ?width 0.9 ?endType "truncate" ?justification "center" 
?encSubPath list(
list(?layer list("MET2" "drawing") ?enclosure 0.05  ?beginOffset -0.05 ?endOffset -0.05)
); end subPath
?subRect list(
;list(?layer list("VIA1" "drawing") ?width 0.5 ?length 0.5 ?justification "center" ?space 0.45 ?gap "minimum" ?beginOffset -0.2 ?endOffset -0.2)
list(?layer list("VIA1" "drawing") ?width 0.5 ?length 0.5 ?justification "center" ?space 0.45 ?gap "minimum" ?beginOffset -0.2 ?endOffset -0.65)
); end subRect
) ; end of leDefineMPPTemplate procedure



) ; end prog

;; load("~/Skill/MPP.il")

