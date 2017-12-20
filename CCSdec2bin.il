;;load "CCSdec2bin.il"

/* 

Group		Custom IC, Cadence Design Systems
Language	SKILL
Revision No.	1.3
Date Created	Oct 31, 2005 
Last Modified	Jan 24, 2006
Tested in	IC5141
Lint score	100 (best is 100)
Description:

A simple SKILL procedure that accepts a single numeric argument,
an integer, and returns this number formatted as a binary value in
a string.  The procedure only accepts integers as input and only
returns a string value.
for(i 1 255 printf("%s\n" CCSdec2bin(i)))
for(i 1 4096-1 printf("%s\n" CCSdec2bin(i)))
for(i 1 16777216-1 printf("%s\n" CCSdec2bin(i)))
CCSdec2bin(16777216-1)
length(parseString(CCSdec2bin(16777216-1) ""))=> 24

Usage:
  CCSdec2bin(25)	;; decimal formatted input
  => "11001"
  CCSdec2bin(0x1a)	;; hexadecimal formatted input
  => "11010"
  CCSdec2bin(035)	;; octal formatted input
  => "11101"
  CCSdec2bin(0b1011)	;; binary formatted input
  => "1011"
  CCSdec2bin(2**31)	;; the largest negative number
  => "10000000000000000000000000000000"
  (-2147483648)

As shown above, the SKILL interpreter can understand binary, octal
or hexadecimal formatted integers in addition to decimal integers.

The limit on integers in SKILL is +2147483647 to -2147483648 (this
is 2**31 - 1 and 2**31 respectively), so the output of the function
is also limited to 32 bits.

If the output is desired as a number, rather than a string, the
following can be used:

  atoi( CCSdec2bin(0x1a) )
  => 11010	;; warning! this is treated as a decimal number!

***************************************************

SCCS Info: @(#) CCSdec2bin.il 03/07/06.15:49:20 1.3

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
*                       CCSdec2bin( x_num )                       *
*                                                                 *
*  A procedure that accepts a decimal integer and formats it as a *
*     string that represents the same value in binary format.     *
*                                                                 *
******************************************************************/
procedure(CCSdec2bin(num "x")
  let( ((binstr ""))
    while(!zerop(num)
      ;; repeat the loop for as many bits needed to represent the
      ;; number in binary. Each iteration picks out that bit and
      ;; adds it to the binary formatted string and then shifts
      ;; to the next bit.
      binstr = strcat( if(zerop(num & 1) "0" "1") binstr)
      num=num>>1
    )
    ;; return the binary formatted string, or 0 if it was blank
    if(binstr=="" "0" binstr)
  ); let
); procedure CCSdec2bin
