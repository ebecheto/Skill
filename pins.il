;; fichier de test peut être supprimé

ineed('busMemeInst)
cv=geGetWindowCellView() ; layout
cvs=geGetWindowCellView(); schematic


dbFindSigByName(cvs "IN<0>")~>memInstTerms ; a pin could be connected to multiple instance terminals...
;=> ((db:0x269e3628 0) (db:0x269e361a 0))
cvs~>sigNames
;=> ("IN<1>" "net05<4>" "IN<0>" "net05<0>" "net05<1>" "IN<5>" "OUT<2>" "OUT<1>" "IN<2>" "TEST<2>" "TEST<1>" "gnd!" "OUT<3>" "IN<4>" "IN<6>" "net05<3>" "IN<3>" "net05<2>" "net05<5>" "OUT<0>" "TESTo<3>" "TEST<3>" "TESTo<0>" "TESTo<1>" "TESTo<2>" "TEST<0>" "IN<7>" "net05<6>" "net05<7>" "OUT<4>" "OUT<5>" "OUT<6>" "OUT<7>")

terminals =cvs~>terminals 
flatTerms=foreach(mapcan tn terminals 
if(length(parseString(tn~>name ":"))>1 foreach(mapcar bus bus2flat(tn~>name) bus) list(tn~>name))
)                                                       ;=> ("IN<17>" "TEST<0>" ... "IN<18>" "IN<19>")
sigs=foreach(mapcar s flatTerms dbFindSigByName(cvs s)) ;=> (db:0x33c10224  ... db:0x33c10250)

sigs=foreach(mapcan s cvs~>sigNames list(dbFindSigByName(cvs s)))

length(cvs~>sigNames)
length(sigs)
i=-1 foreach(mapcar s sigs i=i+1 list(i s~>name))
;=> ((0 "IN<1>") (1 "net05<4>") (2 "IN<0>") (3 "net05<0>") (4 "net05<1>") (5 "IN<5>") (6 "OUT<2>") (7 "OUT<1>") (8 "IN<2>") (9 "TEST<2>") (10 "TEST<1>") (11 "gnd!") (12 "OUT<3>") (13 "IN<4>") (14 "IN<6>") (15 "net05<3>") (16 "IN<3>") (17 "net05<2>") (18 "net05<5>") (19 "OUT<0>") (20 "TESTo<3>") (21 "TEST<3>") (22 "TESTo<0>") (23 "TESTo<1>") (24 "TESTo<2>") (25 "TEST<0>") (26 "IN<7>") (27 "net05<6>") (28 "net05<7>") (29 "OUT<4>") (30 "OUT<5>") (31 "OUT<6>") (32 "OUT<7>"))

foreach(mapcan sig sigs
; sig=nth(14 sigs)
;printf("sig=%s\n" sig~>name)
;=> "IN<6>";=> "IN<1>"
if(length(parseString(sig~>name "<"))>1
then
iterms=dbFindSigByName(cvs sig~>name)~>memInstTerms ; a pin could be connected to multiple instance terminals...
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
;=>(("A<0>" "I6<10>")("A<1>" "I6<10>")("A<0>" "I6<11>")("A<1>" "I6<11>")("A<0>" "I6<12>")("A<1>" "I6<12>")("A<0>" "I6<13>")("A<1>" "I6<13>"))
append(list(sig~>name) nth(atacn buses))
;=> ("IN<18>" "A<0>" "I6<13>")
)
))



dbGetNameNumBit(atach~>name);=> 2
dbGetNameNumBit(atach~>inst~>name);=> 4
;=> 2*4 combination since 
atach~>numBits;=> 8

;=> 

(db:0x269e3628 cellView db:0x31a3fe1a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x269e3a2e name "A<0:1>" net db:0x33c10229 numBits 8 term db:0x340ddb1a widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic")


;=> (db:0x269e3628 6)


;; dbGetNameNumBit
;; dbGetNameNumBit("IN<2:8>")   ;=> 7


;; http://community.cadence.com/cadence_technology_forums/f/48/t/21553

;=> (db:0x33c1021c db:0x33c1021f db:0x33c1022a db:0x33c1022c db:0x33c1022f db:0x33c10231 db:0x33c10232 db:0x33c10233 db:0x33c10234 db:0x33c10237)
sigs~>??
;=> ((db:0x33c1021c cellView db:0x31a3fe1a objType "net" prop nil allInstTerms (db:0x269e3621) connStatus nil criticality 0 figs (db:0x31a3fa2e) routePattern "steiner" groupMembers nil instTerms (db:0x269e3621) name "TESTO" numBits 1 parent nil pins (db:0x269e379b) shieldNet1 nil shieldNet2 nil signals (db:0x33c1021c) sigNames ("TESTO") subnet nil subnets nil term db:0x31a3fb9e terms (db:0x31a3fb9e) textDisplays nil assocTextDisplays nil instTermCount 1 markers nil routes nil source "netlist" sigType "signal" aliases ("TESTO") isGlobal nil memInstTerms ((db:0x269e3621 0)) memNets ((db:0x33c1021c 0)) memTerms ((db:0x31a3fb9e 0)))


(db:0x33c1021f cellView db:0x31a3fe1a objType "net" prop nil allInstTerms nil connStatus nil criticality 0 figs nil routePattern "steiner" groupMembers nil instTerms nil name "IN<2>" numBits 1 parent nil pins nil shieldNet1 nil shieldNet2 nil signals (db:0x33c1021f) sigNames ("IN<2>") subnet nil subnets nil term nil terms nil textDisplays nil assocTextDisplays nil instTermCount 0 markers nil routes nil source "netlist" sigType "signal" aliases ("IN<2>") isGlobal nil memInstTerms ((db:0x269e361a 2)) memNets ((db:0x33c10221 2)) memTerms ((db:0x31a3fba0 2)))

sigim=sig~>memInstTerms
;=> ((db:0x31a3fb9e 0))
caar(sigim);=> db:0x269e361a
term=caar(sigm)
;=> db:0x31a3fba0
nbis=cadar(sigm)
;=> 0


foreach(mapcar sig sigs
sigm=sig~>memTerms
;=> ((db:0x31a3fb9e 0))
term=caar(sigm)
;=> db:0x31a3fb9e
nbis=cadar(sigm)
;=> 0
list(term nbis))

foreach(mapcar sig sigs
foreach(mapcar memTerm sig~>memTerms
term=car(memTerm)
nbit=cadr(memTerm)
))




s="OUT<3>"
dbFindSigByName(cvs s) ;=> db:0x33c1021a

dbFindSigByName(cvs s)~>term

insts
cond(
(listp(insts) insts)
(insts list(insts))


instances=nil
instances=css()
instances=geGetSelectedSet()

foreach(mapcar instances list(nil css() geGetSelectedSet())
(if (instances && not(listp(instances))) then printf("not nil and not a list:%L\n" instances) else printf(",%L,\n" instances))
;=> nil
)


foreach(mapcar instances list(nil css() geGetSelectedSet())
cond(
((instances && not(listp(instances))) printf("not nil and not a list:%L\t" instances) )
(listp(instances)&&instances!=nil printf("a list:%L\t" instances) )
)
printf("cond end\n")
;=> nil
)



!listp(css())
;=> t

