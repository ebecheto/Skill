;; copie n-fois de la meme instance bout a bout en Y vers le bas
selectedInst = css()
for(i 1 8
newInst = dbCreateInst( selectedInst~>cellView selectedInst~>master 
nil ; "toto" ;  ~>xy donne le point d'appel de l'origine de l'instance
list( 
car(selectedInst~>xy) 
2* cadar(selectedInst~>bBox) - cadadr(selectedInst~>bBox)
)
selectedInst~>orient
1
)
selectedInst = newInst
)
