;; load "~/Skill/mos2fet.il"    , load "~/Skill/h18_to_130.il"

;; load("flipTo_cmhv7sf.il") ;<= defines flipList

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

;; car(setof(lib ddGetLibList() lib~>name=="cmhv7sf"))
;; car(setof(lib ddGetLibList() lib~>name=="cmhv7sf"))~>cells~>name
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



;; println toSort
;; toSort='("XOR4XL" "XOR4X8" "XOR4X6" "XOR4X4" "XOR4X3" "XOR4X2" "XOR4X1" "XOR3XL" "XOR3X8" "XOR3X6" "XOR3X4" "XOR3X3" "XOR3X2" "XOR3X1" "XOR2XL" "XOR2X8" "XOR2X6" "XOR2X4" "XOR2X3" "XOR2X2" "XOR2X1" "XNOR4XL" "XNOR4X8" "XNOR4X6" "XNOR4X4" "XNOR4X3" "XNOR4X2" "XNOR4X1" "XNOR3X8" "XNOR3X6" "XNOR3X4" "XNOR3X3" "XNOR3X2" "XNOR3X1" "XNOR2X8" "XNOR2X6" "XNOR2X4" "XNOR2X3" "XNOR2X2" "XNOR2X1" "TIE1" "TIE0" "OR3X8" "OR3X6" "OR3X4" "OR3X3" "OR3X2" "OR3X1" "OR2X8" "OR2X6" "OR2X4" "OR2X3" "OR2X2" "OR2X1" "OAI32X8" "OAI32X6" "OAI32X4" "OAI32X3" "OAI32X2" "OAI32X1" "OAI31X8" "OAI31X6" "OAI31X4" "OAI31X3" "OAI31X2" "OAI31X1" "OAI311X8" "OAI311X6" "OAI311X4" "OAI311X3" "OAI311X2" "OAI311X1" "OAI22X8" "OAI22X6" "OAI22X4" "OAI22X3" "OAI22X2" "OAI22X1" "OAI221X8" "OAI221X6" "OAI221X4" "OAI221X3" "OAI221X2" "OAI221X1" "OAI21X8" "OAI21X6" "OAI21X4" "OAI21X3" "OAI21X2" "OAI21X1" "OAI211X8" "OAI211X6" "OAI211X4" "OAI211X3" "OAI211X2" "OAI211X1" "OA32X8" "OA32X6" "OA32X4" "OA32X3" "OA32X2" "OA32X1" "OA31X8" "OA31X6" "OA31X4" "OA31X3" "OA31X2" "OA31X1" "OA22X8" "OA22X6" "OA22X4" "OA22X3" "OA22X2" "OA22X1" "OA221X8" "OA221X6" "OA221X4" "OA221X3" "OA221X2" "OA221X1" "OA21X8" "OA21X6" "OA21X4" "OA21X3" "OA21X2" "OA21X1" "OA211X8" "OA211X6" "OA211X4" "OA211X3" "OA211X2" "OA211X1" "NOR4X8" "NOR4X6" "NOR4X4" "NOR4X3" "NOR4X2" "NOR4X1" "NOR3X8" "NOR3X6" "NOR3X4" "NOR3X3" "NOR3X2" "NOR3X12" "NOR3X1" "NOR2XL" "NOR2X8" "NOR2X6" "NOR2X4" "NOR2X3" "NOR2X2" "NOR2X12" "NOR2X1" "NAND4X8" "NAND4X6" "NAND4X4" "NAND4X3" "NAND4X2" "NAND4X1" "NAND3X8" "NAND3X6" "NAND3X4" "NAND3X3" "NAND3X2" "NAND3X12" "NAND3X1" "NAND2XL" "NAND2X8" "NAND2X6" "NAND2X4" "NAND2X3" "NAND2X2" "NAND2X12" "NAND2X1" "MUX4X8" "MUX4X6" "MUX4X4" "MUX4X3" "MUX4X2" "MUX4X1" "MUX3X8" "MUX3X6" "MUX3X4" "MUX3X3" "MUX3X2" "MUX3X1" "MUX2X8" "MUX2X6" "MUX2X4" "MUX2X3" "MUX2X2" "MUX2X1" "MAJ3X4" "MAJ3X3" "MAJ3X2" "MAJ3X1" "LNX6" "LNX4" "LNX3" "LNX2" "LNX1" "LNPX6" "LNPX4" "LNPX3" "LNPX2" "LNPX1" "LNCX6" "LNCX4" "LNCX3" "LNCX2" "LNCX1" "LNCPX6" "LNCPX4" "LNCPX3" "LNCPX2" "LNCPX1" "LHX6" "LHX4" "LHX3" "LHX2" "LHX1" "LHPX6" "LHPX4" "LHPX3" "LHPX2" "LHPX1" "LHCX6" "LHCX4" "LHCX3" "LHCX2" "LHCX1" "LHCPX6" "LHCPX4" "LHCPX3" "LHCPX2" "LHCPX1" "LGSPX1" "LGSNX1" "LGPX1" "LGNX1" "INVXL" "INVX8" "INVX6" "INVX4" "INVX32" "INVX3" "INVX24" "INVX2" "INVX16" "INVX12" "INVX1" "IMUX4X8" "IMUX4X6" "IMUX4X4" "IMUX4X3" "IMUX4X2" "IMUX4X1" "IMUX3X8" "IMUX3X6" "IMUX3X4" "IMUX3X3" "IMUX3X2" "IMUX3X1" "IMUX2XL" "IMUX2X8" "IMUX2X6" "IMUX2X4" "IMUX2X3" "IMUX2X2" "IMUX2X1" "IMAJ3X4" "IMAJ3X3" "IMAJ3X2" "IMAJ3X1" "HAX6" "HAX4" "HAX3" "HAX2" "HAX1" "FILLCELLX8" "FILLCELLX4" "FILLCELLX32" "FILLCELLX2" "FILLCELLX16" "FILLCELLX1" "FILLCAPX8" "FILLCAPX4" "FILLCAPX32" "FILLCAPX16" "FAX8" "FAX6" "FAX4" "FAX3" "FAX2" "FAX1" "DLY4X1" "DLY3X1" "DLY2X1" "DLY1X1" "DFXL" "DFX6" "DFX4" "DFX3" "DFX2" "DFX1" "DFSX6" "DFSX4" "DFSX3" "DFSX2" "DFSX1" "DFPX6" "DFPX4" "DFPX3" "DFPX2" "DFPX1" "DFPSX6" "DFPSX4" "DFPSX3" "DFPSX2" "DFPSX1" "DFCX6" "DFCX4" "DFCX3" "DFCX2" "DFCX1" "DFCSX6" "DFCSX4" "DFCSX3" "DFCSX2" "DFCSX1" "DFCPX6" "DFCPX4" "DFCPX3" "DFCPX2" "DFCPX1" "DFCPSX6" "DFCPSX4" "DFCPSX3" "DFCPSX2" "DFCPSX1" "CLKINVX8" "CLKINVX6" "CLKINVX4" "CLKINVX32" "CLKINVX3" "CLKINVX24" "CLKINVX2" "CLKINVX16" "CLKINVX12" "CLKINVX10" "CLKINVX1" "CLKBUFX8" "CLKBUFX6" "CLKBUFX4" "CLKBUFX32" "CLKBUFX3" "CLKBUFX24" "CLKBUFX2" "CLKBUFX16" "CLKBUFX12" "CLKBUFX10" "BUSHDX1" "BUFX8" "BUFX6" "BUFX4" "BUFX32" "BUFX3" "BUFX24" "BUFX2" "BUFX16" "BUFX12" "BUFTX8" "BUFTX6" "BUFTX4" "BUFTX2" "BUFTX16" "BUFTX12" "BUFTX10" "BUFEX8" "BUFEX6" "BUFEX4" "BUFEX2" "BUFEX16" "BUFEX12" "BUFEX10" "AOI32X8" "AOI32X6" "AOI32X4" "AOI32X3" "AOI32X2" "AOI32X1" "AOI31X8" "AOI31X6" "AOI31X4" "AOI31X3" "AOI31X2" "AOI31X1" "AOI311X8" "AOI311X6" "AOI311X4" "AOI311X3" "AOI311X2" "AOI311X1" "AOI22X8" "AOI22X6" "AOI22X4" "AOI22X3" "AOI22X2" "AOI22X1" "AOI221X8" "AOI221X6" "AOI221X4" "AOI221X3" "AOI221X2" "AOI221X1" "AOI21X8" "AOI21X6" "AOI21X4" "AOI21X3" "AOI21X2" "AOI21X1" "AOI211X8" "AOI211X6" "AOI211X4" "AOI211X3" "AOI211X2" "AOI211X1" "AO32X8" "AO32X6" "AO32X4" "AO32X3" "AO32X2" "AO32X1" "AO31X8" "AO31X6" "AO31X4" "AO31X3" "AO31X2" "AO31X1" "AO22X8" "AO22X6" "AO22X4" "AO22X3" "AO22X2" "AO22X1" "AO221X8" "AO221X6" "AO221X4" "AO221X3" "AO221X2" "AO221X1" "AO21X8" "AO21X6" "AO21X4" "AO21X3" "AO21X2" "AO21X1" "AO211X8" "AO211X6" "AO211X4" "AO211X3" "AO211X2" "AO211X1" "ANTENNA" "AND3X8" "AND3X6" "AND3X4" "AND3X3" "AND3X2" "AND3X1" "AND2X8" "AND2X6" "AND2X4" "AND2X3" "AND2X2" "AND2X1")


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

