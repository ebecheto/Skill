;;load "abDumpWaveform.il"
/* abDumpWaveform.il

Author A.D.Beckett
Group Custom IC, Cadence Design Systems Ltd.
Machine SUN
Date Oct 23, 1997
Modified Jan 31, 2005
By A.D.Beckett

Functions for dumping a waveform to a file

Examples:

abDumpWaveform(VT("/c") "data_c.out")
abDumpWaveform(VT("/c") "data_c.out" "%e %e\n") ;; exponential format

abDumpWaveformSplit() is equivalent to abDumpWaveform, but splits
into files a little less than 2Gbytes (the split limit is an optional
argument).

;; sampled output.
;; note that linRg and logRg generate a range of values,
;; with args from, to, step.
abDumpSampledWaveform(VT("/c") linRg(0.01 0.05 0.005) "data_c.out")

;; multi-variable output
;; all waveforms must share same x-axis, as it doesn't do any interpolation (for
;; speed reasons). Interpolation could be done by collecting all the x-values, and
;; then using the value function.
abDumpWaveforms("data.out" VT("/c") VT("/z") VT("/a"))
abDumpWaveforms("data.out" VT("/c") VT("/z") VT("/a") ?format "%-10g" ?separator ",")

;; can also generate PSF now
abDumpWaveformsToBinPSF("rawdir" VT("/c") VT("/z"))

;; can also write out multiple files if presented with a family
abDumpFamily(VT("/c") "data.out")

************************************************** *

SCCS Info: @(#) abDumpWaveform.il 08/12/05.10:54:36 1.6

*/

/************************************************** ***************
* *
* (abDumpWaveform wave fileName @optional (format "%g %g\n")) *
* *
* Take a waveform object, write it out to the fileName specified *
* with the format given. No sampling is done. *
* *
************************************************** ***************/

(procedure (abDumpWaveform wave fileName @optional (format "%g %g\n"))
(let (port (xVec (drGetWaveformXVec wave))
(yVec (drGetWaveformYVec wave)))
(unless (setq port (outfile fileName))
(error "Could not write to file %s\n" fileName))
(for pos 0 (sub1 (drVectorLength xVec))
(fprintf port format
(drGetElem xVec pos)
(drGetElem yVec pos))
)
(close port)
))

/************************************************** ***************
* *
* (abDumpWaveformSplit wave fileName @optional *
* (format "%g %g\n") (split 2**31-512) ) *
* *
* Take a waveform object, write it out to the fileName specified *
* with the format given. No sampling is done. Splits into *
* multiple files when the number of bytes exceeds split *
* *
************************************************** ***************/

(procedure (abDumpWaveformSplit wave fileName @optional (format "%g %g\n") (split 2**31-512))
(let (port (xVec (drGetWaveformXVec wave))
(yVec (drGetWaveformYVec wave))
str (len 0) (suffix 0))
(unless (setq port (outfile fileName))
(error "Could not write to file %s\n" fileName))
(for pos 0 (sub1 (drVectorLength xVec))
(sprintf str format
(drGetElem xVec pos)
(drGetElem yVec pos))
(setq len (plus (strlen str) len))
(when (greaterp len split)
(close port)
(postincrement suffix)
(setq len (strlen str))
(unless (setq port (outfile (sprintf nil "%s_%d" fileName suffix)))
(error "Could not write to file %s_%d\n" fileName suffix))
)
(fprintf port "%s" str)
)
(close port)
))

/************************************************** ******************
* *
* (abDumpFamily family fileNamePrefix @optional (format "%g %g\n")) *
* *
* Write out a sequence of files for a family. Could potentially do *
* this automatically inside abDumpWaveform, but it's hard without *
* using private functions. *
* *
************************************************** ******************/

(procedure (abDumpFamily family fileNamePrefix @optional (format "%g %g\n"))
(let ((xVec (drGetWaveformXVec family))
(yVec (drGetWaveformYVec family))
index
)
(if (drIsWaveform family)
; then
(abDumpWaveform family fileNamePrefix format)
;else
(for pos 0 (sub1 (drVectorLength xVec))
(setq index (drGetElem xVec pos))
(unless (stringp index)
(sprintf index "%L" index))
(rexCompile "[^a-zA-Z0-9.]")
(setq index (rexReplace index "_" 0))
(abDumpWaveform
(drGetElem yVec pos)
(sprintf nil "%s_%s" fileNamePrefix index)
format
)
)
) ; if
))

