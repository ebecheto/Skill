;; copyleft ebecheto
;  load("~/../ebecheto/Skill/menu.il")
;  load("~/../ebechetoil/Skill/menu.il")
;  load("~/../../edouard.bechetoille/home/Skill/menu.il")
;  load("~/../../edouard.bechetoille/home/Skill/menu.il")
;  load("/afs/in2p3.fr/group/micrhau/CADENCE/Skill/menu.il")


;__vv__ the only thing TODO for new user : __vv__
; export SKILLDIR=~/Skill
;__^^__ the only thing TODO for new user : __^^__

; ie export SKILLDIR=/afs/in2p3.fr/group/micrhau/CADENCE/Skill
; or setShellEnvVar("SKILLDIR=/afs/in2p3.fr/group/micrhau/CADENCE/Skill")

let((dir) 
if(dir=getShellEnvVar("SKILLDIR") 
when(not(rexMatchList(dir getSkillPath())) setSkillPath(cons(dir getSkillPath())))
printf("[SKILL] Adding %s in getSkillPath()\n" dir||"nilDir?")
))

let((dir);=> should allow site dependent easyness
cond(; juste rajouter dir="chemin/../..."
; (isFile("/afs/in2p3.fr/group/micrhau/CADENCE/Skill/.skillDir.il") loadi("/afs/in2p3.fr/group/micrhau/CADENCE/Skill/.skillDir.il"))
(isFile("~/../../edouard.bechetoille/home/.skillDir.il") loadi("~/../../edouard.bechetoille/home/.skillDir.il"))
(isFile(".skillDir.il"   ) loadi(".skillDir.il"))
(isFile("../.skillDir.il") loadi("../.skillDir.il"))
(isFile("../ebechetoil/.skillDir.il") loadi("../ebechetoil/.skillDir.il"))
(isFile("~/.skillDir.il" ) loadi("~/.skillDir.il"))
(t  dir="~/../ebecheto/Skill")
);end cond add dir to skillPath
printf("\n__IPNL menu purpose__\n" dir)
printf("%s\nADDeD to the skill PATH\n" dir)
when(not(rexMatchList(dir getSkillPath())) setSkillPath(cons(dir getSkillPath())))
)

defun(menu () loadi("menu.il"))
load("ineed.il")
load("noiseSummary.il")
load("prettyPrint.il")


