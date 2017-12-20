/* 
This SKILL code is not sufficient on its own. You need to also
download CCSinvokeCdfCallbacks.il file before running this code.

load "CCSinvokeCdfCallbacks.il"
load "CCSCdfCallbackEntireLib.il"

CCSCdfCallbackEntireLib("T2K_V5_TRANSLATE")            
 
Where "MYLIB" is the design library. 

*/



/***************************************************************
*                                                              *
*        (CCSCdfCallbackEntireLib libName 		       *
*                                                              *
*  Invoke the CDF callbacks for all schematics of given library *
*                                                              *
***************************************************************/

procedure(CCSCdfCallbackEntireLib(library)
let((libName)
unless(libName=ddGetObj(library) error("Library %s does not exists\n" library))
foreach(cell libName~>cells
    if(exists(x cell~>views~>name (x=="schematic"))
         then
	printf("Processing cell %s\n" cell~>name)
;Open schematic
	cv = dbOpenCellViewByType(library cell~>name "schematic" "schematic" "a")
/* Run CDF Callback. Modify the below line if you want to run it with callInitProc
and userInstCDF. For example:
CCSinvokeCdfCallbacks(cv ?callInitProc t ?useInstCDF t)
*/
	CCSinvokeCdfCallbacks(cv)
;Run schematic check and Save
	schCheck(cv)
	dbSave(cv)
		) ;if
	);foreach
) ;let
) ; procedure