/************************************************** *******************************
* *
* (abDumpWaveforms fileName @key (format "%g") (separator " ") @rest waves) *
* *
* Write out a group of waveforms with a common x-axis to a file. It checks *
* to see if the x-axis is the same, because otherwise some kind of interpolation *
* would be necessary. An optional format string can be specified, so that *
* the precision can be controlled. Also, an optional separator may be given. *
* *
************************************************** *******************************/

(procedure (abDumpWaveforms fileName @key (format "%g") (separator " ") @rest waves)
(let (port xVec)
(setq xVec (drGetWaveformXVec (car waves)))
;-----------------------------------------------------------------
; check to see if all waveforms have same X-axis
;-----------------------------------------------------------------
(when (exists wave waves (neq xVec (drGetWaveformXVec wave)))
(error "All waveforms must have same x-axis")
)
(unless (setq port (outfile fileName))
(error "Could not write to file %s\n" fileName))
(for pos 0 (sub1 (drVectorLength xVec))
(fprintf port format
(drGetElem xVec pos))
(foreach wave waves
(fprintf port "%s" separator)
(fprintf port format (drGetElem (drGetWaveformYVec wave) pos))
)
(fprintf port "\n")
)
(close port)
))

/************************************************** ********************************
* *
* (abDumpSampledWaveform wave samplePoints fileName @optional (format "%g %g\n")) *
* *
* Dump the waveform at the sampled points passed in. wave is a waveform *
* object, samplePoints is a list of x points to sample at, *
* fileName is the file to write to, and format is an optional formatting string. *
* *
************************************************** ********************************/

(procedure (abDumpSampledWaveform wave samplePoints fileName @optional (format "%g %g\n"))
(let (port)
(unless (setq port (outfile fileName))
(error "Could not write to file %s\n" fileName))
(foreach point samplePoints
(fprintf port format
point
(value wave point))
)
(close port)
))

/************************************************** ***********************
* *
* Some global variables which enable simpler specification of the header *
* part of the ASCII PSF file. *
* *
************************************************** ***********************/

(setq abAsciiPSFTokenMap
'((TOK_CR "\n")
(TOK_PROP "PROP( ")
(TOK_STRUCT "STRUCT( ")
(TOK_OPEN "( ")
(TOK_CLOSE ") ")
(TOK_STAR "* ")
)
)

(setq abAsciiPSFHeader
'(
HEADER TOK_CR
"PSFversion" "1.00" TOK_CR
TYPE TOK_CR
"sweep" FLOAT DOUBLE TOK_PROP TOK_CR
"key" "sweep" TOK_CR
TOK_CLOSE TOK_CR
"V" FLOAT DOUBLE TOK_PROP TOK_CR
"units" "V" TOK_CR
"key" "node" TOK_CR
"tolerance" 1.00000e-06 TOK_CR
TOK_CLOSE TOK_CR
SWEEP TOK_CR
"time" "sweep" TOK_PROP TOK_CR
"sweep_direction" 0 TOK_CR
"units" "s" TOK_CR
"plot" 0 TOK_CR
"grid" 1 TOK_CR
TOK_CLOSE TOK_CR
)
)

(setq abAsciiPSFLogFile
'(
HEADER TOK_CR
"PSFversion" "1.00" TOK_CR
"Log Generator" "drlLog rev. 1.0" TOK_CR
"Log Time Stamp" "Thu Jan 3 16:23:59 2002" TOK_CR
"simulator" "spectre" TOK_CR
"version" "4.4.6.122001" TOK_CR
"date" "4:23:59 PM, Thur Jan 3, 2002" TOK_CR
"design" "myres.scs" TOK_CR
TYPE TOK_CR
"analysisInst" TOK_STRUCT TOK_CR
"analysisType" STRING TOK_STAR TOK_CR
"dataFile" STRING TOK_STAR TOK_CR
"format" STRING TOK_STAR TOK_CR
"parent" STRING TOK_STAR TOK_CR
"sweepVariable" ARRAY TOK_OPEN TOK_STAR TOK_CLOSE STRING TOK_STAR TOK_CR
"description" STRING TOK_STAR TOK_CR
TOK_CLOSE TOK_CR
VALUE TOK_CR
"tran-tran" "analysisInst" TOK_OPEN TOK_CR
"tran" TOK_CR
"tran.tran" TOK_CR
"PSF" TOK_CR
"" TOK_CR
TOK_OPEN "time" TOK_CLOSE TOK_CR
"Transient Analysis `tran'" TOK_CR
TOK_CLOSE TOK_CR
END TOK_CR
)
)

