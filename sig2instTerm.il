;; copyleft : ebecheto

ineed('(busMemeInst bus2flat))

defun(sig2instTerm (@optional (sigs nil) (cvs t) )
let((terminals flatTerms iterms atach atacn memInst busIn buses)
when(cvs==t cvs=geGetWindowCellView());<== supposed to be the schematic one
unless(cvs~>viewName=="schematic" printf("WARNING this should be a schematic view:%L\n" cvs~>viewName))

unless(sigs 
terminals =cvs~>terminals 
flatTerms=foreach(mapcan tn terminals 
if(length(parseString(tn~>name ":"))>1 foreach(mapcar bus bus2flat(tn~>name) bus) list(tn~>name))
)
printf("USING ALL SIGS IF NOTHING GIVEN\n%L\n" flatTerms) ;=> ("IN<17>" "TEST<0>" ... "IN<18>" "IN<19>")
sigs=flatTerms )

;; input sigs could be allready given as a db:0xdeadbeaf, buf is given as pin name, it expands
sigs=foreach(mapcar s sigs if(stringp(s) dbFindSigByName(cvs s) s)) ;=> (db:0x33c10224  ... db:0x33c10250)

foreach(mapcan sig sigs
iterms=sig~>memInstTerms ; a pin could be connected to multiple instance terminals...
;iterms=dbFindSigByName(cvs sig~>name)~>memInstTerms ; a pin could be connected to multiple instance terminals...
;=> ((db:0x269e3628 6) (db:0x269e361a 6));=> ((db:0x269e3628 1) (db:0x269e361a 1))
;=> ((db:0x269e3628 1) (db:0x269e361a 1))
;printf("iterms :%L\t" iterms)
foreach(mapcar item iterms
;item=car(iterms) ;=> (db:0x269e3628 6)
atach=car(item)  ;=> db:0x269e3628
atacn=cadr(item) ;=> 6
memInst=atach~>inst~>name          ;=> "I6<10:13>"
busIn=atach~>name                  ;=> "A<0:1>"
buses=busMemeInst(busIn memInst)
printf("%L <-> busMemeInst(%L %L)==>%L\n" sig~>name busIn memInst buses)
;=>(("A<0>" "I6<10>")("A<1>" "I6<10>")("A<0>" "I6<11>")("A<1>" "I6<11>")("A<0>" "I6<12>")("A<1>" "I6<12>")("A<0>" "I6<13>")("A<1>" "I6<13>"))
append(list(sig~>name) nth(atacn buses))
;=> ("IN<18>" "A<0>" "I6<13>")
)
)
))


; __USAGE__
;; sig2instTerm(list("IN<20>" "OUT<0>" "OUT<1>" "VIN"))
;; sig2instTerm(list("IN<20>" "OUT<0>" "OUT<1>" "VIN") dbOpenCellViewByType(geGetWindowCellView()~>libName geGetWindowCellView()~>cellName "schematic"))

;; the intended use of this function was first to map schematic instances to layout ones
;; sigList=sig2instTerm()
;; foreach(mapcar s sigList list(car(s) cadr(s) instName2layout(nth(2 s))))

;; sig2instTerm(list("IN<20>"))
;; sig2instTerm(list("OUT<0>"))