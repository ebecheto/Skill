;; copyleft ebecheto

(defun categorySet ( @optional (libName nil) (cellName nil) (catName nil) @rest rest)
(let (ddId rw cat)
unless(libName libName="local_TDC_BRICK")
unless(cellName cellName="CSAR_sim")
unless(catName catName="SIMU")
ddId= ddGetObj(libName)
rw=if(member(catName ddCatGetLibCats(ddId)) "a" "w")
cat = ddCatOpenEx(ddId catName rw 1)
; ddCatRemove(cat) ;<== delete the category from list.
ddCatAddItem(cat cellName "cell")
printf("%s->%s\n" catName cellName)
ddCatSave(cat)
ddCatClose(cat)
ddCatGetLibCats(ddId) ;<== check ifit worked
))

(defun categorySetLib (@optional (libName nil) (pattern "_sim$") (catName nil) @rest rest)
(let (ddId cellName)
unless(libName libName=geGetWindowCellView()~>libName||"local_TDC_BRICK")
printf("update %s\n" libName)
ddId= ddGetObj(libName)
foreach(mapcar cell ddId~>cells 
cellName=cell~>name
;rexMatchp("_sim$" "Tdc_1_sim")
when(rexMatchp(pattern cellName||"nulnul")
;printf("set for cell %s lib %s  [%s category]\n" libName cellName catName||"default")
categorySet(libName cellName catName rest)
))))
;=> "a"

printf("_USAGE_\n")
printf("categorySet(libName cellName cat);<== affect category 'cat'\n")
printf("categorySetLib(libName \"_sim$\" cat);<== affect category 'cat' to all matched cell name '_sim$' to the given library\n")
printf("categorySetLib();<== affect category 'SIMU' to all matched cell name '_sim$' of the viewing library of the active shematic\n")


;; dmRemoveCellFromCategory(cat list("CSAR_sim"))
;; foreach( i list("CSAR_sim") ddCatSubItem( cat i~>name ))
;; ddCatSave( cat )
;; ddCatGetCatName(cat)
