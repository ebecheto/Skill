/*

Code for pcell to generate barcodes 

Need to change this reference:

        list( dmFindLib( "libName") "pcBarcode" "layout")
or
        list( ddGetObj( "libName") "pcBarcode" "layout")

in 4.4.X

*/

procedure( WriteCharCodeToBars( ch )
	if( exists( x charSet eq( getchar(x 1) ch ) ) then
	  if( exists( x charSet11 eq( getchar(x 1) ch ) ) then a = 1
	    else if( exists( x charSet12 eq( getchar(x 1) ch ) ) then a = 2
	    else if( exists( x charSet13 eq( getchar(x 1) ch ) ) then a = 3
	    else if( exists( x charSet14 eq( getchar(x 1) ch ) ) then a = 4
	    else a = 5 ))))
	  if( exists( x charSet25 eq( getchar(x 1) ch ) ) then b = 5
	    else if( exists( x charSet24 eq( getchar(x 1) ch ) ) then b = 4
	    else if( exists( x charSet23 eq( getchar(x 1) ch ) ) then b = 3
	    else if( exists( x charSet22 eq( getchar(x 1) ch ) ) then b = 2
	    else b = 1 ))))
	  if( exists( x charSet35 eq( getchar(x 1) ch ) ) then c = 5
	    else if( exists( x charSet34 eq( getchar(x 1) ch ) ) then c = 4
	    else if( exists( x charSet33 eq( getchar(x 1) ch ) ) then c = 3
	    else if( exists( x charSet32 eq( getchar(x 1) ch ) ) then c = 2
	    else c = 1 ))))
	  if( exists( x charSet45 eq( getchar(x 1) ch ) ) then d = 5
	    else if( exists( x charSet44 eq( getchar(x 1) ch ) ) then d = 4
	    else if( exists( x charSet43 eq( getchar(x 1) ch ) ) then d = 3
	    else if( exists( x charSet42 eq( getchar(x 1) ch ) ) then d = 2
	    else d = 1 ))))
	  if( exists( x charSet55 eq( getchar(x 1) ch ) ) then e = 5
	    else if( exists( x charSet54 eq( getchar(x 1) ch ) ) then e = 4
	    else if( exists( x charSet53 eq( getchar(x 1) ch ) ) then e = 3
	    else if( exists( x charSet52 eq( getchar(x 1) ch ) ) then e = 2
	    else e = 1 ))))
	  if( exists( x charSet65 eq( getchar(x 1) ch ) ) then f = 5
	    else if( exists( x charSet64 eq( getchar(x 1) ch ) ) then f = 4
	    else if( exists( x charSet63 eq( getchar(x 1) ch ) ) then f = 3
	    else if( exists( x charSet62 eq( getchar(x 1) ch ) ) then f = 2
	    else f = 1 ))))
	    )
	for( i 1 a xKursor = xKursor + bar_space )
	for( i 1 b
		dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
		xKursor = xKursor + bar_width
	   )
	for( i 1 c xKursor = xKursor + bar_space )
	for( i 1 d
		dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
		xKursor = xKursor + bar_width
	   )
	for( i 1 e xKursor = xKursor + bar_space )
	for( i 1 f
		dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
		xKursor = xKursor + bar_width
	   )
	for( k 1 charSetLength
		ch1 = nthelem( k charSet )
		if( eq( getchar(ch1 1) ch ) then CRC = CRC + k
		k++
	   ) 
	) ; end test if char in charset
) ; end procedure WriteCharCodeToBars

procedure(createText(ch )
	    ptList = getPolyPointList( ch )
	    if(ptList then
		ptList = mapcar('lambda( (y) mapcar('lambda( (x) (x*TextScale)) y ) ) ptList) 
		apoly = dbCreatePolygon(pcCellView pcLayer ptList)
		dbMoveFig( apoly nil list( x_Text:y_Text "R0" ) ))
	    x_Text = x_Text + TextDist ) ; end procedure createText

