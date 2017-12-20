/* CCSgetBBox.il

Group		Custom IC, Cadence Design Systems
Language	SKILL
Revision No.	1.1
Date Created	Apr 18, 2006 
Last Modified	
Tested in	IC5141
Lint score	100 (best is 100)
Description:

A function for finding the bounding box that surrounds all of
the selected shapes, or list of shapes passed to the function.
The function accepts an optional argument to supply a list of
database objects, and if not supplied, or not in the correct
form, the list of selected objects from the current cellview is
used.

Usage:
      ;; Use the function with a cellview that has selected shapes
      CCSgetBBox()
      => ((-12.3 -1.4) (-0.7 4.2))

      ;; use the function with a list of shapes, in this case all
      ;; shapes on the "metal1" layer
      CCSgetBBox(
        setof(shape geGetEditCellView()~>shapes 
	  shape~>layerName == "metal1") 
      )
      => ((-14.0 -11.1) (1.02 3.9))

      ;; use the function to create a rectangle on the current
      ;; entry layer to show the bounding box visually
      dbCreateRect(
	;; create the rectangle in the current cellview
        geGetEditCellView()
	;; use the current entry layer for the rectangle
	leGetEntryLayer()
	;; use the bBox returned by CCSgetBBox()
	CCSgetBBox()
      )

***************************************************

SCCS Info: @(#) CCSgetBBox.il 04/18/06.17:34:12 1.1

********************************************************************
* DISCLAIMER: The following code is provided for Cadence customers *
* to use at their own risk. The code may require modification to   *
* satisfy the requirements of any user. The code and any           *
* modifications to the code may not be compatible with current or  *
* future versions of Cadence products.                             *
* THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING   *
* WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES  *
* OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.              *
********************************************************************

*/

/******************************************************************
*                                                                 *
*                    CCSgetBBox( [l_objects] )                    *
*                                                                 *
* A function to return the bounding box that surrounds all of the *
* selected objects, or all of the objects passed to the function  *
*                                                                 *
******************************************************************/
procedure(CCSgetBBox(@optional objects "l")
  let( (lx rx ly uy)
    ;; unless objects is a list of database objects already, get the
    ;; selected set and use that for the list of objects to work with
    unless(objects && forall(obj objects dbobjectp(obj))
      ;; set objects to geGetSelectedSet(), but could still be nil
      objects = geGetSelectedSet()
    ); unless
    ;; when objects is non-nil, obtain starting values for the
    ;; left- and right- most x,  and the lowest and highest y
    when(objects
      lx = xCoord(lowerLeft(car(objects)~>bBox))
      rx = xCoord(upperRight(car(objects)~>bBox))
      ly = yCoord(lowerLeft(car(objects)~>bBox))
      uy = yCoord(upperRight(car(objects)~>bBox))
      ;; iterate over each object and if any point of its
      ;; bounding box is outside the current limits of
      ;; list(lx:ly rx:uy) then store the new value
      foreach(obj objects
	lx = min(lx xCoord(lowerLeft(obj~>bBox)))
	ly = min(ly yCoord(lowerLeft(obj~>bBox)))
	uy = max(uy yCoord(upperRight(obj~>bBox)))
	rx = max(rx xCoord(upperRight(obj~>bBox)))
      ); foreach
      ;; return the calculated bounding box
      list(list(lx ly) list(rx uy))
    ); when
  ); let
); procedure CCSgetBBox
