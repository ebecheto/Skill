;;----------------------------------------------------------------------
;;--    instruction pour chargement de la fonction skill dans le ICFB
;;--              load("~/SKILL_PROC/plot_simu.il")
;;----------------------------------------------------------------------

;;--------------- Plot pour simulation parametrique ------

procedure(PlotParAnalysis(sig_lbl,sig_Name,swpValParAna,l_gain)


	let((x,i,curve,a_g,tmp)
	i=0
	a_g=listToVector(l_gain)
	foreach(x swpValParAna
		curve=value(sig_lbl,"iteration_sweep1",x)
		tmp_name=a_g[i]
		plot(curve ?expr list(sprintf(nil "%s@Ai=%.2f" sig_Name tmp_name)))
		;;Debug
		;;printf("valeur de i=%d et du gain=%f et swp_val=%L\n",i a_g[i] x)
		i=i+1	
	)
	)
)

;;------------- plot d'une simple courbe --------------

procedure(PlotAnalysis(sig_lbl,sig_Name,ValParAna)

	let((x,curve)
		x=ValParAna
		plot(sig_lbl ?expr list(sprintf(nil "%s@Ai=%.2f" sig_Name x)))
	)
	
)

;;------------- manipulation de list--------------

procedure(mylist(l_input)

	let((a_list)
		a_list = listToVector(l_input)
		i=0
		for(i 0 3 
			printf("valeur de i=%d et array[i]=%f et array[i]*i=%.2f\n" i a_list[i] a_list[i]*i)
			i=i+1
		)
	)
)
	

