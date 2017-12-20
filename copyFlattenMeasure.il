dstFig = dbCopyFig(srcFig, dstCellView, list(0:0 "R0" 1.0))
/**************************************************
* layerOffset gives the bounding box of a selected layer*
* default is MET1 *
* Version : 2.1   November 2007                   *
***************************************************/

; load("~/Skill/copyFlattenMeasure.il")
; USAGE :
; layerOffset()
; layerOffset( "MET4" geGetWindowCellView())
; layerOffset( "PAD"  geGetWindowCellView())

dst=dbCopyCellView(cv "T2K_V5" "flattenCopy" "layout" "1" 1 t)
g=geOpen( ?lib "T2K_V5"  ?cell "flattenCopy" ?view "layout" ?mode "r")
leHiConvertShapeToPolygon()

procedure(layerOffset( @optional  (layer "MET1") (cv geGetWindowCellView()))
let( (dstFig xmin ymin xmax ymax x0M1 y0M1 x1M1 y1M1) ; to use later with layerOffset(pcMaster)

dstFig = dbOpenCellViewByType( "T2K_V5" "flattenCopy" "layout" "maskLayout" "w")
dbCopyFig(cv dstFig list(0:0 "R0" 1.0))

xmin=caar(cv~>bBox)
ymin=cadar(cv~>bBox)
xmax=caadr(cv~>bBox)
ymax=cadadr(cv~>bBox)
x0M1=xmax
y0M1=ymax
x1M1=xmin
y1M1=ymin
printf("cellName : %L \n" cv~>cellName)
foreach(met1Lpp 
	  setof(lpp cv~>layerPurposePairs lpp~>layerName==layer)
	(printf " ~>shapes = %L of %L\n" met1Lpp~>shapes met1Lpp~>layerName)
	foreach(shape met1Lpp~>shapes
		(printf "bBox of  = %L\n" shape~>bBox)
		x0M1=min(caar(shape~>bBox) x0M1)
		y0M1=min(cadar(shape~>bBox) y0M1)
		x1M1=max(caadr(shape~>bBox) x1M1)
		y1M1=max(cadadr(shape~>bBox) y1M1)

	         );foreach
         );foreach
x0M1=x0M1 - xmin
y0M1=y0M1 - ymin
x1M1=xmax - x1M1
y1M1=ymax - y1M1
;;list((x0M1 y0M1)(x1M1 y1M1));;<== derniere ligne est le resultat renvoye;;<== ne marche pas.. comprends pas la différence ...
list(x0M1:y0M1 x1M1:y1M1);;<== derniere ligne est le resultat renvoye
); fin du let
);fin procedure

layoutCell = dbOpenCellViewByType( "PAD_cell" "PAD_base_io_M2less"  "layout" )
yoyo = layerOffset()
printf("%L" yoyo)
dbPurge(layoutCell)

;; cv=geOpen( ?lib layoutCell~>libName ?cell layoutCell~>cellName  ?view "layout" ) ;; <== check results
;; ;; hiZoomIn(cv '((4.2 968.475) (1119.15 309.9)))
;; hiZoomWindowAtPoint( cv 1 centerBbox(yoyo) )
