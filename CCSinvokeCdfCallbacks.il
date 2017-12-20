/* CCSinvokeCdfCallbacks.il

Date       Jul 11, 1995 
Modified   Apr 12, 2010 

Invoke all the CDF callbacks for instances

The main entry point is (CCSinvokeCdfCallbacks cellView)
which invokes all the CDF callbacks for every instance in
a cellView. This has some keyword arguments which allow debug
messages to be displayed, to invoke the formInitProc if needed,
and to invoke using the instance CDF directly, rather than try
to create something that looks more like the effective CDF that
is found when the callbacks are normally invoked from the forms.

You can use the variable CCScallbackPatternsToIgnore so
that some callbacks can be omitted.

***************************************************

SCCS Info: @(#) CCSinvokeCdfCallbacks.il 04/30/10.09:56:21 1.14

*/

/*******************************************************************************
*  DISCLAIMER: The following code is provided for Cadence customers to use at  *
*   their own risk. The code may require modification to satisfy the           *
*   requirements of any user. The code and any modifications to the code may   *
*   not be compatible with current or future versions of Cadence products.     *
*   THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING WITHOUT     *
*   LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES OF MERCHANTABILITY *
*   OR FITNESS FOR A PARTICULAR USE.                                           *
*******************************************************************************/

/***************************************************************
*                                                              *
*    The variable CCScallbackPatternsToIgnore is set to be     *
*      a list of patterns against which the callbacks are      *
*      checked. If any of these patterns are matched then      *
*                 the callback is not invoked.                 *
*                                                              *
***************************************************************/