unless(fboundp('RmBannerItemByName) ;define the function when not defined
;; remove possible previously loaded menu
(procedure RmBannerItemByName(l_menuName @optional (window_id window(1)))
(if (length member( l_menuName hiGetBannerMenus(window_id)) )
(hiDeleteBannerMenu window_id (difference
(length hiGetBannerMenus(window_id) )
(length  member(l_menuName hiGetBannerMenus(window_id)))))))
)

RmBannerItemByName('trEdPulldownMenu)


files='("genBox" "addCell" "schematic2symbol" "getInstTermPoint" "getPropList" "vdcGen" "abBinaryStrToInt" "terminalPinsMap" "terminal2pin" "ocnPrint2list" "createPinLPP" "schCreatePinEd" "generateAllPins" "genPinMaster" "generatePin2place" "updateCellviews" "whereExistCell3" "magAC" "sortOPpattern" "gplinFit")
cazfiles=foreach(mapcar file files ;file=car(files)
set(concat('caz file) hiCreateMenuItem(?name concat('caz file) ?itemText file ?callback sprintf(nil "load(\"%s.il\")" file )))
concat('caz file))

hiCreatePulldownMenu( 'trSubMenuDefun ""  cazfiles)
cazDeroule = hiCreateSliderMenuItem( ?name 'cazDeroule ?itemText "__ defun() __ -->" ?subMenu trSubMenuDefun)

; buttons of the first Menu
filesOne='("Functions")
cazfilesOne=foreach(mapcar file filesOne
set(concat('caz file) hiCreateMenuItem(?name concat('caz file) ?itemText file ?callback sprintf(nil "load(\"%s.il\")" file )))
concat('caz file))


;;; creating a item for the pulldown menu
cazMyFunction = hiCreateMenuItem(?name 'cazMyFunction ?itemText "Save noise"
   ?callback "filename = \"summaryNoise.txt\"
              noiseResult( filename ) 
              printf(\"Noise Summary saved in [_** %s/%s **_]\n\", pwd() filename)
	      edit(sprintf(nil \"%s\" filename))"
   ); end of created Menu item

cazPrintNoiseSummary = hiCreateMenuItem(?name 'cazPrintNoiseSummary ?itemText "print noise" ?callback "noiseResult()")
cazPrettyPrint = hiCreateMenuItem(?name 'cazPrettyPrint ?itemText "pretty print" ?callback "prettyPrint()")
cazResize  = hiCreateMenuItem(?name 'cazResize ?itemText "Resize" ?callback "hiResizeWindow( window(1) list(0:0 500:500))")
cazResize2 = hiCreateMenuItem(?name 'cazResize2 ?itemText "Resize higher" ?callback "hiResizeWindow( window(1) list(0:0 500:900))")
cazReload  = hiCreateMenuItem(?name 'cazReload ?itemText "reload_IPNL_menu" ?callback "load(\"menu.il\")" )
cazPin     = hiCreateMenuItem(?name 'cazPin ?itemText "pin2label" ?callback "load(\"pin2label_v2.il\") pin2label()")
cazText    = hiCreateMenuItem(?name 'cazText ?itemText "pgText" ?callback "load(\"pgText.il\") pgText()")
cazMarkers = hiCreateMenuItem(?name 'cazMarkers ?itemText "displayMarkers" ?callback "load(\"displayMarkers.il\"")
cazEmacs   = hiCreateMenuItem(?name 'cazEmacs ?itemText "emacs ipc" ?callback "load(\"emacs_ipc.il\") ipcBeginProcess(\"emacs ~/../ebecheto/Skill/my-log.txt\" \"\" 'socketHandler) printf(\"Try something like :\\n\\t\\tControl-c-v\")" )
cazRegion  = hiCreateMenuItem(?name 'cazRegion ?itemText "regionSat" ?callback "load(\"regionSat.il\") regionSat()"  )
cazMos2Fet = hiCreateMenuItem(?name 'cazMos2Fet ?itemText "mos2fet" ?callback "load \"mos2fet.il\"" )
cazGnuplot = hiCreateMenuItem(?name 'cazGnuplot ?itemText "vt2gnuplot" ?callback "load(\"gnuplotVT.il\") dataToGnuplot()" )
cazFixAMS = hiCreateMenuItem(?name 'cazFixAMS ?itemText "fixState" ?callback "load(\"fixState.il\") fixState()" )
cazTuto   = hiCreateMenuItem(?name 'cazTuto ?itemText "Tuto_menu" ?callback "load(\"menu.il.tutorial.il\")" )
cazFreeLCK   = hiCreateMenuItem(?name 'cazFreeLCK ?itemText "freeLCK" ?callback "load(\"freeLCK.il\")" )
cazpinAddText   = hiCreateMenuItem(?name 'cazpinAddText ?itemText "pinAddText" ?callback "load(\"pinAddText.il\")" )
cazR90   = hiCreateMenuItem(?name 'cazR90 ?itemText "R90_selected" ?callback "foreach(inst geGetSelectedSet() inst~>orient=\"R90\")" )
cazNet   = hiCreateMenuItem(?name 'cazNet ?itemText "edit_netlist" ?callback "edit(strcat(asiGetNetlistDir(asiGetCurrentSession( )) \"/input.scs\"))")

;cazaddCell     =hiCreateMenuItem(?name 'cazaddCell    ?itemText "addCell"  ?callback sprintf(nil "load(%L)" "addCell.il" ))


cazFct = hiCreateMenuItem(?name 'cazFct ?itemText "Functions"
?callback "
printf(\"dbCreateLine( geGetWindowCellView() list(\\\"text\\\" \\\"drawing1\\\") list(-0.5:-100 100:-100)) leSetLayerValid('(\\\"text\\\" \\\"drawing1\\\") t)\")
printf(\"\\nsystem(\\\"xterm&\\\")\")
cmd=sprintf(nil \"echo cd %s\" hiGetCurrentWindow()->cellView->fileName) system( cmd)
"  )




IPNLmenuList = list( cazMyFunction cazPrintNoiseSummary cazDeroule cazResize cazResize2 cazReload cazPin cazText cazFct cazPrettyPrint cazEmacs cazMarkers cazRegion cazMos2Fet cazGnuplot cazFixAMS cazTuto cazpinAddText cazR90 cazNet cazFreeLCK )

;;; inserting the pulldown menu in the CIW
hiCreatePulldownMenu(    'trEdPulldownMenu    "IPNL"   IPNLmenuList    )
hiInsertBannerMenu( window(1) trEdPulldownMenu 666 );<== 666 so it would be the last one on the right presumably


;; ;; Adding cdsLog for fun
;; body=sprintf(nil "`date`;\t%s @ %s" getShellEnvVar("USER")||"" getShellEnvVar("HOSTNAME")||"")
;; subject=sprintf(nil "[cdsLog]:%s" pwd())
;; cmd=sprintf(nil "echo -e %L | mail -s %L %s%s" body subject "e.bechetoille" "@ipnl.in2p3.fr")(system cmd)
;; ;; why is it loaded at every adexl simulation ???
