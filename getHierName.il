;; copyleft ebecheto

;; getHierRootName will be more relevant for this function
defun(getHierName (@optional (idWin hiGetCurrentWindow())(sep "."))
let((hierInstName i)
when(idWin==t idWin=hiGetCurrentWindow())
    hierInstName=""
    when( geGetHierMemInst(idWin)
	i=0
        printf("Hierarchical Scope is :%s\n " caar(geGetHierMemInst(idWin))~>cellView~>cellName)
	printf("depth is :%d\n" length(geGetHierMemInst(idWin)))
        foreach(mapcar hierNb geGetHierMemInst(idWin)
	        hierInstName=strcat(hierInstName car(hierNb)~>baseName)
        	printf("%L\n" hierNb)
        	printf("Level %d %L~>baseName:%L\n" i car(hierNb) list(hierInstName car(hierNb)~>baseName))
        	when((cadr(hierNb)!=0) hierInstName=sprintf(nil "%s<%d>" hierInstName cadr(hierNb)))
     		hierInstName=strcat( hierInstName sep)
        i++ 
    );end foreach
);when hierarchy
hierInstName
))
;; does not work with MN32<0:4> ??! should be corrected

printf("ie.\nstrcat(\"/\" getHierName(t \"/\") css()~>baseName)" )

;; strcat(getHierName() css()~>baseName)
;; strcat(getHierName() x~>baseName)
;; strcat("" "MN0") ;;ou bien
;; strcat("" css()~>baseName) ;;ou bien
;; strcat("I1.I3." "MN0");;ou bien
;; strcat("I1<3>.I3." "MN0")

;; load("~/Skill/regionSat.il.proc.il")