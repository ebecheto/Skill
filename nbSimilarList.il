;; copyleft ebecheto

defun(nbSimilarList (@optional (aList setof(g geGetSelectedSet()~>cellName g)) (tri t) )
let((blist nb)
"gives the number of each same instances"
;printf("%L-elements :: %L\n" length(aList) aList)
bList=nil 
foreach(elt aList 
;printf("\n%L<=element :: bList:%L\n" elt bList)
if(assoc(elt bList) 
then ; incremeent element
;printf("%L<=assoc :: nb:%L\n" assoc(elt bList) cadr(assoc(elt bList)))
nb=cadr(assoc(elt bList))
nb=nb+1
rplaca(cdr(assoc(elt bList)) nb) ;=>  <=> setcdr in foreach loop
else ; add element in the list
bList = append(bList list(list(elt 1)))
);endif
)
if(tri sortcar(bList 'alphalessp) bList)
);output result
)

;; USAGE
; nbSimilarList('("A" "A" "A" "A" "A" "B" "B" "B" "B")) ;=> (("A" 5) ("B" 4))
; select some instances
; nbSimilarList()
;=> (("PDB3AC_with_PAD" 15) ("PFILLER0005A" 51) ("PFILLER10A" 18) ("PFILLER20A" 16) ("PVDD3AC_with_PAD" 1) ("PVSS2AC_with_PAD" 1))
