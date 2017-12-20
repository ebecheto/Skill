;; load "~/Skill/railBox.il"
prog( 
   	 ( tech techLibName techFileName)
	techLibName = "TECH_C35B4"
	techFileName = "techfile.cds"
   	    	 tech         =         techOpenTechFile( techLibName techFileName "r" )

   	    	 if(tech==nil 
   	    	 then
   	    	    	 return(nil)
   	    	 ) ; end if

   	 leDefineMPPTemplate(
   	    	    	    	    	 ?techId          tech
   	    	    	    	    	 ?name            "railBox"
   	    	    	    	    	 ?layer           list("MET1" "drawing")
					 ?justification   "right"
   	    	    	    	    	 ?width           0.500000
   	    	    	 ?offsetSubPath   ; M1 pourtour
   	    	    	    	    	    	 list(
                            list(
			?layer	 list("MET1" "drawing")
			?width	 2.900000
                        ?beginOffset     -5.000000
                        ?endOffset     5.000000
                            ) ; end of first sublist
                            list(
			?layer	 list("MET1" "drawing")
			?width	 2.900000
                        ?beginOffset     -5.000000
                        ?endOffset     5.000000
                            ) ; end of second sublist
                            list(
                                  ?layer           list("MET4" "drawing")
                                  ?width           1.000000
                                  ?choppable       t
                                  ?sep             6.000000
                            ) ; end of third sublist
                ) ; end of offset subpath lists



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
   	 ) ; end leDefineMPPTemplate function for railBox

) ; end prog
