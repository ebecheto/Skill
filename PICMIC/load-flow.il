; load("~/Skill/PICMIC/load-flow.il")
;; MAIN SKILL SCRIPT ;;


;depuis "~/testColor.txt"  
;imadPositionFile="~/testColor.txt"
imadPositionFile="~/testColorSpread.txt" ;<= generated by :
; ineed('ColorFixYellowSpread t);=> generate ~/testColorSpread.txt from ~/testColor.txt.original
when(nil ;<= replace with t to reload manually the hexa tricots
load("~/Skill/PICMIC/ABC_pexRect.il")     ;=> hexTricotRect_15_10
hexsCellName="hexTricotTJ_15_10"
load("~/Skill/PICMIC/copyFlaten.il") ;"hexTricotTJ_15_10_flat" ;<= merge is always a bit long
) 
; load("~/Skill/PICMIC/pavement.il");<= [DONE]
hexsCellName="hexTricotTJ_15_10_flat"
load("~/Skill/PICMIC/ROnb_xy.il");=> ROnb_xy.txt : table position-> strip Number
; load("~/Skill/PICMIC/MAT.il") ;=> to re-load the 2D MAT[][] => pinName and MATp1[][] indexed MAT+1 fori (full dummy first column
load("~/Skill/PICMIC/imad_rand_vias9.il");=> imad_rand_vias9  et tetris
load("~/Skill/PICMIC/imad_rand_plus_dummy.il") ;<== from tetris to tetris_dum 
;; TOTO : ^^ trouver commande pour supprimer la cellule avant d'utiliser dbCopy
;; Suffit pas, il faut faire manuellement la boucle for..



; depuis imad_rand_vias9 et hexTricotRect_15_10
;load("~/Skill/PICMIC/placement.il");<= included NOW at end of imad_rand_vias9.il ;=> TOP4" from imad_rand_vias9 & pavement4 & hexTricot_15-10
; => && generata also pavement_interco, which map hexa pavement +M5+M4+M3 and M2 inteconnection
; load("~/Skill/PICMIC/postPlacement.il")    ;=> TOP4_bord" "layout load("~/Skill/PICMIC/ABC_pexRect.il")
;; ^^ became buggy
load("~/Skill/PICMIC/TOP_full.il")	   ;=> AREA digitalzone for picure
;load("~/Skill/PICMIC/TOP_4chip.il")	   ;=> test with 4 chips rotation +90 position for picture
;vv buggy loop TOFIX vv FIXED
load("~/Skill/PICMIC/countROcells.il")     ;=> picture array, YTAB_RO_YRB.csv and CTAB_RO_YRB.csv 

load("~/Skill/PICMIC/countRandomVias.il")     ;=> generate RO_X_Ys.csv
load("OVERLAP.il") ;<= check VIA region visually for RO cells, kind-of metal eye-diagram

;load("~/Skill/PICMIC/RO_from_VFE_CAP.il") ;<== manual load to erase RO_BYR from VFE_CAP => reload if VFE_CAP is modified
load("~/Skill/PICMIC/netlistGenerate.il") ;<=> ~/Skill/PICMIC/discri_0-6911.csv  for yue
; load("~/Skill/PICMIC/tuneBYR.il") ;<= mannually do i to add GND VDD and bias Rails. in RYBD
;load("~/Skill/PICMIC/TOP_DIG.il") ;=> superpose pixel_matrix and pavement+discri [EN CONSTRUCTION]
; ~/Skill/PICMIC/manual_vout_dummy.il => adding Vout pin into dummy cell
load("~/Skill/PICMIC/tetris_dum_pins.il") ;=> create tetris_dum pins on top ;=> and REMASTER RO_BYR into VFE_CAP
load("~/Skill/PICMIC/tetris_dum_schematic.il") ;=> create tetris_dum schematic
;load("~/Skill/PICMIC/mos_only.il") ;=> generate mos_only layout ;<= inclued if in rail_RO
;load("~/Skill/PICMIC/rail_RO.il") ;=> generate rail_RO[DRYB] and append wires connection to pixel_digi
;load("~/Skill/PICMIC/irRO.il")    ;=> generate ir_tetris_dum from "tetris_dum" (REMASTER INSTANCES)
;load("~/Skill/PICMIC/tetris_dum2_remaster.il");<= (REMASTER INSTANCES) not used
load("~/Skill/PICMIC/ir_power_dum.il") ;=> add pins VDD & VSS in 'L' shape
load("~/Skill/PICMIC/rail_SW_sch.il") ;=> pins for sch and layout rail_SWx54

; load("~/Skill/PICMIC/VFE_CAP.il") ;=> DONE ONCE ONLY => commented, manual modif then.

;load("~/Skill/PICMIC/row_Xtalk.il");<= in construction ;=> done once, => no reload needed 
;=> generate schematic 

;load("~/Skill/PICMIC/picmic0_demo_tune.il") ;=> DONE ONCE ONLY => commented, manual modif then.


