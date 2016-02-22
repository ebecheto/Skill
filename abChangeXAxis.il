/* abChangeXAxis.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       May 25, 1999 
Modified   May 21, 2002 
By         A.D.Beckett

Function to change the X Axis of a waveform to the corresponding
Y values of the second variable.

Also function to transpose the X and Y axes of a waveform.

Now handles families, and can be registered as a special function.
Just call:

abRegChangeXAxis()

to add to the calculator.

***************************************************

SCCS Info: @(#) abChangeXAxis.il 11/27/08.09:59:36 1.3

*/

/*******************************************************************
*                                                                  *
*                    (abChangeXAxis yVar xVar)                     *
*                                                                  *
* Return a new waveform object with the x axis set to the y values *
*                     of the second argument.                      *
*                                                                  *
*******************************************************************/

(procedure (abChangeXAxis yVar xVar)
  (let (newWave)
    (cond
      ;------------------------------------------------------------------
      ; Handle normal waveform
      ;------------------------------------------------------------------
      ((drIsWaveform yVar)
       (setq newWave (drCreateEmptyWaveform))
       (drPutWaveformXVec newWave (drGetWaveformYVec xVar))
       (if (eq (drGetWaveformXVec yVar) (drGetWaveformXVec xVar))
	 ;---------------------------------------------------------------
	 ; if the x axes are the same for both, it's simple
	 ;---------------------------------------------------------------
	 (drPutWaveformYVec newWave (drGetWaveformYVec yVar))
	 ;---------------------------------------------------------------
	 ; otherwise need to use value() to interpolate
	 ;---------------------------------------------------------------
	 (let (xVec yVec len)
	   (setq xVec (drGetWaveformXVec xVar))
	   (setq len (drVectorLength xVec))
	   (setq yVec (drCreateVec (drGetWaveformYType yVar) len))
	   (for ind 0 (sub1 len)
		(drAddElem yVec (value yVar (drGetElem xVec ind)))
		)
	   (drPutWaveformYVec newWave yVec)
	   )
	 )
       newWave
       )
      ;------------------------------------------------------------------
      ; Handle family
      ;------------------------------------------------------------------
      ((famIsFamily yVar)
       (famMap 'abChangeXAxis yVar xVar)
       ) ; is family
      (t
	(error "abChangeXAxis - can't handle %L\n" yVar)
	)
      ) ; cond
    ) ; let
  ) ; defun

/**********************************************************************
*                                                                     *
*                         (abRegChangeXAxis)                          *
*                                                                     *
* Registers abChangeXAxis as a new special function in the calculator *
*                                                                     *
**********************************************************************/

(procedure (abRegChangeXAxis)
  (calRegisterSpecialFunction
    (list "abChangeXAxis" 'abChangeXAxisCB)
    )
  t
  )

/***************************************************************************
*                                                                          *
*                            (abChangeXAxisCB)                             *
*                                                                          *
* Callback function for the special function - which builds the expression *
*                                                                          *
***************************************************************************/

(procedure (abChangeXAxisCB)
  (calSpecialFunctionInput 'abChangeXAxis '(STACK))
  )

/***************************************************************
*                                                              *
*                     (abTransposeXY var)                      *
*                                                              *
*             Swap the X and Y axes of a variable              *
*                                                              *
***************************************************************/

(procedure (abTransposeXY var)
  (let (newWave)
       (setq newWave (drCreateEmptyWaveform))
       (drPutWaveformXVec newWave (drGetWaveformYVec var))
       (drPutWaveformYVec newWave (drGetWaveformXVec var))
       newWave
       )
  )



;; ;------------------------------------------------------------------------
;; ; In this example look for change in slope of a phase noise curve
;; ;------------------------------------------------------------------------
;; pn=phaseNoise(1 "pss_fd" ?result "pnoise")
;; ;------------------------------------------------------------------------
;; ; Convert the x-axis into the log (base 10) of frequency
;; ;------------------------------------------------------------------------
;; decade=log10(xval(pn))
;; ;------------------------------------------------------------------------
;; ; And then get the phase noise versus this - this means that now we
;; ; have phase noise versus the decade number
;; ;------------------------------------------------------------------------
;; pnVsDecade=abChangeXAxis(pn decade)
;; ;------------------------------------------------------------------------
;; ; Now the slope is in db/decade
;; ;------------------------------------------------------------------------
;; slope=deriv(pnVsDecade)
;; ;------------------------------------------------------------------------
;; ; in a phase noise curve, starts at -30dB/decade, and then goes to -20dB/decade
;; ; decide the point at which you consider the "corner" (given that it's a
;; ; transition over a decade or two
;; ;------------------------------------------------------------------------
;; freqDec=cross(slope -28)
;; ;------------------------------------------------------------------------
;; ; Convert back to frequency (from decade)
;; ;------------------------------------------------------------------------
;; freq=10**freqDec
