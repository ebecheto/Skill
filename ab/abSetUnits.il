/* abSetUnits.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Oct 08, 2009 
Modified   
By         

abSetUnits(waveform "s")

sets the units on a waveform to be seconds.

abRegSetUnitsSpecialFunction()

registers a function in the calculator to alter the units on a 
waveform.

***************************************************

SCCS Info: @(#) abSetUnits.il 10/08/09.15:05:50 1.1

*/

/****************************************************************
*                                                               *
*                    (abSetUnits wave units)                    *
*                                                               *
* Sets the units on a waveform, or all the members of a family. *
* If it is just a value, pass straight through (can't set units *
*                         on a number).                         *
*                                                               *
****************************************************************/

(defun abSetUnits (wave units)
  (cond 
    ((drIsWaveform wave)
     (putpropq (drGetWaveformYVec wave) units units)
     )
    ((famIsFamily wave)
     (famMap 'abSetUnits wave units)
     )
    )
  wave
  )

/***************************************************************
*                                                              *
*                    (abCreateSetUnitsForm)                    *
*                                                              *
*  Set up a form for the special function on the calculator,   *
*  which gives choices for the units. It needs to be cyclic,   *
*   because if it's a type in field, quotes don't get added    *
*                      around the units.                       *
*                                                              *
***************************************************************/

(defun abCreateSetUnitsForm ()
  (let (units)
    (setq units (ahiCreateCyclicField
		  ?name 'units
		  ?prompt "Units"
		  ?choices '("V" "A" "s" "W" "dB" "Wb" "C" "Hz")
		  ?value "V"
		  ))
    (calCreateSpecialFunctionsForm
      'abSetUnitsForm
      (list 
	(list units 0:0  180:20 140)
	)
      )
    ))

/*****************************************************************
*                                                                *
*                 (abSetUnitsSpecialFunctionCB)                  *
*                                                                *
* Callback for the abSetUnits special function, which constructs *
*           the buffer input from the form and stack.            *
*                                                                *
*****************************************************************/

(defun abSetUnitsSpecialFunctionCB ()
  (calCreateSpecialFunction
   ?formSym 'abSetUnitsForm
   ?formInitProc 'abCreateSetUnitsForm
   ?formTitle "Set Units"
   ?formCallback 
   "(calSpecialFunctionInput 'abSetUnits '(units))"
   ))


/***************************************************************
*                                                              *
*                (abRegSetUnitsSpecialFunction)                *
*                                                              *
*                Register the special function                 *
*                                                              *
***************************************************************/

(defun abRegSetUnitsSpecialFunction ()
  (calRegisterSpecialFunction
   (list "abSetUnits..." 'abSetUnitsSpecialFunctionCB))
  t
  )