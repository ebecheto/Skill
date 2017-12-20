;; copyleft : ebecheto

;; TODO : default case insensitiv

; (setq viewType list("symbol" "layout" "schematic"))
; (setq cell "nmos4")
procedure(whereExistCell3(  @optional (cell "nmos4") (libList ddGetLibList()) (viewType list("symbol" "layout" "schematic")) )
let((g_libList ret ) ret='()
unless(libList libList=ddGetLibList())
unless(listp(viewType) viewType=list(viewType))
if(type(car(libList))=='string 
g_libList=foreach(mapcar lib libList car(setof(g_lib ddGetLibList() g_lib~>name==lib)))
g_libList=libList)
g_libList=remove(nil g_libList)
foreach( g_lib g_libList  foreach( view viewType
when(member(view dbAllCellViews(g_lib cell))  ret=append(ret list(g_lib~>name view))
;printf("RET=%L\n" ret)
))); tconc(ret) car(ret) serait plus joli. Mais j'ai commencé a utiliser la fonction autrement
ret)) 

;; whereExistCell("INV0")
;; whereExistCell("INVX2") ; ("CORELIB")
;; whereExistCell3("XOR2_A" nil "symbol");=> OK pour ibm
;; whereExistCell3("XOR2X2" nil "symbol");=> amsh18

;; dd=car(ddGetLibList() )
;; dd~>name;=>"analogLib"
;; dd~>cells~>name ;=> ...
;; assocLib=foreach(mapcan dd ddGetLibList() foreach(mapcan cc dd~>cells list(list(dd~>name cc~>name))))

;
