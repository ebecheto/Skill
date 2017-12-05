; copyleft ebecheto
ineed('(bus2list sch2layName))
; this function map the net in schematic to the pin name
; it could be filtered to get only the pins
; sinst~>cellView~>terminals~>name
; setof(s schInst2mapTable(sinst) member(nth(0 s) sinst~>cellView~>terminals~>name))

defun(schInst2mapTable (@optional (sinst nil))
let((inst mapTable pNames lpNames iNames liNames sNames lsNames res)
unless(sinst sinst=css()); end default config
schi=car(sinst~>instTerms)
mapTable=foreach(mapcan schi sinst~>instTerms
pNames=schi~>net~>sigNames
lpNames=length(pNames);=> 8
iNames=bus2list(sinst~>name);=> ("MULT<0>" "MULT<1>" "MULT<2>" "MULT<3>")
liNames=length(iNames);=> 4
sNames=bus2list(schi~>name);=> ("sort<0>" "sort<1>")
lsNames=length(sNames);=> 2
res='()
for(i 0 lpNames-1 
res=append(res list(list(
nth(i pNames); "PTG_1<6>"
sch2layName(nth(i/lsNames iNames))
nth(mod(i lpNames/liNames) sNames)
schi~>direction
))));end for, that defines 'res'
remove(nil foreach(mapcan r res if(cadr(r) list(r) nil)))
); end mapcan
))

;; TODO : test this function with pinBus_check schematic
;; ; res= '(("net06" nil nil "inputOutput") ("CN<2>" "I17" "CN<2>" "inputOutput"))
;; r='("net06" nil nil "inputOutput")
;; r='("CN<2>" "I17" "CN<2>" "inputOutput")
;; cadr(r)

; (
; ("CN<2>" "I17" "CN<2>" "inputOutput")
; ...
; )
; schInst2mapTable()
; WARNING, send allso non-pin net name => setof filtering after that could be necessary
; no, that does not come from here... see other calling functions
; TODO : debug later
