/* CCSresizeFixedMenu.il

Group		Custom IC, Cadence Design Systems
Language	SKILL
Revision No.	1.1
Date Created	Nov 18, 2005 
Last Modified	
Tested in	IC5141
Lint score	100 (best is 100)
Description:

SKILL code to replace the fixed menu of a window with one that is
structured by a user-specified number of columns (the rows adjust
automatically based on the columns and the number of menu items).

The function CCSresizeFixedMenu() requires a value for the number
of columns, and optionally accepts a flag ?sort that controls if
the menus are sorted by name or not, and an argument ?window that
defines which window to operate on - the default is the current
window.

Usage:

  CCSresizeFixedMenu(2)
  => t		;; resizes the fixed menu of the current window
  		;; into two columns (normally the items are in 
		;; a single column)

  CCSresizeFixedMenu(3 ?sort t ?window window(3))
  => t		;; uses 3 columns to re-organize the fixed menu
  		;; of window 3 so that they are sorted by name


***************************************************

SCCS Info: @(#) CCSresizeFixedMenu.il 11/18/05.13:01:42 1.1

********************************************************************
* DISCLAIMER: The following code is provided for Cadence customers *
* to use at their own risk. The code may require modification to   *
* satisfy the requirements of any user. The code and any           *
* modifications to the code may not be compatible with current or  *
* future versions of Cadence products.                             *
* THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING   *
* WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES  *
* OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.              *
********************************************************************

*/

/*************************************************************************
*                                                                        *
*            CCSresizeFixedMenu( x_cols      [?sort nil/t]               *
*              [?window hiGetCurrentWindow()/w_windowId] )               *
*                                                                        *
* This procedure requires the argument 'cols' to indicate the number of  *
* columns to resize the fixed menu to.  The change applies to either the *
*  current window, or the window given by the ?window keyword argument.  *
*   The optional argument ?sort indicates whether the menus should be    *
*  sorted by name or not (the latter is the original order of the fixed  *
*                                menus).                                 *
*                                                                        *
*************************************************************************/
procedure(CCSresizeFixedMenu(cols @key sort (window hiGetCurrentWindow()) "xgw")
  let( (fixMenu items rows menu menuName)
    ;; obtain the fixed menu of the current window
    fixMenu = hiGetWindowFixedMenu(window)
    ;; store the menu's list of items
    items = fixMenu->_menuItemList
    ;; calculate the rows based on the number of list items and the
    ;; cols argument, rounding up to the next nearest integer
    rows = ceiling( length(items) / float(cols))
    ;; if the sort flag is non-nil then the new menu storage name
    ;; uses "Sorted", otherwise it does not use it. Names look like:
    ;; Layout8x2  or LayoutSorted4x4 etc.
    if(sort then
      menuName = concat( hiGetAppType(window) 'Sorted rows 'x cols )
    elsex
      menuName = concat( hiGetAppType(window) rows 'x cols )
    )
    ;; if the menu variable already exists then obtain it,
    ;; otherwise build a new menu structure
    if(boundp(menuName) then
      menu = eval(menuName)
    else
      ;; unless the original order has been stored on the menu
      ;; structure, store the item list on the menu structure for
      ;; later retrieval so that a non-sorted menu can be obtained
      unless(menuName->origOrder
        menuName->origOrder = items
      )
      ;; create a vertical fixed menu based on the original menu
      ;; items.  If the sort flag is non-nil then sort the menu
      ;; items by name, otherwise use the original item order
      menu = hiCreateVerticalFixedMenu( menuName
	if(sort then
	  ;; sort the menu items using the CCSmenuItemSortFunc
	  ;; which sorts the items based on the name attribute
	  sort( 
	    ;; foreach menu item name, return the menu item structure
	    foreach(mapcar item items
	      get(fixMenu item)
	    )
	    'CCSmenuItemSortFunc
	  )
	else
	  ;; foreach menu item name, return the menu item structure
	  foreach(mapcar item menuName->origOrder get(fixMenu item))
	); if
	rows	;; number of rows in the new vertical fixed menu
	cols	;; number of columns in the new vertical fixed menu
      )
    ); if the menu variable already has a value
    ;; when the menu variable has a value, replace the fixed menu
    ;; on the window with this menu
    when(menu
      hiAddFixedMenu(?fixedMenu menu ?window window)
    )
  ); let
); procedure CCSresizeFixedMenu


/****************************************************************
*                                                               *
*               CCSmenuItemSortFunc(item1 item2)                *
*                                                               *
* A procedure to sort menu items based on their item text (the  *
* menu name) which is stored under an attribute name hiItemText *
*                                                               *
****************************************************************/
procedure(CCSmenuItemSortFunc(item1 item2)
  alphalessp( getq(item1 hiItemText) getq(item2 hiItemText))
)
