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
*  - v2ed: Edouard Modifs			  *
*			                          *
***************************************************/

;load("~/Skill/pin2label_v2.il")
;load("~/Skill/pin2label_v2ed.il")

procedure(pin2label(@optional (copy? t ) (LabelSize 5) )
let( ( cv numberofpins layerList layer)
; Selection of the pin

 if((cv =geGetEditCellView())  then	; test sur l'existence d'une fenetre ouverte 
            numberofpins=0

when( copy? 	;; <== peut être rajouter un check sur l'existance d'une selection d'une fenetre "layout"
;; changer peut-être "layout" par cv~>view~>name et ".pin" en @opional (pinExt ".pin")
;; strcat(cv~>view~>name ".pin")
dstCellView  = dbOpenCellViewByType( cv~>libName cv~>cellName strcat("layout" ".pin") "maskLayout" "w")
)

	
         ; Selection of layer METX pin
         foreach(pinLPP setof(lpp cv~>layerPurposePairs lpp~>purpose=="pin"||"PIN")
          ; Selection of each pin in METX pin
;	printf("nb of shapes : %L\n" length(pinLPP~>shapes))
          foreach(shape pinLPP~>shapes
           ; check if the shape is really a pin
           if( shape~>pin then
            ; create a label in the right layer
	printf("\t bBox : %L; shape : %L, lpp :%L \n" shape~>bBox shape~>pin shape~>lpp )
	when( copy?  
	srcFig = shape
	dstFig = dbCopyFig(srcFig, dstCellView, list(0:0 "R0" 1.0)); <== DANGER do not copy pin connection info ?!why
	dbCopyProp(shape dstFig)
;;dbSave(dstCellView)
	); end when
printf("pin: %L -LAYER: %L -cadr(shape~>lpp): %L\n" shape~>net~>term~>name 
							shape~>lpp 
							cadr(shape~>lpp))

;	layerList = '( ("PAD" "pad") )
	layerList = '( ("MET1" "metal1") ("MET2" "metal2") ("MET3" "metal3") ("MET4" "metal4") ("PAD" "pad") )
;	foreach( layer layerList ;)
	for( i 1 length(layerList)
;		printf("%L,%L, %L" layerList length(layerList) nthelem(i layerList))
		layer = nthelem(i layerList)
;		printf("pin: %L, %L, %L\n" layer car(layer)  cadr(layer) )
            when( cadr(shape~>lpp) == cadr(layer)
;              ( car(layer) || cadr(layer) ;)
;             ("metal1" ;)
 	      printf("pin: %L, %L, %L\n" layer car(layer)  cadr(layer) )
              srcFig = dbCreateLabel(geGetEditCellView() list( "PIN" cadr(layer))
              centerBox(shape~>bBox) shape~>net~>term~>name "centerCenter" "R0" "roman" LabelSize)
	      when( copy? dstFig = dbCopyFig(srcFig, dstCellView, list(0:0 "R0" 1.0)) )
              numberofpins++
            );case/if
	    );foreach layer
           );if
          );foreach shape
         );foreach pinLPP
         ; print the number of added label
         printf( "pin2label: cell %s, added %d labels" cv~>cellName numberofpins )
         hiRedraw()

else
 	    printf("Pin2label ERROR: no layout cellview open or selected, exiting.\n")
	); end if        

when( 
printf("**** copies in %L %L *****\n" dstCellView~>cellName dstCellView~>viewName )
copy?  dbSave(dstCellView) dbClose(dstCellView)
)

);let
    
);procedure

;; USAGE pin2label()
;; USAGE pin2label(nil)

