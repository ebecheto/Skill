;; copyleft : ebecheto
; notation tower en micron => si ibm length=1u< 0.18 => on multiplie par 1e6
; j'aurai du faire une fonction generique ... TODO later

defun( ts18StrapProp  (@optional (cv geGetWindowCellView()) (verb t) (supDef t)) let((paramName cdfgData cdfgForm callback success (cnt 0))
; supDef=t; use defValue as defaut minimum instead of 0.22
foreach(inst cv~>instances
when(or(inst~>libName=="ts018_prim" inst~>libName=="tsl18fs120")
(setq cdfgData (cdfGetInstCDF inst))
(setq cdfgForm cdfgData); some callbacks use cdfgForm instead, sinon *Error* eval: unbound variable - cdfgForm
(setq callback (getq cdfgData formInitProc))
when(verb printf("INIT:%s\n" cdfgData||"nil"))
success=t
; (when (and callback (nequal callback "")) (errset (evalstring (strcat callback "(cdfgData)")) t))
; (when (and callback (nequal callback "")) (errset dsmt_cdfFormInit(cdfgData) ))
; (when (and callback (nequal callback "")) (unless (errset (evalstring (strcat callback "(cdfgData)")) t) (setq success nil)))
(when (and callback (nequal callback "")) (unless (errset (evalstring (strcat callback "(cdfgData)")) nil) (setq success nil)))
when(verb&&success&&callback printf("INIT correctly executed!!!\n"))
when(verb printf("%s with %d parameters\n" inst~>name length(cdfgData~>parameters)))
;; Only valid for Tower prompt ie. for ibm transistor w->prompt="derived width"
cond(
(and(member("r" inst~>prop~>name)  (get cdfgData 'r)->prompt=="Resistance" ) ;not(rexMatchp("subc" inst~>cellName))
when(verb printf("%s is a resistance\n" inst~>cellName))
propW=(get cdfgData 'w)
propCal=(get cdfgData 'calculatedParam) 
propW->value=propW->defValue;<= reset to default width of the res to prevent error
propCal->value="Length";<== ok marche : mode changement de la resistance 
paramName='r cnt++
);end resistance case
(and(member("c" inst~>prop~>name)  (get cdfgData 'c)->prompt=="Capacitance") 
when(verb printf("%s is a Capacitance\n" inst~>cellName))
propCal=(get cdfgData 'userParams) 
propCal->value="Length";<== ok marche
paramName='c cnt++;<== le callback du parametre "c" sera re-evaluer pour corriger les defauts
);end capacitance case
(and(member("w" inst~>prop~>name)  (get cdfgData 'w)->prompt=="Total Gate Width") 
when(verb printf("%s is a Transistor\n" inst~>cellName))
propW=(get cdfgData 'w)
propWF=(get cdfgData 'wf)
propFingers=(get cdfgData 'fingers)
propL=(get cdfgData 'l)
val=aelNumber(propL->value)
minL=aelNumber(propL->defValue)
defW=aelNumber(propW->defValue)
minW=if(supDef defW 0.22); dans le cas de Length defValue est minimum. Pas dans le cas de W. choix de la securite plus que du minimalism qd supDef=t
when(val<minL ; notation tower en micron => si ibm length=1u< 0.18 => on multiplie par 1e6
newL=1e6*val
newW=1e6*aelNumber(propW->value)
when(verb printf("Adusting l=%s and w=%s to (w,l)=(%.2g,%.2g)\n" propL->value propW->value newL newW) )
propL->value=aelSuffixNotation(if(newL<minL minL newL))
propW->value=aelSuffixNotation(if(newW<minW minW newW))
propWF->value=aelSuffixNotation(propFingers->value*aelNumber(propW->value))
)
paramName='w cnt++
);end transistor case
);end treated cases (no default)
when(paramName ; evaluation du callback utile pour rafraichir les valeurs des proprietes
(setq callback (getq (get cdfgData paramName) callback))
(when (and callback (nequal callback "")) (errset (evalstring callback) t))
paramName=nil)
);end foreach
) cnt;tower cells only
))