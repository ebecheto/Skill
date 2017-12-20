(setq hv 'y)
; (setq step 0.125)
defun( schDistribute (@optional (hv 'x) (sss nil)(step 0.125))
unless(sss sss=geGetSelectedSet())

if(hv=='x then
ss=sortcar(sss~>xy 'lessp)
else
ssy=sortcar(foreach(mapcar s sss~>xy reverse(s)) 'lessp)
ss=foreach(mapcar sy ssy reverse(sy))
)

cond(
(x=caar(ss~>xy) ; c'est label car points
cond(
(hv=='x 

foreach( s ss s~>xy=list(x cadr(s~>xy)) x=x+step)
(t y=cadar(ss~>xy)


;; repartir label en y
sss=geGetSelectedSet()
tab=foreach(mapcar s sss list(cadr(s~>xy) s))
tabs=sortcar(tab 'lessp)
y=cadr(cadar(tabs)~>xy)
foreach(mapcar ta tabs 
st=cadr(ta) st~>xy=list(car(st~>xy) y) y=y+0.125
)


; reparti symbol pin en y
sss=geGetSelectedSet()

tab=foreach(mapcar s sss list(cadr(cadr(s~>bBox)) s))
tabs=sortcar(tab 'lessp)

; y=cadr(cadr(cadar(tabs)~>bBox))
bx=cadar(tabs)~>bBox
;=> ((-0.025 0.1625) (0.025 0.2125))
foreach(mapcar ta tabs
s=cadr(ta)
s~>bBox=bx
bx=dbTransformBBox( bx list(0:0.125 "R0"))
)


;; repartir en x
sss=geGetSelectedSet()
tab=foreach(mapcar s sss list(cadr(cadr(s~>bBox)) s))
tabs=sortcar(tab 'lessp)
bx=cadar(tabs)~>bBox
foreach(mapcar ta tabs
s=cadr(ta)
;s~>bBox=bx printf("mv %L in %L\n" s~>baseName bx)
;<= marche pas ?? nil
s~>xy=centerBox(bx)
bx=dbTransformBBox( bx list(0.125:0 "R0"))
)

css()~>bBox='((-0.53125 -1.625)(-0.30625 -1.18125))

xy=centerBox('((-0.53125 -1.625)(-0.30625 -1.18125)));=> (-0.41875 -1.403125)

css()~>xy=xy



sss=geGetSelectedSet()
tab=foreach(mapcar s sss 
when(nom=s~>pin~>term~>name
unless(rexMatchp("^_"  nom) s~>pin~>term~>name=strcat("_" nom)
)))

tab=foreach(mapcar s geGetSelectedSet() 
when(nom=s~>theLabel
unless(rexMatchp("^_"  nom) s~>theLabel=strcat("_" nom)
)))


sss=geGetSelectedSet()
tab=foreach(mapcar s sss 
when(nom=s~>pin~>term~>name
when(rexMatchp("^_"  nom) s~>pin~>term~>name=car(parseString(nom "^_"))
)))

tab=foreach(mapcar s geGetSelectedSet()
when(nom=s~>theLabel
when(rexMatchp("^_"  nom) s~>theLabel=car(parseString(nom "^_"))
)))





; dbRenameNet(css()~>name "_Cstim")
css()~>pin~>term~>name="_Cstim"


foreach(mapcar s sss nom=s~>pin~>term~>name)

(and stringp(nil) rexMatchp("^_"  nil))


inst=addCell('("RLC") t xy)

geGetSelectedSet()~>??

; TP12 TP1516 TP1314 TP1112 TP910 TP67 TP56 TP34 



geGetSelectedSet()~>pin~>term~>name
names='("_Cstim" "_CHOP" "_ENA" "_sub!" "_gnda!" "_vcca!" "_VSB2" "_VDB1" "_Dzi" "_Dzo" "_Dzk" "_RN" "_RDIOD")

names='("_Vref")
;xy='(-3 -1)
xy='(-3 -4)
insts=foreach(mapcar s names
inst=car(addCell('("RLC") t xy))
; schCheck(geGetWindowCellView())
xy=dbTransformPoint(xy  list(0:-0.25 "R0"))
sn=car(parseString(s "_"))
printf("terminalPinsMap('%L)\n" list(sn s))
terminalPinsMap(list(sn s) inst)
inst)


;; sss=geGetSelectedSet()~>pin~>term~>name;=>
;; inst=css();=> db:0x20d7b9eb
;; terminalPinsMap('("A" "_A") inst)


for(i 1 16 printf("PA<%d> " i));=> t
for(i 1 16 printf("IN<%d> " i));=> t
; PA<1> PA<2> PA<3> PA<4> PA<5> PA<6> PA<7> PA<8> PA<9> PA<10> PA<11> PA<12> PA<13> PA<14> PA<15> PA<16>