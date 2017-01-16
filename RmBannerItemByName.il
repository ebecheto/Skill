;; copyleft ebecheto

unless(fboundp('RmBannerItemByName) ;define the function when not defined
;; remove possible previously loaded menu
(procedure RmBannerItemByName(l_menuName @optional (window_id window(1)))
(if (length member( l_menuName hiGetBannerMenus(window_id)) )
(hiDeleteBannerMenu window_id (difference
(length hiGetBannerMenus(window_id) )
(length  member(l_menuName hiGetBannerMenus(window_id)))))))
)
