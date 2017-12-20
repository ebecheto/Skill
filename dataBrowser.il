;----------------------------------------------------------------------------;
 
/*
Function 	: dataBrowser.il
Title		: A database browser
Author		: Keith Sabine [Cadence Bracknell UK]
		  With additions by Ian Dobinson [Cadence Consulting, Abingdon]
		  Additions for 4.4 by Andrew Beckett [Cadence Bracknell UK]
		  Added support for ROD objects - Andrew Beckett
Date		: 23rd September 2002
Revision	: 1.5
SW release	: 4.2.1 -> 4.4.X
Prerequesites	: none
Synopsis	: This functionality allows graphical viewing of the 
		  properties and attributes of SKILL objects.

User's guide	: none
Description	: Load this file and type 'brDataBrowser'. You need to have
		: a cellview open in the current window. Alternatively,
		: type 'dataBrowser(cv)' where cv is a database pointer
		: to a cellview, or a design management object, or a list.

SCCS Info: @(#) dataBrowser.il 10/23/02.14:15:54 1.5

*/

/* define a couple of useful utility functions for 4.4 unless they've
   already been defined */
(unless (getd 'ddobjectp)
  (procedure (ddobjectp obj)
	     (equal (substring (type obj) 1 2) "dd")))

; cope with this function not existing (happens sometimes)
(unless (isCallable 'rodIsObj)
  (procedure (rodIsObj obj) nil)
  )

(unless (getd 'ddordbobjectp)
      (procedure (ddordbobjectp obj)
		 (or (dbobjectp obj) (ddobjectp obj) (rodIsObj obj))))


/*
 * Global variables controling whether values of leaf cell objects
 * are displayed on the browser.
 */
brShowValues = t

/*
 * Create the menus for the browser.
 */
hiCreateMenu('brMenu "Commands"

    list(
	; Close Browser.
	hiCreateMenuItem(
	    ?name 'closeHandle
	    ?itemText "Close browser"
	    ?callback "brCloseBrowser()"
	)

	; Centre the browser in the window.
	hiCreateMenuItem(
	    ?name 'centreHandle
	    ?itemText "Centre"
	    ?callback "brCentre(dagGetCurrentTool())"
	)

	; Switch on
	brClearValuesMenuItem = hiCreateMenuItem(
	    ?name 'noShowValues
	    ?itemText "Don't Show Values"
	    ?callback "brClearShowValues()"
	)
    )
)

brShowValuesMenuItem = hiCreateMenuItem(
	    ?name 'showValues
	    ?itemText "Show Values"
	    ?callback "brSetShowValues()"
	)


/*******************************************************************************
 * brCloseBrowser()
 *
 * Close down the browser.
 * Callback for the close function on the top level menu.
 ******************************************************************************/
procedure( brCloseBrowser()

    hiCloseWindow(dagGetCurrentTool()->window)

) ; end procedure brCloseBrowser


/*******************************************************************************
 * brSetShowValues()
 *
 * Set the global controlling showing of leaf cell values, and then
 * swap the menus on the command menu.
 ******************************************************************************/
procedure( brSetShowValues()

    brShowValues = t
    hiDeleteMenuItem(brMenu 'showValues)
    hiAddMenuItem(brMenu brClearValuesMenuItem)

) ; end procedure brSetShowValues


/*******************************************************************************
 * brClearShowValues()
 *
 * Clear the global controlling showing of leaf cell values, and then
 * swap the menus on the command menu.
 ******************************************************************************/
procedure( brClearShowValues()

    brShowValues = nil
    hiDeleteMenuItem(brMenu 'noShowValues)
    hiAddMenuItem(brMenu brShowValuesMenuItem)

) ; end procedure brClearShowValues


/*******************************************************************************
 * brPrintAttributes(node)
 *
 * Print attributes of a node
 ******************************************************************************/
procedure(brPrintAttributes(node)

    let( (obj attribs)

	obj = node->obj
	cond(

	    (!obj
	        printf("nil\n")
	    )

	    (ddordbobjectp(obj)

	        printf("\n%s--------------------------------------\n"
		       "------------------------------------------")
	        printf("\nattributes of %s:\n\n" brGetDBName(obj))
		attribs = obj~>??
		unless(symbolp(car(attribs))
		    attribs = cdr(attribs)
		    )
		while(attribs
		    printf("%-32s : " car(attribs))
		    print(cadr(attribs))
		    printf("\n")
		    attribs = cddr(attribs)
		)
	        printf("\n%s--------------------------------------\n"
		       "------------------------------------------")

	    )

	    (t
		printf("Sorry - not a database object (%L)." typep(obj))
	    )

	) ; end cond

    ) ; end let

) ; end procedure brPrintAttributes


/*******************************************************************************
 * brPrintProperties(node)
 *
 * print properties of a node
 ******************************************************************************/
procedure(printProperties(node)

    let( (obj)

	obj = node->obj
	if(ddordbobjectp(obj) && obj~>objType then
	    printf("\n%s--------------------------------------\n"
		   "------------------------------------------")
	    printf("\nproperties of %s:\n\n" obj~>objType)
	    foreach(prop obj~>prop
		printf("%-32s :  " prop~>name)
		print(prop~>value)
		printf("  (%s)\n" prop~>valueType)
	    )
	    printf("\n%s--------------------------------------\n"
		   "------------------------------------------")
	else
	    printf("Sorry - not a database object\n")
	)

    ) ; end let

) ; end procedure printProperties


/*******************************************************************************
 * brEditProps(node)
 *
 * Edit properties of a node.
 ******************************************************************************/
procedure(brEditProps(node)

    if(ddordbobjectp(node->obj)
        hiEditPropList(node->obj)
    ; else
	printf("Sorry - can only edit properties of a database object.\n")
    )

) ; end procedure brEditProps


/*******************************************************************************
 * brShowValue(node)
 *
 * Show value associated with a leaf node.
 ******************************************************************************/
procedure( brShowValue(node)

    printf("Value is: %L\n" node->obj)

) ; end brShowValue


/*******************************************************************************
 * brExpandObjNew(startNode)
 *
 * Expand a node into a new browser.
 ******************************************************************************/
procedure( brExpandObjNew(startNode)

    brDataBrowser(startNode->obj startNode->name)

) ; end procedure brExpandObjNew


/*******************************************************************************
 * beUnexpandNode(startNode)
 *
 * Unexpand node
 ******************************************************************************/
procedure( beUnexpandNode(startNode)

    mapc('dagDestroyNode startNode->childObjects)

) ; end beUnexpandNode


/*******************************************************************************
 * brDeleteObject(node)
 *
 * Attempt to delete the given object.
 ******************************************************************************/
procedure(brDeleteObject(node)

    when( hiDisplayModalDBox( 'brBox
			"Deleting a database object"
			"Do you REALLY want to do this?"
			"" "" )

	printf("Deleting object type %L " node->obj~>objType)
	cond(

	    (node->obj~>cellName
	        printf("%s" node->obj~>cellName)
	    )

	    (node->obj~>name
		printf("%s" node->obj~>name)
	    )

	) ; end cond

	printf("\n")

	; Try to delete the object.
	if(errset(dbDeleteObject(node->obj)) then

	    /* Delete the children from the display. */
	    foreach( child node->childObjects
		    dagDestroyNode(child)
	    )

	    /* Delete the node itself. */
	    dagDestroyNode(node)

	else

	    printf("Sorry - could not delete this object.\n")

	) ; end i

    ) ; end when

) ; end procedure brDeleteObject


/*******************************************************************************
 * brExpandNode(startNode)
 *
 * Expand node into objects
 ******************************************************************************/
procedure( brExpandNode(startNode )
    let( (obj node entries names name count)

	; go through list of objects and create their nodes
	; first destroy any child nodes...

  	foreach( child startNode->childObjects
    	    dagDestroyNode(child)
  	)

 	obj = startNode->obj

	when(startNode->expandable
	    ; Expand the object into names and values.
	    entries = brExpandObject(obj)
	    count = 1
    
	    ; Convert the values into nodes.
	    foreach(entry entries

		; If we have already had the name in this expansion, then
		; we prefix it with a count, otherwise actions will be applied
		; to the wrong object.
		name = car(entry)
		when(member(name names)
		    name = sprintf(nil "%d_%s" count++ name)
		)
		names = cons(name names)
    
		; Create the node.
		node = dagCreateNode(name 
		    cond( (ddordbobjectp(cadr(entry)) brDBObjectClass)
			  (caddr(entry) brObjectClass)
			  (t brNonExpandObjectClass)))
		node->obj = cadr(entry)
		node->expandable = caddr(entry)

		; Set the colour.
		if(ddordbobjectp(cadr(entry)) || typep(cadr(entry))==t
		    node->textColor = brRedColor
		; else
		if(caddr(entry)
		    node->textColor = brBlueColor
		; else
		    node->textColor = brBlackColor
		))

		; Link the node to its parent.
		dagLinkParentToChild(startNode node)
    
	    ) ; end foreach 

	) ; end when
    
    ) ; end let

) ; end procedure brExpandNode


/*******************************************************************************
 * beExpandObject(val)
 *
 * Expand a general object, according to its type.
 ******************************************************************************/
procedure( brExpandObject(val)

    caseq(typep(val)

	((dbobject rodObj t) brExpandDBObject(val))

	(list brExpandList(val))

	((wtype other) brExpandUserType(val))

	(array brExpandArray(val))

	(t
	    cond( 
		(ddobjectp(val) brExpandDBObject(val))
		(defstructp(val) brExpandUserType(val))
	    )
	)

    ) ; end caseq

) ; end procedure brExpandObject


/*******************************************************************************
 * beExpandCBObject(dbId)->expansionList
 *
 * Convert a db object into its expansion entries.
 ******************************************************************************/
procedure(brExpandDBObject(dbId)

    let( (objList objNames)

	objList = dbId~>??
	unless(symbolp(car(objList))
	    objList=cdr(objList)
	)
	/* Convert to an assoc type list. */
	while(objList
	    if(brExpandable(cadr(objList))
	        objNames = cons(list(get_pname(car(objList))
			     cadr(objList)
			     t) objNames)
	    ; else
		objNames = cons(list(sprintf(nil "%s %s %L" 
					get_pname(car(objList)) 
					if(brShowValues "-" "")
					if(brShowValues cadr(objList) ""))
				cadr(objList) nil) objNames)
	    )
	    objList = cddr(objList)
	)

	objNames

    ) ; end let

) ; end procedure brExpandDBObject


/*******************************************************************************
 * beExpandList(list)
 *
 * Expand list into nodes
 ******************************************************************************/
procedure( brExpandList( list )

    /* Take each element, get a name, and whether expandable, and
       build the result list.
    */
    foreach(mapcar element list
	list(brGetName(element) element brExpandable(element))
    )

) ; end procedure brExpandList


/*******************************************************************************
 * beExpandArray(arr)
 *
 * Expand list into nodes
 ******************************************************************************/
procedure( brExpandArray( arr )

    let( (res val)

	for(i 0 length(arr)-1
	    unless((val = arrayref(arr i)) == 'unbound
		res = cons(list(sprintf(nil "%d - %L" i brGetName(val)) 
			        val brExpandable(val)) 
			   res)
	    )
	)

	reverse(res)

    ) ; end let

) ; end procedure brExpandArray


/*******************************************************************************
 * brExpandUserType(obj)->expansionList
 *
 * Expand a 'user type', such as a window, menu, or defstruct type object.
 * This means picking objects from the ->?? structure.
 ******************************************************************************/
procedure(brExpandUserType(dbId)

    let( (objList objNames)

	if(typep(dbId) == 'wtype
	    objList = plist(dbId)
	; else
	    objList = dbId->??
	)
	/* Convert to an assoc type list. */
	while(objList
	    if(brExpandable(cadr(objList))
	        objNames = cons(list(get_pname(car(objList))
			     cadr(objList)
			     t) objNames)
	    ; else
		objNames = cons(list(sprintf(nil "%s %s %L" 
					get_pname(car(objList)) 
					if(brShowValues "-" "")
					if(brShowValues cadr(objList) ""))
				cadr(objList) nil) objNames)
	    )
	    objList = cddr(objList)
	)

	objNames

    ) ; end let

) ; end procedure brExpandUserType


/*******************************************************************************
 * brDataBrowser([d_cv] [t_rootName])
 *
 * Main entry point to the browser.
 * The arguments are both optional, and are the object to expand, and the
 * name to use for the top level object. The later is used when expanding
 * an object into a new browser, and is not expected to be used by the
 * user.
 ******************************************************************************/
procedure( brDataBrowser(@optional cv rootName)
let( (rootNode firstNode browser expandable dbObj)

    unless(cv
	cv = hiGetCurrentWindow()->cellView
    )

    unless(boundp('brObjectClass) && brObjectClass

	; create brObjectClass, used for display of objects
	brObjectClass = dagCreateClass("brObjectClass")
    
	; valid actions for obj...
	dagAddActionToObject( '("expand object" "brExpandNode" 
				"dagGetCurrentObject()" "mouseLeft" t) 
				brObjectClass)
	dagAddActionToObject( '("unexpand object" "beUnexpandNode"
				"dagGetCurrentObject()" "mouseRight" t) 
				brObjectClass)
	dagAddActionToObject( '("expand to new browser" "brExpandObjNew"
				"dagGetCurrentObject()" "mouseRight" t) 
				brObjectClass)

	brDBObjectClass = dagCreateClass("brDBObjectClass")
	; valid actions for obj...
	dagAddActionToObject( '("expand object" "brExpandNode" 
				"dagGetCurrentObject()" "mouseLeft" t) 
				brDBObjectClass)
	dagAddActionToObject( '("unexpand object" "beUnexpandNode"
				"dagGetCurrentObject()" "mouseRight" t) 
				brDBObjectClass)
	dagAddActionToObject( '("expand to new browser" "brExpandObjNew"
				"dagGetCurrentObject()" "mouseRight" t) 
				brDBObjectClass)
	dagAddActionToObject( '("show attributes" "brPrintAttributes" 
				"dagGetCurrentObject()" "" t) brDBObjectClass)
	dagAddActionToObject( '("show properties" "printProperties" 
				"dagGetCurrentObject()" "" t) brDBObjectClass)
	dagAddActionToObject( '("edit properties" "brEditProps" 
				"dagGetCurrentObject()" "" t) brDBObjectClass)
	dagAddActionToObject( '("delete" "brDeleteObject" 
				"dagGetCurrentObject()" "" t) brDBObjectClass)

	brNonExpandObjectClass = dagCreateClass("brNonExpandObjectClass")
	dagAddActionToObject( '("Show Value" "brShowValue" 
				"dagGetCurrentObject()" "mouseLeft" t) 
				brNonExpandObjectClass)

        ; Set up colors.
        brRedColor   = hiMatchColorByName("red")
        brBlackColor = hiMatchColorByName("black")
        brBlueColor = hiMatchColorByName("blue")

    ) ; end unless
    
    ; now setup root node, doesn't matter which class.
    firstNode = dagCreateNode("" brObjectClass)

    ; set the value
    firstNode->obj = cv

    ; open the browser, same size as library browser...
    browser = dagOpenTool( hiMatchColorByName("white") list(200:200 500:700) 
			 firstNode "database browser" "help")
    browser->horizontal = t
    browser->textOnly = t
    browser->showLabels = t
    browser->labelJustification = 'centerLeft
    browser->scaleToFit = nil
    browser->anchorObject = firstNode
    browser->rootNode = firstNode
    browser->anchorTo = 'centerLeft
    browser->placer = dagFindPlacer("versionPlacer")
    unless(rootName rootName = brGetName(cv))

    expandable = brExpandable(cv)
    dbObj = ddordbobjectp(cv) || typep(cv)==t
    rootNode = dagCreateNode(rootName 
		cond( (dbObj brDBObjectClass) (expandable brObjectClass)
			(t brNonExpandObjectClass)))
    dagLinkParentToChild( firstNode rootNode)          
    rootNode->obj = cv  
    firstNode->invisible = t  
    rootNode->expandable = expandable                            
    rootNode->textColor = if(dbObj brRedColor 
			      if(expandable brBlueColor brBlackColor))

    ; redraw the browser with the above options...
    dagDisplayTool(browser)

    hiInsertBannerMenu(browser->window 'brMenu 0)

)) ; end procedure brDataBrowser


