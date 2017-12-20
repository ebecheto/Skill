procedure( (aelDisplayOPParam instName simParam @optional (labelParam nil) (resName nil))
    let((insts values)
	unless(resName 
	    (resName = strcat(asiMapFuncToLogicalName(asiGetTool((asiGetCurrentDataContext()->simulator)) 
			'OP))))
	if( auLvsParSimContext()
	    then
	    unless(labelParam 
		(labelParam = simParam)
	    )
	    (insts = auLvsMapSchInstNameParInstName(instName "" labelParam))
	    if( !insts then insts = list(instName))
	    if( !listp(insts) then insts = list(insts))
	    else
	    insts = list(instName)
	)
	when((insts && member(resName results(?noAlias t)))
	    values = foreach( mapcar x insts aelSuffixNotation(pv(x simParam ?result resName)))
	)
	buildString(values ",")
    )
)
