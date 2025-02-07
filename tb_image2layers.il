
;"/group/validmgr/PROJET/TSMC/LOGO/ebecheto/cds_V1.7A_1/cds.lib"

ineed('(image2layers geOpenOrRaisecv) t)
cv=geGetWindowCellView()
cv~>libName ;=> "PICMIC1_ebecheto"

ifile="Signe-MI2I.png"
ifile="/winhome/validmgr/ebecheto/Mi2i/WP5_1_comm/logos_MI2I/Tous_logos_png/Signe-MI2I.png"
ifile="/winhome/validmgr/ebecheto/Mi2i/WP5_1_comm/logos_MI2I/Tous_logos_png/Logo-MI2I-horiz-black-base.png"
;ifile="/winhome/validmgr/ebecheto/Administratif/SERVICE/IP2I/logo_IP2I_big.jpg" ; too big
ifile="/winhome/validmgr/ebecheto/Administratif/SERVICE/IP2I/logo_IP2I_3508x2480.png"
ifile="~/groupU/Mi2i/pics/MICRHAU/Sami_idcrop_grey.jpg"
ifile="~/groupU/Mi2i/pics/MICRHAU/Sam.jpg"
;; TODO vvv
ifile="/winhome/validmgr/ebecheto/Administratif/SERVICE/IP2I/logo_IP2I_croquis_4bit.bmp"
ifile="/group/validmgr/PROJET/TOWER/PICMIC1/work_libs/ebecheto/cds/in2p3_web_0.jpg"
ifile="~/PICMIC/DEMANDES/FCPPL/2025chnSM.JPG"
ifile="~/PICMIC/DEMANDES/FCPPL/snake.bmp"
ifile="~/PICMIC/PRESENTATION/in2p3_web_0.bmp"

filename=car(last(parseString(ifile "/")));=> "Signe-MI2I.png"
basename=car(parseString(filename "."));=> "Signe-MI2I"
basename=buildString(parseString(basename "-") "_")
1+1
cv2  =dbOpenCellViewByType(cv~>libName strcat("logo_" basename) "layout" "maskLayout" "w")
;cv2  =dbOpenCellViewByType(cv~>libName strcat("logo_" basename "_2p6") "layout" "maskLayout" "w") ;=> modif python size
win=geOpenOrRaisecv(cv2) ;=> now get the active one for python ; cv=geGetWindowCellView() default command

image2layers(ifile 2)
;; does not work with wiedr pathname

;; cmd=sprintf(nil "cp %s ." ifile)
;; (system cmd)

;; ;cmd=sprintf(nil "python3 %s/image2layers.py %s %d %g > %s" SKILLDIR ifile nb px ofile)
;; cmd=sprintf(nil "python3 %s/image2layers.py %s %d %g > %s" SKILLDIR filename nb px ofile)

;; script=strcat(pwd() "/file.sh")
;; close(fp)
;; fp = outfile(script "w")
;; ;script=(get_filename fp)
;; fprintf(fp strcat(cmd "\n"))
;; close(fp)
;; edit(eval(script))

;; system(strcat("source " script))

;; image2layers(ifile 7)
;; ineed('shout)
;; (shout "which python3 ")

;; /winhome/validmgr/ebecheto/PROJETS/IMADs/PICMIC/DEMANDES/FCPPL/snake.il

win=geOpenOrRaisecv(cv=geGetWindowCellView()) ; cv~>bBox;=> ((0.0 32.565) (46.605 46.605))

cv=geGetWindowCellView() foreach(mapcar lpp '(("DEV_AREA" "ext")("AREA10" "opc")) dbCreateRect(cv lpp cv~>bBox)
load("/winhome/validmgr/ebecheto/PROJETS/IMADs/PICMIC/DEMANDES/FCPPL/snake10.il")
load("/winhome/validmgr/ebecheto/PROJETS/IMADs/PICMIC/DEMANDES/FCPPL/snake2p5.il")
load("/winhome/validmgr/ebecheto/Mi2i/WP5_1_comm/logos_MI2I/Tous_logos_png/Logo-MI2I-horiz-black-base_3p4.il")