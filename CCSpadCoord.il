/* CCSpadCoord.il

Group		Custom IC, Cadence Design Systems
Language	SKILL
Revision No.	1.1
Date Created	14th Dec 2005 
Last Modified	13th Jan 2006
Tested in	IC5141USR3
Lint score	100 (best is 100)
Description:

This program will print padnames and coordinates to a file.
It is assumed that the pin shapes are on the "metal1" layer,
and that the pad shapes are on the "pad" layer - adjust to meet
your requirements.  When the pad coordinates contain a pin, the
pin name and the pad center coordinates are output to a file in
the current directory named "myPadCoordinates.log"

Usage:

	load("CCSpadCoord.il")
	;; have the relevant layout cellview open and then call
	;; the CCSpadCoord function
	CCSpadCoord()
	=> nil

***************************************************

SCCS Info: @(#) CCSpadCoord.il 01/13/06.17:09:09 1.1

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

println("Please type CCSpadCoord() in the CIW panel to use the program")
println("Pad coordinates will be written to a log file named myPadCoordinates.log")

procedure( CCSpadCoord()
	let( (cv myPort allpins allpads)
	cv=geGetWindowCellView()

	; opens a file handle to write the output
	myPort = outfile("./myPadCoordinates.log")

		; the following code only identifies metal1 pin
		allpins = setof(x cv~>shapes (x~>purpose=="pin" && x~>layerName=="MET1"))
		;if pins of all layers are required, use this instead
		;allpins = setof(x cv~>shapes x~>purpose=="pin")
		
		; the following code identifies all the pads
		allpads = setof(y cv~>shapes y~>layerName=="PAD")
;		allPins = foreach(mapcar y cv~>terminals printf("%L " y~>name)) ;;<==pour un schematic
		;;cv~>terminals~>name  ;; ou bien <==pour un schematic

		; use fprintf instead of printf when writing to a file
		fprintf(myPort "Pad coordinates list created on : %s\n\n\n" getCurrentTime())
		fprintf(myPort "Pad name\t\tCentre Coordinates\n")
		fprintf(myPort "========\t\t==================\n")
	
		; for each pin in the layout, check the corresponding pad below it
		foreach( pinshape allpins
			foreach( padshape allpads
				if( 
					; a pad is associated with a particular pin if it encloses it
					(leftEdge(padshape~>bBox) < leftEdge(pinshape~>bBox)) &&
					(bottomEdge(padshape~>bBox) < bottomEdge(pinshape~>bBox)) &&	
					(rightEdge(padshape~>bBox) > rightEdge(pinshape~>bBox)) &&			
					(topEdge(padshape~>bBox) > topEdge(pinshape~>bBox)) then
					
					; \t option adds tab spacing to the output
					fprintf(myPort "%s\t\t\t%L\n" pinshape~>net~>name centerBox(padshape~>bBox))
				)						

			)
		)
	close(myPort) ; close the file handle
	myPort = nil  ; remove it from memory
   );end of let
 );end of procedure 

