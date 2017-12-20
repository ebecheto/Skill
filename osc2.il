; loaded from prepTier3.il
; load("osc2.il")
; bug counter @909ps => simuler a part.
; quand 1 seul enable, freqDiff=2.3521p Fslow=

rdir="/home/validmgr/ebecheto/Work/h18/Sim/osc_matrix_simN/spectre/schematic"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf0"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf1"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf2"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf3"
;; rdir="/group/validmgr/Sim/osc_matrix_sim/UltraSim/schematic/netlist/../psf4"

when(oo=openResults() rdir=oo)

;; simulator('UltraSim)
;; when(rdir resultsDir(openResults(rdir)))

logFile=sprintf(nil "%s/osc2.log" pwd())
system(sprintf(nil "echo -n -e _________ >> %s; date >>%s" logFile logFile)) 

pf = outfile(logFile "a")
; UltraSim results();=> (variables tran); et non tran-tran 
;! => utiliser plutot VT

; frequency(v("/slow" ?resultsDir rdir ?result "tran"))

per_fast = average(deriv(cross(v("/fast" ?result "tran-tran") 0.9 1 "rising" t "cycle")))
per_slow = average(deriv(cross(v("/slow" ?result "tran-tran") 0.9 1 "rising" t "cycle")))
per_diff=per_slow-per_fast


Fslow=frequency(v("/slow" ?resultsDir rdir ?result "tran-tran"))
Ffast=frequency(v("/fast"  ?resultsDir rdir ?result "tran-tran"))
freqDiff = ((1 / frequency(v("/fast"  ?resultsDir rdir ?result "tran-tran"))) - (1 / frequency(v("/slow"  ?resultsDir rdir ?result "tran-tran"))))
;; fprintf(pf "Fslow=%s\nFfast=%s\nfreqDiff=%s\n" aelSuffixNotation(Fslow) aelSuffixNotation(Ffast) aelSuffixNotation(freqDiff))

for(i 1 4 fprintf(pf "FDC_%d=%3g " i VAR(sprintf(nil "FDC_%d" i)) ))
fprintf(pf "\n")
for(i 1 4 fprintf(pf "SDC_%d=%3g " i VAR(sprintf(nil "SDC_%d" i)) ))
fprintf(pf "\n")

fprintf(pf "Fslow=%s\t(%g)\nFfast=%s\t(%g)\nfreqDiff=%s\t(%g)\nper_fast=%s\t(%g)\nper_slow=%s\t(%g)\nper_diff=%s\t(%g)\n" 
aelSuffixNotation(Fslow) Fslow
aelSuffixNotation(Ffast) Ffast
aelSuffixNotation(freqDiff) freqDiff
aelSuffixNotation(per_fast) per_fast
aelSuffixNotation(per_slow) per_slow
aelSuffixNotation(per_diff) per_diff
)

close(pf)
pf=nil

printf("CHECK LOG FILE : %s\n" logFile)
printf("edit(%L)\n" logFile)



1.0/frequency(clip(VT("/Z<0>") 2u 2.5u));=>2.764348e-09
1.0/frequency(clip(VT("/Z<1>") 2u 2.5u));=>2.764349e-09
1.0/frequency(clip(VT("/Z<2>") 2u 2.5u));=>2.764951e-09
1.0/frequency(clip(VT("/Z<3>") 2u 2.5u));=>2.764949e-09
1.0/frequency(clip(VT("/Z<4>") 2u 2.5u));=>2.764948e-09