; Define characters in this procedure as a list of points.
procedure(getPolyPointList(character)
    prog((theList)
	theList = case(character
	("." list(100:0 100:100 200:100 200:0 ))
	("A" list(0:0 100:0 100:350 150:400 200:400 250:350 250:300 100:300 100:200
	 250:200 250:0 350:0 350:400 250:50q0 100:500 0:400 ))
	("B" list(0:0 100:0 100:200 250:200 250:100 100:100 100:0 300:0 350:50 350:200
	 300:250 350:300 350:450 300:500 100:500 100:400 250:400 250:300 100:300 100:500 0:500 ))
	("C" list(50:0 300:0 350:50 350:150 250:150 250:100 100:100 100:400 250:400
	 250:350 350:350 350:450 300:500 50:500 0:450 0:50 ))
	("D" list(0:0 100:0 100:400 250:400 250:100 100:100 100:0 300:0 350:50 350:450
	 300:500 0:500 ))
	("E" list(0:0 350:0 350:100 100:100 100:200 250:200 250:300 100:300 100:400
	 350:400 350:500 0:500 ))
	("F" list(0:0 100:0 100:200 250:200 250:300 100:300 100:400 350:400 350:500 0:500 ))
	("G" list(50:0 300:0 350:50 350:300 150:300 150:200 250:200 250:100 100:100 100:400
	 250:400 250:350 350:350 350:450 300:500 50:500 0:450 0:50 ))
	("H" list(0:0 100:0 100:200 250:200 250:0 350:0 350:500 250:500 250:300 100:300 100:500 0:500 ))
	("I" list(120:0 120:500 220:500 220:0 ))
	("J" list(50:0 300:0 350:50 350:500 250:500 250:100 100:100 100:150 0:150 0:50 ))
	("K" list(0:0 100:0 100:150 150:150 300:0 350:0 350:100 200:250 350:400 350:500 300:500
	 150:350 100:350 100:500 0:500 ))
	("L" list(0:0 350:0 350:100 100:100 100:500 0:500 ))
	("M" list(0:0 100:0 100:400 150:400 150:250 250:250 250:400 300:400 300:0 400:0 400:450
	 350:500 50:500 0:450 ))
	("N" list(0:0 100:0 100:200 150:200 250:100 250:0 350:0 350:500 250:500 250:300 200:300
	 100:400 100:500 0:500 ))
	("O" list(50:0 100:0 100:400 250:400 250:100 100:100 100:0 300:0 350:50 350:450 300:500
	 50:500 0:450 0:50 ))
	("P" list(0:0 100:0 100:400 250:400 250:300 100:300 100:200 300:200 350:250 350:450 300:500 0:500 ))
	("Q" list(400:50 350:100 350:450 300:500 250:500 250:200 200:200 200:100 100:100 100:400
	 250:400 250:500 50:500 0:450 0:50 50:0 400:0 ))
	("R" list(0:0 100:0 100:400 250:400 250:300 100:300 100:150 150:150 300:0 350:0 350:100 300:150
	 300:200 350:250 350:450 300:500 0:500 ))
	("S" list(50:0 300:0 350:50 350:250 300:300 100:300 100:400 250:400 250:390 350:390 350:450
	 300:500 50:500 0:450 0:250 50:200 250:200 250:100 100:100 100:110 0:110 0:50 ))
	("T" list(100:0 200:0 200:400 300:400 300:500 0:500 0:400 100:400 ))
	("U" list(50:0 300:0 350:50 350:500 250:500 250:100 100:100 100:500 0:500 0:50 ))
	("V" list(175:0 325:150 325:500 225:500 225:200 175:150 125:200 125:500 25:500 25:150 ))
	("W" list(25:0 325:0 375:50 375:500 275:500 275:100 225:100 225:250 125:250 125:100 75:100 75:500
	 -25:500 -25:50 ))
	("X" list(30:0 80:0 180:100 280:0 330:0 330:100 230:200 230:300 330:400 330:500 280:500 180:400
	 80:500 30:500 30:400 130:300 130:200 30:100 ))
	("Y" list(130:0 230:0 230:300 330:400 330:500 280:500 180:400 80:500 30:500 30:400 130:300 ))
	("Z" list(0:0 350:0 350:100 150:100 150:150 350:350 350:500 0:500 0:400 200:400 200:350 0:150 ))
	("-" list(50:200 50:250 300:250 300:200 ))
	("_" list(50:0 50:50 300:50 300:0 ))
	("0" list(50:0 100:0 100:400 250:400 250:100 100:100 100:0 300:0 350:50 350:450 300:500 50:500
	 0:450 0:50 ))
	("1" list(135:0 235:0 235:500 135:500 35:400 35:350 135:350 ))
	("2" list(350:100 100:100 100:200 300:200 350:250 350:450 300:500 50:500 0:450 0:400 250:400 250:300
	 50:300 0:250 0:0 350:0 ))
	("3" list(350:200 300:250 350:300 350:450 300:500 50:500 0:450 0:400 250:400 250:300 100:300 100:200
	 250:200 250:100 0:100 0:50 50:0 300:0 350:50 ))
	("4" list(350:200 300:200 300:222.348 200:222.348 200:200 100:200 100:250 300:450 300:500 200:500
	 0:300 0:100 200:100 200:0 300:0 300:100 350:100 ))
	("5" list(350:250 300:300 100:300 100:400 350:400 350:500 0:500 0:250 50:200 250:200 250:100 100:100
	 100:100 0:100 0:50 50:0 300:0 350:50 ))
	("6" list(350:250 300:300 250:300 250:100 100:100 100:200 250:200 250:300 100:300 100:400 350:400
	 350:450 300:500 50:500 0:450 0:50 50:0 300:0 350:50 ))
	("7" list(350:500 0:500 0:400 250:400 250:350 200:300 100:300 100:200 0:100 0:0 100:0 100:50 250:200
	 300:200 300:250 350:300 ))
	("8" list(50:0 100:0 100:200 250:200 250:100 100:100 100:0 300:0 350:50 350:200 300:250 350:300 350:450
	 300:500 100:500 100:400 250:400 250:300 100:300 100:500 50:500 0:450 0:300 50:250 0:200 0:50 ))
	("9" list(350:450 300:500 250:500 250:300 100:300 100:400 250:400 250:500 50:500 0:450 0:250 50:200
	 250:200 250:100 0:100 0:50 50:0 300:0 350:50 ))
	    (t nil)
	) ; end case
	return(theList) ) ; end prog
) ; end procedure getPolyPointList

