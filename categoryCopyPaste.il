;ineed('categoryCopyPaste t)

ineed('(categoryGet categorySet) )

;; SUPPOSING we have two libraries with same cells, but the hierchycal copy did not copy the categories.

;; libName1="lojic_130_v1"
;; libName2="lojic_65_TRANSLATE"

defun(categoryCopyPaste (@optional (libName1 "lojic_130_v1")(libName2 "lojic_65_TRANSLATE"))
let((ddId1 ddId2 cellNames catName cat cat2 rw2 cellsInCat cellName cellp)
ddId1= ddGetObj("lojic_130_v1")
ddId2= ddGetObj("lojic_65_TRANSLATE")
;cellName="LOJIC130_simu" ;<= debug
cellNames=ddId1~>cells~>name
; ddId1~>name;=> "lojic_130_v1"
catNames=ddCatGetLibCats(ddId1)
; catName=car(catNames);=> "CORE_LOJIC130" ;<= debug
catName
foreach(mapcar catName catNames
rw2=if(member(catName ddCatGetLibCats(ddId2)) "a" "w")
cat2 = ddCatOpenEx(ddId2 catName rw2 1)
cat2~>??
;categoryGet(ddId1~>name cellName)
cat = ddCatOpenEx(ddId1 catName "a" 1)
cellsInCat=ddCatGetCatMembers(cat) ;=> (("CORE_LOJIC130" "cell") ("CORE_LOJIC130_simu" "cell") ("OUT_PROBE_OSC" "cell") ("PAD_IN" "cell") ("PAD_OUT" "cell") ("paramset_core_lojic" "cell"))
;cell=car(cellsInCat) ;<= debug

foreach(mapcar cell cellsInCat
cellName=car(cell)
cellp=cadr(cell)
if( 
cellp=="cell"
then
ddCatAddItem(cat2 cellName "cell")
else
printf("FUNCTION %s, does not handle subCategory yet (%s)\n" "categoryCopyPaste" cellp)
);end if
); end cells in category loop
ddCatSave(cat2)
ddCatClose(cat2)
); end category Names in the original library
))

; first try bug with sos checkin/out stuff