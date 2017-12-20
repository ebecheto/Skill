/* CCSencapRodPcell.il

Group		Custom IC, Cadence Design Systems
Language	SKILL
Revision No.    1.1
Date Created	Aug 06, 2008
Last Modified	
Tested in	IC5141
Lint score	94 (best is 100)
Description:

A simple example of an encapsulated PCell with a stretch handle and
CDF for one of the parameters.  CDF is created for the two parameters
and the stretchable parameter is either hidden, or visible but not
editable on the Edit Instance Properties form.

NOTE: The Lint score is not 100 because SKILL Lint does not recognise
pcCellView as a legal parameter, but instead thinks it is a global.

***************************************************

SCCS Info: @(#) CCSencapRodPcell.il 08/11/08.11:19:22 1.1

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

;; This is the function that does all the work in creating the
;; PCell shapes, labels etc.  This routine can be tested outside
;; of the pcDefinePCell statement, and it goes through SKILL Lint
;; with better results too.

procedure(CCScreateBoxAndLabels(cv w l "dnn")
  let( (rectRodObj)
  ;; create a rectangle on metal1 with x & y dimensions set by w & l
  rectRodObj = rodCreateRect(
      ?name	"myRect"
      ?cvId	cv
      ?layer	list("metal1" "drawing")
      ?width	w
      ?length	l
      ?origin	list(0 0)
  )
  ;; create labels to show the w and l parameters
  dbCreateLabel(cv list("text" "drawing") list(0 0) 
    sprintf(nil "%2.8f" w) "lowerLeft" "R0" "stick" 0.05)
  dbCreateLabel(cv list("text" "drawing") list(0 0.2) 
    sprintf(nil "%2.8f" l) "lowerLeft" "R0" "stick" 0.05)
  ;; create a stretch handle for the width, in the X dimension, it
  ;; will display as "width = <value>" and change by 0.1 increments
  rodAssignHandleToParameter(
    ?parameter		"w"
    ?rodObj		rectRodObj
    ?handleName		"centerRight"
    ?stretchDir		"X"
    ?displayName	"width"
    ?displayExpression	"w"
    ?updateIncrement	0.1
  ); rodAssignHandleToParameter
  ); let
); procedure CCScreateBoxAndLabels

;; Create the PCell, the "drawing routine" is encapsulated in the
;; CCScreateBoxAndLabels function which does all the work

pcDefinePCell(
  list(ddGetObj("test") "encapRodPcell" "layout")
  (
    (w 1.0)
    (l 0.6)
  )
  let( ((cv pcCellView))
    CCScreateBoxAndLabels(cv w l)
  ); let
)

;; Create the CDF for the 'l' and 'w' parameters, the width (w)
;; parameter is either hidden or displayed but not editable.
let( (cellId cdfId)
  when(cellId = ddGetObj("test" "encapRodPcell")
    ;; if the cell CDF already exists, delete it
    when( cdfId = cdfGetBaseCellCDF(cellId)
      cdfDeleteCDF(cdfId)
    )
    ;; create the base cell CDF
    cdfId = cdfCreateBaseCellCDF(cellId)
    ;; create the parameters
    cdfCreateParam( cdfId
      ?name	"l"
      ?prompt	"Length"
      ?defValue	0.6
      ?type	"float"
      ?display	"t"
    )
    cdfCreateParam( cdfId
      ?name	"w"
      ?prompt	"Width"
      ?defValue	1.0
      ?type	"float"
      ;; comment out the next line and uncomment the lines below
      ;; it if the parameter is to be visible but not editable
      ?display	"nil"
;      ?display	"t"
;      ?editable	"nil"
    )
    cdfSaveCDF(cdfId)
  ); when
); let for CDF creation
