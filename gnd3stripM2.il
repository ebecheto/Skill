; load("gnd3stripM2.il")
prog(( tech techLibName techFileName)
techLibName = techGetTechFile(geGetWindowCellView())~>libName
techFileName = techGetTechFile(geGetWindowCellView())~>fileName
tech = techOpenTechFile( techLibName techFileName "r" )
if(tech==nil then return(nil)) ; end if

;foreach(mapcar a linRg(1 5 1) 3+a*(9+3)) ;=>(15 27 39 51 63)

leDefineMPPTemplate(?techId tech ?name "gnd3stripM2" ?layer list("MET2" "drawing") 
?width 9 ?choppable t ?endType "flush" ?beginExt 0.0 ?endExt 0.0 ?justification "right" ?offset 0.0 
?offsetSubPath list(
list(
?layer           list("MET2" "drawing")
?width           9.0
?sep             3.0
?justification	 "left")

list(
?layer           list("MET2" "drawing")
?width           9.0
?choppable       t
?sep             15.0
?justification	 "left")

list(
?layer           list("MET2" "drawing")
?width           9.0
?choppable       t
?sep             27.0
?justification	 "left")

list(
?layer           list("MET2" "drawing")
?width           9.0
?choppable       t
?sep             39.0
?justification	 "left")

list(
?layer           list("MET2" "drawing")
?width           9.0
?choppable       t
?sep             51.0
?justification	 "left")

) ; end of offset subpath lists
) ; end of leDefineMPPTemplate for function gnd3strip
)