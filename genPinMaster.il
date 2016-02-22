;; copyleft ebecheto
ineed('(getInstTermPointLPP createPinLPP) )

; (setq pn "vdd!")


defun(genPinMaster (@optional (pn "vdd!")(sigName nil)(instances nil)(only1 nil)(cv t) )
let((apn bBox dir lpp)
; pn : pin name
when(cv==t cv=geGetWindowCellView())
insts=(cond 
(listp(instances)&&instances!=nil instances)
(instances&&not(listp(instances)) list(instances))
(geGetSelectedSet())
(foreach(mapcan inst cv~>instances when(member(pn inst~>instTerms~>name) list(inst))))
(nil)
)
;printf(",%L,\n" insts)

; if its a list of intance name, get the db:0xxxx insts=list("|I0(10)" "|I0(11)")
; but require the correct cv (cellview) has argument ...
insts=foreach(mapcar inst insts if( stringp(inst) car(setof(i cv~>instances i~>name==inst)) inst))

when(only1 insts=list(car(insts)))
; instances are the one selected or the ones that 
;; insts=geGetSelectedSet()||cv~>instances
;; inst=car()
;; unless(inst printf("clic and select an instance\n") 
;; ;return(nil)
;; )

unless(sigName sigName=pn)

foreach(mapcar inst insts
apn=assoc(pn getInstTermPointLPP(inst))
;=> ("vdd!" (7.6 -4.575) ("MET1" "pin") ((7.25 -7.25) (7.95 -1.9)) db:0x31a35b23)
bBox=nth(3 apn) 
lpp=nth(2 apn); 
dir=nth(4 apn)~>pin~>term~>direction
printf("createPinLPP%L\n" list(sigName bBox lpp dir))
if(bBox&&lpp then createPinLPP(sigName bBox lpp dir) else printf("NO LPP or bBox for:%L\n" list(sigName bBox lpp dir)))

); end insts loop
))


defun(genPinsMaster (@optional (pns list(list("vdd!" "vdd!") list("gnd!" "gnd!") )) (cv t) )
; printf("|%L|\n" pns)
foreach(mapcar pn pns
genPinMaster(car(pn) cadr(pn) nil nil cv)
)
)


; genPinMaster()
; genPinMaster("vdd!" "VDD")
; genPinMaster( "gnd!")

printf("genPinMaster()\n")
printf("genPinMaster(%L %L)\n" "vdd!" "VDD")
printf("genPinMaster(%L)\n" "gnd!")


printf("genPinsMaster(list(list(%L %L) list(%L %L) ))\n" "vdd!" "PWR" "gnd!" "GRD")
printf("genPinsMaster(list(list(%L %L) list(%L %L) ));<== default\n" "vdd!" "vdd!" "gnd!" "gnd!")
printf("genPinsMaster( ));<== default : indem as ^^ above\n" )
printf(";<== default : add vdd! and gnd! pins to the selected instances. If nothing selected, Add to instances with pins named vdd!\n" )
