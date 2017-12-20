;; load "~/Skill/mos2fet.il"    , load "~/Skill/h18_to_130.il"

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



defun( alphaNum (aa) let((sa csa tsa) sa=list(car(aa)) csa=cdr(aa)
foreach( a csa tsa='() csa=sa
(when alphaNumCmp(a car(csa))<0  sa=append(list(a) csa) csa='())
while( csa&&alphaNumCmp(a car(csa))>=0
tsa=append(tsa list(car(csa))) csa=cdr(csa))
sa=append(append(tsa list(a)) csa)
) sa))



file=strcat(pwd() "/coreList.txt")

if(myPort=infile(file) then 
myPort = infile(file)  gets(f myPort) close(myPort)
rexCompile("^(") f=rexReplace(f "" 1)
rexCompile(")$") f=rexReplace(f "" 1)
rexCompile("\" \"") f=rexReplace(f "\"\"" 0)
rexCompile("\"") f=rexReplace(f "" 0)
fl=parseString( f ") (")
flatList=foreach(mapcar x fl rexCompile("\"\"") x=rexReplace(x " " 0) rexCompile("\"") x=rexReplace(x "" 0) simStringsToList(x))

else
co35=alphaNum(car(setof(lib ddGetLibList() lib~>name=="CORELIB"))~>cells~>name )     ;=> 
co18=alphaNum(car(setof(lib ddGetLibList() lib~>name=="CORELIB_H18"))~>cells~>name ) ;=> 476 pfff....
coType='( "^INV" "NAND2" "NAND3" "NAND4" "NOR2" "NOR3" "NOR4" "^BUF" "DF" "^AO" "^MUX2" "^MUX3" "^MUX4" "^IMUX2" "^IMUX3" "^IMUX4")
coType=append(coType list("^CLKBU" "^CLKIN")) 
alphaNum(setof(c co35 rexMatchp("NAND4" c )))
;; vaut mieux matcher NAND3 NAND4 ...
;  and sort PB : alphalessp notgood enough => defun( alphaNum ...)
compare=foreach(mapcar co coType list(
alphaNum(setof(c co35 rexMatchp(co c )) )
alphaNum(setof(c co18 rexMatchp(co c )) ) ))

;; ; setof(c co35 rexMatchp("AND" c ))
;; inv=car(compare) invList='()
;; for(i 1 
;; max(length(car(inv)) length(cadr(inv)))
;; un=nth(i car(inv) )||un
;; de=nth(i cadr(inv))||de
;; invList=append(invList list(list(un de)))
;; ) invList

fullList=foreach(mapcar comp compare
compList='()
for(i 0 
length(car(comp))-1
; max(length(car(comp)) length(cadr(comp)))-1; convertion c35 to 180nm donc pas besoin de plus d'element que c35.
un=nth(i car(comp) )||un
de=nth(i cadr(comp))||de
compList=append(compList list(list(un de "CORELIB_H18" )))
) compList)

flatList='() foreach(mapcar co fullList flatList=append(flatList co)); 141 element, enougth for now

myPort = outfile(file) 
fprintf(myPort "%L" flatList) ;<== pff !! cannot take an input list ! only %s %d %g with scanf ...
; foreach(mapcar f flatList fprintf(myPort "%L\n" f))
close(myPort)
)


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
flip=append(flip '(("cap" "cmimx" "cmhv7sf" (("flipPin" (("PLUS" "D")("MINUS" "S"))))  ) ))
flip=append(flip '(("rpoly2" "oprppres")("rpoly2c" "oprppresx")("rpolyh" "oprrpres")("rpolyhc" "oprrpresx") ))
flip=append(flip '(("nmos4" "nfetx"  "cmhv7sf" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf")))))))
flip=append(flip '(("pmos4" "pfetx"  "cmhv7sf" (("flipProp" (("w" "wf")("wtot" "wt")("ng" "nf")))))))
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

flip=foreach(mapcar fp flip if(and(length(fp)>=3 or(cadr(fp)=="oprppres" cadr(fp)=="oprrpres"))
then list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0 0.1875) )))) else fp))

flip=foreach(mapcar fp flip if(and(or(car(fp)=="nmos4" car(fp)=="pmos4") length(fp)>=3) then 
list(car(fp) cadr(fp) caddr(fp) append(cadddr(fp) '(("adjust" (0.0625 0.0) )))) else fp))

;; ;; for DIGITAL cells, PRIMLIB output is named Q but cmos8rf output is named Z  ;not true for cmhv7sf
;; flip=foreach(mapcar fp flip 
;; if(caddr(fp)=="cmos8rf"&&length(fp)>=3 then fp=append(fp '((("flipPin" (("Q" "Z")))))) else fp))




;; fp='("pmos4" "pfet" "cmrf8sf" (("flipProp" (("w" "wf") ("wtot" "wt") ("ng" "nf")))) (("adjust" '(0.0625 0.0))))