(unless (boundp 'CCScallbackPatternsToIgnore)
  (setq CCScallbackPatternsToIgnore
	'("^MYPDKNot_Allowed.*")))

/***************************************************************
*                                                              *
*           (CCSshouldCallbackBeExecuted callback)             *
*                                                              *
*  This checks the callback against all the patterns defined   *
*    in the list CCScallbackPatternsToIgnore to determine      *
*       whether the callback should be executed or not.        *
*                                                              *
***************************************************************/

(procedure (CCSshouldCallbackBeExecuted callback)
  (forall pattern CCScallbackPatternsToIgnore
	  (null (rexMatchp pattern callback)))
  )

/*********************************************************************
*                                                                    *
*        (CCScreateEffectiveCDFLookalike cdf [lookalikeParams])      *
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

(procedure (CCScreateEffectiveCDFLookalike cdf @optional lookalikeParams)
  (let (new cdfFields newParam)
       (unless (getd 'make_CCSeffCDF)
	       ;---------------------------------------------------------
	       ; Because some slots appear twice in cdf->? have
	       ; to make the list unique
	       ;---------------------------------------------------------
	       (setq cdfFields (makeTable 'cdfFields))
	       (foreach field (getq cdf ?)
			(setarray cdfFields  field t)
			)
	       (eval `(defstruct CCSeffCDF ,@(getq cdfFields ?))))
       (setq new (make_CCSeffCDF))
       (when (and lookalikeParams (null (getd 'make_CCSeffCDFparam)))
	 (setq cdfFields (makeTable 'cdfFields))
	 (foreach field (getq (car (getq cdf parameters)) ?)
		  (setarray cdfFields field t))
	 (eval `(defstruct CCSeffCDFparam ,@(getq cdfFields ?))))
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
			    (setq newParam (make_CCSeffCDFparam))
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
*       (CCSaddFormFieldsToEffectiveCDFLookalike cdf inst)         *
*                                                                  *
* Populate four extra fields - libraryName, cellName, viewName and *
*  instanceName to emulate the forms on the forms - i.e. so that   *
*  cdfgForm gets these slots. This is for callbacks which (badly)  *
*   use cdfgForm to find out libraryName, cellName and viewName.   *
*                                                                  *
*******************************************************************/

(procedure (CCSaddFormFieldsToEffectiveCDFLookalike cdf inst)
  (let (fieldData value)
    (unless (getd 'make_CCSeffCDFFormFields)
      (defstruct CCSeffCDFFormFields value defValue lastValue 
	editable enabled invisible)
      )
    (foreach (field attr) '(libraryName cellName viewName instanceName) 
	     '(libName cellName viewName name)
	     (setq value (dbGet inst attr))
	     (setq fieldData
		   (make_CCSeffCDFFormFields
		     ?value value
		     ?defValue value
		     ?lastValue value
		     ?editable t
		     ?enabled t
		     ?invisible nil
		     ))
	     (putprop cdf fieldData field)
	     )
    cdf
    )
  )

/*******************************************************************
*                                                                  *
*      (CCSinvokeObjCdfCallbacks cdf @key (debug nil) order        *
*               (callInitProc nil) (setCdfgForm t))                *
*                                                                  *
*      Underlying function which does all the real work. This      *
*is separated from the original function CCSinvokeInstCdfCallbacks *
*    so that this can be called with a completely virtual CDF.     *
*     See CCSinvokeInstCdfCallbacks for a description of the       *
*  arguments - note that there is the ability to control whether   *
*                     cdfgForm is set or not.                      *
* Return nil if any callback failed with a SKILL error, t otherwise*
*                                                                  *
*******************************************************************/

(procedure (CCSinvokeObjCdfCallbacks cdf @key (debug nil) order
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
			(CCSshouldCallbackBeExecuted callback))
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
			   (CCSshouldCallbackBeExecuted callback))
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
*      (CCSinvokeInstCdfCallbacks instance [?debug debug]        *
*  [?order order] [?callInitProc callInitProc] [?useInstCDF nil] *
*                      [?addFormFields nil]                      *
*                                                                *
* Invoke all the parameter callbacks in the CDF for an instance. *
*       This won't do anything if it doesn't have any CDF.       *
* debug is a flag to turn on debug messages. order allows just   *
* selected parameters to be called, in the specified order.      *
* callInitProc allows the formInitProc to be called. useInstCDF  *
* tells the formInitProc to be called with the instCDF rather    *
* than the effective lookalike CDF. addFormFields tells it to    *
* add the libraryName/cellName/viewName slots to emulate the     *
* fields on the cdfgForm, which are used by some bad callback    *
* code - note this is only done if useInstCDF is nil             *
*                                                                *
*****************************************************************/

(procedure (CCSinvokeInstCdfCallbacks instance @key (debug nil) order
				     (callInitProc nil) (useInstCDF nil)
				     (addFormFields nil))
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
	       (setq cdf (CCScreateEffectiveCDFLookalike cdf))
	       (when addFormFields
		 (CCSaddFormFieldsToEffectiveCDFLookalike cdf instance)
		 )
	       )
       ;-----------------------------------------------------------------
       ; Return value will be nil if any callbacks had errors
       ;-----------------------------------------------------------------
       (CCSinvokeObjCdfCallbacks
	 cdf 
	 ?debug debug ?order order ?callInitProc callInitProc
	 ?setCdfgForm (null useInstCDF)
	 )
  ))

/***************************************************************
*                                                              *
*              (CCSconvertCdfToPcellParams cdf)                *
*                                                              *
* Take modified parameters in the CDF, and return this as the  *
*      list of parameter names, types, and values that is      *
*       needed to create a pcell with dbCreateParamInst.       *
*                                                              *
***************************************************************/

(procedure (CCSconvertCdfToPcellParams cdf)
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
*       (CCSinvokeCdfCallbacks cellView @key (debug nil)       *
*   (callInitProc nil) (useInstCDF nil) (addFormFields nil))   *
*                                                              *
*  Invoke the CDF callbacks for all instances in the cellView. *
*  Returns nil if any callback had a SKILL error, otherwise t  *
*                                                              *
***************************************************************/

(procedure (CCSinvokeCdfCallbacks cellView @key (debug nil) 
				 (order nil)
				 (callInitProc nil) (useInstCDF nil)
				 (addFormFields nil))
  (let ((success t))
       (when debug
	     (printf "Invoking callbacks for all instances in cell '%s'\n"
		     (dbGetq cellView cellName)))
       (foreach instance (dbGetq cellView instances)
		(unless
		 (CCSinvokeInstCdfCallbacks instance 
					   ?debug debug
					   ?order order
					   ?callInitProc callInitProc
					   ?useInstCDF useInstCDF
					   ?addFormFields addFormFields
					   )
		 (setq success nil)
		 )
		) ; foreach
       success
       )
  ) ; procedure


