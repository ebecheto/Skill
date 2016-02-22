;; copyleft ebecheto

defun(geOpenOrRaise (@key (cell nil)(lib nil)(view nil))
unless(cell cellName=geGetWindowCellView()~>cellName)
unless(lib libName=geGetWindowCellView()~>libName)
unless(view view=geGetWindowCellView()~>cellViewType)
wini=setof(win hiGetWindowList() win~>cellView~>cellName==cell)
if(length(wini)>=2&&lib wini=setof(win wini win~>cellView~>libName==lib))
if(wini then
wini=car(wini) ;(window:18)=> window:18
hiRaiseWindow(wini)
else
wini=geOpen(?lib lib ?cell cell ?view view)
)
)


; geOpenOrRaise(?cell "IOPINS_RING" ?lib "Ed_IC6" ?view "layout")
printf("geOpenOrRaise(?cell \"IOPINS_RING\" ?lib \"Ed_IC6\" ?view \"layout\")\n")


