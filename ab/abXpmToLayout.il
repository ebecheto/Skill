/* abXpmToLayout.ils

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Jun 15, 2001 
Modified   
By         

NOTE: This is SKILL++ code, so please preserve the .ils suffix.

Code to read an X pixmap and draw a layout.

The main entry function is abXpmToLayout(), which should
be invoked with a layout window being the current window.

Limitations/Ideas for future:

1. This only handles up to something like 62 layers
   properly. This is because the pixmap format changes to use
   more than one character per pixel, and the code rather
   dumbly assumes that there will only ever be one. To
   be fair, setting up all the layer purpose pairs would
   be a nightmare.
2. Could merge colours which appear similar, to avoid
   having to specify similar colours lots of times.
3. Some convenience toggles could be added, to turn on or
   off all layers.

Primarily this expected to be used for a small number of
colours in the pixmap file. This can be arranged using
other tools (xv, gimp, PC tools etc).
These tools can also be used to convert from other formats
to xpm.

***************************************************

SCCS Info: @(#) abXpmToLayout.ils 06/15/01.15:27:13 1.4

*/

(importSkillVar abPixMapOptionsForm)

;------------------------------------------------------------------------
; Define classes used within the code
;------------------------------------------------------------------------

(defclass abPixMap ()
  (
   (width @initarg width @reader abPixMapGetWidth)
   (height @initarg height @reader abPixMapGetHeight)
   (colours @initarg colours @reader abPixMapGetColours)
   (pixels @initarg pixels @reader abPixMapGetPixels)
   )
  )

(defclass abPixMapColour ()
  (
   (char @initarg char)
   (red @initarg red @reader abPixMapColourGetRed)
   (green @initarg green @reader abPixMapColourGetGreen)
   (blue @initarg blue @reader abPixMapColourGetBlue)
   (lpp @reader abPixMapColourGetLpp @writer abPixMapColourSetLpp)
   )
  )

/***************************************************************
*                                                              *
*                (abPixMapColourGetLpp _colour)                *
*                                                              *
*   A dummy method, so that if the colour isn't found for a    *
*        character in the pixel strings, it returns nil        *
*                                                              *
***************************************************************/

(defmethod abPixMapColourGetLpp ((_colour list))
  nil
  )

/***************************************************************
*                                                              *
*                 (abPixMapReadFile fileName)                  *
*                                                              *
*  Read a pixmap file, and return an instance of the abPixMap  *
*                          structure.                          *
*                                                              *
***************************************************************/