/*******************************************************************************
 * brGetName(obj)->name
 *
 * Get a name for an object.
 ******************************************************************************/
procedure(brGetName(obj)

    caseq(typep(obj)

    	((dbobject rodObj t)
	    sprintf(nil "%s" brGetDBName(obj))
	)

	(string
	    sprintf(nil "'%s'" obj)
	)

	(wtype
	    sprintf(nil "window %d" obj->windowNum)
	)

	(list
	    "<list>"
	)

	(t
	    if( ddobjectp(obj) then
		sprintf(nil "%s" brGetDBName(obj))
	    else
		sprintf(nil "<%L> %L" typep(obj) if(brShowValues obj ""))
	    )
	)

    ) ; end caseq

) ; end procedure brGetName


/*******************************************************************************
 * brGetDBName(obj)->name
 *
 * Get the name of a db object.
 ******************************************************************************/
procedure( brGetDBName(obj)

    case(obj~>objType

	("cellView" sprintf(nil "(cv) %s %s" obj~>cellName obj~>viewName))

	(("lib" "cell" "view" "prop") 
		sprintf(nil "(%s) %s " obj~>objType obj~>name))

	("cellview" sprintf(nil "(cv) %s %s" obj~>cell~>name obj~>view~>name))

	("version" sprintf(nil "(v) %L.%L" obj~>primaryIndex
				obj~>secondaryIndex))

	("LP" sprintf(nil "%s %s" obj~>layerName obj~>purpose))

	(t obj~>name || "<>")

    ) ; end case

) ; end procedure brGetDBName


/*******************************************************************************
 * brExpandable(obj)->t/nil
 *
 * Whether an object type is expandable.
 ******************************************************************************/
procedure(brExpandable(obj)

    ((memq(typep(obj) '(list dbobject wtype other array rodObj t)) || ddobjectp(obj)) && obj) ||
	defstructp(obj)

) ; end procedure brExpandable


/*******************************************************************************
 * brCentre(tool)
 *
 * Centre the browser.
 ******************************************************************************/
procedure(brCentre(tool)

    tool->anchorObject = tool->rootNode
    tool->anchorTo = 'centerLeft

) ; end brCentre
