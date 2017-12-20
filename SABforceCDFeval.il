;==============================================================================
; SABforceCDFeval -- Force the reevaluation of a CDF callback
;
; Author      : Svenn Are Bjerkem
; Date        : 2006-11-05
; Modified    : 2006-11-07
; Limitations : Currently only one level can be flattened
;
; Example of usage:
; (SABforceCDFeval "MyLib" 'w)
;==============================================================================
(procedure (SABforceCDFeval libName paramName)
    (let (libId cvId viewName)
        (setq libId (ddGetObj libName ))
        (setq viewName "schematic")
        (setq listOfCells (dbGetq libId cells))
        (setq cellList (setof cell listOfCells  (member viewName
(dbGetq (dbGetq cell views) name))))
        (foreach cell cellList
            (setq cellName (dbGetq cell name))
            (setq cvId (dbOpenCellViewByType libName cellName viewName
nil "a"))
            (foreach instRef (dbGetq cvId instances)
	    	(sprintf evalParam "(dbGetq instRef %s)" paramName)
                (when (setq value (evalstring evalParam))
                    (printf "%s of %s is %L\n" paramName (dbGetq
instRef name) value)
		    ;(putpropq instRef (lowerCase value) cellName)
                    (setq cdfgData (cdfGetInstCDF instRef))
                    (setq callback (getq (get cdfgData paramName)
callback))
                    (when (and callback (nequal callback ""))
                        (errset (evalstring callback) t))))
            (schCheck cvId)
)))