addToNameSpace( "ilSafeFuncs" 'WriteCharCodeToBars )
addToNameSpace( "ilSafeFuncs" 'getPolyPointList )
addToNameSpace( "ilSafeFuncs" 'createText )

pcDefinePCell(
;	library, cellname and view :
	list( dmFindLib( "Ed") "pcBarcode" "layout")
;	list( ddGetObj( "pcells") "pcBarcode" "layout")
;	input parameters and their default values :
	((preText	string	"TF1.2-")
	 (layerList	string	"A1 B1" )f
	  (version	string	  "1" ) )
; find the library name
	(pcLib = (pcCellView~>lib))
;	define constants :
	charSet = list( " " "!" "\"" "#" "$" "%" "&" "'" "(" ")"
			"*" "+" "," "-" "." "/" "0" "1" "2" "3"
			"4" "5" "6" "7" "8" "9" ":" ";" "<" "="
			">" "?" "@" "A" "B" "C" "D" "E" "F" "G"
			"H" "I" "J" "K" "L" "M" "N" "O" "P" "Q"
			"R" "S" "T" "U" "V" "W" "X" "Y" "Z" "["
			 "\\" "]" "_" )
	charSet11=list( " " "!" "\"" "#" "$" "%" "&" "'" "(" ")"
			"*" "+" "," "-" "." "/" "0" "1" "2" "3"
			"4" "5" "6" "7" "8" "9" ":" ";" "<" "="
			">" "?" "@" "A" "B" "C" "D" "E" )
	charSet12=list( "F" "G"
			"H" "I" "J" "K" "L" "M" "N" "O" "P" "Q"
			"R" "S" "T" "U" )
	charSet13=list( "V" "W" "X" "Y" "Z" "["
			 "\\" "]" )
	charSet14=list( "_" )
	charSet25=list( " " )
	charSet24=list( "!" "\"" )
	charSet23=list( "#" "$" "%" "&" "'" "(" "F" "G" "V" )
	charSet22=list(  ")" "*" "+" "," "-" "." "/" "0" "1" "2" "H" "I" "J" "K" "X" "W" )
	charSet35=list( "E" )
	charSet34=list( "D" "U" )
	charSet33=list( "(" "1" "2" "@" "A" "B" "C" "T" )
	charSet32=list( "'" "/" "0" "<" "=" ">" "?" "G" "J" "K" "P" "Q" "R" "S" "]" )
	charSet45=list( "3" )
	charSet44=list( ")" "4" )
	charSet43=list( "#" "*" "5" "6" "<" "@" "L" "P" "Y" )
	charSet42=list( "!" "$" "+" " " "/" "1" "7" "8" "=" "A" "H" "J" "M" "Q" "W" "Z" )
	charSet55=list( ";" )
	charSet54=list( "?" "O" )
	charSet53=list( "&" " " "." "6" "8" ":" "C" "S" "\\" )
	charSet52=list( "'" "/" "0" "<" "=" ">" "D" "F" "H" "I" "L" "M" "N" "T" "]" "_" )
	charSet65=list( "9" )
	charSet64=list( "-" "7" )
	charSet63=list( "%" "+" "5" ":" ">" "B" "N" "R" "[" )
	charSet62=list( "\"" "$" "*" "." "0" "2" "4" "8" "=" "A" "I" "K" "M" "Q" "X" "Z" )
	lList = parseString( layerList )
	foreach( layer lList
	Text = get_pname(concat( preText layer version ))
	bar_width = 30
	bar_space = 30
	bar_hight = 600
	quite_length = 800
	xKursor = 0
	yKursor = 0
	CRC = 0
	x_Text = 600
	y_Text = -1000
	TextDist = 500
	charSetLength = length( charSet )
	TextScale = 1
; get layer number from string
	(pcLayer = layer)
	if((!stringp(pcLayer) || !(pcLayer = dbGetLayerNum(pcLib pcLayer))) then 
	    (pcLayer = 12)
	)
;	define Quite 1 :
	dbCreateRect( pcCellView pcLayer list( xKursor:yKursor xKursor+quite_length:yKursor+bar_hight ) )
	xKursor = xKursor+quite_length
;	define start pattern :
	for( i 1 3
		xKursor = xKursor + bar_space
		dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
		xKursor = xKursor + bar_width )
	for( i 1 4 xKursor = xKursor + bar_space )
	dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
	xKursor = xKursor + bar_width
	for( i 1 2 xKursor = xKursor + bar_space )
	dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
	xKursor = xKursor + bar_width
	xKursor = xKursor + bar_space
	dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
	xKursor = xKursor + bar_width

;	process the string :
	upperCase(Text)
	if( strlen(Text)>0 then 
		for( j 1 10
			ch = getchar( Text j )
			if( ch then
				WriteCharCodeToBars( ch )
				createText( get_pname(ch) )
			  ) ; end test if ch not empty
	  	   ) ; end for 1 ... 10

;	CRC character assembling
		CRC = mod( (CRC-1) 64 ) +1
		ch1 = getchar( nthelem( CRC charSet ) 1 )
		WriteCharCodeToBars( ch1 )

	   ) ; end test if string empty

;	define stop pattern :
	for( i 1 5 xKursor = xKursor + bar_space )
	for( i 1 2
		dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
		xKursor = xKursor + bar_width
		xKursor = xKursor + bar_space )
	for( i 1 2
		dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
		xKursor = xKursor + bar_width )
	xKursor = xKursor + bar_space
	for( i 1 2
		dbCreateRect( pcCellView pcLayer list( xKursor:0 xKursor+bar_width:bar_hight) )
		xKursor = xKursor + bar_width
		xKursor = xKursor + bar_space )

;	define Quite 2 :
	dbCreateRect( pcCellView pcLayer list( xKursor:yKursor xKursor+quite_length:yKursor+bar_hight ) )
	xKursor = xKursor+quite_length
	) ; end foreach element of layerList
	dbReplaceProp( pcCellView "instNamePrefix" "string" "pcBarcode")
	t
)
