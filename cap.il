 /* dcUnitCapPCell_v2.il

Author D.A. Carnelli
Group Analog And Mixed Signal, ETH Zurich.
Machine SUN
Date Jul 1, 2010
Modified
By

SKILL code for creating the "UnitCap" pcell schematic
and the CDF as well

***************************************************

SCCS Info: %Z% %M% %G%.%U% %I%

*/

let( (library cell pcellId)
library="Ed"
cell="FiltCap"
unless(ddGetObj(library)
error("Couldn't open library %L" library)
)

;--------------------------------------------------------------------
; First the schematic
;--------------------------------------------------------------------
pcellId=pcDefinePCell(
                        list(
                             ddGetObj(library)
                             cell
                             "schematic_UnitCap_v2"
                             "schematic"
                             )

;----------------------------------------------------------------
; Formal parameters
;----------------------------------------------------------------
(
(multiplier 1)
)

;----------------------------------------------------------------
; Code itself
;----------------------------------------------------------------
let(( cv )

cv = pcCellView

;----------------------------------------------------------------
; open master cell views
;----------------------------------------------------------------
unitCapMaster = dbOpenCellViewByType( "Ed" "cpoly.Ed" "symbol" nil "r" )

;----------------------------------------------------------------
; create the nets
;----------------------------------------------------------------
netPos=dbMakeNet(cv "pos")
netNeg=dbMakeNet(cv "neg")
netGnd=dbMakeNet(cv "gnd!")    ;How to make this net inherited?

;----------------------------------------------------------------
; create the terminals
;----------------------------------------------------------------
dbCreateTerm(netPos netPos~>name "inputOutput")
dbCreateTerm(netNeg netNeg~>name "inputOutput")

;----------------------------------------------------------------
; create the instances of mimCaps
;----------------------------------------------------------------
unitCapID=nil
for( i 0 multiplier-1
unitCapID = cons(
                    dbCreateInst(
                                     cv
                                      unitCapMaster
                                      sprintf( nil "I%d" i)     
                                    0:i
                                    "R0"
                                    multiplier-1
                    );dbCreateParamInst
                    unitCapID
                    )
);for

;----------------------------------------------------------------
; Connect it up
;----------------------------------------------------------------
for( i 0 multiplier-1
dbCreateConnByName(netPos nth(multiplier-1-i unitCapID) "sw")
dbCreateConnByName(netNeg nth(multiplier-1-i unitCapID) "bot")
dbCreateConnByName(netGnd nth(multiplier-1-i unitCapID) "c0")
dbCreateConnByName(netGnd nth(multiplier-1-i unitCapID) "c1")
dbCreateConnByName(netGnd nth(multiplier-1-i unitCapID) "c2")
dbCreateConnByName(netGnd nth(multiplier-1-i unitCapID) "c3")    
dbCreateConnByName(netGnd nth(multiplier-1-i unitCapID) "c4")
);for

;----------------------------------------------------------------
; Make the connectivity look up to date - not always needed, but
; Assura needs this, for example.
;----------------------------------------------------------------
dbDisablePropTimeStamp()
dbReplaceProp(cv "lastSchematicExtraction" "time" getCurrentTime())

dbClose( unitCapMaster )
t
) ; let
)
dbSave(pcellId)
dbClose(pcellId)


;------------------------------------------------------------------------
; Now create the CDF
;------------------------------------------------------------------------
let( (cellId cdfId )
unless( cellId = ddGetObj( library cell )
error( "Could not get cell %s." cell )
)
when( cdfId = cdfGetBaseCellCDF( cellId )
cdfDeleteCDF( cdfId )
)
cdfId = cdfCreateBaseCellCDF( cellId )

;;; Parameters
 cdfCreateParam( cdfId
     ?name "multiplier"
     ?prompt "Multiplier"
     ?defValue 1
     ?type "int"
 )

;;; Simulator Information
cdfId->simInfo = list( nil )
cdfId->simInfo->UltraSim = '( nil )
cdfId->simInfo->ams = '( nil )
cdfId->simInfo->auCdl = '( nil )
cdfId->simInfo->auLvs = '( nil )
cdfId->simInfo->cdsSpice = '( nil )
cdfId->simInfo->hspiceD = '( nil )
cdfId->simInfo->hspiceS = '( nil )
cdfId->simInfo->spectre = '( nil )
cdfId->simInfo->spectreS = '( nil )

;;; Properties
cdfId->formInitProc = ""
cdfId->doneProc = ""
cdfId->buttonFieldWidth = 340
cdfId->fieldHeight = 35
cdfId->fieldWidth = 350
cdfId->promptWidth = 175
cdfId->paramLabelSet = "buswidth busvalue"
cdfId->paramDisplayMode = "parameter"
cdfSaveCDF( cdfId )
) ; let
) ; let


/*********************** END OF CODE *********************/

;; This works when I instantiate the PCell and I pass directly the number

;; I also tought to replace the CDF definition with this, it should be the correct vay to do that:

;;   ;;; Parameters
;;  cdfCreateParam( cdfId
;;      ?name "multiplier"
;;      ?prompt "Multiplier"
;;      ?defValue "string"
;;      ?type "1"
;;      ?parseAsNumber "yes"
;;      ?parseAsCEL "yes"
;;  )
;; load("~/Skill/cap.il")