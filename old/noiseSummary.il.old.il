;; A noise simulation is supposed to have been run
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

procedure( noiseSummary_call( @optional (file nil ) )
let( (pfile param2 paramNoiseList)

;; traitement de l'argument optionel
caseq( file  (nil pfile = poport)  (t   pfile = file) )
;; pfile is a pointer file opened by the function that call this procedure

;; create a variable that contains all the "Something...noise" directories of the current ADE working directory
; paramList2 = rexMatchList(".*noise"  ls(strcat( openResults(hiGetCurrentWindow()~>artistSimulationDataDir) "/" "psf" )))
paramList2 = rexMatchList(".*noise"  ls(strcat( openResults() "/" "psf" )))

rexCompile("\\.noise")
paramNoiseList=mapcar('lambda( (x) rexReplace( x "-noise" 1 ) ) paramList2 );
;; combining rexCompile and rexReplace will substitute name.noise in name-noise, mapcar&lambda just apply it to all element of the list ;;
;; remarque ; mapcar(lambda equivaut a foreach(mapcar ....  ))

foreach(param2 paramNoiseList
fprintf(pfile "\t\t[** %s **]\n",param2)
noiseSummary( 'integrated ?result param2 ?noiseUnit "V" ?truncateType 'byNumber ?truncateData 30 ?output pfile)
;;noiseSummary( 'integrated ?result param2 ?noiseUnit "V" ?truncateType 'absolute ?truncateData 0.1 ?output pfile)
;;noiseSummary( 'integrated ?result param2 ?noiseUnit "V" ?truncateType 'relative ?truncateData 0.1 ?output pfile)
;;noiseSummary( 'integrated ?result param2 ?noiseUnit "V" ?truncateType 'byNumber ?truncateData 10 ?output pfile)
;; println(openResults())
;; WARNING, some troubles might append if the file name.noise exist but its simulation is not valid anymore.
;; in this case, cadence function : noiseSummary Errors but does not get out of directory psf. so do : ADE ->Results->Select-> <RET>
;; or do : openResults(strcat( openResults() "/../" ))   ;"not recommended"

); fin du foreach

); fin du let
); end procedure "noiseSummary_call"


;;;                                     nil is the default argument of file
procedure( noiseResult( @optional (file nil ) )
let( (resultDir pfile param paramList paramDir)

;; traitement de l'argument optionel
caseq( file 
 (nil pfile = poport)
;;  (t   pfile = outfile(file));;<== PB with skillPath IC6 (work with 5141)
 (t   pfile = outfile(sprintf(nil "%s/%s" pwd() file)))
 )

;; (if rexMatchp("psf$" openResults()) then )

;; does not work if anyone had created a directory  named *=* also
if( paramList=rexMatchList(".*=.*"  ls(openResults())) then 
;; loop on every parametric directory
resultDir = openResults()
foreach(param paramList
openResults(strcat(resultDir "/" param))
fprintf(pfile "\t[************ %s ************]\n",param)
noiseSummary_call( pfile )
); end foreach

else ;; not a parametric simulation

;; call to the noise summary function in the current directory
noiseSummary_call( pfile )
); end if

; println(openResults())
close(pfile)

;; Changed back the old directory to ../psf
openResults(hiGetCurrentWindow()~>artistSimulationDataDir)
;; openResults(resultDir)
); end let
); end procedure "noiseResult"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
