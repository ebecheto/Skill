;; copyleft ebecheto

; gplinFit(ymax(ENC_PA3))
ineed('scaleStringLine)

defun(gplinFit (wave @optional (mult '(nil)) )
let((dname unit fp fo i avg scale nline outnextLine)
dname=sprintf(nil "%s/%s" pwd() "data.dat")
(setq cols '(1))
; ocnPrint(ENC_PA3 ?output dname ?format "engineering")
ocnPrint(wave ?output dname ?format "engineering")
unit=nil
fp=infile(dname)
fo=outfile(daname=strcat(dname "a")) ;==> "data.data"
i=0
avg=0
while(gets(nextLine fp)
printf(nextLine)
if(i<=2 then fprintf(fo strcat("# " nextLine)) printf("ligne %d" i)  else 
if(i==3 then printf("### Third LINE #### %d #" i)
scale=scaleStringLine(nextLine)
printf("scaleStringLine('%L)\n" nextLine)
nline=car(scale) sscale=cadr(scale)
fprintf(fo sprintf(nil "# %L\n" sscale))
fprintf(fo sprintf(nil "# %L\n" foreach(mapcar s sscale aelSuffixNotation(s||"0"))))
); end case i=3
towrite=car(scaleStringLine(nextLine sscale))
printf("[i=%d scale %L]" i sscale)
;printf( buildString(towrite " HOHO "))
fprintf(fo buildString(towrite "\t"))
)
i++
);end while
close(fo)

out = outfile(fname=sprintf(nil "%s/%s" pwd() "gplinFit.gp"))
fprintf(out "f(x) = a*x + b\n")
fprintf(out "a=%g\n" average(deriv(wave)))
fprintf(out "b=%g\n" value(wave 0))
fprintf(out "fit f(x) '%s' u 1:2  via a, b\n" daname)
fprintf(out "plot '%s', f(x)\n" daname)
fprintf(out "set ytics format '%s.1s%sc'\n" "%" "%" )
fprintf(out "set xtics format '%s.1s%sc'\n" "%" "%" )
fprintf(out "set title titre=sprintf('lin fit f(x)=%ss*x+%s.2f', gprintf('%s.1s%sc',a), b)\n" "%" "%" "%" "%")
fprintf(out "replot\n")
fprintf(out "pr titre, ' [%s]' \n" daname)
fprintf(out "pause(1)\n" daname)
close(out)

;(system sprintf(nil "gnuplot %s --persist - " fname))
printf("gnuplot %s --persist &" fname)
(system sprintf(nil "gnuplot %s --persist &" fname))
))

printf("gplinFit(ymax(ENC_PA3))")
printf("gplinFit(ymax(ENC_PA_1))")
