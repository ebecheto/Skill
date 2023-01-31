;copyleft ebecheto
;ineed('categoryGet t)

defun(categoryGet (@optional (libName nil)(catName nil))
let((cat ddId)
unless(libName libName="tsmcN65")
unless(catName catName="Resistors")
ddId= ddGetObj(libName)
;; rw=if(member(catName ddCatGetLibCats(ddId)) "a" "w")
;; cat = ddCatOpenEx(ddId catName rw 1);=> not writable
cat = ddCatOpenEx(ddId catName "r" 1);=> dd:0x2bcb0800
;cat~>??
;=> (type ddLibFileType name "Resistors.Cat" readPath "/xtools/tsmc/tsmc_cern_65_1.7a/V1.7A_1/1p6m3x1z1u/tsmcN65/Resistors.Cat" writePath "/xtools/tsmc/tsmc_cern_65_1.7a/V1.7A_1/1p6m3x1z1u/tsmcN65/Resistors.Cat" lastModify "Sep  3 08:30:01 2012" owner "tsmmgr" ownerAccess "rw" group 100032 groupAccess "r" publicAccess "" isReadable t isWritable nil lib dd:0x29d354c0)
;; ddCatGetCatMembers( cat)
;; ;=> (("rnod" "cell") ... ("rppolywo_rf" "cell"))
foreach(mapcar c ddCatGetCatMembers( cat) car(c))
))

;;USAGE
; categoryGet(strcat("tsmc" "N65") "Mosfets")
; categoryGet(strcat("tsmc" "N65") "Mosfets_mac")

