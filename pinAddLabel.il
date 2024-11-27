;ineed('pinAddLabel t)
defun(pinAddLabel (@optional (cv nil) (font nil) (drawing2label t))
let((pins pin accessDir REC bBox lpp disp)
unless(cv cv=geGetWindowCellView() )
unless(font font="roman")
;; font="roman"
;; drawing2label=t

pins=remove(nil cv~>shapes~>pin);=> (db:0x2b0c8c1a ... db:0x2b0c8c3e)
length(pins);=> 37
pin=car(pins)

foreach(mapcar pin pins
accessDir=car(pin~>accessDir)
REC=pin~>fig
bBox=REC~>bBox;=> ((16.66 0.0) (16.94 0.73))
ineed('(bBoxHeight bBoxWidth))
bBoxHeight(REC~>bBox);=> 0.73
bBoxWidth(REC~>bBox);=> 0.28


case(accessDir
("bottom" orient="R90" justify="centerLeft"  height=bBoxWidth(REC~>bBox))
("left"   orient="R0"  justify="centerLeft"  height=bBoxHeight(REC~>bBox))
("right"  orient="R0"  justify="centerRight" height=bBoxHeight(REC~>bBox))
("top"    orient="R90" justify="centerRight" height=bBoxWidth(REC~>bBox))
(t        orient="R0"  justify="centerLeft"  height=bBoxHeight(REC~>bBox))
)

unless(
REC~>children;=> nil
lpp=REC~>lpp;=> ("M2" "drawing")
name=REC~>net~>name;=> "Rst_n"
REC~>??
when(drawing2label
lpp=list(REC~>layerName "label")
)
;; list(cv lpp centerBox(bBox) name justify orient font height)
;; ;=> (db:0x2b0cbb1a ("M2" "label") (16.8 0.365) "Rst_n" "centerLeft" "R90" "roman" 0.28)
disp=dbCreateLabel(cv lpp centerBox(bBox) name justify orient font height)
disp~>isNameVisible=nil ;makes the 'name=' invisible
disp~>parent=pin~>fig   ;makes the text moving with the rect pin

);unless no label on the pins => add it
);foreach all pins in the cellview
));let defun