;; copyleft ebecheto
;load("lib2csv.il")
;; _______________study a new library : lib2csv
;; create a lib : ANALOG_TUT for parameter instanciation viewing
defun( lib2csv (@optional (libName "ts018_prim") (row t) (verb t)) let((masterList file pf cv inst cdfgData srow)
ddLibName=car(setof(lib ddGetLibList() lib~>name==libName))
if(row srow="_row" srow="")
cv=dbOpenCellViewByType( "ANALOG_TUT" "tmp" "schematic" "schematic" "w")
masterList=ddLibName~>cells
file=strcat( pwd() "/" libName srow ".csv")
pf=outfile(file)  ; desactive la non creation du fichier, ce n est pas si long que ca.
when(verb printf("Treating %d-cells" length(masterList)))
foreach(cell masterList
when(member("symbol" dbAllCellViews(ddLibName cell~>name))  mast=dbOpenCellViewByType(libName cell~>name "symbol")
fprintf(pf "%s;%L;" cell~>name mast~>terminals~>name)
inst=(dbCreateInst cv mast nil 0:0 "R0")
cdfgData=(cdfGetInstCDF inst)
foreach(par cdfgData~>parameters
fprintf(pf "%s;%s;%L;%s;%L;" par~>name par~>prompt par~>value par~>paramType par~>defValue)
when(row fprintf(pf "\n"))
);end loop properties
fprintf(pf "\n")
printf("%s||%L\n" cell~>name mast~>??)
))
close(pf) sprintf(cmd  "cp %s ~/groupU/RunT2K/." file)
system(cmd)
edit(eval(file))
)) ; lib2csv("tsl18fs120") lib2csv("ts018_prim") lib2csv("cmos8rf") lib2csv("cmrf8sf") lib2csv("CORELIB")
printf("lib2csv(%L)\n" "CORELIB")
printf("lib2csv(%L t nil)   ;=> non verbeux\n" "CORELIB")
printf("lib2csv(%L nil nil) ;=> sur une seul ligne, non verbeux\n" "PRIMLIB")