(defun abPixMapReadFile (fileName)
  (let (prt staticFound line data dimensions width height ncolours
	    colourTable colourInfo red green blue pixmap)
       (unless (setq prt (infile fileName))
	       (error "Could not read pixmap file %s" fileName)
	       )
       (rexCompile "static char")
       (while (and (null staticFound) (gets line prt))
	      (setq staticFound (rexExecute line))
	      )
       (when staticFound
	     (setq data t)
	     (while (equal (setq data (lineread prt)) t) t)
	     ;-----------------------------------------------------------
	     ; Swallow any warnings about closing } etc
	     ;-----------------------------------------------------------
	     (getWarn)
	     )
       (close prt)
       (when (and data (nequal data t))
	     ;-----------------------------------------------------------
	     ; first entry in the list will be the dimensional information
	     ;-----------------------------------------------------------
	     (setq dimensions (linereadstring (car data)))
	     (setq width (car dimensions))
	     (setq height (cadr dimensions))
	     (setq ncolours (caddr dimensions))
	     (setq data (cdr data))
	     ;-----------------------------------------------------------
	     ; Now read the colours
	     ;-----------------------------------------------------------
	     (setq colourTable (makeTable 'colourTable nil))
	     (for colour 1 ncolours
		  (setq colourInfo (parseString (car data)))
		  (setq data (cdr data))
		  (when (cddr colourInfo)
			(sscanf (caddr colourInfo)
				"#%2x%2x%2x" red green blue
				)
			(setarray colourTable
				  (car colourInfo)
				  (makeInstance 'abPixMapColour
						?char (car colourInfo)
						?red red || 0
						?green green || 0
						?blue blue || 0
						)
				  )
			)
		  )
	     ;-----------------------------------------------------------
	     ; Now create the pixmap object
	     ;-----------------------------------------------------------
	     (setq pixmap
		   (makeInstance 'abPixMap
		    ?width width
		    ?height height
		    ?colours colourTable
		    ?pixels data
		    )
		   )
	     ) ; when
       pixmap
       )
  )

/***************************************************************
*                                                              *
*        abPixMapDrawLayout(@key pixmap (pixelSize 0.1)        *
*                (cellView (geGetEditCellView))                *
*                        (origin 0:0))                         *
*                                                              *
*      Draw the layout itself from the pixmap structure.       *
*                                                              *
***************************************************************/

(defun abPixMapDrawLayout (@key pixmap (pixelSize 0.1) 
				(cellView (geGetEditCellView))
				(origin 0:0))
  (let (x y colours rectList lpp)
       (setq colours (abPixMapGetColours pixmap))
       (setq y (yCoord origin))
       ;-----------------------------------------------------------------
       ; Iterate over each row
       ;-----------------------------------------------------------------
       (foreach row (abPixMapGetPixels pixmap)
		(setq x (xCoord origin))
		(foreach pixel (parseString row "")
			 ;-----------------------------------------------
			 ; Determine the layer purpose pair
			 ;-----------------------------------------------
			 (setq lpp 
			       (abPixMapColourGetLpp (arrayref colours pixel)))
			 ;-----------------------------------------------
			 ; Draw the rectangle
			 ;-----------------------------------------------
			 (when (and (listp lpp) lpp)
			       (setq rectList
				     (cons
				      (dbCreateRect
				       cellView
				       lpp
				       (list
					(list x y)
					(list 
					 (plus x pixelSize) 
					 (difference y pixelSize)
					 )
					)
				       )
				      rectList
				      )))
			 (setq x (plus x pixelSize))
			 )
		(setq y (difference y pixelSize))
		)
       ;-----------------------------------------------------------------
       ; Merge all the shapes to reduce the shape count
       ;-----------------------------------------------------------------
       (leMergeShapes rectList)
       t
       ))
				       

/***************************************************************
*                                                              *
*                     (abPixMapCreateForm)                     *
*                                                              *
*        Create the options form for the pixmap drawer.        *
*    Note that all the layers aren't put on the form until     *
*                    the file has been read                    *
*                                                              *
***************************************************************/

(defun abPixMapCreateForm ()
  (let (fileName selectFile pixelSize scrollRegion readFile)
       (setq fileName
	     (hiCreateStringField
	      ?name 'fileName
	      ?prompt "Pixmap File"
	      ?callback "(abUpdateSelectFile)"
	      )
	     )
       (setq selectFile
	     (hiCreateButton
	      ?name 'selectFile
	      ?buttonText "Select File"
	      ?callback "(abPixMapSyncWithSelectFile)"
	      )
	     )
       (setq readFile
	     (hiCreateButton
	      ?name 'readFile
	      ?buttonText "Read File"
	      ?callback "(abPixMapReadFileCB)"
	      )
	     )
       (setq pixelSize
	     (hiCreateFloatField
	      ?name 'pixelSize
	      ?defValue 0.1
	      ?prompt "Pixel Size"
	      )
	     )
       (setq scrollRegion
	     (hiCreateScrollRegion
	      ?borderWidth 0
	      ?name 'layers
	      )
	     )
       (hiCreateAppForm
	?name 'abPixMapOptionsForm
	?formTitle "Choose pixmap settings"
	?formType 'options
	?buttonLayout 'HideCancel
	?fields (list
		 (list fileName 0:0 405:35 105)
		 (list selectFile 105:35 95:30)
		 (list readFile 205:35 95:30)
		 (list pixelSize 0:70 405:35 105)
		 (list
		  (hiCreateLabel
		   ?name 'colourLab
		   ?labelText "Colour"
		   )
		  105:105 35:30)
		 (list
		  (hiCreateLabel
		   ?name 'convertLab
		   ?labelText "Draw"
		   )
		  160:105 32:30)
		 (list
		  (hiCreateLabel
		   ?name 'lppLab
		   ?labelText "Layer"
		   )
		  205:105 32:30)
		 (list scrollRegion 105:130 300:200)
		 )
	)
       )
  )

/***************************************************************
*                                                              *
*          (abPixMapAddPointCB _windowId _pointList)           *
*                                                              *
*     Ignore any points entered before the pixmap has been     *
*                            read.                             *
*                                                              *
***************************************************************/

(defun abPixMapAddPointCB (_windowId _pointList)
  (unless (getq abPixMapOptionsForm pixmap)
	  (deletePoint)
	  )
  )

/***************************************************************
*                                                              *
*             (abPixMapDoneCB _windowId ok points)             *
*                                                              *
*  When the points have been entered, and all is OK, proceed   *
* to fill the colour structure with the selected layer purpose *
*  pairs, and then draw the pixmap starting at the specified   *
*                         coordinates.                         *
*                                                              *
***************************************************************/

(defun abPixMapDoneCB (_windowId ok points)
  (let (pixmap)
       (setq pixmap (getq abPixMapOptionsForm pixmap))
       (when (and ok points pixmap)
	     (abPixMapFillInLpps (getq abPixMapOptionsForm layers) pixmap)
	     (abPixMapDrawLayout
	      ?pixmap pixmap
	      ?pixelSize (getq (getq abPixMapOptionsForm pixelSize) value)
	      ?cellView (getq abPixMapOptionsForm cellView)
	      ?origin (car points)
	      )
	     )
       )
  )

/***************************************************************
*                                                              *
*                (abPixMapGetLayer layerString)                *
*                                                              *
*      Because we have multiple layer cyclic fields, need      *
*       to extract the layer purpose pair name ourselves       *
*                                                              *
***************************************************************/

(defun abPixMapGetLayer (layerString)
  (let (layer)
       (setq layer (linereadstring layerString))
       (list (get_string (car layer))
             (get_string (caadr layer)))))


/***************************************************************
*                                                              *
*              (abPixMapFillInLpps region pixmap)              *
*                                                              *
*     Given the scroll region on the form, and the pixmap      *
*     instance, fill in the lpp information in the colour      *
*     structures, based on what was selected on the form.      *
*                                                              *
***************************************************************/

(defun abPixMapFillInLpps (region pixmap)
  (let (colours colourNum colour)
       (setq colours (abPixMapGetColours pixmap))
       (setq colourNum 0)
       ;-----------------------------------------------------------------
       ; Loop through all the colour names
       ;-----------------------------------------------------------------
       (foreach colourName (getq region colourNames)
		(setq colour (arrayref colours colourName))
		(abPixMapColourSetLpp
		 colour
		 (and (getq (get region (concat 'convert colourNum)) value)
		      (abPixMapGetLayer 
		       (cadddr
			(getq (get region (concat 'lpp colourNum)) value))
		       )
		      )
		 )
		(postincrement colourNum)
		)
       )
  )

/***************************************************************
*                                                              *
*                 (abPixMapSyncWithSelectFile)                 *
*                                                              *
*      Set up the synchronisation with the file selecter       *
*                                                              *
***************************************************************/

(defun abPixMapSyncWithSelectFile ()
  (abSyncWithSelectFile
   abPixMapOptionsForm
   'fileName
   nil))

/****************************************************************
*                                                               *
*                     (abPixMapReadFileCB)                      *
*                                                               *
* Callback for the read file button. When this is done, it must *
* read the pixmap structure, and fill in the scroll region with *
*                    the appropriate layers.                    *
*                                                               *
****************************************************************/

(defun abPixMapReadFileCB ()
  (let (fileName pixmap)
       (setq fileName (getq (getq abPixMapOptionsForm fileName) value))
       (unless (blankstrp fileName)
	       ;---------------------------------------------------------
	       ; Read the pixmap
	       ;---------------------------------------------------------
	       (setq pixmap (abPixMapReadFile fileName))
	       (when pixmap
		     ;---------------------------------------------------
		     ; Put the layers into the scroll region
		     ;---------------------------------------------------
		     (abPixMapFillScrollRegion 
		      pixmap (getq abPixMapOptionsForm layers) 
		      (getq abPixMapOptionsForm cellView))
		     ;---------------------------------------------------
		     ; Record the pixmap for posterity
		     ;---------------------------------------------------
		     (putpropq abPixMapOptionsForm pixmap pixmap)
		     ;---------------------------------------------------
		     ; Change the enter function - primarily to change
		     ; the prompt
		     ;---------------------------------------------------
		     (changeEnterFun 'enterPoint
				     ?prompts 
				     '("Point at top left origin of pixmap")
				     ?form abPixMapOptionsForm
				     ?addPointProc "abPixMapAddPointCB"
				     ?doneProc "abPixMapDoneCB"
				     ?noInfix t
				     ?alwaysMap t
				     )
		     )
	       )
       )
  )

/***************************************************************
*                                                              *
*              (abPixMapCreateColourIcon colour)               *
*                                                              *
*  Build a small coloured icon in the colour which was in the  *
*    original pixmap (or as close to it as we can get given    *
*               the colour limitations in DFII)                *
*                                                              *
***************************************************************/

(defun abPixMapCreateColourIcon (colour)
  (let (colourArray
	(line "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
	)
       (setq colourArray (hiCreateColorArray))
       (setarray colourArray 0
		 (hiMatchColor
		  (foreach mapcar intensity
			   (list
			    (abPixMapColourGetRed colour)
			    (abPixMapColourGetGreen colour)
			    (abPixMapColourGetBlue colour)
			    )
			   (round (times intensity 3.915))
			   )
		  ) 
		 )
       (hiStringToIcon
	colourArray
	strcat(line line line line line line)
	32 6
	)
       )
  )

/***************************************************************
*                                                              *
*      (abPixMapFillScrollRegion pixmap region cellView)       *
*                                                              *
*   Fill the scroll region with all the colours found in the   *
*                         pixmap file                          *
*                                                              *
***************************************************************/

(defun abPixMapFillScrollRegion (pixmap region cellView)
  (let (current colours colourNames colourNum button y lpp tfId convert
		icon)
       (setq tfId (techGetTechFile cellView))
       ;-----------------------------------------------------------------
       ; Erase any current layer definitions
       ;-----------------------------------------------------------------
       (setq current (getq region fieldList))
       (when current (hiDeleteFields region current))
       ;-----------------------------------------------------------------
       ; Add the labels at the top
       ;-----------------------------------------------------------------
       (setq colours (abPixMapGetColours pixmap))
       (setq colourNames (sort (getq colours ?) 'alphalessp))
       (setq colourNum 0)
       ;-----------------------------------------------------------------
       ; Remember the colour names to ease lookup later
       ;-----------------------------------------------------------------
       (putpropq region colourNames colourNames)
       ;-----------------------------------------------------------------
       ; Build the scrollable region on the form
       ;-----------------------------------------------------------------
       (foreach colourName colourNames
		(setq icon
		      (abPixMapCreateColourIcon (arrayref colours colourName)))
		;--------------------------------------------------------
		; The pretty coloured button, corresponding
		; to the colour in the original pixmap
		;--------------------------------------------------------
		(setq button
		      (hiCreateButton
		       ?name (concat 'colour colourNum)
		       ?buttonIcon icon
		       )
		      )
		;--------------------------------------------------------
		; Boolean button to enable the layer
		;--------------------------------------------------------
		(setq convert
		      (hiCreateBooleanButton
		       ?name (concat 'convert colourNum)
		       ?buttonText " "
		       ?defValue t
		       ?value t
		       )
		      )
		;--------------------------------------------------------
		; Create the layer cyclic box
		;--------------------------------------------------------
		(setq lpp
		      (hiCreateLayerCyclicField
		       tfId
		       "Choose"
		       ""
		       (leGetValidLayerList tfId)
		       ))
		;--------------------------------------------------------
		; Make sure field symbol is unique
		;--------------------------------------------------------
		(putpropq lpp
			  (concat 'lpp colourNum) hiFieldSym)

		(setq y (times colourNum 35))
		(hiAddFields region
			     (list
			      (list button 0:y+11 32:12)
			      (list convert 60:y 20:35 0)
			      (list lpp 100:y 150:35 0)
			      )
			    )
		(postincrement colourNum)
		)
       )
  )

/***************************************************************
*                                                              *
*                       (abXpmToLayout)                        *
*                                                              *
*           Main entry point for the pixmap drawer.            *
*                                                              *
***************************************************************/

(defun abXpmToLayout ()
  (let (current)
       (unless (boundp 'abPixMapOptionsForm)
	       (abPixMapCreateForm))
       (setq current (getq (getq abPixMapOptionsForm layers) fieldList))
       (when current (hiDeleteFields (getq abPixMapOptionsForm layers) current))
       (putpropq abPixMapOptionsForm (geGetEditCellView) cellView)
       (putpropq abPixMapOptionsForm nil pixmap)
       (enterPoint
	?prompts '("Use options form to specify file to read")
	?form abPixMapOptionsForm
	?addPointProc "abPixMapAddPointCB"
	?doneProc "abPixMapDoneCB"
	?noInfix t
	?alwaysMap t
	)
       )
  )