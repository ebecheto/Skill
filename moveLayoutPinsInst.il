;ineed('moveLayoutPinsInst t)
;;generateAllPins ;<= was creating pins  
;<= i assume now in this scipt that the pins are allready create, so i do not need to create layers etc...
ineed('(getInstTermPointLPP3 getInstTermPointLPP  textDisplay2label metalPin2pinDrawing bus2flat bBoxHeight isPointInBbox))

;ineed('pinLppChange)
;pinLppChange("MET2")

;; QUICK AND DIRTY JOB ...

defun(moveLayoutPinsInst (@optional (cv nil)(shapes geGetSelectedSet())(updatelpp t))
let((rect labs pairs ppins lpin pins2move cvs pin sigName mits mit itds iname inst its ins pn apn bBox lpp dir REC point justify height orient font)
unless(cv cv=geGetWindowCellView()) ;<= should be layout active view freshly gerneratedFromSource but with cells placed as wishes
unless(shapes shapes=cv~>shapes) ;<= take selected set if any, else all shapes from cellview
;; LIST OF PINS '((PIN1 LABEL) (PIN2 LABEL2)) to move
rect=setof(c shapes c~>objType=="rect")
labs=setof(c shapes c~>objType=="label")
labs~>theLabel
rect~>pin~>name
lab=car(labs)
lab~>theLabel;=> "VSS"
pairs=remove(nil foreach(mapcar lab labs rects=setof(rec rect rec~>pin~>name==lab~>theLabel) remove(nil foreach(mapcan rec rects when(isPointInBbox(lab~>xy rec~>bBox) list(rec lab))))))

;pairs=remove(nil foreach(mapcan r rect remove(nil foreach(mapcar lab labs when(isPointInBbox(lab~>xy r~>bBox) when( r~>layerName==lab~>layerName list(r lab)))))))
;length(pairs);=> 13
;pairs~>pin
;=> ((db:0x3f868d1a nil) (db:0x3f868d1b nil) (db:0x3f868d20 nil) (db:0x3f868d24 nil) (nil nil) (nil nil))

ppins=setof(p pairs car(p)~>pin) ;=> take only rectangle of type pin matching with label pair
;length(ppins);=> 11
pins2move=remove(nil foreach(mapcan ppin ppins lpin=car(ppin) unless(dbFindProp(lpin  "dontmove") list(ppin)))) ;=> add dontmove property if you want to keep pin allready  placed.
cvs=dbOpenCellViewByType(cv~>libName cv~>cellName "schematic")
unless(cvs printf("Hey dude, where is your schematic ? %L\n" list(cv~>libName cv~>cellName )))
;; cvs~>sigNames;=> ("VSS" "VDD" "VB" "OUT-4" "OUT+1" "OUT+2" "OUT+3" "OUT+4" "OUT-1" "OUT-2" "OUT-3")
;; dbFindSigByName(cvs "VB")~>term

;; pinlab=nth(1 pins2move);=> (db:0x3f868c9a db:0x3f868c9b)
;; pinlab=nth(0 pins2move);=> (db:0x3f868c9a db:0x3f868c9b)

printf("TOMOV : %L\n" list(pins2move length(pins2move)))

foreach(mapcar pinlab pins2move
Apin=car(pinlab);=> db:0x3f868c9e
sigName=car(pinlab)~>pin~>name;=> "OUT+1"
printf("MOVING : %L\n" list(sigName Apin))

;sigNames=setof(s cvs~>sigNames dbFindSigByName(cvs s)~>term) ;=> nets that are pins
;; sigName=nth(2 sigNames);=> "VB"
;; sigName=nth(3 sigNames);=> "VB";=> "OUT-4"

dbFindSigByName(cvs sigName)
dbFindSigByName(cvs sigName)~>memInstTerms

mits=dbFindSigByName(cvs sigName)~>memInstTerms;=> ((db:0x4f19cf20 0) (db:0x4f19cf2d 0) (db:0x4f19cfdb 0) (db:0x4f19cfe8 0))

when( mit=car(mits);=> (db:0x4f19cf20 0)  ;<= take the first found instance where the pin ins connecter, in pin not on an instance => pass this one
;; mit
itsd=foreach(mapcar mit dbFindSigByName(cvs sigName)~>memInstTerms list(car(mit)~>name dbGetMemName(car(mit)~>inst~>name cadr(mit)))) ;=> (("VB" "I0") ("VB" "I7") ("VB" "I12") ("VB" "I1"))
iname=dbGetMemName(car(mit)~>inst~>name cadr(mit));=> "I0"
inst=car(setof(inst cv~>instances inst~>name==iname));=> db:0x457bb59d

its=car(itsd)
ins=cadr(its);=>"I10"
pn=car(its);=>"Z"  ;<== TODO : if instance as a pin Z<0:1> it bugs .... or do it before in the creation of itsd

apn=assoc(pn getInstTermPointLPP3(inst));=> ("VB" (3.49 14.11) ("MET2" "pin") ((2.99 13.995) (3.99 14.225)) db:0x4b803222)
bBox=nth(3 apn)
lpp=nth(2 apn);=> ("MET2" "pin")
dir=nth(4 apn)~>pin~>term~>direction
REC=nth(4 apn)
point=nth(1 apn)
justify=car(REC~>children)~>justify
height=car(REC~>children)~>height
orient=car(REC~>children)~>orient
font=car(REC~>children)~>font
printf("move %L " list(pin~>objType sigName))
printf("onto : Pin LPP %L \n" list(pn  bBox lpp dir))

;centerBox(pin~>bBox);=> (41.535 22.56)
relativemovexy=mapcar('difference point centerBox(Apin~>bBox))
printf("MV %L\n" list(Apin relativemovexy ))
dbMoveFig(Apin nil list(relativemovexy "R0"))
printf("DONE \n" list(pn  bBox lpp dir))

;updatelpp=t
when(updatelpp Apin~>lpp=lpp cadr(pinlab)~>layerName=car(lpp)) ; update of the label can be techno dependent (met pin) or (met TEXT) versus ("pin" "metal") ...
);end when pin is connecter to an instance (netSet on VSS is not taken into account or global! net)
);end foreach pins2move
));;<= end let and defun

;css()~>??
;=> (db:0x3f868c9f cellView db:0x457bd39a objType "label" prop nil bBox ((9.359 10.735) (19.171 12.735)) children nil groupMembers nil isAnyInst nil isShape t matchPoints nil net nil parent db:0x3f868c9e pin nil purpose "TEXT" textDisplays nil assocTextDisplays nil markers nil figGroup nil isUnshielded nil shieldedNet1 nil shieldedNet2 nil layerName "MET1" layerNum 13 lpp ("MET1" "TEXT") connRoutes nil routeStatus "normal" font "stick" height 2.0 isDrafted t isOverbar nil isVisible t justify "centerCenter" labelType "normalLabel" orient "R0" theLabel "OUT+1" xy (14.265 11.735) hasTextDisplay nil)