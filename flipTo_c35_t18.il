;; load "~/Skill/mos2fet.il"    , load "~/Skill/h18_to_130.il"
;;  AMSC35 to TOWER JAZZ 180nm
;; load("flipTo_c35_t18.il") ;<= defines flipList

;; fp='("NOR20" "NOR2_A")
;; tata~>cellName==

; when(tata~>cellName==car(fp)||strcat(car(fp) "_3B") tata~>master=dbOpenCellViewByType("cmos8rf" cadr(fp) "symbol") )


;; ih = car(setof( instHead cv~>instHeaders instHead~>libName == "origLibName" && instHead~>cellName == "origCellName")
;; dbSetInstHeaderMasterName(ih "NEW_PROCESS" ih~>cellName ih~>viewName)
;; setof( oldProp  css()~>prop  oldProp~>name == "wf" )
;; setof( newProp  css()~>prop  newProp~>name == "w" )
;; css()~>prop~>??
;; foreach(mapcar prop css()~>prop  when(prop~>name=="w" printf("oldProp %s=%s convert to : \n" prop~>name prop~>value)))
;; dbCreateProp(inst "w" "float" )
;; tata~>prop~>??
;; when(setof( newProp   css()~>prop newProp~>name=="wf" ) newProp=dbCreateProp(css() "w" "float" ))

;; car(setof(lib ddGetLibList() lib~>name=="ts018_prim"))
;; car(setof(lib ddGetLibList() lib~>name=="ts018_prim"))~>cells~>name
;; co35=sort(car(setof(lib ddGetLibList() lib~>name=="CORELIB"))~>cells~>name 'alphalessp)     ;=> 262
;; co18=sort(car(setof(lib ddGetLibList() lib~>name=="CORELIB_H18"))~>cells~>name 'alphalessp) ;=> 476 pfff....

;; setof(newProp css()~>prop newProp~>name=="w" )~>??
;; oldProp=setof(p css()~>prop p~>name=="ng") oldProp~>??
;; newProp=setof(p css()~>prop p~>name=="nf") newProp~>??
;; dbDeletePropByName(css() "nf")
;; dbCreateProp(css() "nf" "string" "26")
;; dbDeletePropByName(css() "nf")
;; dbCreateProp(css() "nf" "int" "26")   ;<= *Error* dbCreateProp: Invalid integer - "26"
;; dbCreateProp(css() "nf" "int" aelNumber("26")) ;<= *Error* dbCreateProp: Invalid integer - 26.0 
;; dbCreateProp(css() "nf" "int" atoi("26")) ;<= OK
;; dbCreateProp(css() "nf" "string" atoi("26")) ;<= *Error* dbCreateProp: Invalid string - 26
;; newProp=setof(p css()~>prop p~>name=="nf")~>value


defun( sort123 (toSort) (let (l_var s_var pattern OUT)
pattern="ed_"
when(listVariables(strcat("^" pattern)) printf("\nATTENTION DANGER\n") ) ; eventuelement while(pattern_ pattern_i++ ...)
foreach(mapcar so toSort ss=parseString(so "0123456789")
s_var=strcat(pattern car(ss))
not(boundp(stringToSymbol( s_var)))&&set(stringToSymbol( s_var) nil)
unless(member(s_var l_var) l_var=append(l_var list(s_var))); evite les doublon dans l_var. liste des element a purger apres
; printf("SO:%s" so) println(insertAlphaNum(so eval(stringToSymbol(s_var)))) printf("\n")
;set(stringToSymbol(s_var) append(eval(stringToSymbol(s_var)) list(so)));<= action a modifier en fonction du tri
set(stringToSymbol(s_var) insertAlphaNum(so eval(stringToSymbol(s_var))));<= action a modifier en fonction du tri
eval(stringToSymbol(s_var))
)
l_var=sort(l_var nil) foreach(l l_var OUT=append(OUT eval(stringToSymbol(l))))
; OUT=nil l_var=sort(listVariables(pattern) nil) foreach(l l_var OUT=append(OUT eval(l)))
unless(length(toSort)==length(OUT) printf("Lost elements ?%d\n" length(toSort)-length(OUT)))
; losts=remove(t foreach(mapcar to toSort if(member(to OUT) t to)))
foreach(l l_var set(stringToSymbol(l) 'unbound)) ; purge les liste definies
; foreach(mapcar l listVariables(strcat("^" pattern)) eval(l)) ; check results
OUT))


defun( alphaNum (aa) let((sa csa tsa) sa=list(car(aa)) csa=cdr(aa)
foreach( a csa tsa='() csa=sa
(when alphaNumCmp(a car(csa))<0  sa=append(list(a) csa) csa='())
while( csa&&alphaNumCmp(a car(csa))>=0
tsa=append(tsa list(car(csa))) csa=cdr(csa))
sa=append(append(tsa list(a)) csa)
) sa))
;; alphaNum marche bien que si c'est deja trie par sort....
;; alphaNum('("XOR4X6" "XOR4XL" "XOR4X8" "XOR4X6" "XOR4X4")) error si deux elements identiques ?


defun( insertAlphaNum (sa lsa) let((OUT ins done) foreach( a lsa
when(alphaNumCmp(a sa)>=0 ins=t)
if(done||!ins then
OUT=append(OUT list(a))
else
OUT=append(OUT list(sa a)) done=t
)
; printf("%L %L %s %L\n" done ins a OUT)
);foreach
unless(lsa OUT=list(sa) ins=t)
unless(ins OUT=append(OUT list(sa)))
OUT))
;; insertAlphaNum("XOR4X6" '("XOR4X1" "XOR4X2" "XOR4X3" "XOR4X10"))


; file=strcat(pwd() "/coreList.txt")

defun( mkFlipList (lib1 lib2 @optional (coType '( "^INV" "NAND2" "NAND3" "NAND4" "NOR2" "NOR3" "NOR4" "^BUF" "DF" "^AO" "^MUX2" "^MUX3" "^MUX4" "^IMUX2" "^IMUX3" "^IMUX4")) (redoFile t))
(let (file myPort f fl flatList  co35 co18 compare fullList compList un de flatList)
file=strcat("./" lib1 "_" lib2 ".txt")
if((and not(redoFile)  myPort=infile(file))  ; desactive la non creation du fichier, ce n est pas si long que ca.
then
myPort = infile(file)  
printf("Reads from transfert File: %s\n" file)
gets(f myPort) close(myPort)
rexCompile("^(") f=rexReplace(f "" 1)
rexCompile(")$") f=rexReplace(f "" 1)
rexCompile("\" \"") f=rexReplace(f "\"\"" 0)
fl=parseString( f ") (")
flatList=foreach(mapcar x fl rexCompile("\"\"") x=rexReplace(x " " 0) rexCompile("\"") x=rexReplace(x "" 0) simStringsToList(x))
else ;;; if not yet created, create file since my alphaNum function is a bit slow ! do not do it twice!
; co35=alphaNum(sort(car(setof(lib ddGetLibList() lib~>name==lib1)~>cells~>name) nil))     ;=> 189
co35=sort123(car(setof(lib ddGetLibList() lib~>name==lib1)~>cells~>name) )     ;=> 189
co18=sort123(car(setof(lib ddGetLibList() lib~>name==lib2)~>cells~>name)) ;=> ma fonction alphNum deconne avec cette liste (triee dans l autre sens)
coType=append(coType list("^CLKBU" "^CLKIN")) 
alphaNum(setof(c co35 rexMatchp("NAND4" c )))
alphaNum(setof(c co35 rexMatchp("NAND2" c )))
;; vaut mieux matcher NAND3 NAND4 ...
;  and sort PB : alphalessp notgood enough => defun( alphaNum ...)
compare=foreach(mapcar co coType list(
alphaNum(setof(c co35 rexMatchp(lowerCase(co) lowerCase(c) )) )
alphaNum(setof(c co18 rexMatchp(lowerCase(co) lowerCase(c) )) ) ))
fullList=foreach(mapcar comp compare
compList='()
for(i 0 
length(car(comp))-1
; max(length(car(comp)) length(cadr(comp)))-1; convertion c35 to 180nm donc pas besoin de plus d'element que c35.
un=nth(i car(comp) )||un
de=nth(i cadr(comp))||de
compList=append(compList list(list(un de lib2 )))
) compList)
flatList='() foreach(mapcar co fullList flatList=append(flatList co)); 141 element, enougth for now
myPort = outfile(file) 
fprintf(myPort "%L" flatList) ;<== pff !! cannot take an input list ! only %s %d %g with scanf ...
; foreach(mapcar f flatList fprintf(myPort "%L\n" f))
close(myPort)
)
flatList))
;; edit(eval(file))

;; std_tower=sort123(car(setof(lib ddGetLibList() lib~>name=="tsl18fs120")~>cells~>name) )
;; std_ams=sort123(car(setof(lib ddGetLibList() lib~>name=="CORELIB")~>cells~>name) )

;; ; remark : pas de mux 3 en ams, mux 8 en tower....
;; equiv='(("INV" "inv") ("^MUX2" "^mx02"))

;; member("mx0" std_tower);=>nil
;; foreach(mapcan s std_tower when(rexMatchp("^mx0" s) list(s)))
;; foreach(mapcan s std_ams when(rexMatchp("^MUX" s) list(s)))



;; when launching hv into C35
flatList=mkFlipList("CORELIB" "tsl18fs120")
;; flatList=append(flatList mkFlipList("CORELIB_3B" "CORELIB_HV_H18"))

;; ;; when launching C35 into hv ; <= NOT DEBUGGED YET 
;; flatList=mkFlipList("CORELIB__C35" "CORELIB")
;; flatList=append(flatList mkFlipList("CORELIB__C35_3B" "CORELIB_HV"))

; ________________________________________________________________________________________________________________________________________________________________
; cv = geGetWindowCellView()
flip='()
flip=append(flip flatList)
;; flip='(("INV0" "INVERT_A")("INV1" "INVERT_B")("INV2" "INVERT_C")("INV3" "INVERT_D")("INV4" "INVERT_E")("INV6" "INVERT_F")("INV8" "INVERT_H")("INV10" "INVERT_I")("INV12" "INVERT_J")("INV15" "INVERT_K"))
;; flip=append(flip '(("NOR20" "NOR2_A")("NOR21" "NOR2_B")("NOR22" "NOR2_C")("NOR23" "NOR2_D")("NOR24" "NOR2_E")("NOR26" "NOR2_F")("NOR28" "NOR2_H")) )
;; flip=append(flip '(("BUF2" "BUFFER_C")("BUF4" "BUFFER_D")("BUF6" "BUFFER_E")("BUF8" "BUFFER_F")("BUF12" "BUFFER_H")("BUF15" "BUFFER_I")) )
;; flip=append(flip '(("NAND20" "NAND2_A")("NAND21" "NAND2_B")("NAND22" "NAND2_C")("NAND23" "NAND2_D")("NAND24" "NAND2_E")("NAND26" "NAND2_F")("NAND28" "NAND2_H")) )
;; flip=append(flip '(("DF1" "DFFR_E") ))
flip=append(flip '("subc" )) ;ts018_prim
flip=append(flip '(("cpoly" "cmim_hc" "ts018_prim"))) ;ts018_prim
flip=append(flip '(("cpolyc" "cm53t" "ts018_prim" (("flipPin" (("PLUS" "PLUS")("MINUS" "MINUS")("SUB" "B")))))));;add magnitude flipProp to ignore it in new lib
;; flip=append(flip '(("cpoly" "cmim" "ts018_prim" (("flipPin" (("PLUS" "D")("MINUS" "S"))) ("flipProp" (("m" "m" "int" 'atoi))))  ) ));;add magnitude flipProp to ignore it in new lib
flip=append(flip '(("rpoly2" "rplpoly2t")("rpoly2c" "rplpoly3t")("rpolyh" "rphpoly2t")("rpolyhc" "rphpoly3t") ))
flip=append(flip '(("nmos4" "nfetx"  "ts018_prim" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf" "int" 'atoi))))))); I think atoi not necessary anymore, 
flip=append(flip '(("pmos4" "pfetx"  "ts018_prim" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf" "int" 'atoi))))))); prefer postprocess strapPropLib
; warning prop-value nf=12 ng="12" => evalstring if string : apply('evalstring list("4"))

dftNewLib="ts018_prim" concFlip='()
foreach(fp flip 
when(!listp(fp) fp=list(fp))
when(length(fp)==1 fp=append(fp fp))
when(length(fp)==2 fp=append(fp list(dftNewLib)))
when(length(fp)>4 printf("For now AST of 4 max not %d %L\n" length(fp) fp))
concFlip=tconc(concFlip fp)
) flip=car(concFlip)

;; append options for pins correspondences ie. 'rpolyhc' terminals are : MINUS, PLUS REF, where 'oprppres' terminals are S, D and G.
;; flip=foreach(mapcar fp flip if(and(length(fp)==3 or(cadr(fp)=="oprppres" cadr(fp)=="oprrpres"))
;; then fp=append(fp '((("flipPin" (("MINUS" "S")("PLUS" "D")))))) else fp))

flip=foreach(mapcar fp flip if(and(length(fp)==3 rexMatchp("poly3t" cadr(fp)))
then fp=append(fp '((("sideWays") ("flipPin" (("MINUS" "MINUS")("PLUS" "PLUS")("REF" "B")))))) else fp))

;; flip=foreach(mapcar fp flip if(and(length(fp)>=3 or(cadr(fp)=="oprppres" cadr(fp)=="oprrpres" cadr(fp)=="oprppresx" cadr(fp)=="oprrpresx"))
;; then list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0 0.1875) )))) else fp))

;; flip=foreach(mapcar fp flip if(and(or(car(fp)=="nmos4" car(fp)=="pmos4") length(fp)>=3) then 
;; list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0625 0.0) )))) else fp))

;; flip=foreach(mapcar fp flip if(and(or( rexMatchp("cmim" cadr(fp)) ) length(fp)>=3) then ; very little adjustement to try to center the offset between the two symbols
;; list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" ( 0.0 -0.0625) )))) else fp))

;; ;; for DIGITAL cells, PRIMLIB output is named Q but cmos8rf output is named Z  ;
;; flip=foreach(mapcar fp flip 
;; if(caddr(fp)=="cmos8rf"&&length(fp)>=3 then fp=append(fp '((("flipPin" (("Q" "Z")))))) else fp))




;; fp='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) (("adjust" '(0.0625 0.0))))
;; cv=geGetWindowCellView() 
;; cv~>??

;; bList=nil  
;; OUT=remove(nil  foreach(mapcar f cv~>instances~>cellName ;printf("f:%L\n" f)  
;; unless(member(f bList ) 
;; printf("%L %L %L \n" f bList assoc(f flip ))
;; bList=append(bList list(f)) assoc(f flip ))))
;; bList
;; assoc("cpoly" flip )
