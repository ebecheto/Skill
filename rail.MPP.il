prog( 
   	 ( tech techLibName techFileName)

	techLibName = techGetTechFile(geGetWindowCellView())~>libName
;	techLibName = "TECH_C35B4"
	techFileName = techGetTechFile(geGetWindowCellView())~>fileName
;	techFileName = "techfile.cds"
    	tech = techOpenTechFile( techLibName techFileName "r" )

   	if(tech==nil  then return(nil) ) ; end if

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "railM3M4"
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
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
			)
		list(
			?layer	 list("MET3" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 65.65
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
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           23.9
                                  ?choppable       t
                                  ?sep             41.75
				  ?justification	 "left"
                            ) ; end of second sublist
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           20.9
                                  ?choppable       t
                                  ?sep             68.65
				  ?justification	 "left"
                            ) ; end of third subPath
                ) ; end of offset subpath lists
	) ; end of railM3M4


	leDefineMPPTemplate(
		?techId	 tech
		?name	 "railM3M4_off"
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
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
                        ?beginOffset      -30.0
			)
		list(
			?layer	 list("MET3" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 65.65
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
                        ?endOffset      41.7
                        ?beginOffset      -30.0
			)

		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           34.95
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           23.9
                                  ?choppable       t
                                  ?sep             41.75
				  ?justification	 "left"
                        	?endOffset      76.7
	                        ?beginOffset      0.0
                            ) ; end of second sublist
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           20.9
                                  ?choppable       t
                                  ?sep             68.65
				  ?justification	 "left"
                        	  ?endOffset      76.7
	                        ?beginOffset      0.0
                            ) ; end of third subPath
                ) ; end of offset subpath lists
	) ; end of railM3M4_off


	leDefineMPPTemplate(
		?techId	 tech
		?name	 "railM3M4_off_dwn"
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
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
                        ?beginOffset      -30.0
			)
		list(
			?layer	 list("MET3" "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 65.65
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
                        ?beginOffset      41.7
                        ?endOffset      -30.0
			)

		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           34.95
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublistk
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           23.9
                                  ?choppable       t
                                  ?sep             41.75
				  ?justification	 "left"
                        	?beginOffset      76.7
	                        ?endOffset      0.0
                            ) ; end of second sublist
                            list(
                                  ?layer           list("MET3" "drawing")
                                  ?width           20.9
                                  ?choppable       t
                                  ?sep             68.65
				  ?justification	 "left"
                        	  ?beginOffset      76.7
	                          ?endOffset      0.0
                            ) ; end of third subPath
                ) ; end of offset subpath lists
	) ; end of railM3M4_off_dwn

couche = "MET1"
largeur = 0.8
	leDefineMPPTemplate(
		?techId	 tech
		?name	 "bus-8-M1"
		?layer	 list(couche "drawing")
		?width	 largeur
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
   	    	?offsetSubPath   
   	    	list(
                   list(
                          ?layer           list(couche "drawing")
                          ?width           largeur
                          ?choppable       t
                          ?sep             1
			  ?justification	 "left"
                    ) ; end of first sublistk
                    list(
                          ?layer           list(couche "drawing")
                          ?width           largeur
                          ?choppable       t
                          ?sep             2.8
			  ?justification	 "left"
                    ) ; end of second sublist
                    list(
                          ?layer           list(couche "drawing")
                          ?width           largeur
                          ?choppable       t
                          ?sep             4.8
			  ?justification	 "left"
                    ) ; end of second sublist
                    list(
                          ?layer           list(couche "drawing")
                          ?width           largeur
                          ?choppable       t
                          ?sep             6.4
			  ?justification	 "left"
                    ) ; end of third subPath
                    list(
                          ?layer           list(couche "drawing")
                          ?width           largeur
                          ?choppable       t
                          ?sep             8.2
			  ?justification	 "left"
                    ) ; end of third subPath
                    list(
                          ?layer           list(couche "drawing")
                          ?width           largeur
                          ?choppable       t
                          ?sep             10.0
			  ?justification	 "left"
                    ) ; end of third subPath
                    list(
                          ?layer           list(couche "drawing")
                          ?width           largeur
                          ?choppable       t
                          ?sep             11.8
			  ?justification	 "left"
                    ) ; end of third subPath
                ) ; end of offset subpath lists
	) ; end of bus-8-M1


	leDefineMPPTemplate(
		?techId	 tech
		?name	 "railM4"
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
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
                        ?beginOffset      -30.0
			)
		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           34.95
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublist
                ) ; end of offset subpath lists
	) ; end of railM4

couleur = "MET1"

	leDefineMPPTemplate(
		?techId	 tech
		?name	 strcat( "rail_" couleur)
		?layer	 list(couleur "drawing")
		?width	 34.95
		?choppable	 t
		?endType	 "flush"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "right"
		?offset	 0.000000
		?subRect	 list(
		list(
			?layer	 list(couleur "drawing")
			?width	 3.000000
			?length	 10.000000
			?choppable	 t
			?sep	 0.000000
			?justification	 "left"
			?space	 30.000000
			?gap	 "distribute"
			?diagonal	 t
                        ?beginOffset      -30.0
			)
		)
   	    	    	 ?offsetSubPath   
   	    	    	    	    	    	 list(
                            list(
                                  ?layer           list(couleur "drawing")
                                  ?width           34.95
                                  ?choppable       t
                                  ?sep             3.000000
				  ?justification	 "left"
                            ) ; end of first sublist
                ) ; end of offset subpath lists
	) ; end of railM4


) ; end prog

;; load("~/Skill/rail.MPP.il")
