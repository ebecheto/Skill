/* busset.il Download at : http://www.groupsrv.com/computers/about232477.html
Author A.D.Beckett Group Custom IC, Cadence Design Systems Ltd. Machine SUN
Date Jul 11, 2004, SKILL code for creating the "busset" pcell schematic, symbol,
and the CDF as well.
*************************************************** SCCS Info: %Z% %M% %G%.%U% %I%
*/

let( (library cell pcellId) 
library="Ed_Si"
;;library="training"
cell="busset"
unless(ddGetObj(library) error("Couldn't open library %L" library) )

;--------------------------------------------------------------------
; First the schematic
;--------------------------------------------------------------------
pcellId=pcDefinePCell( list(ddGetObj(library) cell "schematic" "schematic")
( (buswidth 6) (busvalue 0) )			; Formal parameters
let(( cv master instId netH netL busOut driveName driveNet) ; variables

cv = pcCellView
;----------------------------------------------------------------
; Convert parameters, and figure out drive net name
;----------------------------------------------------------------
when(buswidth<1 buswidth=1)
    for(bit 0 buswidth-1
	if(driveName then driveName=strcat("," driveName) else driveName="" ) ; if
	driveName=strcat( if(busvalue<bit>==1 "hi" "lo") driveName )
	) ; for

master = dbOpenCellViewByType( "basic" "cds_thru" "symbol" nil "r" ) ; open master cell view
;----------------------------------------------------------------
; create the nets
;----------------------------------------------------------------
netH=dbMakeNet(cv "hi")
netL=dbMakeNet(cv "lo")
busOut=dbMakeNet(cv sprintf(nil "bus<%d:0>" buswidth-1))
driveNet=dbMakeNet(cv driveName)
;----------------------------------------------------------------
; create the terminals
;----------------------------------------------------------------
dbCreateTerm(netH netH~>name "inputOutput")
dbCreateTerm(netL netL~>name "inputOutput")
dbCreateTerm(busOut busOut~>name "inputOutput")
;----------------------------------------------------------------
; create the instance of cds_thru
;----------------------------------------------------------------
instId =
dbCreateInst(
cv master sprintf(nil "thru<%d:0>" buswidth-1)
0:0 "R0"
)
;----------------------------------------------------------------
; Connect it up
;----------------------------------------------------------------
dbCreateConnByName(busOut instId "dst");
dbCreateConnByName(driveNet instId "src");

;----------------------------------------------------------------
; Make the connectivity look up to date - not always needed, but
; Assura needs this, for example.
;----------------------------------------------------------------
dbDisablePropTimeStamp()
dbReplaceProp(cv "lastSchematicExtraction" "time" getCurrentTime())

dbClose( master )
t
) ; let
); end definition of the schematic
dbSave(pcellId)
dbClose(pcellId)

;--------------------------------------------------------------------
; Now the symbol
;--------------------------------------------------------------------
pcellId=pcDefinePCell(
list(ddGetObj(library) cell "symbol" "schematicSymbol")

;----------------------------------------------------------------
; Formal parameters
;----------------------------------------------------------------
( (buswidth 6) (busvalue 0) )

;----------------------------------------------------------------
; Code itself
;----------------------------------------------------------------
let(( cv netH netL
busOut figH figL figBus hp ps pl bw lh
pxc label)

cv = pcCellView

;----------------------------------------------------------------
; Various dimensions
;----------------------------------------------------------------
hp=0.025 ; half pin size
ps=0.125 ; pin spacing
pl=0.250 ; pin length
bw=1.4375; box width
lh=0.0625; label height
pxc=0.5  ; param label x coord

;----------------------------------------------------------------
; create the shapes - first the pins
;----------------------------------------------------------------
figH = dbCreateRect(cv list("pin" "drawing") list(-hp:-hp hp:hp))
dbCreateLine(cv list("device" "drawing") list(0:0 pl:0))
figL = dbCreateRect(cv list("pin" "drawing") list(-hp:-ps-hp hp:-ps+hp))
dbCreateLine(cv list("device" "drawing") list(0:-ps pl:-ps))
figBus = dbCreateRect(cv list("pin" "drawing")
list(2*pl+bw-hp:-hp 2*pl+bw+hp:hp)
) ; dbCreateRect
dbCreateLine(cv list("device" "drawing") list(pl+bw:0 2*pl+bw:0))
;----------------------------------------------------------------
; Then the boxes
;----------------------------------------------------------------
dbCreateRect(cv list("device" "drawing") list(pl:-2*ps pl+bw:ps))
dbCreateRect(cv list("instance" "drawing") list(0:-2*ps 2*pl+bw:ps))

;----------------------------------------------------------------
; create the nets
;----------------------------------------------------------------
netH=dbMakeNet(cv "hi")
netL=dbMakeNet(cv "lo")
busOut=dbMakeNet(cv sprintf(nil "bus<%d:0>" buswidth-1))
;----------------------------------------------------------------
; create the terminals
;----------------------------------------------------------------
dbCreateTerm(netH netH~>name "inputOutput")
dbCreateTerm(netL netL~>name "inputOutput")
dbCreateTerm(busOut busOut~>name "inputOutput")
;----------------------------------------------------------------
; create the pins
;----------------------------------------------------------------
dbCreatePin(netH figH)
dbCreatePin(netL figL)
dbCreatePin(busOut figBus)

;----------------------------------------------------------------
; Put some labels for the pins
;----------------------------------------------------------------
dbCreateLabel(cv list("pin" "drawing") pl+ps/2:0 netH~>name "centerLeft" "R0" "stick" lh)
dbCreateLabel(cv list("pin" "drawing") pl+ps/2:-ps netL~>name "centerLeft" "R0" "stick" lh)
dbCreateLabel(cv list("pin" "drawing") bw+pl-ps/2:0 busOut~>name "centerRight" "R0" "stick" lh)

;----------------------------------------------------------------
; And other symbol labels
;----------------------------------------------------------------
label=dbCreateLabel(cv list("annotate" "drawing7") bw+pl-ps/2:ps*1.5 "cdsName()" "centerRight" "R0" "stick" lh)
label~>labelType="ILLabel"
label=dbCreateLabel(cv list("annotate" "drawing") pxc:0 "cdsParam(1)" "centerLeft" "R0" "stick" lh)
label~>labelType="ILLabel" 
label=dbCreateLabel(cv list("annotate" "drawing") pxc:-ps "cdsParam(2)" "centerLeft" "R0" "stick" lh)
label~>labelType="ILLabel"

t
) ; let
)
dbSave(pcellId)
dbClose(pcellId)

;------------------------------------------------------------------------
; Now create the CDF
;------------------------------------------------------------------------
let( (cellId cdfId ) unless( cellId = ddGetObj( library cell ) error( "Could not get cell %s." cell ))
when( cdfId = cdfGetBaseCellCDF( cellId ) cdfDeleteCDF( cdfId ) )
cdfId = cdfCreateBaseCellCDF( cellId )

;;; Parameters
cdfCreateParam( cdfId ?name "buswidth" ?prompt "Bus Width" ?defValue 666 ?type "int" ?display "t" )
cdfCreateParam( cdfId ?name "busvalue" ?prompt "Bus Value" ?defValue 0   ?type "int" ?display "t" )

;;; Simulator Information
cdfId->simInfo = list( nil )
cdfId->simInfo->ams = '( nil )

;;; Properties
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