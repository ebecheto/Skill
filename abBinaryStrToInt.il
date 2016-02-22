/* abBinaryStrToInt.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Feb 11, 2011 
Modified   
By         

Use bit field functions to convert to and from binary strings.

Two functions:

abBinaryStrToInt("1011") => 11
abIntToBinaryStr(11 4) => "1011"

***************************************************

SCCS Info: @(#) abBinaryStrToInt.il 02/11/11.11:56:48 1.1

*/

/***************************************************************
*                                                              *
*                    abBinaryStrToInt(str)                     *
*                                                              *
*    Take a string of 1s and 0s and convert to an integer.     *
*                                                              *
***************************************************************/

procedure(abBinaryStrToInt(str "t")
    let((len (result 0))
	len=strlen(str)
	when(len>32 error("Cannot convert more than 32 bits"))
	for(i 1 len
	    setqbitfield1(result case(substring(str i 1)
		("1" 1)
		("0" 0)
		(t error("Illegal character %s in binary string" substring(str i 1)))
		)
		len-i
	    )
	)
	result
    )
)


/***************************************************************
*                                                              *
*          abIntToBinaryStr(val @optional (bits 32))           *
*                                                              *
*    Take an integer and convert to a string of 1s and 0s.     *
*    An optional width of the resulting string can be given    *
*                                                              *
***************************************************************/

procedure(abIntToBinaryStr(val @optional (bits 32) "xx")
    let(((result ""))
	when(bits>32 error("Cannot convert more than 32 bits"))
	for(i 0 (sub1 bits)
	    result=strcat(if(onep(bitfield1(val i)) "1" "0") result)
	)
	result
    )
)