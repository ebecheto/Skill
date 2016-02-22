;; copyleft ebecheto

; load("mkFlipList.il")
unless(fboundp('sort123) load("sort123.il"))

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
; 
; mkFlipList("cmos8rf" "CORELIB" '( "^INV" "^NAND2" "^NAND3" "^NAND4" "^AND2" "^AND3" "^AND4" "^NOR2" "^NOR3" "^NOR4" "^XNOR2" "^XNOR3" "^XNOR4" "^BUF" "^DF" "^AO" "^MUX2" "^MUX3" "^MUX4" "^IMUX2" "^IMUX3" "^IMUX4"))

defun( mkFlipList2 (lib1 lib2 @optional (coType '(("^AND2_" "an02")("^AND3_" "an03")("^AND4_" "an04") ("^INVERT_" "^inv0") ("^MUX21_" "^mx02"))) (redoFile t) (verb nil))
(let (std_tower std_OLD un de fullList compList compare flatList)
std_tower=sort123(car(setof(lib ddGetLibList() lib~>name==lib2)~>cells~>name) )
std_OLD=sort123(car(setof(lib ddGetLibList() lib~>name==lib1)~>cells~>name) )
when(verb printf("%d-oldStd to %d-oldStd\n " length(std_OLD) length(std_tower)))
compare=foreach(mapcar co coType 
list( ;compare devient une liste de paires trié avec ( (anciens nouveaux) ...())
; printf("OLD-%s:%L\n" cadr(co) alphaNum(foreach(mapcan c std_OLD   when(rexMatchp(car(co) c) list(c) )) ))
; printf("NEW-%s:%L\n" car(co) alphaNum(foreach(mapcan c std_tower when(rexMatchp(cadr(co)  c) list(c) )) ))
alphaNum(foreach(mapcan c std_OLD   when(rexMatchp(car(co) c) list(c)   )) )
alphaNum(foreach(mapcan c std_tower when(rexMatchp(cadr(co)  c) list(c) )) )))
when(verb printf("COMPARE:%L\n" compare))
fullList=foreach(mapcar comp compare 
when(verb printf("COMP:%L\n" comp))
compList='()
for(i 0 
max(length(car(comp)) length(cadr(comp)))-1; convertion c35 to 180nm donc pas besoin de plus d'element que c35.
; length(car(comp))-1
un=nth(i car(comp) )||un
de=nth(i cadr(comp))||de
compList=append(compList list(list(un de lib2)))
) compList)
when(verb printf("fullList:%L\n" fullList))
flatList=foreach(mapcan co fullList co); 141 element, enougth for now
; remark : pas de mux 3 en ams, mux 8 en tower....
; member("mx0" std_tower);=>nil
;; foreach(mapcan s std_tower when(rexMatchp("^mx0" s) list(s)))
;; foreach(mapcan s std_OLD when(rexMatchp("^MUX" s) list(s)))
)) 
;  mkFlipList2("cmos8rf" "tsl18fs120")
;               OLD        NEW


;; equiv='(("^AND2_" "an02")("^AND3_" "an03")("^AND4_" "an04")("^INVERT_" "^inv0")("^MUX21_" "^mx02")("^MUX41_" "^mx04")("^NAND2_" "^nd02")("^NAND3_" "^nd03")("^NAND4_" "^nd04"))
;; equiv=append(equiv '(("^NOR2_" "nr02")("^XNOR2_" "xn02")))

;; equiv='( ("^INVERT_" "^INV") ("^NAND2_" "^NAND2" ) ("^NAND3_" "^NAND3" ) ("^NAND4_" "^NAND4" ) ("^AND2_" "^AND2" ) ("^AND3_" "^AND3" ) ("^AND4_" "^AND4" ) ("^NOR2_" "^NOR2" ) ("^NOR3_" "^NOR3" ) ("^NOR4_" "^NOR4" )  ("^BUF" "^BUFFER_") ("^DF" "^DF" ) ("^AO" "^AO") ("^MUX21_" "^MUX2") ("^MUX31_" "^MUX3") ("^MUX41_" "^MUX4") ("^IMUX2" "^IMUX2") ("^IMUX3" "^IMUX3") ("^IMUX4" "^IMUX4"))
;; mkFlipList2("cmos8rf" "CORELIB" equiv) ; IBM130->AMS_C35
;; mkFlipList2("CORELIB" "cmos8rf" foreach(mapcar equ equiv reverse(equ)))  ; AMS_C35->IBM130



