;; copyleft : ebecheto

;I used to call this function :whereExistCell

procedure(whereIsCell(  @optional (cell "nmos4") (libList ddGetLibList()) @rest rest)
let((g_libList ret ) ret='()
unless(views=member('views rest) viewType=list("symbol" "layout" "schematic"))
icase=assoc('i rest)
unless(libList libList=ddGetLibList())
unless(listp(viewType) viewType=list(viewType))
if(type(car(libList))=='string 
g_libList=foreach(mapcar lib libList car(setof(g_lib  ddGetLibList() g_lib~>name==lib)))
g_libList=libList)
g_libList=remove(nil g_libList)
foreach( g_lib g_libList  foreach( view viewType
when(member(view dbAllCellViews(g_lib cell))  ret=append(ret list(g_lib~>name view))
;printf("RET=%L\n" ret)
))); tconc(ret) car(ret) serait plus joli. Mais j'ai commencé a utiliser la fonction autrement
ret)) ; whereExistCell("INV0")
; whereExistCell("XOR2_A" nil "symbol")

printf("whereExistCell();<== find all existing cells named \"nmos4\"\n")
printf("whereExistCell(\"INV0\");<== find all existing cells named INV0\n")

;; (setq viewType list("symbol" "spectre" "layout" "schematic"))
;; g_lib=car(ddGetLibList())

;; dbAllCellViews(g_lib "nmos4")
;; viewType='("rien")

;; remove(nil foreach(mapcan vie viewType member(vie dbAllCellViews(g_lib "nmos4"))))
;; append('("3" "4") nil)
;; views=remove(nil foreach(mapcan vie viewType member(vie dbAllCellViews(g_lib "nmos4"))))


; case sensitiv ... or not

