; load("~/Skill/PICMIC/via_debug.il")
ineed('(createPinLPPcv xy2bBox triangleBord) )
ineed('(geOpenOrRaise geOpenOrRaisecv pinCopyFromTo))

cv=dbOpenCellViewByType( "test" "via" "layout" "maskLayout" "w");<= open erase
tech = techGetTechFile(cv)
v1s=techFindViaDefByName(tech "M2_M1_S")
v1=techFindViaDefByName(tech "M2_M1")

dx=1.0
i=0
dbCreateVia(cv v1 i*dx:0 "R0") i+=1
dbCreateVia(cv v1s i*dx:0 "R0") i+=1

geOpenOrRaisecv(cv)
v1~>??
;=> (db:0x475972a3 objType "stdViaDef" prop nil groupMembers nil tech db:0x4b577c9a techFile db:0x4b577c9a name "M2_M1" layer1 db:0x32a97fc4 layer1Num 40 layer2 db:0x32a97fc8 layer2Num 42 resistancePerCut 0.0 implant1 nil implant2 nil wellOrSubstrate nil params ("V2" 0.26 0.26 1 2 (0.26 0.26) (0.06 0.06) (0.06 0.06) (0.0 0.0) (0.0 0.0) (0.0 0.0) nil nil))
v1s~>??
;=> (db:0x4759729e objType "stdViaDef" prop nil groupMembers nil tech db:0x4b577c9a techFile db:0x4b577c9a name "M2_M1_S" layer1 db:0x32a97fc4 layer1Num 40 layer2 db:0x32a97fc8 layer2Num 42 resistancePerCut 0.0 implant1 nil implant2 nil wellOrSubstrate nil params ("V2" 0.26 0.26 1 1 (0.26 0.26) (0.01 0.01) (0.01 0.01) (0.0 0.0) (0.0 0.0) (0.0 0.0) nil nil))

techGetViaSpecTableEntriesByName(d_viaSpecID ); => l_table / nil
techGetViaSpecTableEntries(d_viaSpecID );=> l_table / nil
techGetViaSpecTableEntries( v1 );=> nil 
v1 est un stdViaDef, pas une viaSpecID

techFindViaSpec( d_techID  tx_layer1Num tx_layer2Num)
techFindViaSpec(tech "M1" "M2");=> nil

tech~>??


tech~>viaDefs~>??

car(tech~>viaDefs)~>params
;=> ("TOP_V" 0.36 0.36 1 1 (0.35 0.35) (0.01 0.01) (0.09 0.09) (0.0 0.0) (0.0 0.0) (0.0 0.0) nil nil)
v1~>params
;=> ("V2" 0.26 0.26 1 2 (0.26 0.26) (0.06 0.06) (0.06 0.06) (0.0 0.0) (0.0 0.0) (0.0 0.0) nil nil)
techCreateStdViaDef()
d_techID 
t_viaDefName
t_layer1Name
t_layer2Name
l_cutLayerInfo
l_cutArrayInfo
ln_layer1Enc
ln_layer2Enc
ln_layer1Offset
ln_layer2Offset
ln_originOffset
[ t_imp1 ln_imp1Enc
[ t_imp2 ln_imp2Enc ] ]
)
=> d_viaDefID / nil

css()~>??
;=> (db:0x4a722b9c cellView db:0x4a722f9a objType "stdVia" prop nil purpose "drawing" viaHeader db:0x4a720d1f route db:0x366b849a routeStatus "normal" direction "layer1ToLayer2" topology "none" origin (-3.61 1.78) orient "R0" bBox ((-4.28 1.175) (-2.94 2.395)) net nil pin nil connRoutes nil figGroup nil markers nil groupMembers nil isUnshielded nil shieldedNet1 nil shieldedNet2 nil parent nil children nil)

css()~>viaHeader~>??
;=> (db:0x4a720d1f cellView db:0x4a722f9a objType "stdViaHeader" prop nil viaDef db:0x4759729c viaDefName "M4_M3_S" master db:0x4a6b361a subHeaders nil vias (db:0x4a722b9c) overrideParams (("cutRows" 2) ("cutColumns" 3) ("layer1Enc" (0.02 0.22)) ("layer2Enc" (0.02 0.22)) ("layer1Offset" (0.0 0.005)) ("layer2Offset" (0.0 0.005))))
css()~>viaHeader~>viaDef~>??
;=> (db:0x4759729c objType "stdViaDef" prop nil groupMembers nil tech db:0x4b577c9a techFile db:0x4b577c9a name "M4_M3_S" layer1 db:0x32a97fcc layer1Num 44 layer2 db:0x32a97fd0 layer2Num 46 resistancePerCut 0.0 implant1 nil implant2 nil wellOrSubstrate nil params ("V4" 0.26 0.26 1 1 (0.26 0.26) (0.01 0.01) (0.01 0.01) (0.0 0.0) (0.0 0.0) (0.0 0.0) nil nil))

sqrt(0.202);=> 0.4494441

;defun(label (cv xy text) dbCreateLabel(cv "text" xy text "centerCenter" "R0" "roman" 0.2))
label(cv 0:0 "0:0")
defun(label (cv text) dbCreateLabel(cv "text" evalstring(text) text "centerCenter" "R0" "roman" 0.2))
label(cv "0:0")

a=evalstring("0:0")
sx=1 sy=2
;"sx:sy"
a=evalstring("sx:sy")

