;; copyleft ebecheto

; open a layout view and load
; change libName and categoryName as wishes
ineed('(bBoxWidth bBoxHeight))
libName="tsl18fs120"
categoryName="FFs"
ddId= ddGetObj(libName);=> dd:0x2599fa00
ddCatGetLibCats(ddId);=> ("ADDERs" "ANDs" "BUFFERs" "CLOCK_GATEs" "COMPLEX_GATEs" "FEEDs" "FFs" "INVERTERs" "LATCHs" "MISC" "MUXEs" "NANDs" "NORs" "ORs" "SCAN_FFs" "SCAN_LATCHs" "SUBSTRACTORs" "TIEs" "XORs" "vulcan_top_cells")
ccId=ddCatGetCatName( categoryName)

X=0 Y=0
ddCat = ddCatFindCat( ddId categoryName "r") ;=> dd:0x3934e3e0
ddCatGetCatMembers(ddCat);=> (("decfq1" "cell") ... ("mffnrb4" "cell"))
cv=geGetWindowCellView()
cell=car(ddCatGetCatMembers(ddCat))

xMin=1k
cMin='()
foreach(mapcar cell ddCatGetCatMembers(ddCat)
cellName=car(cell)
inst=(dbOpenCellViewByType libName cellName "layout")
d_inst=(dbCreateInst cv inst nil X:Y "R0") ;ie. "PAD_IO" "RO" ou R90
d_inst~>bBox;=> ((-0.434 -1.667) (16.674 5.89))
bbX=bBoxWidth(d_inst~>bBox);=> 17.108
bbY=bBoxHeight(d_inst~>bBox)
xMin=if(xMin<=bbX xMin bbX)
when(xMin==bbX cMin=cellName)
printf("%s [%g, %g]\n" cellName bbX bbY)
Y=Y+bbY
)
printf("Mini = %L [%g]\n" cMin xMin)
