procedure(dt(argList)
prog((techName libPath)
when(techName=techGetTechLibName(argList->libId)
/*
foreach(packet drGetPacketList(drGetDisplay("display"))
drDeletePacket(drGetDisplay("display") packet)
) ; foreach
*/
libPath=ddGetObjWritePath(ddGetObj(techName))
when((isFile(strcat(libPath "/display.drf")) &&
!isFile("display.drf"))
drLoadDrf(strcat(libPath "/display.drf"))
) ; when
) ; when
return(t)
) ; prog
) ; procedure
when(member('dt deGetAppInfo("maskLayout")->userAppTrigList)
;if registered, unregister
_deUnRegUserTrigger("maskLayout" 'dt nil nil)
) ; when
;register the display.drf load user trigger
deRegUserTriggers("maskLayout" 'dt nil nil) 

;; 2. you can do (didn't try it)
foreach( packet drGetPacketList("display")
drDeletePacket("display" packet)
) ; foreach
;; or even enclose it in foreach( display drGetDisplayNameList() ... )
;; to process all displays.
;; I think however that all PDKs should use different packet names in order
;; to be able to load several at the same time without conflicts.
;; 3. try 
drLoadDrf( file nil ) 