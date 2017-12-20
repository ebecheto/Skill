/* These functions add a menu to the layout tool
 * for creating cross section drawings.
 *
 * To use, add the following lines to your .cdsinit
 *
 * load("/path/to/layout_menu.il")
 * load("/path/to/cross_section.il")
 * deRegUserTriggers("maskLayout" nil nil 'myLayoutTrigger)
 *
 * You also need to customise the paths in the RALCreateOtherMenu()
 * calls to RALGetCrossSection() to match your own installation.
 */

(defun RALCreateOtherMenu ()
  RALItemCrossSect = (hiCreateMenuItem
?itemText "Generate Cross Section"
?callback "RALGenCrossSection(\"/soft/cadence/gen_cross_section-20090110/layers.txt\" \"/soft/cadence/gen_cross_section-20090110/palette.txt\" 800)"
?name 'itemCrossSect)

  RALItemCrossSectScale = (hiCreateMenuItem
?itemText "Generate Cross Section (to scale)"
?callback "RALGenCrossSection(\"/soft/cadence/gen_cross_section-20090110/layers_scale.txt\" \"/soft/cadence/gen_cross_section-20090110/palette.txt\" 800)"
?name 'itemCrossSectScale)

  RALOtherMenu = (hiCreatePulldownMenu
				   'RALOtherMenu
				   "Other"
				   (list RALItemCrossSect RALItemCrossSectScale))
)

(defun RALOtherMenuTrigger (args)
  RALCreateOtherMenu()
  
  (hiInsertBannerMenu
		hiGetCurrentWindow()
		RALOtherMenu
		(length (hiGetBannerMenus hiGetCurrentWindow()))
		)
  )

(defun myLayoutTrigger (l)
  (RALOtherMenuTrigger l)
  )

