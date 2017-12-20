; gplinFit(ymax(ENC_PA3))

defun(gplinFit (wave) let((dname fp fo i out fname daname nextLine)
dname=sprintf(nil "%s/%s" pwd() "data.dat")
; ocnPrint(ENC_PA3 ?output dname ?format "engineering")
ocnPrint(wave ?output dname ?format "engineering")

fp=infile(dname)
fo=outfile(daname=strcat(dname "a")) ;==> "data.data"
i=0
while(gets(nextLine fp) 
when(i<=2 fprintf(fo "# "))
fprintf(fo nextLine)
i++)
close(fo)

out = outfile(fname=sprintf(nil "%s/%s" pwd() "gplinFit.gp"))
fprintf(out "f(x) = a*x + b\n")
fprintf(out "a=%g\n" average(deriv(wave)))
fprintf(out "b=%g\n" value(wave 0))
fprintf(out "fit f(x) '%s' u 1:2  via a, b\n" daname)
fprintf(out "plot '%s', f(x)\n" daname)
fprintf(out "set ytics format '%s.1s%sc'\n" "%" "%" )
fprintf(out "set xtics format '%s.1s%sc'\n" "%" "%" )
fprintf(out "set title titre=sprintf('lin fit f(x)=%s.2g*x+%s.2f', a, b)\n" "%" "%")
fprintf(out "replot\n" daname)
fprintf(out "pr titre\n" daname)
fprintf(out "pause(1)\n" daname)
close(out)

(system sprintf(nil "gnuplot %s --persist - " fname))
))

printf("gplinFit(ymax(ENC_PA3))")
