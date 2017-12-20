cv=getEditRep()~>cellView
library=getEditRep()~>libName
cell=getEditRep()~>cellName
padLib = "PAD_cell"

wireId=schCreateWire( cv "route" "direct" list(0:0 0:1) 0.0625 0.0625 0.0125 ); <== creat wire line
wireId=schCreateWire( cv "route" "direct" list(0:0 1:0) 0.0625 0.0625 0.0125 ); <== creat wire line

X=1 Y=1
mn=0
mn++ dbCreateInstByMasterName(cv padLib "PAD_IO" "symbol"  sprintf(nil "PAD_%d" mn) X:Y rot)
mn++ dbCreateInstByMasterName(cv padLib "PAD_IO" "symbol"  sprintf(nil "PAD_%d" mn) X:Y "90")
mn++ dbCreateInstByMasterName(cv padLib "PAD_IO" "symbol"  sprintf(nil "PAD_%d" mn) X:Y "180")
mn++ dbCreateInstByMasterName(cv padLib "PAD_IO" "symbol"  sprintf(nil "PAD_%d" mn) X:Y "270")
