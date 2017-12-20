;; copyleft ebecheto


defun(DLLmklist (@optional (motif '("E" "F" "H" "I" "E" "F" "H" "I"))(libName 'ibm)(cellName nil))
let((L xors pins)
xors=dllGenMotif(motif 'ibm) L=length(motif)
unless(cellName cellName=strcat("d_" apply('strcat motif)))
pins=list(netMakeBus("S" L t "_") netMakeBus("Q" L t "_"))
list(list(xors) libName cellName reverse(pins))
))
