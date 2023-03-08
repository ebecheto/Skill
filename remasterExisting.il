ineed('(rexFindCell) )

; lib~>type=='ddLibType;=> t
;; lib=car(setof(g_lib  ddGetLibList() g_lib~>name==newLib))
;; lib~>cells
;inst=car(insts);=> db:0x3edeb335
;; cellName=inst~>cellName;=> "IND2D1"
;; rexFindCell(strcat("^" cellName "$") list(libName) )
;; rexFindCell(strcat("^" cellName "$") )
;; rexFindCell(cellName)

defun(remasterExisting (@optional (cv nil)(libName nil)(force nil))
let((insts)
unless(cv cv=geGetWindowCellView())
unless(libName libName="tcbn65lp")
insts=cv~>instances

foreach(mapcar inst insts
unless(or(inst~>master force)
if( newMast=dbOpenCellViewByType(libName inst~>cellName "symbol")
then
inst~>master=newMast ;<= remaster instance
else
printf("[TODO] %L\n" rexFindCell(strcat("^" cellName "$")))
)))
))


defun(remasterExistingLib (@optional (libName nil)(libMaster nil ))
let((lib cv)
cv~>libName;=> "lojic_65_TRANSLATE"
unless(libName libName="lojic_65_TRANSLATE")
unless(libMaster libMaster="tcbn65lp")
lib=car(setof(g_lib  ddGetLibList() g_lib~>name==libName))
foreach(mapcar cell lib~>cells 
foreach(mapcar view cell~>views  when(cv=dbOpenCellViewByType( newLib cell~>name "schematic")
remasterExisting(cv libMaster)
;abInvokeCdfCallbacks(cv)
;moveBackAndForth(cv~>instances) ;;<= eventually
)))
))

