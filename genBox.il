;; copyleft ebecheto

ineed('geOpenOrRaise 'padRing )

defun(genBox (@optional (cv nil)(dummy t)(PWR t)(MAS t) @rest rest)
let( (pinName lib cell padName name pfile i terms globals amsopt1 amsopt2 SUB)
unless(cv cv=geGetWindowCellView())
when(PWR==t PWR="vdd!")
when(MAS==t MAS="gnd!")
if(r=assoc('amsopt1 rest) then amsopt1=cadr(r) else amsopt1="P") ;possible "C" "P" "D"
if(r=assoc('amsopt2 rest) then amsopt2=cadr(r) else amsopt2="_3B") ;possible "" "_3B"
if(r=assoc('SUB rest) then SUB=cadr(r) else SUB="vsub!") ;possible "sub" "subc" "masse" "whatever"
; when(SUB==t MAS="sub!")

pins=car(setof(p cv~>prop p~>name=="pin#"))
terms=(remove nil foreach(mapcan p pins~>object~>instances~>net p~>sigNames))
; pins~>object~>instances~>net~>sigNames;=> (("b") ("a") ("OUT") ("IN") ("b") ("a") ("OUT") ("IN"))
globals=setof( n cv~>signals~>name rexMatchp("!$" n));=> ("vdd!" "gnd!")
pinName=append( terms globals)

;pinName=cv~>terminals~>name
lib=cv~>libName
cell=cv~>cellName
padName=strcat(cell "_RING")

cond( ; IBM ?
(member("cmrf8sf" ddGetLibList()~>name) 
IOCELL="SIOWIRE_ESD"
PERICELL="SIOFILL_sx";<== donner aussi la pcell !!
COMPCELL="SHORT_IO_BREAKGND_CELL_8MA_44"
CORNERCELL="SIOCORNER45";<== dans les shortio du cern...
GNDCELL="SIOGND"
VDDCELL="SIOVDD"
SUBCELL="SIODVSS"
METAL="MG"
) ; TSMC ?
(member("tsmc13rf" ddGetLibList()~>name) 
IOCELL="PDB3A"
PERICELL="PFILLER20A"
COMPCELL="PFILLER20A"
CORNERCELL="PCORNERA"
GNDCELL="PVSS2AC"
VDDCELL="PVDD3AC"
SUBCELL="PVSS2AC"
METAL="METAL3"
;; IOCELL="PDB3A_with_PAD"
;; PERICELL="PFILLER10"
;; COMPCELL="PRCUTA"
;; CORNERCELL="PCORNER"
;; GNDCELL="PVSS2CDG_with_PAD"
;; VDDCELL="PVDD3A_with_PAD"
) ; AMS ?
(t; member("IOLIB_ANA_3B_4M" ddGetLibList()~>name)
IOCELL		=strcat("APRIO" amsopt1 amsopt2)
PERICELL	=strcat("PERI_SPACER_100_" amsopt1 amsopt2)
COMPCELL	=strcat("PERI_SPACER_100_" amsopt1 amsopt2)
CORNERCELL	=strcat("CORNER" amsopt1 amsopt2)
GNDCELL		=strcat("AGND3ALL" amsopt1 amsopt2)
VDDCELL		=strcat("AVDD3ALL" amsopt1 amsopt2)
SUBCELL		=strcat("AVSUB" amsopt1 amsopt2)
METAL="MET1"
))

;; help gnd/vdd cas ; pinName list adjustment
pinName=foreach(mapcar pn pinName cond((pn==PWR list(pn VDDCELL)) (pn==MAS list(pn GNDCELL))(pn==SUB list(pn SUBCELL)) (t pn)))

name="box_" i=0
while( isFile( filename=sprintf(nil "%s/%s%d%s" pwd() name i ".il")) i++)
; filename ;=> "/home/validmgr/ebecheto/Work/IC6/box_0.il"

pfile=outfile(filename)
fprintf(pfile ";; Generated %s\n" getCurrentTime())
fprintf(pfile ";; load(%L)\n ;<== do not uncomment load(...) or it loops infinitely\n" filename)
fprintf(pfile "ineed('padRing)\n\n")
foreach(mapcar truc list('IOCELL 'PERICELL 'COMPCELL 'CORNERCELL 'GNDCELL 'VDDCELL 'pinName 'lib 'padName 'METAL)
fprintf(pfile "%s=%s%L\n" symbolToString(truc) if(listp(eval(truc)) "'" "") eval(truc)))
fprintf(pfile ";Add whatever (\"vdd!\" %L) in the pinName list if needed\n" VDDCELL)
fprintf(pfile ";Add whatever (\"gnd!\" %L) in the pinName list if needed\n" GNDCELL)
fprintf(pfile "; Attention. Will OVERWRITE %s %s. So change its name if needed\n" lib padName)

fprintf(pfile "createPadRing(pinName 50 5 lib padName '%L '%L '%L '%L '%L '%L '%L '%L '%L '%L '%L)\n" '("IO" IOCELL) '("fill" PERICELL) '("complete" COMPCELL) '("padCap" CORNERCELL) '("fillFirst" 0) '("fillLast" 0) '("GND" "GND") '("VDD" "VDD") '("cornPatch" -5.4) '(xn 5) list("metal" METAL))

fprintf(pfile "geOpenOrRaise(?cell %L ?lib %L ?view %L)\n" padName lib "layout")
close(pfile)


printf("\n** Now just type **\nload(%L)\n" filename)

; createPadRing(pinName 50 5 lib padName '("IO" IOCELL) '("fill" PERICELL) '("complete" COMPCELL) '("padCap" CORNERCELL) '("fillFirst" 0) '("fillLast" 0) '("GND" "GND") '("VDD" "VDD") '("cornPatch" -5.4))


edit(eval(filename))
when(dummy load(filename)) ;<== load it automaticaly ?
filename;<= return what... filename or a better thing ?
)
)

printf("\n** Now just type :** \ngenBox()\n")
printf("genBox(nil t \"vdd!\");<= treat vdd! with AVDD3ALLP_3B for AMS, SIOVDD for IBM, PVDD3AC for tsmc\n")
printf("genBox(nil t \"vdd!\" \"gnd!\")\n")
printf("genBox(nil t \"VDD\" \"GND\")\n")
printf("genBox(nil nil \"VDD\" \"GND\"); <= wait you to load box_n.il manually\n")
printf("genBox(nil t t t '(amsopt1 \"C\"));<== generate with ams corelimited\n")
printf("genBox(nil t t t '(amsopt1 \"P\") '(amsopt2 \"\"));<== default mode\n")
printf("genBox(nil t t t '(amsopt1 \"P\") '(amsopt2 \"\") '(SUB \"vsub!\"));<== default mode\n")



; genBox (@optional (cv nil)(dummy t)(PWR t)(MAS t))