/************************************************** *************
* *
* (abDumpPSFMagic port magic) *
* *
* A function for dumping the "magic" tokenised PSF header *
* format information, to make writing the ASCII PSF simpler *
* (believe it or not...) *
* *
************************************************** *************/

(procedure (abDumpPSFMagic port magic)
(let (mapped)
;-----------------------------------------------------------------
; Ensure that the PSF token map has been created
;-----------------------------------------------------------------
(unless (boundp 'abPSFTokenMap)
(setq abPSFTokenMap (makeTable 'PSFTokenMap nil))
(foreach tokenMap abAsciiPSFTokenMap
(setarray abPSFTokenMap (car tokenMap) (cadr tokenMap))
)
)
;-----------------------------------------------------------------
; Now write out each word in the magic list, mapping if necessary
;-----------------------------------------------------------------
(foreach word magic
(if (setq mapped (arrayref abPSFTokenMap word))
(fprintf port mapped)
(progn
(print word port)
(fprintf port " ")
)
)
)
)
)

/************************************************** *************
* *
* (abDumpWaveformsToAsciiPSF fileName @rest waves) *
* *
* Create an ASCII PSF file containing the waves passed *
* as remaining arguments. Note that all must have the same X *
* axis *
* *
************************************************** *************/

(procedure (abDumpWaveformsToAsciiPSF fileName @rest waves)
(let (port xVec (waveNum 1))
;-----------------------------------------------------------------
; If a list of waves is passed in, use that instead
;-----------------------------------------------------------------
(when (listp (car waves)) (setq waves (car waves)))
;-----------------------------------------------------------------
; Get the x vector of the first waveform
;-----------------------------------------------------------------
(setq xVec (drGetWaveformXVec (car waves)))
;-----------------------------------------------------------------
; check to see if all waveforms have same X-axis
; much simpler this way...
;-----------------------------------------------------------------
(when (exists wave waves (neq xVec (drGetWaveformXVec wave)))
(error "All waveforms must have same x-axis")
)
(unless (setq port (outfile fileName))
(error "Could not write to file %s\n" fileName))
(abDumpPSFMagic port abAsciiPSFHeader)
(abDumpPSFMagic port `(TRACE TOK_CR "group" GROUP ,(length waves) TOK_CR))
;-----------------------------------------------------------------
; Create a waveform name for each waveform
;-----------------------------------------------------------------
(abDumpPSFMagic port
(foreach mapcan wave waves
; next line is just to fool lint
wave
(list (sprintf nil "wave%d" (postincrement waveNum)) "V" 'TOK_CR)
))
(abDumpPSFMagic port `(VALUE TOK_CR))
;-----------------------------------------------------------------
; Now write out the actual data
;-----------------------------------------------------------------
(for pos 0 (sub1 (drVectorLength xVec))
(fprintf port "\"time\" %.14e\n\"group\" " (drGetElem xVec pos))
(foreach wave waves
(fprintf port "%.14e\n" (drGetElem (drGetWaveformYVec wave) pos))
)
)
(abDumpPSFMagic port `(END TOK_CR))
(close port)
)
)

/************************************************** *************
* *
* (abDumpWaveformsToBinPSF rawdir @rest waves) *
* *
* Specify a raw directory, and a number of waveforms, this *
* will create an ASCII PSF file and then use the psf *
* utility to convert it to binary. *
* *
************************************************** *************/

(procedure (abDumpWaveformsToBinPSF rawdir @rest waves)
(let (port)
(if (or (isDir rawdir) (createDir rawdir))
(progn
(apply 'abDumpWaveformsToAsciiPSF (cons (strcat rawdir "/tran.asc") waves))
(setq port (outfile (strcat rawdir "/logFile")))
(when port
(abDumpPSFMagic port abAsciiPSFLogFile)
(close port))
;------------------------------------------------------------
; Use the transpose option (-x) (think this is right...)
;------------------------------------------------------------
(system
(sprintf nil "psf -x -i %s/tran.asc -o %s/tran.tran"
rawdir rawdir)
)
t
)
(error "Could not create directory %s" rawdir)
)
)
)