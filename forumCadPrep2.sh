ebecheto@lyoelectro02 ~/Skill grep ineed generateAllPins.il 
ineed('(getInstTermPointLPP createPinLPP textDisplay2label metalPin2pinDrawing bus2flat) ) #'

for file in getInstTermPointLPP createPinLPP textDisplay2label metalPin2pinDrawing bus2flat;do  grep ineed $file.i;done

for file in generateAllPins getInstTermPointLPP createPinLPP textDisplay2label metalPin2pinDrawing bus2flat netMakeBus itos; do emacs -r -batch -l my-htmlize.el  ~/Skill/$file.il > RTF2F/$file.rtf   2>/dev/null ;done
