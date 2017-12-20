/* CCSdeleteMarkers.il

Group		Custom IC, Cadence Design Systems
Language	SKILL
Revision No.	1.2
Date Created	Dec 14, 2007 
Last Modified	
Tested in	IC5141
Lint score	100 (best is 100)
Description:

A SKILL procedure to delete marker shapes from a cellview; by default
error and warning markers will be removed from the current cellview.
The cellview can be specified by the ?cv keyword argument, and the
marker types can be specified by the ?types keyword argument.

Usage:

    ;; run with default settings
    CCSdeleteMarkers()

    ;; remove only warnings
    CCSdeleteMarkers(?types list("warning"))

    ;; remove errors from a specified cellview
    mycv = dbOpenCellViewByType("mylib" "mycell" "myview" "" "a")
    CCSdeleteMarkers(?cv mycv ?types '("error"))


***************************************************

SCCS Info: @(#) CCSdeleteMarkers.il 02/28/08.23:58:04 1.2

***********************************************************************
* DISCLAIMER: This code is provided for Cadence customers to use      *
* with Cadence tools at their own risk. The code may require          *
* modification to satisfy the requirements of any user. The code and  *
* any modifications to the code may not be compatible with current or *
* future versions of Cadence products.                                *
* THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING      *
* WITHOUT LIMITATION ANY EXPRESS OR IMPLIED WARRANTIES OF             *
* MERCHANTABILITY, FITNESS FOR A PARTICULAR USE OR NON-INFRINGEMENT.  *
* © 2007 Cadence Design Systems, Inc. All rights reserved.            *
***********************************************************************

*/

/**********************************************************************
*                                                                     *
*     CCSdeleteMarkers( [?cv d_cv|geGetEditCellView()]                *
*                       [?types l_types|'("error" "warning")])        *
*                                                                     *
* Deletes marker shapes in the supplied cellview.  The default is to  *
* remove error and warning markers from the current cellview, but the *
* types can be specified with the ?types keyword and the cellview can *
*             be specified with the ?cv keyword argument.             *
*                                                                     *
**********************************************************************/
procedure(CCSdeleteMarkers(@key (cv geGetEditCellView())
	    (types '("error" "warning")) "dl")
  let( (markers)
  unless(forall(entry types stringp(entry))
    error("CCSdeleteMarkers: 'types' keyword must be a list of strings")
  ); unless
  when(and(dbobjectp(cv) cv~>objType=="cellView")
    markers = setof(lpp cv~>lpps and(lpp~>layerName=="marker"
	     member(lpp~>purpose types)))
    foreach(type markers
      ;; delete each shape in the list of shapes for that marker type
      mapcar('dbDeleteObject type~>shapes)
    ); foreach marker type (error or warning)
  ); when 'cv' is a valid cellview db object
  ); let
); procedure CCSdeleteMarkers
