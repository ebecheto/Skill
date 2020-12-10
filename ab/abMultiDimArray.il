/* abMultiDimArray.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Nov 23, 2009 
Modified   
By         

Function for creating a multi-dimensional array.

Usage:

data=abMultiDimArray(6 8)

Creates a 6 by 8 array (starting index is from 0). Then you can use:

data[4][5]=23
data[0][7]=123

You can specify more dimensions by passing more arguments to abMultiDimArray.

***************************************************

SCCS Info: @(#) abMultiDimArray.il 11/23/09.16:24:27 1.1

*/

procedure(abMultiDimArray(@rest dimensions)
    let((arr)
	if(integerp(car(dimensions)) && plusp(car(dimensions)) then
	    arr=makeVector(car(dimensions))
	    when(cdr(dimensions)
		for(ind 0 sub1(car(dimensions))
		    arr[ind]=apply('abMultiDimArray cdr(dimensions))
		)
	    ) ; when 
	    arr
	else
	    error("Dimension %L must be a positive integer\n" car(dimensions))
	) ; if
    ) ; let
) ; procedure 
