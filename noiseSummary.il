;; copyleft ebecheto
;; A noise simulation is supposed to have been run
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
load("noise2pv.il")
procedure( noiseSummary_call( @optional (file nil ) )
let( (pfile param2 paramNoiseList oldDir)
; rexCompile("/psf") oldDir=rexReplace(resultsDir() "" 0) ; ? simulator('spectre)
; when(length(parseString(openResults() "/psf"))>=2 ...)
caseq( file  (nil pfile = poport)  (t   pfile = file) )
; paramList2 = rexMatchList(".*noise"  ls(strcat( openResults(hiGetCurrentWindow()~>artistSimulationDataDir) "/" "psf" )))
paramList2 = rexMatchList(".*noise"  ls(strcat( openResults() "/" "psf" )))

rexCompile("\\.noise")
paramNoiseList=mapcar('lambda( (x) rexReplace( x "-noise" 1 ) ) paramList2 ); remarque ; mapcar(lambda equivaut a foreach(mapcar ....  ))

foreach(param2 paramNoiseList
fprintf(pfile "\t\t[** %s : %s **]\n",param2 getCurrentTime())
noiseSummary( 'integrated ?result param2 ?noiseUnit "V" ?truncateType 'byNumber ?truncateData 60 ?output pfile)
;;noiseSummary( 'integrated ?result param2 ?noiseUnit "V" ?truncateType 'byNumber ?truncateData 10 ?output pfile)
;; println(openResults())
;; WARNING, some troubles might append if the file name.noise exist but its simulation is not valid anymore.
;; in this case, cadence function : noiseSummary Errors but does not get out of directory psf. so do : ADE ->Results->Select-> <RET>
;; or do : openResults(strcat( openResults() "/../" ))   ;"not recommended"
))
); end procedure "noiseSummary_call"

;;;                                     nil is the default argument of file

procedure( noiseResult( @optional (file nil ) )
let( (resultDir pfile pf param paramList )

;; traitement de l'argument optionel
caseq( file (nil pfile = poport)
 (t   pfile = outfile(sprintf(nil "%s/%s" pwd() file)))
 );;  (t   pfile = outfile(file));;<== PB with skillPath IC6 (worked with 5141)

;; does not work if anyone had created a directory  named *=* also
if( paramList=rexMatchList(".*=.*"  ls(openResults())) then 
resultDir = openResults()
foreach(param paramList ;; loop on every parametric directory
openResults(strcat(resultDir "/" param))
fprintf(pfile "\t[************ %s ************]\n",param)
noiseSummary_call( pfile )
); end foreach
else ;; not a parametric simulation
noiseSummary_call( pfile )
); end if

; println(openResults())
close(pfile)

;; Changed back the old directory to ../psf
openResults(hiGetCurrentWindow()~>artistSimulationDataDir)
when(file noise2pv(file))
)); end procedure "noiseResult"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
