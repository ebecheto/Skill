/* CCSflip.il

Language   SKILL
Date       Jun 22, 2005 
Modified   Nov 18, 2009 

Functions to do flipping (and rotation) in place. Examples
of usage:

CCSflip()
  - does a flip horizontally relative to the centre of the selected figures
CCSflip(?relativeTo 'lowerLeft)
  - does a horizontal flip relative to the lower left corner
CCSflip(?orient "MX" ?relativeTo 'upperRight)
  - does a vertical flip relative to the upperRight corner
CCSflip(?orient "MY" ?relativeTo 'upperRight ?mode 'copy)
  - does a horizontal flipped copy relative to the upperRight corner
CCSflip(?orient "R90" ?relativeTo 'refPoint)
  - does a 90 degree rotation relative to the reference point (often
    the + key on the numeric keypad).

In this function:

?orient can be set to:

    "MY" - mirror in Y axis (i.e. horizontal flip) (default)
    "MX" - mirror in X axis (i.e. vertical flip)
    "R90" - 90 degree anti-clockwise rotate
    "R180" - 180 degree anti-clockwise rotate
    "R270" - 90 degree clockwise rotate
    "R0" - no rotation (not much point!)
    "MYR90" - mirror in Y axis and rotate by 90
    "MXR90" - mirror in X axis and rotate by 90

?relativeTo can be set to:

'centerBox - center of selected figures (default)
'lowerLeft - lower left of selected figures
'lowerRight - lower right of selected figures
'upperLeft - upper left of selected figures
'upperRight - upper right of selected figures
'refPoint - the reference point
'origin - the cellview origin (i.e. 0:0)

?mode can be set to 

'move - (the default) flip during a move
'copy - (the default) flip during a copy

?noSnap can be set to t if you don't want it to
snap the origin of the flip

CCSsetRefPoint(?relativeTo 'upperLeft)
  - set the ref point relative to the selected objects

The ?relativeTo has the same meaning as for CCSflip()

***************************************************

SCCS Info: @(#) CCSflip.il 11/18/09.11:21:07 1.3

*/

/*******************************************************************************
*  DISCLAIMER: The following code is provided for Cadence customers to use at  *
*   their own risk. The code may require modification to satisfy the           *
*   requirements of any user. The code and any modifications to the code may   *
*   not be compatible with current or future versions of Cadence products.     *
*   THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING WITHOUT     *
*   LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES OF MERCHANTABILITY *
*   OR FITNESS FOR A PARTICULAR USE.                                           *
*******************************************************************************/

/******************************************************************
*                                                                 *
*         (CCSflip [?orient "MY"] [?relativeTo 'centerBox]        *
*           [?mode 'move] [?win windowId] [?noSnap nil])          *
*                                                                 *
* Flips the selected objects (if any) relative to somewhere, with *
*       a particular orientation. Can either copy or move.        *
*      For details, see the comments at the top of this file      *
*                                                                 *
******************************************************************/

