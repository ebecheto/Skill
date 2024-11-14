;; copyleft : ebecheto
unless(fboundp('a2s) ineed('itos) alias(a2s itos))

; load("vdcGen.il")
defun( vdcGen (@optional  (pinName t) (cv t) (N1 4) (N2 8) (bus t)(zero 0)(un 3.3))
let((XY tmp X0 Y0 dX dY label i v wid Ni2s bug bud nwidth labelR0)
when(cv=='t cv=geGetWindowCellView())
when(pinName=='t pinName="SDC")
if(bus then bug="<" bud=">" else bug="_" bud="")
printf("Insert vdc_ %L in %s\n" list(N1 N2) cv~>cellName||"pasDeCellName?")
if(listp(N2) then N2t=cadr(N2)||1 N2f=car(N2) when(N2t<N2f tmp=N2f N2f=N2t N2t=tmp) else N2f=1 N2t=N2)
if(listp(N1) then N1t=cadr(N1)||1 N1f=car(N1) when(N1t<N1f tmp=N1f N1f=N1t N1t=tmp) else N1f=1 N1t=N1)
X0=ceiling(caar(cv~>bBox))+0.375
Y0=ceiling(cadadr(cv~>bBox))
XY=list(X0 Y0)
dX=0.25 ;0.5
dY=1
nwidth=0;  0.0125
labelR0="R90"
printf("from to loops :%L\n" list(N1f N1t N1f N2t) )
for(Ni1 N1f N1t
for(Ni2 N2f N2t
label=if(N1f!=N1t sprintf(nil "%s_%d%s%d%s" pinName Ni1 bug Ni2 bud) strcat(pinName bug a2s(Ni2) bud))
printf("label:%s\n" label)
Ni2s=Ni2; Ni2-1<= choix sur le shift de depart de Ni TODO
i=0 base="V"
while(member(baseName=sprintf(nil "%s%d" base i) cv~>instances~>baseName) i++)
i=0 base="I"
while(member(baseI=sprintf(nil "%s%d" base i) cv~>instances~>baseName) i++)

dbCreateInstByMasterName(cv "analogLib" "gnd" "symbol" baseI rodSubPoints(XY 0:0.375) "R0")
v=dbCreateInstByMasterName(cv "analogLib" "vdc" "symbol" baseName rodAddPoints(XY 0:0) "R0")
param=cdfFindParamByName( cdfGetInstCDF(v) "vdc")
;param~>value=sprintf(nil "V%s_%d_%d" pinName Ni1 Ni2)
varName=if(N1f!=N1t strcat(pinName "_" a2s(Ni1)) pinName)
param~>value=sprintf(nil "int(%s)&(1<<%d) ? %s:%s" varName Ni2s a2s(zero) a2s(un))
wid=schCreateWire( cv "draw" "direct" list(XY rodAddPoints(XY 0:0.25)) 0.0625 0.0625 nwidth)
schCreateWireLabel(cv car(wid) rodAddPoints(XY -0.0625:0.2) label "centerCenter" labelR0 "euroStyle" 0.0625 nil)
XY=rodAddPoints(XY dX:0)
)
XY=list(X0 cadr(XY)+dY)
)))

;; ; vdcGen("SDC" t 4 8)
;; printf("vdcGen(\"FDC\" t 4 8)\n")
;; printf("vdcGen(\"SDC\" t 4 8)\n")

printf("vdcGen (@optional  (pinName t) (cv t) (N1 4) (N2 8) (bus t)(zero 0)(un 3.3))\n")
printf("vdcGen(\"FDC\" t 2 2 nil); <== 4th param ==> _ instead of <> \n")
printf("vdcGen(\"SDC\" t 3 8);<== array of configs\n")
printf("vdcGen(\"ZC\" t 1 6 nil 0 3.3);<== single row, Low=0V, High=3.3V\n")
printf("vdcGen(\"ZC\" t 1 6 nil \"-15\" \"+15\")\n")
printf("vdcGen(\"ZC\" t 1 '(0 5))\n")
printf("vdcGen(\"TH\" t 1 '(0 5));<==one row from 0 to 5\n")
printf("vdcGen(\"TH\" t 1 '(0 5) t 3.3 0);<== \n")
printf("vdcGen(\"ZC\" t 1 '(0 5) t 3.3 0)\n")
printf("ineed('underscore2bus); if i need  _2bus\n")
; bus2_() si on ne veut pas des <1:2> bus, mais des _1 _2


; ineed('abBinaryStrToInt)
; abIntToBinaryStr(11 4);=>"1011"


;; study cdfgData=(cdfGetInstCDF css())~>parameters~>value

;; foreach(mapcar p (cdfGetInstCDF css())~>parameters list(p~>name p~>value))
;; ; a=setof(p (cdfGetInstCDF css())~>parameters when(p~>value!="" list(p~>name p~>value)))
;; params=foreach(mapcar p (cdfGetInstCDF css())~>parameters when(p~>value!="" list(p~>name p~>value)))
;; qpar=setof(p params p)
;; assoc("t3" qpar) ;=> ("t3" "T0+RT")