procedure( (aelSumOPParam instName simParam @optional (labelParam nil) (resName nil))
    let((insts (total 0.0)) 
	unless(resName 
	    (resName = strcat(asiMapFuncToLogicalName(asiGetTool((asiGetCurrentDataContext()->simulator)) 
			'OP))))
	if( auLvsParSimContext() then
	    unless(labelParam labelParam = simParam)
	    insts = auLvsMapSchInstNameParInstName(instName "" labelParam)
	    if( !insts then insts = list(instName))
	    if( !listp(insts) then (insts = list(insts)))
	    else
	    (insts = list(instName))
	)
	when((insts && member(resName results(?noAlias t)))
	    foreach( x insts total = total + pv(x simParam ?result resName))
	)
	 total
    )
)
