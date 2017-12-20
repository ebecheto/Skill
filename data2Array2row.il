; load("data2Array2row.il")
defun( array2row (@optional (file "data_ymaxENC_PA6.txt") (pwd pwd()))
myPort=infile(sprintf(nil "%s/%s" pwd file));read a first time for size colum
OUT=outfile(sprintf(nil "%s/file_OUT.gp" pwd))
a=0 file_s=nil XYZ=nil yList=nil XL=nil head=nil
while(gets(nextLine myPort) 
lineList=remove("\n" simStringsToList(nextLine))
when(member("#" lineList) a=a+1 printf("%2d _ Get # in : %L\n" a lineList)) unless(XL XL=nth(1 lineList) ZL=nth(2 lineList))
when(member("=" lineList) param=car(last(lineList)) printf("NEWFILE %L\n" param||"noLabel")
when(file_s ;purge cas precedent
foreach(el XYZ fprintf(oFile "%s\n" buildString(el "\t"))); fprintf(oFile "\n")
XYZ=nil
close(oFile))
file_s=sprintf(nil "%s/file_3d_%s_%s" pwd nth(1 lineList) param) 
oFile=outfile(file_s) fprintf(oFile "# X\tY\tZ\n")
if(yList=remove("\n" remove("#" simStringsToList(gets(nextLine myPort)))) then printf("CLIST=%L\n" yList) 
else printf("No line after # .. = .. ?\n")
)
unless(head fprintf(OUT "set grid\nset xlabel '%s';set ylabel '%s';set zlabel '%s' offset 4,4;\nsplot " XL car(yList) ZL) head=t)
fprintf(OUT "\"%s\" with lines,\\\n" file_s)
lineList=remove("\n" simStringsToList(gets(nextLine myPort)))
); fin du = <=> header X
when(yList ;deux header passe
printf("line:%L\n" lineList)
X=car(lineList)
xi=0 foreach(Z cdr(lineList) xi++
Y=nth(xi yList)
XYZ=append(XYZ list(list(X Y Z)))
); foreach z
XYZ=append(XYZ list(list("")));<= add an empty line
)
); while
;purge cas precedent
foreach(el XYZ fprintf(oFile "%s\n" buildString(el "\t")))
close(oFile)
fprintf(OUT "\n\nset contour; replot\npause -1 'pressRet'\nset cntrparam levels auto 30; replot\npause -1 'pressReturn'\nunset contour;set view 90,90;replot;\npause -1 'Y axis'\nset view 90,0;replot;\npause -1 'X axis'\n" )
close(OUT)
;edit(strcat(pwd "file_OUT.gp"))
)
; METTRE UN ESPACE A CHAQUE FIN DE LIGNE POUR EVITER QUE LE \n SOIT COLLE AU DERNIER CHIFFRE

array2row()

buildString(car(XYZ) "\t")