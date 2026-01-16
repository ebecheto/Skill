;ineed('trombi)
1+1
ineed('(image2layers geOpenOrRaisecv my_modf bBoxWidth pgTextCB) t)
;cv=geGetWindowCellView()
libName="APICS"
libName="PICMIC1_ebecheto"
libName="180_ebecheto"
cv=dbOpenCellViewByType(libName "trombi_200px" "layout" "maskLayout" "w") ;now routing is manual, do not "w" it
cv=dbOpenCellViewByType(libName "trombi_200px" "layout" "maskLayout" "r") ;now routing is manual, do not "w" it
geOpenOrRaisecv(cv)
;; ifile="/uelec/Projets/Picmic/TOWER/TS18IS/picmic1/work_libs/ebecheto/cds/trombi/SELECTION/hung_id.bmp"

dir="/uelec/Projets/Picmic/TOWER/TS18IS/picmic1/work_libs/ebecheto/cds/trombi/SELECTION2/"
images=remove(".." remove("." getDirFiles(dir)))
images=setof(image images not(rexMatchp(".il$" image)))
images=setof(image images not(rexMatchp(".sh$" image)))
images=setof(image images not(rexMatchp(".sh~$" image)))
;images=list("edouard_bechetoille.bmp")
;images=list("loup_balleyguier.bmp")
;; image=car(images);=> "henso_id.bmp"
;; image=nth(2 images)
;; image=nth(length(images)-2 images)
;; image="matthieu_id.bmp"
;; ifile=strcat(dir image);=> "/uelec/Projets/Picmic/TOWER/TS18IS/picmic1/work_libs/ebecheto/cds/trombi/SELECTION/henso_id.bmp"
ifile="/share/Mi2i/logo/logo_home_web_xsmall.png"
CV=image2layers(ifile 10 0.195 50 libName)
CV=image2layers("/share/Mi2i/logo/lpccaen.bmp" 10 0.195 50 libName)
;; db=image2layers(ifile 7 0.195 100 libName)
;; ;geOpenOrRaisecv(CV)
;; 1+1

;; python ~/Skill/image2layers.py image.png 1 0.065 0.065 #<== check if nothing appends


foreach(mapcar image images ifile=strcat(dir image) image2layers(ifile 7 0.195 100 libName))


;pgTextCB( "Hello_World !" 100:-20 5.0 "TOP_M" nil t)

buildString(reverse(parseString(basename "_")) "\n")
libName="APICS"
image=car(images)

X=0 Y=0 SPACE=40 PLUSX=5
foreach(mapcar image images
ifile=strcat(dir image)
YMAX=100
filename=car(last(parseString(ifile "/")));=> "Signe-MI2I.png"
basename=car(parseString(filename "."));=> "Signe-MI2I"
basename=buildString(parseString(basename "-") "_")
cellName=strcat("logo_" basename if(YMAX "_" "") aelSuffixNotation(YMAX)||"")
inst=dbOpenCellViewByType( libName cellName "layout" "maskLayout" "r")
printf("XX: %L\n" list(X bBoxWidth(inst~>bBox)))
when(inst iinst=dbCreateInst( cv inst nil X:Y "R0") 
printf("XX: %L\n" list(X bBoxWidth(iinst~>bBox)))
;pgTextCB(basename X:-20 5.0 "TOP_M" cv t)
;pgTextCBs(buildString(reverse(parseString(basename "_")) "\n") X:-40 5.0 "TOP_M" cv t)
pgTextCBs(buildString(parseString(basename "_") "\n") X:-40 5.0 "TOP_M" cv t)
printf("XX: %L\n" list(X bBoxWidth(iinst~>bBox)))
)
X=X+bBoxWidth(inst~>bBox)+PLUSX ;<== add 20u space in between or not?
;X=X+100
printf("XX: %L\n" list(X bBoxWidth(iinst~>bBox)))
)


ineed('bBoxShrink )
; NO :  DEV_AEREA in thumbnail, not overall
;bBox=cv~>bBox foreach(mapcar lpp '("NODUMMY" ("DEV_AREA" "ext")("AREA10" "opc")) dbCreateRect(cv lpp bBoxShrink(bBox 1.1)))

bBox=cv~>bBox foreach(mapcar lpp '("NODUMMY") dbCreateRect(cv lpp bBoxShrink(bBox 1.1)))

text="I code this file : github.com/ebecheto/Skill/blob/master/image2layers.il in the first attempt to pay a tribute to a dear old friend gone too soon : Samuel Manen 1978-2024. Now i can also honor the living who worked with me on this projet. I thank them, and whish them all the luck and happyness. For you too, with your binocular zooming at the chip. I shall also thanks Andrew Beckett for all the effort he put in the cadence Forum explaying to newbies the power of skill-code."

pgTextCB(text 0:-8 1.0 "TOP_M" cv t)


;foreach(mapcar lpp '(("DEV_AREA" "ext")("AREA10" "opc")) dbCreateRect(cv lpp '(0:-9 940:-5))
foreach(mapcar lpp '(("DEV_AREA" "ext")("AREA10" "opc")) dbCreateRect(cv lpp '((0.0 -9.0) (940 -5.0))))
;css()~>bBox ;=> 
;; win=geOpenOrRaisecv(cv=geGetWindowCellView()) ; cv~>bBox;=> ((0.0 32.565) (46.605 46.605))
;; tf=techGetTechFile(cv)
;; foreach(mapcar lpp '(("LOGO" "drawing")("DEV_AREA" "ext")("AREA10" "opc")) when(leIsLayerValid(lpp tf) dbCreateRect(cv lpp cv~>bBox)))

;DRC rules => pixel >~ 0.5 size 100um => 200pix Height max~
;=> resisez all pictute to 200pixel hight
1+1
