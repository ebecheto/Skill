;; copyleft ebecheto

;; TODO : replace pv(" with pv("/
;;        replace . with /   
;; => plot(pv("/I57/I72/I3<0>/I55/I0/MN4" "id" ?result "noise-noise"))
;; instead of  "I57.I72.I3<0>.I55.I0.MN4" "id" ?result "noise-noise"

;; pv("I1.MP16" "total" ?result "tran_noise-tran_noise") ;=> paramVal 2 si deux actimes  sst2

;ineed('noise2pv t)
;;ie : noise2pv("summaryNoise.txt")
procedure( noise2pv( @optional (file "summaryNoise.txt") (verb t) )
let( (fp fo fs noiseSim rmSlash aList inst)
printf("noise2pv(\"%s\")... processing\n" file)

; file="summaryNoise.txt"
fp=infile(sprintf(nil "%s/%s" pwd() file))
fo=outfile(sprintf(nil "%s/%s.pv.il" pwd() file))
fs=outfile(sprintf(nil "%s/%s.sqrtIinteg.il" pwd() file))
fs2=outfile(sprintf(nil "%s/%s.carre.il" pwd() file))

; while(fscanf( fp "%/" slash)    print(slash)     )
while(gets(nextLine fp) when(verb printf("line: %s" nextLine))
cond(
(rexMatchp(" .*-noise" nextLine)
rexCompile(" .*-noise")
rexExecute(nextLine) 
noiseSim=rexSubstitute( "\\0") 
when(noiseSim rexCompile(" ") noiseSim=rexReplace(noiseSim "" 1))
fprintf(fo ";; %s" nextLine)
fprintf(fs ";; %s" nextLine)
);cond1
(rexMatchp("^/" nextLine) rexCompile( "^/") rmSlash=rexReplace(nextLine "" 1) aList=simStringsToList(rmSlash)
when(verb printf("aList:_%L_\n" aList))
rexCompile("/") inst=rexReplace(car(aList) "." 0)
fprintf(fo "plot(pv(%L %L ?result %L))\n" inst cadr(aList) noiseSim )
fprintf(fs "plot(sqrt(iinteg(pv(%L %L ?result %L)**2)))\n" inst cadr(aList) noiseSim )
fprintf(fs2 "plot(pv(%L %L ?result %L)**2)\n" inst cadr(aList) noiseSim )
);cond2
(t 
fprintf(fo ";; %s" nextLine)
fprintf(fs ";; %s" nextLine)
fprintf(fs2 ";; %s" nextLine)
);cond default
);end cond
);end while

close(fp) close(fo) close(fs) close(fs2)
;; fo=infile(sprintf(nil "%s/%s.pv.il" pwd() file))
;; while(gets(nextLine fo) printf("%s\n" nextLine )) ;; <== lit tout le fichier et l'affiche dans icfb
;; close(fo)
printf("edit%L\n" list(sprintf(nil "%s/%s.pv.il" pwd() file)))
printf("edit%L\n" list(sprintf(nil "%s/%s.sqrtIinteg.il" pwd() file)))
;; gets(nextLine fp) nextLine

))
