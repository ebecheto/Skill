;;  load("~/../ebecheto/Skill/menu.il")

let((dir) dir="~/../ebecheto/Skill"
when(not(rexMatchList(dir getSkillPath())) setSkillPath(cons(dir getSkillPath())))
)

;; remove possible previously loaded menu
(procedure RmBannerItemByName(l_menuName @optional (w_id window(1)))
 (if (length member( l_menuName hiGetBannerMenus(w_id)) )
  (hiDeleteBannerMenu w_id
   (difference
    (length hiGetBannerMenus(w_id) )
    (length  member(l_menuName  hiGetBannerMenus(w_id)))
    ))))

RmBannerItemByName('trEdPulldownMenuDev)

procedure(MYdeleteBannerMenuByName(winId name)  let(((ind 0))
    exists(pulldown hiGetBannerMenus(winId) eq(pulldown name) || ind++)
    hiDeleteBannerMenu(winId ind)
  ))


;;; creating a item for the pulldown menu
trMenuItemGnuplotDev = hiCreateMenuItem(?name 'trMenuItemGnuplotDev ?itemText "vt2gnuplot" ?callback "load(\"gnuplotVT.il.dev.il\")" )



IPNLmenuListDev = list(trMenuItemGnuplotDev)


;;; creating the Example Menu pulldown menu
hiCreatePulldownMenu(
   'trEdPulldownMenuDev
   "Dev"
   IPNLmenuListDev
   )

;;; inserting the pulldown menu in the CIW

;; RmBannerItemByName('menuCiw)
;; hiInsertBannerMenu( window(1) menuCiw 5  )
;; RmBannerItemByName('trEdPulldownMenu)
hiInsertBannerMenu( window(1) trEdPulldownMenuDev 8 )

