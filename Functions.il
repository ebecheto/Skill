;; Functions.il
printf("dbCreateLine( geGetWindowCellView() list(\"text\" \"drawing1\") list(-0.5:-100 100:-100)) leSetLayerValid('(\"text\" \"drawing1\") t)")
printf("\nsystem(\"xterm&\")")
cmd=sprintf(nil "echo cd %s" hiGetCurrentWindow()->cellView->fileName||"") system( cmd)
