/**************************************************
* pin2label() find the pin in a layout and put    *
* a label for ASSURA                              *
*                                                 *
* Authors : Frederic Morel, Gregory Bertolone 	  *
*			IPHC (IN2P3-CNRS / ULP)	  *
* Version : 2.1   November 2007                   *
* History :                                       *
*  - 1.0 : selection of all objects and the test  *
*          of lpp use several if                  *
*  - 1.1 : selection of all objects and the test  *
*          of lpp use one case                    *
*  - 2.0 : list all the pin with layerPurposePair *
*          and the test of lpp use one case       *
*                        *
***************************************************/

;load("~/Skill/pin2label_v2.il")

procedure(pin2label(@optional (copy? t ))
let( ( cv numberofpins )
; Selection of the pin

 if((cv =geGetEditCellView())  then	; test sur l'existence d'une fenetre ouverte 
            numberofpins=0

when( copy? 	
dstCellView  = dbOpenCellViewByType( cv~>libName cv~>cellName strcat("layout" ".pin") "maskLayout" "w")
printf("**** copies in %L *****\n" dstCellView~>cellName)
)

	
         ; Selection of layer METX pin
         foreach(pinLPP setof(lpp cv~>layerPurposePairs lpp~>purpose=="pin"||"PIN")
          ; Selection of each pin in METX pin
	printf("nb of shapes : %L\n" length(pinLPP~>shapes))
          foreach(shape pinLPP~>shapes
           ; check if the shape is really a pin
           if( shape~>pin then
            ; create a label in the right layer
	printf("\t bBox : %L\n" shape~>bBox)
	when( copy?  
	srcFig = shape
	dstFig = dbCopyFig(srcFig, dstCellView, list(0:0 "R0" 1.0))
printf(" - pin : %L\n" shape~>net~>term~>name)
;;dbSave(dstCellView)
	)
            case( car(shape~>lpp)
             ("MET1" 
               dbCreateLabel(geGetEditCellView() list( "PIN" "metal1")
               centerBox(shape~>bBox) shape~>net~>term~>name "centerCenter" "R0" "roman" 0.5)
               numberofpins++
              )
             ("MET2"
               dbCreateLabel(geGetEditCellView() list( "PIN" "metal2")
               centerBox(shape~>bBox) shape~>net~>term~>name "centerCenter" "R0" "roman" 0.5)
               numberofpins++
             )
            ("MET3" 
              dbCreateLabel(geGetEditCellView() list( "PIN" "metal3")
              centerBox(shape~>bBox) shape~>net~>term~>name "centerCenter" "R0" "roman" 0.5)
              numberofpins++
             )
            ("MET4"
              dbCreateLabel(geGetEditCellView() list( "PIN" "metal4")
              centerBox(shape~>bBox) shape~>net~>term~>name "centerCenter" "R0" "roman" 0.5)
              numberofpins++
             )
            );case
           );if
          );foreach
         );foreach
         ; print the number of added label
         printf( "pin2label: cell %s, added %d labels" cv~>cellName numberofpins )
         hiRedraw()

else
 	    printf("Pin2label ERROR: no layout cellview open or selected, exiting.\n")
	); end if        

when( copy?  dbSave(dstCellView) dbClose(dstCellView) )

);let
    
);procedure

;; USAGE pin2label()
;; USAGE pin2label(copy? nil)

