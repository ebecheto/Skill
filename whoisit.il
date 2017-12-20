idList='()
id='((name "claire") (eye "brown") (hair "red") (hat "flower") (glasses "blue") (mouse "small") (sex "girl"))
idList=append(idList list(id))
id='((name "bill") (eye "broun") (hair "red") (cheekbone t) (glasses nil) (mouse "small") (sex "boy") (bald t))
idList=append(idList list(id))
id='((name "robert") (eye "brown") (hair "red") (cheekbone t) (glasses nil) (mouse "large")(sex "boy") (smile nil))
idList=append(idList list(id))


foreach(mapcan id idList cdr(assoc('name id))) ;=> liste des noms

lst=nil foreach(id idList 
foreach(part id
unless(member(car(part) lst) lst=append(lst list(car(part))) ))) ;=> liste des caracteristiques
lPart=lst



(remq 'name id)
(remove '(name) id)
defun( rm2list (lst del) foreach(mapcan l lst unless(member(del l) l)))
rm2list(id 'name)

; tree view
lst=nil foreach(id idList 
foreach(part id  ;=> (name ...) (eye ..)
if(tmpPart=member(car(part) lst) then
unless(lstd=assoc(car(cadr(part) tmpPart)) lst=append(rm2list(lst car(part)) list(lstd cadr(part))))
else
lst=append(lst list(part)) ))) ;=> liste des caracteristiques
lst


;; member('name  id)
;; assoc('name  id)
;; assoc(car('(name "rober")) id)