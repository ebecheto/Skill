;;  load("~/../ebecheto/Skill/menu.il.tutorial.il")

let((dir) dir="~/../ebecheto/Skill" when(not(rexMatchList(dir getSkillPath())) setSkillPath(cons(dir getSkillPath()))))

;; remove possible previously loaded menu
unless(fboundp('RmBannerItemByName)
(procedure RmBannerItemByName(l_menuName @optional (window_id window(1)))
(if (length member( l_menuName hiGetBannerMenus(window_id)) )
(hiDeleteBannerMenu window_id (difference
(length hiGetBannerMenus(window_id) )
(length  member(l_menuName  hiGetBannerMenus(window_id))))))))

RmBannerItemByName('trTutoPulldownMenu)

cazPrettyPrint =hiCreateMenuItem(?name 'cazPrettyPrint ?itemText "pretty print" ?callback "prettyPrint()")
cazReload      =hiCreateMenuItem(?name 'cazReload      ?itemText "reload_Tuto_menu" ?callback "load(\"menu.il.tutorial.il\")")
cazText        =hiCreateMenuItem(?name 'cazText        ?itemText "pgText" ?callback "load(\"pgText.il\") pgText()")
cazMarkers     =hiCreateMenuItem(?name 'cazMarkers     ?itemText "displayMarkers" ?callback "load(\"displayMarkers.il\"")
cazRegion      =hiCreateMenuItem(?name 'cazRegion      ?itemText "regionSat" ?callback "load(\"regionSat.il\") regionSat()")
cazMos2Fet     =hiCreateMenuItem(?name 'cazMos2Fet     ?itemText "mos2fet" ?callback "load \"mos2fet.il\"")
cazGnuplot     =hiCreateMenuItem(?name 'cazGnuplot     ?itemText "vt2gnuplot" ?callback "load(\"gnuplotVT.il\") dataToGnuplot()")
cazUpdate      =hiCreateMenuItem(?name 'cazUpdate      ?itemText "updateCellviews" ?callback "load(\"updateCellviews.il\") updateCellviews()")
cazRing        =hiCreateMenuItem(?name 'cazRing        ?itemText "padRing" ?callback "load(\"padRing.il\") updateCellviews()")
cazFixAMS      =hiCreateMenuItem(?name 'cazFixAMS      ?itemText "fixState" ?callback "load(\"fixState.il\") fixState()" )
cazHex      =hiCreateMenuItem(?name 'cazHex      ?itemText "hexagone" ?callback "load(\"hexagone.array.il\")" )
cazCnt      =hiCreateMenuItem(?name 'cazCnt      ?itemText "combiToSch" ?callback sprintf(nil "load(%L)" "CntUcnt.il" ))
cazIpwl     =hiCreateMenuItem(?name 'cazIpwl      ?itemText "ipwl gen" ?callback sprintf(nil "load(%L)" "currentADCramp.il" ))
cazTerm     =hiCreateMenuItem(?name 'cazTerm      ?itemText "term 2 pin" ?callback sprintf(nil "load(%L)" "terminal2pin.il" )) 
cazXterm    =hiCreateMenuItem(?name 'cazXterm    ?itemText "Shell" ?callback "(system \"xterm&\")")
cazDraw     =hiCreateMenuItem(?name 'cazDraw    ?itemText "drawLine"  ?callback sprintf(nil "load(%L)" "drawLine.il" ))
cazLib     =hiCreateMenuItem(?name 'cazLib    ?itemText "lib2csv"  ?callback sprintf(nil "load(%L)" "lib2csv.il" ))
cazL2W     =hiCreateMenuItem(?name 'cazL2W    ?itemText "ocnPrint2list"  ?callback sprintf(nil "load(%L)" "ocnPrint2list.il" ))


cazEmacs= hiCreateMenuItem(?name 'cazEmacs ?itemText "1) emacs ipc" ?callback "load(\"emacs_ipc.il\") ipcBeginProcess(\"emacs ~/../ebecheto/Skill/skillTuto.il\" \"\" 'socketHandler)" )



hiCreatePulldownMenu( 'trSubMenu "" list( cazHex cazDraw cazCnt cazIpwl cazTerm cazXterm cazLib cazL2W) )
cazDeroule = hiCreateSliderMenuItem( ?name 'cazDeroule ?itemText "(2) defun->" ?subMenu trSubMenu)

TUTOmenuList = list(cazReload cazEmacs cazDeroule cazPrettyPrint cazText cazMarkers cazRegion cazMos2Fet cazGnuplot cazUpdate cazRing cazFixAMS)


;;; inserting the pulldown menu in the CIW
hiCreatePulldownMenu('trTutoPulldownMenu    "Tuto"   TUTOmenuList)
hiInsertBannerMenu(window(1) trTutoPulldownMenu 666)

; multipart path
; File import Spice
; pin names from schematic cellviews
; loop analyse de données
; lib2csv
; Option->LogFilter-> all