defun( mkFlipList (lib1 lib2 @optional (coType '( "^INV" "NAND2" "NAND3" "NAND4" "NOR2" "NOR3" "NOR4" "^BUF" "DF" "^AO" "^MUX2" "^MUX3" "^MUX4" "^IMUX2" "^IMUX3" "^IMUX4")) (redoFile nil))
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
alphaNum(setof(c co35 rexMatchp(co c )) )
alphaNum(setof(c co18 rexMatchp(co c )) ) ))
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

;; when launching hv into C35
flatList=mkFlipList("CORELIB" "CORELIB_H18")
flatList=append(flatList mkFlipList("CORELIB_3B" "CORELIB_HV_H18"))

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
flip=append(flip '("subc" ))
flip=append(flip '(("cpoly" "cmim" "cmhv7sf" (("flipPin" (("PLUS" "D")("MINUS" "S")))))));;add magnitude flipProp to ignore it in new lib
;; flip=append(flip '(("cpoly" "cmim" "cmhv7sf" (("flipPin" (("PLUS" "D")("MINUS" "S"))) ("flipProp" (("m" "m" "int" 'atoi))))  ) ));;add magnitude flipProp to ignore it in new lib
flip=append(flip '(("rpoly2" "oprppres")("rpoly2c" "oprppresx")("rpolyh" "oprrpres")("rpolyhc" "oprrpresx") ))
flip=append(flip '(("nmos4" "nfetx"  "cmhv7sf" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf" "int" 'atoi))))))); I think atoi not necessary anymore, 
flip=append(flip '(("pmos4" "pfetx"  "cmhv7sf" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf" "int" 'atoi))))))); prefer postprocess strapPropLib
; warning prop-value nf=12 ng="12" => evalstring if string : apply('evalstring list("4"))

dftNewLib="cmhv7sf" concFlip='()
foreach(fp flip 
when(!listp(fp) fp=list(fp))
when(length(fp)==1 fp=append(fp fp))
when(length(fp)==2 fp=append(fp list(dftNewLib)))
when(length(fp)>4 printf("For now AST of 4 max not %d %L\n" length(fp) fp))
concFlip=tconc(concFlip fp)
) flip=car(concFlip)

;; append options for pins correspondences ie. 'rpolyhc' terminals are : MINUS, PLUS REF, where 'oprppres' terminals are S, D and G.
flip=foreach(mapcar fp flip if(and(length(fp)==3 or(cadr(fp)=="oprppres" cadr(fp)=="oprrpres"))
then fp=append(fp '((("flipPin" (("MINUS" "S")("PLUS" "D")))))) else fp))
flip=foreach(mapcar fp flip if(and(length(fp)==3 or(cadr(fp)=="oprppresx" cadr(fp)=="oprrpresx"))
then fp=append(fp '((("sideWays") ("flipPin" (("MINUS" "S")("PLUS" "D")("REF" "G")))))) else fp))

flip=foreach(mapcar fp flip if(and(length(fp)>=3 or(cadr(fp)=="oprppres" cadr(fp)=="oprrpres" cadr(fp)=="oprppresx" cadr(fp)=="oprrpresx"))
then list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0 0.1875) )))) else fp))

flip=foreach(mapcar fp flip if(and(or(car(fp)=="nmos4" car(fp)=="pmos4") length(fp)>=3) then 
list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0625 0.0) )))) else fp))

flip=foreach(mapcar fp flip if(and(or( rexMatchp("cmim" cadr(fp)) ) length(fp)>=3) then ; very little adjustement to try to center the offset between the two symbols
list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" ( 0.0 -0.0625) )))) else fp))

;; ;; for DIGITAL cells, PRIMLIB output is named Q but cmos8rf output is named Z  ;not true for cmhv7sf
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