(procedure (CCSflip @key (orient "MY") (relativeTo 'centerBox) 
		   (mode 'move) noSnap
		   (win (hiGetCurrentWindow)))
  (let (bbox figs origin transform)
       (setq figs (geGetSelSet win))
       ;-----------------------------------------------------------------
       ; work out the origin of the transform
       ;-----------------------------------------------------------------
       (setq bbox (CCSfindBBox figs))
       (setq origin
	     (case relativeTo
		   (centerBox (centerBox bbox))
		   (lowerLeft (lowerLeft bbox))
		   (lowerRight (list (xCoord (upperRight bbox))
				     (yCoord (lowerLeft bbox))))
		   (upperLeft (list (xCoord (lowerLeft bbox))
				    (yCoord (upperRight bbox))))
		   (upperRight (upperRight bbox))
		   (refPoint (leGetRefPoint (geGetEditCellView win)))
		   (origin (list 0 0))
		   (t (error "Unknown ?relativeTo mode; must be one of 'centerBox, 'lowerLeft, 'lowerRight, 'upperLeft, 'upperRight, 'refPoint, 'origin"))
		   ))
       (when origin
	     (unless noSnap
		     (setq origin
			   (list
			    (times (round (quotient 
					   (xCoord origin)
					   (getq win xSnapSpacing)))
				   (getq win xSnapSpacing))
			    (times (round (quotient 
					   (yCoord origin)
					   (getq win ySnapSpacing)))
				   (getq win ySnapSpacing))
			    )))
	     ;-----------------------------------------------------------
	     ; Combine the transform to do a shift to the origin,
	     ; rotate/flip, and then shift back again
	     ;-----------------------------------------------------------
	     (setq transform
		   (dbConcatTransform
		    (dbConcatTransform
		     (list (mapcar 'minus origin) "R0")
		     (list 0:0 orient)
		     )
		    (list origin "R0")
		    ))
	     ;-----------------------------------------------------------
	     ; Then either move or copy all the figures
	     ;-----------------------------------------------------------
	     (foreach fig figs
		      ;--------------------------------------------------
		      ; Don't move or copy the shape if it's attached
		      ; to something else that is also selected
		      ;--------------------------------------------------
		      (unless fig~>parent && geIsFigSelected(fig~>parent)
			(case mode
			  (move 
			    (dbMoveFig fig (dbGetq fig cellView) transform))
			  (copy 
			    (dbCopyFig fig (dbGetq fig cellView) transform))
			  )
			)
		      )
	     t
	     )
       )
  )

/***************************************************************
*                                                              *
*   (CCSsetRefPoint [?relativeTo 'centerBox] [?win windowId])  *
*                                                              *
*     Set the reference point relative to somewhere on the     *
*                        selected set.                         *
*                                                              *
***************************************************************/

(procedure (CCSsetRefPoint @key (relativeTo 'centerBox) 
		   (win (hiGetCurrentWindow)))
  (let (bbox figs origin)
       ;-----------------------------------------------------------------
       ; Work out the new reference point
       ;-----------------------------------------------------------------
       (setq figs (geGetSelSet win))
       (setq bbox (CCSfindBBox figs))
       (setq origin
	     (case relativeTo
		   (centerBox (centerBox bbox))
		   (lowerLeft (lowerLeft bbox))
		   (lowerRight (list (xCoord (upperRight bbox))
				     (yCoord (lowerLeft bbox))))
		   (upperLeft (list (xCoord (lowerLeft bbox))
				    (yCoord (upperRight bbox))))
		   (upperRight (upperRight bbox))
		   (refPoint (leGetRefPoint (geGetEditCellView win)))
		   (origin (list 0 0))
		   (t (error "Unknown ?relativeTo mode; must be one of 'centerBox, 'lowerLeft, 'lowerRight, 'upperLeft, 'upperRight, 'refPoint, 'origin"))
		   ))
       (when origin
	     (leSetRefPoint (geGetEditCellView win) origin)
	     )
       )
  )


/*************************************************
*                                                *
*          (CCSextendBBox bbox @rest xy)         *
*                                                *
* procedure to take a bounding box and extend it *
*              by a list of points.              *
*                                                *
*************************************************/

(procedure (CCSextendBBox bbox @rest xy)
  (let (minx maxx miny maxy coord)
       (if (and (listp xy)
		(listp (car xy))
		(listp (car (car xy))))
	   (setq xy (car xy)))
       (if (null bbox) 
	   (setq bbox (list (car xy) (car xy))))
       (setq minx (xCoord (lowerLeft bbox)))
       (setq maxx (xCoord (upperRight bbox)))
       (setq miny (yCoord (lowerLeft bbox)))
       (setq maxy (yCoord (upperRight bbox)))
       (foreach coord xy
		(if (lessp (xCoord coord) minx) (setq minx (xCoord coord)))
		(if (lessp (yCoord coord) miny) (setq miny (yCoord coord)))
		(if (greaterp (xCoord coord) maxx) (setq maxx (xCoord coord)))
		(if (greaterp (yCoord coord) maxy) (setq maxy (yCoord coord))))
       ;-----------------------------------------------------------------
       ; return the new bbox
       ;-----------------------------------------------------------------
       (list (list minx miny) (list maxx maxy))))

/******************************************
*                                         *
*          (CCSbBoxToPoints bbox)         *
*                                         *
* Convert a bounding box to a point list. *
*                                         *
******************************************/

(procedure (CCSbBoxToPoints bbox)
  (list 
   (lowerLeft bbox)
   (list (xCoord (lowerLeft bbox)) (yCoord (upperRight bbox)))
   (upperRight bbox)
   (list (xCoord (upperRight bbox)) (yCoord (lowerLeft bbox)))))


/**********************************************************
*                                                         *
*                   (CCSfindBBox select)                  *
*                                                         *
* Find the bounding box of the list of objects passed in. *
*     Copes with partially selected objects as well.      *
*                                                         *
**********************************************************/

(procedure (CCSfindBBox select @optional forceWholeObject)
  (let (bbox)
       (foreach dbp select
		(if (or forceWholeObject (geIsFigAllSelected dbp))
		    (setq bbox (CCSextendBBox bbox (dbGetq dbp bBox)))
		    (let (pointList)
			 ;-----------------------------------------------
			 ; generate a point list for object, either 
			 ; directly or from bbox
			 ;-----------------------------------------------
			 (unless (setq pointList (dbGetq dbp points))
				 (setq pointList (CCSbBoxToPoints 
						   (dbGetq dbp bBox))))
			 ;-----------------------------------------------
			 ; scan two lists, extending bbox if point is 
			 ; selected
			 ;-----------------------------------------------
			 (mapc '(lambda (point bool) 
					(when bool 
					  (setq bbox 
						(CCSextendBBox bbox point))))
			       pointList
			       (geGetSelSetFigPoint dbp)))))
       ;-----------------------------------------------------------------
       ; return bounding box
       ;-----------------------------------------------------------------
       bbox))
