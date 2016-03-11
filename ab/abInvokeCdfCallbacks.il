/* abInvokeCdfCallbacks.il

Author     A.D.Beckett
Group      Structured Custom, Cadence Design Systems Ltd.
Machine    SUN
Date       Jul 11, 1995 
Modified   Nov 22, 2006 
By         A.D.Beckett

Invoke all the CDF callbacks for instances

The main entry point is (abInvokeCdfCallbacks cellView)
which invokes all the CDF callbacks for every instance in
a cellView. This has some keyword arguments which allow debug
messages to be displayed, to invoke the formInitProc if needed,
and to invoke using the instance CDF directly, rather than try
to create something that looks more like the effective CDF that
is found when the callbacks are normally invoked from the forms.

You can use the variable abCallbackPatternsToIgnore so
that some callbacks can be omitted.

***************************************************

SCCS Info: @(#) abInvokeCdfCallbacks.il 12/03/08.15:27:36 1.12

*/

/***************************************************************
*                                                              *
*     The variable abCallbackPatternsToIgnore is set to be     *
*      a list of patterns against which the callbacks are      *
*      checked. If any of these patterns are matched then      *
*                 the callback is not invoked.                 *
*                                                              *
***************************************************************/

(unless (boundp 'abCallbackPatternsToIgnore)
  (setq abCallbackPatternsToIgnore
	'("^SIG3Not_Allowed.*")))

/***************************************************************
*                                                              *
*            (abShouldCallbackBeExecuted callback)             *
*                                                              *
*  This checks the callback against all the patterns defined   *
*     in the list abCallbackPatternsToIgnore to determine      *
*       whether the callback should be executed or not.        *
*                                                              *
***************************************************************/

(procedure (abShouldCallbackBeExecuted callback)
  (forall pattern abCallbackPatternsToIgnore
	  (null (rexMatchp pattern callback)))
  )

/*********************************************************************
*                                                                    *
*         (abCreateEffectiveCDFLookalike cdf [lookalikeParams])      *
*                                                                    *
*     Create a structure which looks (sort of) like an effective     *
*  CDF. The reason for creating this is to allow the "id" parameter  *
*  to be correctly set to the cell, rather than the instance, which  *
* is what happens if we use the cdfGetInstCDF() function to simulate *
* cdfgData. The lookalikeParams optional parameter allows creation   *
* of the parameters to be "lookalike" as well, so that callbacks can *
*          be called even if there is no actual instance.            *
*                                                                    *
*********************************************************************/

(procedure (abCreateEffectiveCDFLookalike cdf @optional lookalikeParams)
  (let (new cdfFields newParam)
       (unless (getd 'make_abEffCDF)
	       ;---------------------------------------------------------
	       ; Because some slots appear twice in cdf->? have
	       ; to make the list unique
	       ;---------------------------------------------------------
	       (setq cdfFields (makeTable 'cdfFields))
	       (foreach field (getq cdf ?)
			(setarray cdfFields  field t)
			)
	       (eval `(defstruct abEffCDF ,@(getq cdfFields ?))))
       (setq new (make_abEffCDF))
       (when (and lookalikeParams (null (getd 'make_abEffCDFparam)))
	 (setq cdfFields (makeTable 'cdfFields))
	 (foreach field (getq (car (getq cdf parameters)) ?)
		  (setarray cdfFields field t))
	 (eval `(defstruct abEffCDFparam ,@(getq cdfFields ?))))
       ;-----------------------------------------------------------------
       ; populate the effective cdf with the top level cdf attributes
       ;-----------------------------------------------------------------
       (foreach param (getq cdf ?)
		(putprop new (get cdf param) param))
       ;-----------------------------------------------------------------
       ; Set the id and type attributes appropriately
       ;-----------------------------------------------------------------
       (when (equal (getq new type) "instData")
	 (putpropq new (dbGetq (dbGetq (getq cdf id) master) cell) id)
	 (putpropq new "cellData" type)
	 )
       ;-----------------------------------------------------------------
       ; If we want the parameters to be lookalike too, create those
       ;-----------------------------------------------------------------
       (when lookalikeParams
	 (putpropq new 
		   (foreach mapcar param (getq cdf parameters)
			    (setq newParam (make_abEffCDFparam))
			    (foreach slot (getq param ?)
				     (putprop newParam (get param slot) slot))
			    ; reset the value to defValue for safety
			    (putpropq newParam (getq newParam defValue) value)
			    newParam
			    )
		   parameters)
	 ) ; when
       ;-----------------------------------------------------------------
       ; Add the parameters as properties in the effective cdf
       ;-----------------------------------------------------------------
       (foreach param (getq new parameters)
		(putprop new param (getq param name))
		)
       new
       )
  )

/*******************************************************************
*                                                                  *
*       (abInvokeObjCdfCallbacks cdf @key (debug nil) order        *
*               (callInitProc nil) (setCdfgForm t))                *
*                                                                  *
*      Underlying function which does all the real work. This      *
* is separated from the original function abInvokeInstCdfCallbacks *
*    so that this can be called with a completely virtual CDF.     *
*      See abInvokeInstCdfCallbacks for a description of the       *
*  arguments - note that there is the ability to control whether   *
*                     cdfgForm is set or not.                      *
* Return nil if any callback failed with a SKILL error, t otherwise*
*                                                                  *
*******************************************************************/

(procedure (abInvokeObjCdfCallbacks cdf @key (debug nil) order
				     (callInitProc nil) (setCdfgForm t))
  ;----------------------------------------------------------------------
  ; Make cdfgData and cdfgForm dynamically scoped, to avoid
  ; interfering with any global usage of these variables
  ;----------------------------------------------------------------------
  (let (callback parameters cdfgData cdfgForm (success t))
       ;-----------------------------------------------------------------
       ; Set the cdfgData to be the instance CDF
       ;-----------------------------------------------------------------
       (setq cdfgData cdf)
       (setq cdfgForm nil)
       (when setCdfgForm 
	 ;---------------------------------------------------------------
	 ; some callbacks use cdfgForm instead
	 ;---------------------------------------------------------------
	 (setq cdfgForm cdfgData)
	 )
       ;-----------------------------------------------------------------
       ; Call the formInitProc if there is one.
       ;-----------------------------------------------------------------
       (when callInitProc
	     (setq callback (getq cdfgData formInitProc))
	     (when (and callback 
			(nequal callback "")
			(abShouldCallbackBeExecuted callback))
		   (when debug
			 (printf "  Invoking formInitProc: '%s'\n" callback))
		   ;-----------------------------------------------------
		   ; Evaluate the callback
		   ;-----------------------------------------------------
		   (unless
		    (errset (evalstring 
			     (strcat callback "(cdfgData)")) t)
		    (setq success nil)
		    )
		   )
	     )
       ;-----------------------------------------------------------------
       ; Control order of parameter evaluation. If order specified,
       ; just do those, otherwise do all in arbitrary order
       ;-----------------------------------------------------------------
       (if order
	   (setq parameters (foreach mapcar param order
				     (get cdfgData param)))
	   (setq parameters (getq cdfgData parameters))
	   )
       ;-----------------------------------------------------------------
       ; loop through all parameters
       ;-----------------------------------------------------------------
       (foreach param parameters
		(setq callback (getq param callback))
		(when (and callback 
			   (nequal callback "")
			   (abShouldCallbackBeExecuted callback))
		      (when debug
			    (printf "  Invoking callback for '%s': '%s'\n"
				    (getq param name) callback))
		      ;--------------------------------------------------
		      ; evaluate the callback
		      ;--------------------------------------------------
		      (unless (errset (evalstring callback) t)
		       (setq success nil)
		       )
		      ))
  success))

/*****************************************************************
*                                                                *
*       (abInvokeInstCdfCallbacks instance [?debug debug]        *
* [?order order] [?callInitProc callInitProc] [?useInstCDF nil]) *
*                                                                *
* Invoke all the parameter callbacks in the CDF for an instance. *
*       This won't do anything if it doesn't have any CDF.       *
* debug is a flag to turn on debug messages. order allows just   *
* selected parameters to be called, in the specified order.      *
* callInitProc allows the formInitProc to be called. useInstCDF  *
* tells the formInitProc to be called with the instCDF rather    *
*                than the effective lookalike CDF.               *
*                                                                *
*****************************************************************/

(procedure (abInvokeInstCdfCallbacks instance @key (debug nil) order
				     (callInitProc nil) (useInstCDF nil))
  ;----------------------------------------------------------------------
  ; Make cdfgData and cdfgForm dynamically scoped, to avoid
  ; interfering with any global usage of these variables
  ;----------------------------------------------------------------------
  (let (cdf)
       (when debug
	     (printf " Invoking callbacks for instance '%s'\n"
		     (dbGetq instance name)))
       ;-----------------------------------------------------------------
       ; Set the cdf to be the instance CDF
       ;-----------------------------------------------------------------
       (setq cdf (cdfGetInstCDF instance))
       (unless useInstCDF
	       (setq cdf (abCreateEffectiveCDFLookalike cdf))
	       )
       ;-----------------------------------------------------------------
       ; Return value will be nil if any callbacks had errors
       ;-----------------------------------------------------------------
       (abInvokeObjCdfCallbacks
	 cdf 
	 ?debug debug ?order order ?callInitProc callInitProc
	 ?setCdfgForm (null useInstCDF)
	 )
  ))

/***************************************************************
*                                                              *
*               (abConvertCdfToPcellParams cdf)                *
*                                                              *
* Take modified parameters in the CDF, and return this as the  *
*      list of parameter names, types, and values that is      *
*       needed to create a pcell with dbCreateParamInst.       *
*                                                              *
***************************************************************/

(procedure (abConvertCdfToPcellParams cdf)
  (foreach mapcar param
	   (setof par (getq cdf parameters) 
		  (nequal (getq par value) (getq par defValue)))
	   (list
	     (getq param name)
	     ; need to map this to pcell parameter types...
	     (case (getq param paramType)
	       (("int" "boolean" "float" "string") (getq param paramType))
	       (t "string")
	       )
	     (getq param value)
	     )
	   )
  )

/***************************************************************
*                                                              *
*        (abInvokeCdfCallbacks cellView @key (debug nil)       *
*              (callInitProc nil) (useInstCDF nil))            *
*                                                              *
*  Invoke the CDF callbacks for all instances in the cellView. *
*  Returns nil if any callback had a SKILL error, otherwise t  *
*                                                              *
***************************************************************/

(procedure (abInvokeCdfCallbacks cellView @key (debug nil) 
				 (order nil)
				 (callInitProc nil) (useInstCDF nil))
  (let ((success t))
       (when debug
	     (printf "Invoking callbacks for all instances in cell '%s'\n"
		     (dbGetq cellView cellName)))
       (foreach instance (dbGetq cellView instances)
		(unless
		 (abInvokeInstCdfCallbacks instance 
					   ?debug debug
					   ?order order
					   ?callInitProc callInitProc
					   ?useInstCDF useInstCDF
					   )
		 (setq success nil)
		 )
		) ; foreach
       success
       )
  ) ; procedure

