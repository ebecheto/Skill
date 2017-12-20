procedure(
rmVirtuoso()
let( 
(listWinIn titleName win)

listWinIn=hiGetWindowList()
;; remove unnecessary name Virtuoso in window names
rexCompile( "Virtuoso. " )
foreach( win listWinIn 
	   when( ;; test sur titleName car il peut être nil ==> error rexReplace
		titleName = hiGetWindowName(win)
		hiSetWindowName( win rexReplace( titleName  "" 1) )
		hiSetIconName( win rexReplace( titleName "" 1) );; for some Linux distrib, hiSetIconName is also needed
	   ))
rexCompile( "Analog Design Environment" )
foreach( win listWinIn 
	   when( ;; test sur titleName car il peut être nil ==> error rexReplace
		 titleName = hiGetWindowName(win)
		 hiSetWindowName( win rexReplace( titleName "ADE" 1) )
		 hiSetIconName( win rexReplace( titleName "ADE" 1) );; for some Linux distrib, hiSetIconName is also needed
	   ))
rexCompile( "Schematic Editing" )
foreach( win listWinIn 
	   when( ;; test sur titleName car il peut être nil ==> error rexReplace
		 titleName = hiGetWindowName(win)
		 hiSetWindowName( win rexReplace( titleName "S" 1) )
		 hiSetIconName( win rexReplace( titleName "S" 1) );; for some Linux distrib, hiSetIconName is also needed
	   ))
rexCompile( "Schematic Reading" )
foreach( win listWinIn 
	   when( ;; test sur titleName car il peut être nil ==> error rexReplace
		 titleName = hiGetWindowName(win)
		 hiSetWindowName( win rexReplace( titleName "Sr" 1) )
		 hiSetIconName( win rexReplace( titleName "Sr" 1) );; for some Linux distrib, hiSetIconName is also needed
	   ))

rexCompile( "Layout Editing" )
foreach( win listWinIn 
	   when( ;; test sur titleName car il peut être nil ==> error rexReplace
		 titleName = hiGetWindowName(win)
		 hiSetWindowName( win rexReplace( titleName "L" 1) )
		 hiSetIconName( win rexReplace( titleName "L" 1) );; for some Linux distrib, hiSetIconName is also needed
	   ))

rexCompile( "Waveform Window" )
foreach( win listWinIn 
	   when( ;; test sur titleName car il peut être nil ==> error rexReplace
		titleName = hiGetWindowName(win)
		hiSetWindowName( win rexReplace( titleName  "W" 1) )
		hiSetIconName( win rexReplace( titleName "W" 1) );; for some Linux distrib, hiSetIconName is also needed
	   ))
); fin let
); fin proc


;;listIn = foreach(mapcar x listWinIn 

;; titleName = hiGetWindowName(window(10))
;;==> "Virtuoso\256 Schematic Editing: T2K PA_TOP.sim2 schematic  Config: T2K PA_TOP.sim2 config -- Virtuoso\256 Analog Design Environment (2)"
;; hiSetWindowName( window(10) rexReplace( titleName "" 1) )
;;==> t

;; rexReplace( titleName  "" 1)