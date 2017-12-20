/*

 wrAltEdit.il 
 Date: 070316
 Source: http://relyveld.wordpress.com/cadence-page/


 This file defines my Cadence customizations for schematic and layout entry. 
 It can be loaded automatically, but the prefered way is to define one key 
 binding (Alt-l)in your icfb startup script to load this file on demand. 
 Copy and the following lines for this:

   printf( "Set the CIW Alt-l bindkey to load wrAltEdit.il file.\n")
   printf( "Use Alt-l to load wrAltEdit.il file.\n")
   hiSetBindKey( "Command Interpreter" "Alt<Key>l" "load( \"/<your_path>/wrAltEdit.il\") wrWindowName( \"Loaded wrAltEdit.il\")")

 Notice that this file needs a redefinition of the key bindings. Standard 
 cadence key bindings do not use the Alt key. Therefore, the key bindings in 
 this file always use the Alt key to make shure the normal behaviour is 
 unaltered. There is one exeption: a Shift-9 key binding is added which 
 deletes all probes (which can be added by key 9). Ofcourse no existing cadence 
 function is redefined, all functions in this file are prefixed with wr to 
 prevent accidental redefinition of cadence functions. 

 A single key binding in this can file perform different functions depending on 
 the mode. For example, Alt-1 toggles metal1 visibility but can also add 
 metal1-metal2 vias in via mode. I choose this to keep the key combinations simple. 
 There are several modes: selecting layers, setting the entry layer, via mode, 
 move mode, etc. To start a mode you type Alt-i (library manager mode) etc. Now, 
 every new Alt-key entered is evaluated in this mode. So Alt-i, Alt-e selects 
 the wrOpenOtherView function which opens the layout window of the cell you are 
 viewing now. Type Alt-i again and you are back in your schematic window. 
 When you type an Alt-key binding which is unknown in the current mode, the 
 mode is reset, and the key is evaluated again. So Alt-f will reset the library 
 manager mode and enter the find mode. If you don't use any Alt-key binding for 
 two minutes, the mode is automatically reset to prevent accidental changes 
 because you might have forgotten that for example the via mode was still active 
 and you only wanted to toggle the metal-1 visiblity. The mode is also reset 
 by Alt-0. Use Alt-F1 to get help. The help is mode sensitive. 

 The functions in this file are build the way I build other unix scripts. They 
 don't follow any programming guideline but are created on the fly. It starts 
 with a good idea or a comment from one of my colleagues. Or a simple idea 
 is borowed from another program. Like I wanted cadence to open all the 
 views which were open when I quited cadence the previous time. This is possible 
 with some other programs and is now possible with Alt-s to save the 
 current views (or Alt-F4 to save and quit afterwards) and Alt-o when you
 start cadence. (Alt-l first to load this file). (these are all CIW keybindings)
 After the initial idea, it usually takes a short time to get the basic 
 functionallity. And while using the functions, you encounter problems or 
 unexpected behaviour and the basic function gets refined. You might want 
 to store also the window positions or ... (not implemented btw)

 One important dependency is the connection to your own technology package. 
 This file is made compatible to the technology packages from all the 
 propriety CMOS processes we use within NXP. However, I guess that it 
 is not that difficult to update this file to work with other technology 
 packages. But please let me know if you managed to do this and how. 

 After this introduction you will find functions which are technology dependend. 
 Aliasses are used to make the rest of the file technology undependend. 
 As we are working on various technology nodes at the same time, this file 
 uses the path to determine the right technology package to load. 

 You are free to add your own functions or improve the existing ones. There is 
 no problem. In general, I had very little problems in getting things working 
 the way I wanted them to work, just working on my normal databases. The 
 skill interpreter is forgiving to errors and normally just a reload of this 
 file after editing (Shift-ALt-l to open, and Alt-l to load again) gives 
 you the right message (loaded wrAltEdit.il) or tells you where you forgot that ). 
 The stacktrace shows what goes wrong and I don't experience frequent cadence 
 crashes due to my keybindings. If you are going to share this file with 
 several users, I implemented a wrAltEditlocal.il extention. The wrAltEditlocal.il 
 needs to be placed in the cadence starting directory if needed. You can 
 copy any function you want to this file and change it as you wish. It will 
 be loaded at the end of this file if present and will thus overwrite the 
 function in this file. It is not easy to add keybindings however, or you 
 have to copy the decode function as well (wrDecodeBindKeysSchematics or 
 wrDecodeBindKeysLayout). Or you have to rewrite these two functions to do 
 some search for bindkeys defined somewhere in this file...

 You can freely distribute this file. I've put it under GPL, but the 
 reason for that is only that I think that changing and redistributing shouldn't 
 be done in a totally disordered way. 
 The intention of releasing such a set of functions is to give you a starting 
 point, to give you examples of how to do it yourself. Please understand these 
 functions more as a tutorial of how to do it yourself than as ready end product 
 designed specifically to your needs, how could anyone know about these, unless 
 you tell him so, and pay him for implementing it!

 Before first using this file, search all _update_ occurences in this file and make the 
 necessary changes.

 The two main functions are wrDecodeBindKeysSchematics and wrDecodeBindKeysLayout.
 They decode the Alt-x Alt-y combinations and handle special cases like 
 entering numbers or layers. 
 
 This file is accompanied by the wr.drf file which contains my customized 
 layer patterns. The metal patterns are shifted a bit to mimic transparency. 
 
 Custom Cadence Skill functions used (and present) in this file:
                                         grep '^p.*ure.*CCS' wrAltEdit.il
 * CCSgetLayAndPurpose
 * CCSrememberFormLocations
 * CCSsuppressDispForm

 Finally, this file contains my personal customizations. Since editing  
 styles, needs and tastes are completely different, you should adjust 
 everything to suit your needs, preferences and usage patterns. Make your 
 layout editor work the way you want, rather than the other way round! 

 Used with cadence icfb version 5.10.41.500.2.23 and older. 

 
 Skill Conversion Checker results with 060614:

 List of Private functions in relIC5141USR2
 * ilDebugToolBox
 * startFinder

 Explanation:
 The ilDebugToolbox and startFinder are part of the Alt-x debug shortkeys which 
 are not ment for daily use but only for debugging.
 
 
 History
 
 070316
 * Corrected wrInit_Cxx load error.
 * Used the occasion to update several functions with small bugfixes/enhancements.

 061009
 * Added Alt-f Alt-w wrFilter key to filter wires in a schematic.
 * Corrected wrDecodeBindKeysSchematics restore mode function.
   The restore mode incorrectly called wrDecodeBindKeysLayout 
   instead of wrDecodeBindKeysSchematics. 

 060901
 * Added wrMagnify to scale  paths, devices, polygons etc.
 * Improved wrShowProperties. Now shows the last selected element of a list.
 * Improved wrSearchReplace. Now working with pins as well. Places new pin label in the middle of the pin.
 * Improved wrGrowPin. Snaps pins to the Cell3 grid defined by variable wrLayoutGrid. 
 * Added variable wrDeviceTechLibName2. It is used in wrFilter function to find 
   devices which are not instanciated from the techGetTechLibName.
 * Added restore mode function. When the current mode is interrupted by a simple one key command
   like toggle metal2 visibility (Alt-2) then the mode is restored after the simple command.
   So, when in Move mode (Alt-m), toggling metal2 visibility with Alt-2 will not reset the Move mode.
 * Corrected wrFilter when filtering cells.
 * Added a few missing hiSetBindKey definitions for Shift-Alt-.. keys. 
 
 060728
 * Added Mouse Scroll button support for layout views. pan x and y and zoom.
 * Corrected bug in wrShowProperties which failed to show device properties.
 * Corrected bug in wrZoomXY.
 * Corrected bug in Filter when filtering for notVias.
 * Corrected message in wrMoveCursor.
 
 060628
 * Added wrLayoutZoomNext to cycle through selection.
 
 060619
 * Corrected wrSaveLastViews to wrSaveOpenViews in Alt-q shortkey.
 * Replaced PcInvokeInstCdfCallbacks everywhere by wrInvokeInstCdfCallbacks. 
 * Expanded header.
 * Removed unused functions CCSidpt, CCSprintLayAndPurpose and wrEnterName.
 * Added a few comments.
 
 060614
 * Replaced real data by random numbers for confidentiality.
 
 060516
 * Cleanup of code for wrWindow notifications in functions. 
 * Made SearchReplace bindkeys in layout mode identical to schematic mode. 
  
 060509
 * Changed Alt-l Alt-v (wrLSWDefault) to set the LSW window to the right side 
   of the screen.
 * Added Alt-l Alt-w (wrLSWLayersUsedValid) to add all used layers in a layout 
   to the LSW window.
 
 060424
 * Added new filter Alt-f Alt-e to select only paths and polygons in the entry layer.
 * Added new filter Alt-f Alt-b to select big (small with Shift) paths or rectangles 
   based on the 10/90% intervals between the smallest and biggest width.
 * Added save default form locations to the Alt-l Alt-e layout prefs.

 Show the present bindkeys with: icfb:
 hiSetBindKey( )
*/

;; _update_ 060323 The path to this file is stored in:
;; wrAltEditPath = "/add/your/path/here"
wrAltEditPath = "/home/validmgr/ebecheto/Skill/"

wrDecodeBindKeysText = "CIW"
wrDecodeBindKeysTextPrev = ""
wrDecodeBindKeysTextPrevOld = ""
GetEntryLayer = nil
wrEntryLayer = ""
wrEntryLayerText = ""
wrEntryLayerPrev = nil
wrSearch = ""
wrReplace = ""

wrMoveNumber = 0.1
wrPropNumber = 0.1
wrDeviceW = 1
wrDeviceL = 1
wrDeviceF = 1
wrRow = 1
wrCol = 1
wrNumber = 0.0
wrNumberText = ""

wrStopLevel = 0
wrLibManagerMode = nil
wrSchematicSnapSpacingValue = 1
wrLayoutSnapSpacingValue = 1

wrPathWidth = 0
wrOrient = "R0"

;; 060617 optional second diffusion names. Because this file is compatible 
;; for older and newer design kits, old and new names are recognized. You 
;; might not need these variables.
 wrViaTypeN2 = "none"
 wrViaTypeP2 = "none"

procedure( wrInit_Cxx( )

  ;; 060620 _update_ Add a wrInit_Cxx procedure for each technology you use.
  ;; The current technology is deterimined automatically with function wrGetProcess
  ;; when this file is used.
  wrDeviceTechLibName2 = CMOMSxx

)

procedure( wrInit_089( )

  ;; 060620 _update_ Replace all device and parameter names in this init 
  ;; procedure to your PDK names.
  wrDeviceTechLibName2 = CMOMS089
  wrTransistorsGO1 = list( "nmos2" "pmos2" "nmos1" "nmos2")
  wrTransistorsGO2n = list( "nmos3")
  wrTransistorsGO2p = list( "pmos3")
  wrTransistorsGO3 = list( )
  wrTransistors = append( wrTransistorsGO1 wrTransistorsGO2n)
  wrTransistors = append( wrTransistors wrTransistorsGO2p)
  wrResistors = list( "res1" "res2" "res3")
  wrDiodes = list( "d1" "d2")
  wrDevices = append( wrTransistors append( wrResistors wrDiodes))
  wrMetalName = "M"
  wrMaxMetals = 6
  wrM1 = "M1"
  wrM2 = "M2"
  wrM3 = "M3"
  wrM4 = "M4"
  wrM5 = "M5"
  wrM6 = "M6"
  wrMetals = list( wrM1 wrM2 wrM3 wrM4 wrM5 wrM6)
  wrViaName = "VIA"
  wrVia1 = "VIA1"
  wrVia2 = "VIA2"
  wrVia3 = "VIA3"
  wrVia4 = "VIA4"
  wrVia5 = "VIA5"
  wrVias = list( wrVia1 wrVia2 wrVia3 wrVia4 wrVia5)
  wrViaTypeN = "m1_nactive"
  wrViaTypeP = "m1_po"
  wrViaTypeNW = "m1_nw"
  wrViaTypeNPo = "m1_npo"
  wrViaTypePPo = "m1_ppo"
  wrViaType1 = "m2_m1"
  wrViaType2 = "m3_m2"
  wrViaType3 = "m4_m3"
  wrViaType4 = "m5_m4"
  wrViaType5 = "m6_m5"
  wrViaTypes = list( wrViaTypeN wrViaTypeP wrViaTypeNW "PTAP" "NTAP" wrViaTypeNPo wrViaTypePPo wrViaType1 wrViaType2 wrViaType3 wrViaType4 wrViaType5)
  wrDnw = "dnw"
  wrNw = "nw"
  wrNp = "np"
  wrOd = "od"
  wrOd_2 = "o_2"
  wrOd_3 = "o_3"
  wrRpo = "rpo"
  wrVthName = "vth"
  wrVtlName = "vtl"
  wrVth_n = "vthn"
  wrVth_p = "vthp"
  wrVtl_n = "vtln"
  wrVtl_p = "vtlp"
  wrPb = "boundary"
  wrPo = "po"
  wrPp = "pp"
  wrCo = "co"
  wrMsub = "sub"
  wrLayers = list( wrPb wrDnw wrNw wrNp wrPp wrVth_n wrVth_p wrOd wrOd_2 wrOd_3 wrCo wrPo wrRpo)
  wrLayers = append( wrLayers wrMetals)
  wrLayers = append( wrLayers wrVias)
  wrSchematicLayers = list( "wire"  list( "wire" "label") "pin" list( "pin" "label") "text" "device" list( "device" "drawing1") "instance" list( "instance" "label") "border" "annotate" list( "annotate" "drawing7") list( "annotate" "drawing8") list( "marker" "warning") list( "marker" "error") )
  wrLayers = append( wrLayers wrSchematicLayers)
  
  wrW = "w"
  wrL = "l"
  wrM = "m"
  wrF = "nfing"
  wrBulk = "bulk"
  wrNuB = "NuB"
  wrSpaceCoPoS = "dcops"
  wrSpaceCoPoD = "dcopd"
  wrSpaceCoPoSet = list( wrSpaceCoPoS wrSpaceCoPoD)
  wrResW = "w"
  wrResL = "l"
  wrPathPoMin = 0.30
  wrPathM1Min = 0.32
  wrPathMin = 0.34
  wrPathMax = 20
  wrStepMin = 0.005
  wrLayoutGrid = 0.38 / 2
  wrPathStepMin = 0.01
  
  wrParamGO1Wmin = 0.32
  wrParamGO1Lmin = 0.3

  wrParamGO2nWmin = 0.3
  wrParamGO2nLmin = 0.38
  wrParamGO2pWmin = wrParamGO2nWmin
  wrParamGO2pLmin = wrParamGO2nLmin

  wrParamResWmin = 0.34
  wrParamResLmin = 0.33
  alias( wrEnterLayer wrEnterLayer_089)
  alias( wrLoadDrf wrLoadDrf_089)
  alias( wrViaSpaceInit wrViaSpaceInit_089)
)




procedure( wrViaTableInit( )

  wrViaTable = makeTable( "atabel" 0)
  wrViaTable[ "no" ] = wrViaTypeN 
  wrViaTable[ "po" ] = wrViaTypeP 
  wrViaTable[ "nw" ] = wrViaTypeNW 
  wrViaTable[ "np" ] = wrViaTypeNPo
  wrViaTable[ "pp" ] = wrViaTypePPo
  wrViaTable[ "v1" ] = wrViaType1 
  wrViaTable[ "v2" ] = wrViaType2 
  wrViaTable[ "v3" ] = wrViaType3 
  wrViaTable[ "v4" ] = wrViaType4 
  wrViaTable[ "v5" ] = wrViaType5
)

procedure( wrGetProcess( )

  unless( boundp( 'wrDeviceTechLibName)
    wrDeviceTechLibName = nil
  )
  cv = geGetEditCellView( )
  unless( ! cv
    wrCellName = cv->cellName
    wrLibName = cv->libName
    wrBBox = cv->bBox
    ans = techGetTechLibName( cv)
    if( ans && ans != wrDeviceTechLibName
    then
      wrDefault( )
      wrDeviceTechLibName = ans
      ;; wrDeviceTechLibName2 is used in function wrFilter to find 
      ;; devices which are not instanciated from the techGetTechLibName.
      ;; Overrule this variable in the wrInit_xx function.
      wrDeviceTechLibName2 = wrDeviceTechLibName
      wrTechFile = techGetDeviceTechFile( cv)
      rexCompile( "[A-Z]+[0-9]+")
      rexExecute( wrDeviceTechLibName)
      wrDeviceLibName = rexSubstitute( "\\0")
      cond(
        ( rexMatchp("Cxx" wrDeviceTechLibName)
	  wrInit_Cxx( )
	)
        ( rexMatchp("089" wrDeviceTechLibName)
	  wrInit_089( )
	)
      )
      wrViaTableInit( )
    )
  )  
)

procedure( wrWindowName( text)

  let( ( window wrViewName)
    
    foreach( window hiGetWindowList( )
      wrViewName = geGetWindowRep( window)->viewName
      getWarn( )
      unless( wrViewName
        wrViewName = "empty"
      )
      if( rexMatchp( "schematic" wrViewName) || rexMatchp( "layout" wrViewName) || rexMatchp( "symbol" wrViewName) || rexMatchp( "extracted" wrViewName)
      then
        hiChangeBannerLabel( window text 0)
      )
    ) ;; foreach
  ) ;; let
)

procedure( wrHelp( text)
  
  wrShFile = outfile(".wrCadenceFile")
  fprintf( wrShFile "%s" text)
  close( wrShFile)
  
  sh( "pager ./.wrCadenceFile")
  
  ;; grep wrWindowName % | cut -f 2 -d '"' | pager

)

wrUser = getShellEnvVar( "USER" )
wrUserName = getShellEnvVar( "UserName" )
unless( wrUserName
  wrUserName = wrUser
)

procedure( wrInvokeInstCdfCallbacks( instance parmName)

  cdfgData = cdfGetInstCDF( instance)
  str = strcat("cdfgData->" parmName "->callback")
  when( callback=evalstring(str)
    evalstring(callback)
  )
)


/***************************************************************
*                                                              *
*                   CCSgetLayAndPurpose(obj)                   *
*                                                              *
*  Tests the passed-in object, if it is not a list and has a   *
*   layerName attribute, return a list of the layerName and    *
*  layerPurpose. If the object is a list and the second item   *
* in that list is non-nil then recursively call this function  *
*                  with that second list item                  *
*                                                              *
***************************************************************/
procedure( CCSgetLayAndPurpose(obj)
  cond(
    ;; if the object is not a list and the layerName database 
    ;; property is a string then this is a valid layer name and
    ;; purpose, return as a list of layer and purpose
    (!pairp(obj) && stringp(obj~>layerName)
      list(obj~>layerName obj~>purpose)
    )
    ;; if this object is a list and the second list item is non-nil
    ;; then recursively call this function again to push down one
    ;; level of hierarchy
    (pairp(obj) && cadr(obj)
      CCSgetLayAndPurpose(cadr(obj))
    )
  ); cond
); procedure CCSgetLayAndPurpose


/* CCSrememberFormLocations.il

Group		Custom IC, Cadence Design Systems
Language	SKILL
Revision No.	1.1
Date Created	Oct 01, 2004 
Last Modified	
Tested in	IC5033
Lint score	100 (best is 100)
Description:

A SKILL procedure to save the DFII session to a named file (or the
default file of ".formlocations") but only keeping the form location
information.  The form name, if available, is added as a comment
for better readability of the output file.  The resultant file will
only contain lines that start with the command "hiStoreFormLocation"
which is used to give the initial location of forms.

This procedure could be called automatically from a regExitBefore
trigger so that the form locations are always stored upon exit,
then the file can be read during startup from a .cdsinit file.

For example the .cdsinit could contain:

  regExitBefore('CCSrememberFormLocations)
  when(isFile("./.formlocations")
    load("./.formlocations")
  )

***************************************************

SCCS Info: @(#) CCSrememberFormLocations.il 10/01/04.18:29:46 1.1

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

procedure( CCSrememberFormLocations(@optional (filename ".formlocations") "t")
  let( (saveport line formname data)
  ;; unless there is a problem writing the Save Session file
  unless(stringp(hiSaveForRestore(filename))
    ;; open the session file for reading
    when(saveport = infile(filename)
      ;; read each line of the session file, ignore anything that is
      ;; saving a form location. Obtain the symbol for the form and
      ;; if it is possible prepend the form name as a comment in the
      ;; saved data
      while(gets(line saveport)
        when(rexMatchp("^hiStoreFormLocation" line)
	  formname = concat(substring(cadr(parseString(line)) 2))
	  ;; if the form structure is available, get the form name
	  ;; use a tconc structre to efficiently build the list
	  if(boundp(formname) then
	    data = tconc(data strcat(";; "
	      getq(symeval(formname) _formName) "\n" line))
	  else
	    data = tconc(data line)
	  ); if
	); when it is a line that stores a form location
      ); while we can read from the file
      ;; close the file handle
      close(saveport)
      ;; the list is the car of the tconc structure
      data = car(data)
    ); when the file can be opened for reading
    ;; when the file can be opened for writing, write each line
    ;; of data from the data list
    when(saveport = outfile(filename)
      foreach(item data
	fprintf(saveport "%s" item)
      )
      ;; close the file handle
      close(saveport)
    ); when the file can be opened for writing
  ); unless there was a problem saving the session file
  ); let
); procedure CCSrememberFormLocations


when(isFile("~/.icfb_formlocations")
   printf( "wrAltEdit.il: Loading ~/.icfb_formlocations .\n")
  load("~/.icfb_formlocations")
)

procedure( wrGetNameCB( )

  wrName = wrGetNameForm->wrName->value
)

procedure( wrGetNumberCB( )

  wrNumber = wrGetNumberForm->wrNumber->value
  wrNumberText = pcExprToString( wrNumber)
)

procedure( wrEnterNumberWithForm( titletext prompttext)

  unless( boundp( 'wrNumber)
    wrNumber = 0.0
  )
  
  ;; 060818 dont know how to update prompt field, so create form from scratch each time.
  ;; unless( boundp( 'wrGetNumberForm)
  
    wrGetNumberField = hiCreateFloatField(
      ?name 'wrNumber
      ?value wrNumber
      ?prompt prompttext
      ?defValue wrNumber
      ;?format 8.1f
      ?editable t
    )

    ;; define the form around the button
    wrGetNumberForm = hiCreateAppForm( 
      ?name 'wrGetNumberForm
      ?formTitle titletext
      ?fields list( wrGetNumberField)
      ?buttonLayout 'OKCancelDefApply
      ?initialSize t
      ?callback "wrGetNumberCB( )"
      ?unmapAfterCB t
    ) ;; form
  ;; ) ;; unless
  hiDisplayForm( wrGetNumberForm)
)

procedure( wrEnterNameWithForm( titletext prompttext)

  unless( boundp( 'wrName)
    wrName = ""
  )

  ;; unless( boundp( 'wrGetNameForm)
  ;; 060818 dont know how to update prompt field, so create form from scratch each time.

    wrGetNameField = hiCreateStringField(
      ?name 'wrName
      ?value wrName
      ?prompt prompttext
      ?defValue wrName
      ?editable t
    )
    
    ;; define the form around the button
    wrGetNameForm = hiCreateAppForm( 
      ?name 'wrGetNameForm
      ?formTitle titletext
      ?fields list( wrGetNameField)
      ?buttonLayout 'OKCancelDefApply
      ?initialSize t
      ?callback "wrGetNameCB( )"
      ?unmapAfterCB t
    ) ;; form
  ;; ) ;; unless
  ;; wrGetNameField->prompt=wrText
  hiDisplayForm( wrGetNameForm)
)

procedure( wrGet2NamesCB( )

  wrName = wrGet2NamesForm->wrName->value
  wrName2 = wrGet2NamesForm->wrName2->value
)

procedure( wrEnter2NamesWithForm( titletext prompttext prompttext2)

  ;; 060818 dont know how to update prompt field, so create form from scratch each time.
  ;; unless( boundp( 'wrGet2NamesForm)
    
  unless( boundp( 'wrName)
    wrName = ""
  )
  unless( boundp( 'wrName2)
    wrName2 = ""
  )
  
    wrGetNameField = hiCreateStringField(
      ?name 'wrName
      ?value wrName
      ?prompt prompttext
      ?defValue wrName
      ;?format 8.1f
      ?editable t
    )

    wrGetName2Field = hiCreateStringField(
      ?name 'wrName2
      ?value wrName2
      ?prompt prompttext2
      ?defValue wrName2
      ;?format 8.1f
      ?editable t
    )
    
    ;; define the form around the button
    wrGet2NamesForm = hiCreateAppForm( 
      ?name 'wrGet2NamesForm
      ?formTitle titletext
      ?fields list( wrGetNameField wrGetName2Field)
      ?buttonLayout 'OKCancelDefApply
      ?initialSize t
      ?callback "wrGet2NamesCB( )"
      ?unmapAfterCB t
    ) ;; form
  ;; ) ;; unless
  
  ;; wrGetNameField->prompt = wrText
  ;; wrGetName2Field->prompt = wrText2
  hiDisplayForm( wrGet2NamesForm)
)

procedure( wrDefault( )

  wrWriteMode = hiGetCurrentWindow()->cellView->mode

  if( wrWriteMode == "r"
  then
    wrWriteModeTxt = "RO "
  else
    wrWriteModeTxt = ""
  )
  ; wrShowProperties( "stop")
  wrLayoutZoomNext( "stop")
  wrWindowName( strcat( wrWriteModeTxt "Alt-0 clear [use Alt-~ to get help]"))
  wrDecodeBindKeysTextPrev = ""
  GetEntryLayer = nil
  wrEntryLayerText = ""
  wrNameText = ""
)

procedure( wrClear( )

  wrSeconds = compareTime( getCurrentTime( ) wrStartTime)
  if( wrSeconds > 110
  then
    wrStartTime = getCurrentTime( )
    wrDefault( )
    wrWindowName( strcat( "Automatic return from " wrDecodeBindKeysTextPrev " after 2min."))
  )
)

wrStartTime = getCurrentTime( )

procedure( wrCreateNetlistFromSchematic( )
 
  let( ( viewName wid cv )

    ;; see ocnHelp( )
    ;; set simulator
    ;; 060617 _update_ Set the right simulator name here.
    simulator( 'spectre )
    wid = hiGetCurrentWindow()
    cv = geGetEditCellView( )
    viewName = cv~>viewName
    ;; set design
    design( cv~>libName cv~>cellName viewName )
    ;; 060616 _update_ Change the next line to the right CreateNetlist function. 
    createNetlist()
  ) ;; let
)

procedure( wrAlign( @key (dir "left") )

  instancepointers = geGetSelectedSet( )
  selinst = setof( shape instancepointers shape~>objType == "inst" || shape~>objType == "label" || shape~>objType == "textDisplay" )
  if( selinst
  then
    wrAlignCell( ?cells selinst ?dir dir)
  )
  selother = setof( shape instancepointers shape~>objType == "rect" )
  if( selother
  then
    wrAlignOther( ?cells selother ?dir dir)
  )
)

procedure( wrAlignCell( @key ( cells nil ) (dir "left") )
    let( ( cell x y xyList xy )
	
      unless( cells
        cells = geGetSelectedSet( )
      )
	
    xyList = cells~>xy
    case( dir
      ( "left"
	x = apply( 'min mapcar('car xyList))
       )
      ( "right"
	x = apply( 'max mapcar('car xyList))
       )
      ( "up"
	y = apply( 'max mapcar('cadr xyList))
       )
      ( "down"
	dir = 'vd
	y = apply( 'min mapcar('cadr xyList))
       )
      ( t
	printf( "ERROR: illegal direction specified: %s\n" dir )
	nil
      )
    ) ; ** case dir **
    foreach( cell cells
      case( dir
	( ( "left" "right")
	  xy = list( x cadr( cell~>xy ) )
	)
	( t
	  xy = list( car( cell~>xy ) y )
	)
      ) ; ** case **
      cell~>xy = xy
    ) ; ** foreach cell **
  ) ; ** let **
)

procedure( wrAlignOther( @key ( cells nil ) (dir "left") )

    let( ( x y bBoxList wrAddX wrAddY wrBB wrPoint1X wrPoint1Y wrPoint2X wrPoint2Y )
	
      unless( cells
        cells = geGetSelectedSet( )
      )
	
     bBoxList = cells~>bBox
     case( dir
       ( "left"
	 x = apply( 'min mapcar('caar bBoxList))
       )
       ( "right"
	 x = apply( 'max mapcar('caar bBoxList))
	)
       ( "up"
	 y = apply( 'max mapcar('cadr bBoxList))
	)
       ( "down"
	 y = apply( 'min mapcar('cadar bBoxList))
	)
       ( t
	 printf( "ERROR: illegal direction specified: %s\n" dir )
	 nil
       )
     ) ; ** case dir **
     wrAddX = 0
     wrAddY = 0
     foreach( cell cells
       wrBB = cell->bBox
       wrPoint1X = caar( wrBB)
       wrPoint1Y = cadar( wrBB)
       wrPoint2X = caadr( wrBB)
       wrPoint2Y = cadadr( wrBB)
       case( dir
	 ( ( "left" "right")
	   wrAddX = x - wrPoint1X
	 )
	 ( t
	   wrAddY = y - wrPoint1Y
	 )
       ) ; ** case orthDir **
       wrPoint1X = wrPoint1X + wrAddX
       wrPoint1Y = wrPoint1Y + wrAddY
       wrPoint2X = wrPoint2X + wrAddX
       wrPoint2Y = wrPoint2Y + wrAddY
       cell~>bBox = list( list( wrPoint1X wrPoint1Y) list( wrPoint2X wrPoint2Y))
     ) ; ** foreach cell **
  ) ; ** let **
)

procedure( wrGetBBView( )
  
  let( ( wrPointList)
    wrPointList = list( 
      geWindowToEditPoint( hiGetCurrentWindow( ) car( hiGetViewBBox( hiGetCurrentWindow( ))))
      geWindowToEditPoint( hiGetCurrentWindow( ) cadr( hiGetViewBBox( hiGetCurrentWindow( )))))
    list( 
      list( apply( 'min mapcar('car wrPointList)) apply( 'min mapcar('cadr wrPointList)))
      list( apply( 'max mapcar('car wrPointList)) apply( 'max mapcar('cadr wrPointList))))
  )
)

procedure( wrZoomXY( point)

  let( ( x y xD yD wrBB wrBBNew)
  
    x = xCoord( point)
    y = yCoord( point)
    wrBB = wrGetBBView( )
    xD = ( xCoord( cadr( wrBB)) - xCoord( car( wrBB))) / 2
    yD = ( yCoord( cadr( wrBB)) - yCoord( car( wrBB))) / 2
    wrBBNew = list( 
      geEditToWindowPoint( hiGetCurrentWindow( ) list( (x - xD) (y - yD))) 
      geEditToWindowPoint( hiGetCurrentWindow( ) list( (x + xD) (y + yD))))

    wrWindowName( strcat( wrDecodeBindKeysText ": move to " pcExprToString( x) ", " pcExprToString( y)))
    hiZoomIn( hiGetCurrentWindow( ) wrBBNew)
  ;; test: wrZoomXY( list( 12 23) )
  )
)

procedure( wrZoomXYInput( )

  unless( boundp( 'wrXNumber)
    wrXNumber = 0
    wrYNumber = 0
  )
  wrEnterNameWithForm( "Enter point" "X coordinate [, ] [Y coordinate]")
  rexCompile( "-*[0-9]*.[0-9]*")
  rexExecute( wrName)
  wrXNumber = evalstring( rexSubstitute( "\\0"))
  if( ! floatp( wrXNumber)
  then
    rexCompile( "-*[0-9]*")
    rexExecute( wrName)
    wrXNumber = evalstring( rexSubstitute( "\\0"))
  )
  rexCompile( "[, ]")
  if( rexExecute( wrName)
  then
    rexCompile( "-*[0-9]*.[0-9]*$")
    rexExecute( wrName)
    wrYNumber = evalstring( rexSubstitute( "\\0"))
    if( ! floatp( wrYNumber)
    then
      rexCompile( "-*[0-9]*$")
      rexExecute( wrName)
      wrYNumber = evalstring( rexSubstitute( "\\0"))
    )
  )
  if( wrYNumber == 0
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": Enter Y coordinate" ))
    wrEnterNumberWithForm(  "Enter Y coordinate" "Y coordinate")
    wrYNumber = wrNumber
  )
  if( wrXNumber >= 6000 || wrYNumber >= 6000 
  then
    wrXNumber = wrXNumber/1000.0
    wrYNumber = wrYNumber/1000.0
  )
  wrZoomXY( list( wrXNumber wrYNumber))
  wrXNumber = 0
  wrYNumber = 0
)

procedure( wrMagnify( )
  
;; Warning: this function changes the sizes of instances and does not 
;; guarantee DRC/LVS correctness.

  let( ( wrText wrBB wrPoint1X wrPoint1Y wrPoint2X wrPoint2Y wrPoints wrPathWidth wrHeight)

    unless( boundp( 'wrMag)
      wrMag = 1
    )

    wrEnterNumberWithForm(  "Enter value" "Magnify")
    wrMag = wrNumber
    instances = geGetSelectedSet( )
    instancepointer = car( instances)
    foreach( instancepointer instances
      wrPoint = instancepointer->xy
      if( wrPoint
      then
        wrPoint1X = round(  xCoord( wrPoint) * wrMag / wrStepMin) * wrStepMin
        wrPoint1Y = round(  yCoord( wrPoint) * wrMag / wrStepMin) * wrStepMin
        instancepointer->xy = list( wrPoint1X wrPoint1Y)
      )
      wrInstType = instancepointer->objType
      case( wrInstType
	( "rect"
	  wrBB = instancepointer->bBox
	  wrPoint1X = round( caar( wrBB) * wrMag / wrStepMin) * wrStepMin
	  wrPoint1Y = round( cadar( wrBB) * wrMag / wrStepMin) * wrStepMin
	  wrPoint2X = round( caadr( wrBB) * wrMag / wrStepMin) * wrStepMin
	  wrPoint2Y = round( cadadr( wrBB) * wrMag / wrStepMin) * wrStepMin
	  wrPoint1 = list( wrPoint1X wrPoint1Y)
	  wrPoint2 = list( wrPoint2X wrPoint2Y)
	  instancepointer->bBox = list( wrPoint1 wrPoint2)
	)
	( "polygon"
	  wrPoint1X = ( xCoord( car( instancepointer->points)) * wrMag / wrStepMin) * wrStepMin
	  wrPoint1Y = ( yCoord( car( instancepointer->points)) * wrMag / wrStepMin) * wrStepMin
	  wrPoints = tconc( nil list( wrPoint1X wrPoint1Y))
	  foreach( wrPoint cdr( instancepointer->points)
	    wrPoint1X = ( xCoord( wrPoint ) * wrMag / wrStepMin) * wrStepMin
	    wrPoint1Y = ( yCoord( wrPoint ) * wrMag / wrStepMin) * wrStepMin
	    tconc( wrPoints list( wrPoint1X wrPoint1Y))
	  )
          instancepointer->points = car( wrPoints)
	)
	( "path"
	  wrPathWidth = instancepointer->width
	  wrPathWidth = round( wrPathWidth * wrMag / wrStepMin) * wrStepMin
	  instancepointer->width = wrPathWidth
	  wrPoint1X = ( xCoord( car( instancepointer->points)) * wrMag / wrStepMin) * wrStepMin
	  wrPoint1Y = ( yCoord( car( instancepointer->points)) * wrMag / wrStepMin) * wrStepMin
	  wrPoints = tconc( nil list( wrPoint1X wrPoint1Y))
	  foreach( wrPoint cdr( instancepointer->points)
	    wrPoint1X = ( xCoord( wrPoint ) * wrMag / wrStepMin) * wrStepMin
	    wrPoint1Y = ( yCoord( wrPoint ) * wrMag / wrStepMin) * wrStepMin
	    tconc( wrPoints list( wrPoint1X wrPoint1Y))
	  )
          instancepointer->points = car( wrPoints)
	)
	( "inst"
	  wrInstCellName = instancepointer~>cellName
	  cond( 
	    ( member( wrInstCellName wrTransistors)
	      wrDeviceW = dbFindProp( instancepointer wrW)->value
	      if( stringp( wrDeviceW)
	       then
		 wrDeviceW = evalstring( wrDeviceW)
	       )
	      wrDeviceL = dbFindProp( instancepointer wrL)->value
	      if( stringp( wrDeviceL)
	       then
		 wrDeviceL = evalstring( wrDeviceL)
	       )
	    )
	    ( member( wrInstCellName wrResistors)
	      wrError = t
	    )
	    ( member( wrInstCellName wrViaTypes)
	      wrError = t
	    )
	    ( t
	      wrText = strcat( "error: cannot change " wrInstType " yet")
	      printf( strcat( wrDecodeBindKeysText ": wrMagnify: " wrText))
	      wrError = t
	    )
	  ) ;; cond
	) ;; inst
	( ( "label" "textDisplay")
          wrHeight = instancepointer->height
	  wrHeight = round( wrHeight * wrMag / wrStepMin) * wrStepMin
	  instancepointer->height = wrHeight
	)
	( t
	  wrText = strcat( "error: unsupported instancetype: " wrInstType)
	  printf( strcat( wrDecodeBindKeysText ": wrMagnify: " wrText))
	  wrError = t
	)
      ) ;; case
    ) ;; foreach
    if( stringp( wrText)
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrMagnify: " wrText))
    else
      wrWindowName( strcat( wrDecodeBindKeysText ": wrMagnify: applied: " pcExprToString( wrMag)))
    )
  ) ;; let
)

procedure( wrSave( )

  cv = geGetEditCellView( )
  wrViewName = cv->viewName
  if( cv->mode != "r"
  then
    case( wrViewName 
      ( "layout"
        geSave( )
      )
      ( "schematic"
        schHiCheckAndSave()
      )
    )
    wrWindowName( strcat( "wrSave: saved " cv->cellName))
  else
    wrWindowName( strcat( "RO wrSave: Read-only: " cv->cellName))
  )
)

procedure( wrLayoutPlot( )
 ;; *WARNING* Invalid template file: 'Library' must be a string.
 ;; Solved: add nil at the end!
  lePlotOptions = ( )
  lePlotOptions = cons( 'fullarea  	cons( t  		lePlotOptions))
  lePlotOptions = cons( 'view      	cons( "layout"  	lePlotOptions))
  lePlotOptions = cons( 'plot      	cons( "Cellview"  	lePlotOptions))
  lePlotOptions = cons( 'plotterType  	cons( "epsfC"  		lePlotOptions))
  lePlotOptions = cons( 'plotter	cons( "PS-encapsulated color"  	lePlotOptions))
  lePlotOptions = cons( 'fit		cons( nil  		lePlotOptions))
  lePlotOptions = cons( 'plotToFile  	cons( t  		lePlotOptions))
  lePlotOptions = cons( 'time		cons( "now"  		lePlotOptions))
  lePlotOptions = cons( 'tmpdir		cons( "/usr/tmp"  	lePlotOptions))
  lePlotOptions = cons( 'copy		cons( 1  		lePlotOptions))
  lePlotOptions = cons( 'mail		cons( nil  		lePlotOptions))
  lePlotOptions = cons( 'orientation  	cons( "automatic"  	lePlotOptions))
  lePlotOptions = cons( 'offset		cons( '(0.0 0.0)  	lePlotOptions))
  lePlotOptions = cons( 'plotsize  	cons( '(15.13333 6.484598)  	lePlotOptions))
  lePlotOptionsi = cons( 'instName  	cons( "instance"  	lePlotOptions))
  cv = geGetEditCellView( )
  wrCellName = cv->cellName
  wrLibName = cv->libName
  wrBBox = cv->bBox
  wrOutputfile = strcat( pcExprToString( wrCellName) "_layout.eps")
  lePlotOptions = cons( 'outputfile cons( wrOutputfile lePlotOptionsi))
  lePlotOptions = cons( 'bBox cons( wrBBox lePlotOptions))
  lePlotOptions = cons( 'cv cons( cv lePlotOptions))
  lePlotOptions = cons( 'library cons( wrLibName lePlotOptions))
  lePlotOptions = cons( 'cell cons( wrCellName lePlotOptions))
  lePlotOptions = cons( nil lePlotOptions)
  lePlot( )
  wrWindowName( strcat( wrDecodeBindKeysText ": wrLayoutPlot: " wrOutputfile))
)

procedure( wrSchPlot( )

   schPlotOptions = ( )
   schPlotOptions = cons( 'hierarchy       cons( nil		schPlotOptions))
   schPlotOptions = cons( 'hierleveldown   cons( 0		schPlotOptions))
   schPlotOptions = cons( 'multisheet      cons( nil		schPlotOptions))
   schPlotOptions = cons( 'plot            cons( "cellview"	schPlotOptions))
   schPlotOptions = cons( 'fullarea        cons( t		schPlotOptions))
   schPlotOptions = cons( 'view            cons( "schematic"	schPlotOptions))
   schPlotOptions = cons( 'noteText        cons( ""		schPlotOptions))
   schPlotOptions = cons( 'grid            cons( nil		schPlotOptions))
   schPlotOptions = cons( 'indexsheet      cons( t		schPlotOptions))
   schPlotOptions = cons( 'notes           cons( nil		schPlotOptions))
   schPlotOptions = cons( 'header          cons( t		schPlotOptions))
   schPlotOptions = cons( 'plotToFile      cons( t		schPlotOptions))
   schPlotOptions = cons( 'display         cons( "display"	schPlotOptions))
   schPlotOptions = cons( 'vsheets         cons( 1		schPlotOptions))
   schPlotOptions = cons( 'hsheets         cons( 1		schPlotOptions))
   schPlotOptions = cons( 'pagecount       cons( 1		schPlotOptions))
   schPlotOptions = cons( 'nullpage        cons( nil		schPlotOptions))
   schPlotOptions = cons( 'paperdim        cons( '(12.1 7.3)	schPlotOptions))
   schPlotOptions = cons( 'papersize       cons( "Unlimited"		schPlotOptions))
   schPlotOptions = cons( 'resolution      cons( 300		schPlotOptions))
   schPlotOptions = cons( 'plottertype     cons( "epsf"		schPlotOptions))
   schPlotOptions = cons( 'plotter         cons( "PS-encapsulated B/W"	schPlotOptions))
   schPlotOptions = cons( 'fit             cons( nil		schPlotOptions))
   schPlotOptions = cons( 'time            cons( "now"		schPlotOptions))
   schPlotOptions = cons( 'tmpdir          cons( "/usr/tmp"	schPlotOptions))
   schPlotOptions = cons( 'copy            cons( 1		schPlotOptions))
   schPlotOptions = cons( 'unit            cons( "inches"	schPlotOptions))
   schPlotOptions = cons( 'center          cons( nil		schPlotOptions))
   schPlotOptions = cons( 'mail            cons( nil		schPlotOptions))
   schPlotOptions = cons( 'orientation     cons( "landscape"	schPlotOptions))
   schPlotOptions = cons( 'offset          cons( '(0.5 0.5)	schPlotOptions))
   schPlotOptions = cons( 'plotsize        cons( '(12.6 7.8)	schPlotOptions))
  
  ;; geSelectAll( )
  ;; instances = geGetSelectedSet( )
  ;; sel = setof( shape instances shape~>libName == wrDeviceLibName)
  geDeselectAll( )
  ;; asaEditCompDisplay( )
  ;; geSelectObject( car(sel))
  ;; _ahiiUniqueSymbolformannotateForm0->labelInfo->terminal->value =  t
  ;; _ahiiUniqueSymbolformannotateForm0->tdisplay->value = "none"
  ;; hiFormDone(_ahiiUniqueSymbolformannotateForm0)
  wrOutputfile = strcat( pcExprToString( wrCellName) "_schematic.eps")
  schPlotOptions = cons( 'outputfile cons( wrOutputfile schPlotOptions))
  schPlotOptions = cons( 'bBox cons( wrBBox schPlotOptions))
  schPlotOptions = cons( 'cv cons( cv schPlotOptions))
  schPlotOptions = cons( 'library cons( wrLibName schPlotOptions))
  schPlotOptions = cons( 'cell cons( wrCellName schPlotOptions))
  schPlotOptions = cons( 'nil schPlotOptions)
  schPlot( )
  wrWindowName( strcat( wrDecodeBindKeysText ": wrSchPlot: " wrOutputfile))
  wrShFile = outfile(".wrCadenceFile")
  fprintf( wrShFile "#!/bin/ksh\n")
  fprintf( wrShFile "epsffit -c -r 0 0 595 842 %s %s" wrOutputfile strcat( pcExprToString( wrCellName) "_schematic_rotated.eps"))
  close( wrShFile)
  sh( "chmod 750 ./.wrCadenceFile")
  sh( "./.wrCadenceFile")
  sh( "rm ./.wrCadenceFile")
)

procedure( wrProperties( propertySet value)
  
  let( ( propertyList)
    if( listp( propertySet)
    then
      propertyList = propertySet
    else
      propertyList = list( propertySet)
    )
    wrWindowName( strcat( wrDecodeBindKeysText ": wrProperties: apply: " car( propertyList) " = " pcExprToString( value)))
    foreach( instancepointer geGetSelectedSet( )
      if( member(instancepointer~>cellName wrDevices)
      then
	foreach( property propertyList
          dbReplaceProp( instancepointer property "float" value)
	  wrInvokeInstCdfCallbacks( instancepointer property)
	) 
      else
	wrWindowName( strcat( wrDecodeBindKeysText ": wrProperties: no valid device selected"))
      ) ;; if
    ) ;; foreach
  )
  hiRedraw( )
  case( car( propertyList) 
    ( wrW
      wrDeviceW = value
    )
    ( wrL
      wrDeviceL = value
    )
  )
;; test: wrProperties( wrW 2.0)
)

procedure( wrCopyProperties( copy)
  
  instancepointer = car( geGetSelectedSet( ))
  if( copy == "copy" && cadr( geGetSelectedSet( )) != nil
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyProperties: Please select only one instance"))
  else
    case( instancepointer->objType
      ( "path"
	wrCopyPath( copy)
      )
      ( "label"
	wrCopyLabel( copy)
      )
      ( t
	wrInstCellNameh = instancepointer->cellName
	unless( wrInstCellNameh
	  wrInstCellNameh = "none"
	)
	if( rexMatchp( strcat( wrMetalName "[1-9].*_" wrMetalName "[1-9].*") wrInstCellNameh)
	then
	  wrCopyVia( copy)
	else
	  wrCopyDevice( copy)
	)
      )
    ) ;; case
  ) ;; if
;; test: wrCopyProperties( )
)

procedure( wrShowProperties( @optional value)
  
  let( ( wrText cv wrLibName wrViewName wrInstCellName wrDeviceW wrDeviceL wrDeviceF wrDeviceNuB wrB wrH)    
  
    unless( boundp( 'wrShowPropertiesValue)
      wrShowPropertiesValue = "start"
      wrWindowName( strcat( wrDecodeBindKeysText ": wrShowProperties: started"))
      instancepointerPrev = nil
    )
        
    if( null( value)
    then
      if( wrShowPropertiesValue == "repeat"
      then
        wrShowPropertiesValue = "stop"
      else
       wrShowPropertiesValue = "repeat"
      )
    else
      if( value == "stop"
      then
        wrShowPropertiesValue = "stop"
      )
    )
    
    case( wrShowPropertiesValue 
      ( "stop"
        wrWindowName( strcat( wrDecodeBindKeysText ": wrShowProperties: stopped"))
	instancepointerPrev = nil
      )
      ( t
	wrText = ""
	instancepointer = car( last( geGetSelectedSet( )))
	getWarn( )
	if( ! null( instancepointer) && instancepointer != instancepointerPrev
	then
	  instancepointerPrev = instancepointer
	  cv = geGetEditCellView( )
	  wrLibName = cv->libName
          wrViewName = cv->viewName
	  wrInstType = instancepointer->objType
	  case( wrInstType
	    ( ( "rect" "polygon")
	      wrBB = instancepointer->bBox
	      wrPoint1X = caar( wrBB)
	      wrPoint1Y = cadar( wrBB)
	      wrPoint2X = caadr( wrBB)
	      wrPoint2Y = cadadr( wrBB)
	      wrB = (wrPoint2X - wrPoint1X)
	      wrH = (wrPoint2Y - wrPoint1Y)
	      wrText = car( instancepointer~>lpp)
	      if( cadr( instancepointer~>lpp) != "drawing"
	      then
	       wrText = strcat( wrText ":" cadr( instancepointer~>lpp))
	      )
	      wrText = strcat( "layer: " wrText ", W/H: " pcExprToString( wrB) "/" pcExprToString( wrH))
	    )
	    ( "path"
	      wrText = strcat( "layer: " car( instancepointer~>lpp))
	      wrPathWidth = instancepointer->width
	      wrPrevPoint = car( instancepointer~>points)
	      wrPathLength = 0.0
	      foreach( point cdr( instancepointer~>points)
		wrPathLength = wrPathLength  + abs( xCoord( point) - xCoord( wrPrevPoint)) + abs( yCoord( point) - yCoord( wrPrevPoint))
		wrPrevPoint = point
	      )
	      wrText = strcat( wrText ", W,L: " pcExprToString( wrPathWidth) "," pcExprToString( wrPathLength))
	    )
	    ( "inst"
	      wrInstCellName = instancepointer~>cellName
              cond( 
	        ( member( wrInstCellName wrDevices)
		  wrInstName = instancepointer~>name
		  if( stringp( wrInstName)
		   then
		     wrText = wrInstName
		   )
		  wrDeviceW = dbFindProp( instancepointer wrW)->value
		  if( stringp( wrDeviceW)
		   then
		     wrDeviceW = evalstring( wrDeviceW)
		   )
		  wrDeviceL = dbFindProp( instancepointer wrL)->value
		  if( stringp( wrDeviceL)
		   then
		     wrDeviceL = evalstring( wrDeviceL)
		   )
		  if( member( wrInstCellName wrTransistors)
		  then
		    wrDeviceF = dbFindProp( instancepointer wrF)->value
		    wrDeviceF = round( evalstring( wrDeviceF))
		    wrText = strcat( wrText " W/L: " pcExprToString( wrDeviceW) "/" pcExprToString( wrDeviceL))
		    if( wrDeviceF != 1
		    then
		      wrText = strcat( wrText ", F:" pcExprToString( wrDeviceF))
		    )
		  )
		  if( member( wrInstCellName wrResistors)
		  then
		    wrDeviceNuB = dbFindProp( instancepointer wrNuB)->value
		    wrText = strcat( wrInstCellName " W/L: " pcExprToString( wrDeviceW) "/" pcExprToString( wrDeviceL))
		    if( wrDeviceNuB != 0
		    then
		      wrText = strcat( wrText ", NuB:" pcExprToString( wrDeviceNuB))
		    )
		  )
		)
	        ( member( wrInstCellName wrViaTypes)
		  wrCol = dbFindProp( instancepointer "row")->value
		  wrRow = dbFindProp( instancepointer "column")->value
		  unless( wrRow
        	    wrRow = 1
		  )
		  unless( wrCol
        	    wrCol = 1
		  )
		  cond( 
		    ( wrRow != 1 && wrCol != 1
		      wrText = strcat( wrInstCellName ", " pcExprToString( wrRow) "x" pcExprToString( wrCol))
		    )
		    ( wrRow != 1 || wrCol != 1
		      wrText = strcat( wrInstCellName ", " pcExprToString( max( wrRow, wrCol)) "x")
		    )
		  )
		)
		( t
		  if( instancepointer->libName == wrLibName
		  then
		    wrText = strcat( "cell: " instancepointer->cellName ", Name: " instancepointer->name)
		  else
		    wrText = strcat( "lib: " instancepointer->libName ", Cell: " instancepointer->cellName ", Name: " instancepointer->name)
		  )
	        )
	      ) ;; cond
	    ) ;; inst
	    ( "label"
	      case( wrViewName 
                ( "layout"
	          wrText = strcat( "layer: " car( instancepointer~>lpp))
	          wrText = strcat( wrText ", pin: " instancepointer~>theLabel)
		)
		( t
	          wrText = strcat( "label: " instancepointer~>theLabel)
	        )
	      ) ;; case
	    )
	    ( "line"
	      wrText = strcat( "line: " instancepointer~>net~>name)
	    )
	    ( t
	      wrText = strcat( "error: unsupported instancetype: " wrInstType)
	    )
	  ) ;; case
	  if( stringp( wrText) && wrDecodeBindKeysText == " Alt-q Alt-q"
	  then
	    wrText = strcat( wrText " (Alt-q to stop)")
	  else
	    wrText = strcat( wrText " (Alt-q Alt-q to stop)")
	  )
	  if( stringp( wrText)
	  then
	    wrWindowName( strcat( "wrShowProperties: " wrText))
	  else
	    wrWindowName( strcat( "wrShowProperties: no valid device selected"))
	  )
	)
	if( wrShowPropertiesValue == "repeat"
	then
	  hiRegTimer( "wrShowProperties( \"repeat\")" 2)
	)
      )
    ) ;; case
  ) ;; let
;; test: wrShowProperties( )
)

procedure( wrSet( )
  
  if( boundp( 'wrLabelName)
  then
    wrName = wrLabelName
  )
  wrEnterNameWithForm( "Enter name" "Name [Alt-Enter to increase number in name]")
  wrLabelName = wrName
  wrSetName( wrLabelName)
)

procedure( wrSetRectName( value)

  ;; derived from:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;File Name     : BfChangePinByName.il
;Function(s)   : BfChangePinByName
;Author        : Bernd Fischer
;Date          : Fri, 20 Apr 2001
;Revision      : 1.0
;SW Release    : 4.4.5
;SKILL Lint    : PASSed
;Synopsis      : BfChangePinByName( t_sourcePinName t_destPinName )
;Modification  :
;Description   : This SKILL function deletes the old pins including net name,
;         given by the source pin name and replaces them with a new one,
;                given by the destination pin name.
;                Exception: works only for rectangular pins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  let( ( wrPoint wrPoint1X wrPoint1Y wrPoint2X wrPoint2Y wrPointX wrPointY wrNewRect wrNewLabel wrLabelOrient wrLabelHeight)

    wrNewNet = dbFindNetByName( cv value)
    if( null( wrNewNet)
    then
      wrNewNet = dbCreateNet( cv value)
    )
    
    wrBB = instancepointer->bBox
    ;; get the pin figure layer purpose pair
    wrType = instancepointer->lpp
    wrPoint1X = caar( wrBB)
    wrPoint1Y = cadar( wrBB)
    wrPoint2X = caadr( wrBB)
    wrPoint2Y = cadadr( wrBB)
    wrPointX = round( (wrPoint1X + wrPoint2X)/2 / wrLayoutGrid) * wrLayoutGrid
    wrPointY = round( (wrPoint1Y + wrPoint2Y)/2 / wrLayoutGrid) * wrLayoutGrid
    wrPoint = list( wrPointX wrPointY)
    wrHeight = wrPoint2Y - wrPoint1Y
    wrWidth  = wrPoint2X - wrPoint1X

    ;; delete the current pin
    dbDeleteObject( instancepointer)

    ;; create the new pin shape
    wrNewRect = dbCreateRect( cv wrType wrBB)

    ;; create the new pin    
    dbCreatePin( wrNewNet wrNewRect value)
    
    if(  wrHeight > wrWidth
    then
      wrLabelOrient = "R90"
      wrLabelHeight = wrWidth / 2
    else
      wrLabelOrient = "R0"
      wrLabelHeight = wrHeight / 2
    )
    
    cond(
     ( wrLabelHeight < 0.2
      wrLabelHeight = 0.2
      )
    )
    wrNewLabel = dbCreateLabel( cv wrType wrPoint value "centerCenter" wrLabelOrient "stick" wrLabelHeight)
    leAttachFig( wrNewLabel wrNewRect)
  )
)

procedure( wrSetName( value)
  
  let( ( wrError sel)
  
    instances = geGetSelectedSet( )
    instancepointer = car( instances)
    wrInstType = instancepointer->objType
    wrError = nil
    case( wrInstType
      ( "inst"
      )
      ( ( "rect" "label")
      )
      ( "textDisplay"
	wrText = "error: please select the pin instead of the label"
	wrError = t
      )
      ( t
	wrText = "error: not a instance, pin or label"
	wrError = t
      )
    )
    sel = setof( shape instances shape~>objType != wrInstType)
    if( ! null( sel)
    then
      wrText = "error: select only instances from the same type"
      wrError = t
    )
    if( null( instances)
    then
      wrText = "error: nothing selected"
      wrError = t
    )
    cv = geGetEditCellView( )
    unless( cv->mode != "r"
      wrText = "error: cell must be editable"
       wrError = t
    )
    unless( wrError
      wrLabelName = value
      foreach( instancepointer geGetSelectedSet( )    
	wrInstCellName = instancepointer~>cellName
	case( wrInstType
	  ( "inst"
	    wrText = strcat( "set inst name: " wrLabelName)
	    instancepointer->name = wrLabelName
	  )
	  ( "rect"
	     wrSetRectName( wrLabelName)
	     wrText = strcat( "set pin name: " wrLabelName)
	  )
	  ( "label"
	    wrText = strcat( "set label name: " wrLabelName)
	    instancepointer->theLabel = wrLabelName
	  )
	  ( "textDisplay"
	    wrText = "error: please select the pin instead of the label"
	    wrError = t
	  )
	  ( t
	    wrText = "error: not a instance or label"
	    wrError = t
	  )
	)
	unless( wrError
	  ;; increase name
	  wrShFile = outfile(" ./.wrCadenceFile")
	  fprintf( wrShFile "echo '%s' | perl -pe 's/(\\d+)/ 1 + $1 /ge' > .wrCadenceFile2" wrLabelName)
	  close( wrShFile)
	  sh( "chmod 750 ./.wrCadenceFile")
	  sh( "./.wrCadenceFile")
	  sh( "rm ./.wrCadenceFile")
	  wrShFile = infile(" ./.wrCadenceFile2")
	  wrLabelName = pcExprToString( car( lineread( wrShFile)))
	  close( wrShFile)
	  sh( "rm ./.wrCadenceFile2")
	) ;; if
      ) ;; foreach
    ) ;; unless
    if( stringp( wrText)
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrSetName: " wrText))
    )
  ) ;; let
;; test: wrSetName( "abc")
)

procedure( wrSearch( )

  wrEnterNameWithForm( "Search for" "Search ")
  wrSearchName = wrName
  wrText = strcat( "matches for " wrSearchName)
  wrShFile = outfile(".wrCadenceFile")
  fprintf( wrShFile "echo '%s' | sed -re 's|^|\"|;s|([a-zA-Z])|[\\l\\1\\u\\1]|g;s|$|\"|' > .wrCadenceFile2" wrSearchName)
  close( wrShFile)
  sh( "chmod 750 ./.wrCadenceFile")
  sh( "./.wrCadenceFile")
  wrShFile = infile(" ./.wrCadenceFile2")
  wrSearchNameCase = pcExprToString( car( lineread( wrShFile)))
  close( wrShFile)
  sh( "rm ./.wrCadenceFile")
  rexCompile( wrSearchNameCase)
  wrFilter( "search")
)

procedure( wrSearchReplace( )

  if( wrEnter2NamesWithForm( "Search and replace" "Search " "Replace ")
  then
    wrSearch = wrName
    wrReplace = wrName2
    wrSearchReplaceName( wrSearch wrReplace)
  )
)

procedure( wrSearchReplaceName( wrSearchValue wrReplaceValue)
  
  let( ( instances wrError sel wrText  wrNewLabel)
  
    instances = geGetSelectedSet( )
    instancepointer = car( instances)
    wrInstType = instancepointer->objType
    wrInstCellName = instancepointer->cellName
    cv = geGetEditCellView( )
    wrLibName = cv->libName
    wrError = nil
    wrReplaced = 0
    unless( cv->mode != "r"
      wrText = "error: cell must be editable"
       wrError = t
    )
    sel = setof( shape instances shape~>objType != wrInstType)
    if( ! null( sel)
    then
      wrText = "error: select only instances from the same type"
      wrError = t
    )
    cond(
      ( member( wrSearchValue wrDevices)
	case( wrInstType
	  ( "inst"
	    cond( 
	      ( member( wrInstCellName wrTransistors)
	        wrParam = wrW
		unless( member( wrReplaceValue wrTransistors)
		  wrText = strcat( "error: cannot change transistors to " wrReplaceValue)
		  wrError = t
		)
	      )
	      ( member( wrInstCellName wrResistors)
	        wrParam = wrResW 
		unless( member( wrReplaceValue wrResistors)
		  wrText = strcat( "error: cannot change resistors to " wrReplaceValue)
		  wrError = t
		)
	      )
	      ( member( wrInstCellName wrViaTypes)
	        wrParam = "row"
	      )
	      ( t
	        wrText = strcat( "error: cannot change " wrInstType " yet")
		wrError = t
	      )
	    ) ;; cond
	  )
	  ( t
	    wrText = "error: renaming device names but no instances selected"
	    wrError = t
	  )
	) ;; case
      )
      ( t
	case( wrInstType
	  ( ( "inst" "rect" "label")
	  )
	  ( "textDisplay"
	    wrText = "error: please select the pin instead of the label"
	    wrError = t
	  )
	  ( t
	    wrText = strcat( "error: cannot change " wrInstType)
	    wrError = t
	  )
	)
      )
    ) ;; cond
    unless( wrError
      wrText = "unknown error or no names replaced"
      rexCompile( wrSearchValue)

      cond(
	( member( wrSearchValue list( wrDeviceLibName wrLibName)) || member( wrReplaceValue list( wrDeviceLibName wrLibName))
	  case( wrInstType
	    ( "inst"
	      wrText = strcat( "set inst master: " wrReplaceValue)
              foreach( instancepointer instances
		;; leReplaceAnyInstMaster( instancepointer wrReplaceValue nil "layout"
		leReplaceAnyInstMaster( instancepointer wrReplaceValue nil nil)
		wrInvokeInstCdfCallbacks( instancepointer wrParam)
		wrReplaced++
              )
	    )
	    ( t
               wrText = strcat( "error: cannot change " wrInstType " yet")
	       wrError = t
	    )
	  ) ;; case
	)
	( member( wrSearchValue append( wrDevices wrViaTypes)) || member( wrReplaceValue append( wrDevices wrViaTypes))
	  case( wrInstType
	    ( "inst"
	      wrText = strcat( "set inst master: " wrReplaceValue)
              foreach( instancepointer instances
		;; leReplaceAnyInstMaster( instancepointer "CMOS065" wrReplaceValue "layout")
		leReplaceAnyInstMaster( instancepointer nil wrReplaceValue nil)
		wrInvokeInstCdfCallbacks( instancepointer wrParam)
		wrReplaced++
              )
	    )
	    ( t
               wrText = strcat( "error: cannot change " wrInstType " yet")
	       wrError = t
	    )
	  ) ;; case
	)
	( t
	  case( wrInstType
	      sel = setof( shape instances ( shape~>objType == "inst" && shape~>cellName == wrSearchValue))
	      if( ! null( sel)
	      then
                ;; Search replace instance cell names.
	        wrText = strcat( "set inst cell name: " wrReplaceValue)
		foreach( instancepointer instances
		  leReplaceAnyInstMaster( instancepointer nil wrReplaceValue nil)
		  wrReplaced++
 		) ;; foreach
	      else
                ;; Search replace instance names.
		foreach( instancepointer instances
		  wrOldName = instancepointer->name
		  wrNewName = rexReplace( wrOldName wrReplaceValue 0)
		  if( wrOldName != wrNewName
		  then
		    instancepointer->name = wrNewName
	            wrText = strcat( "set inst name: " wrNewName)
		    wrReplaced++
                  )
		) ;; foreach
	      )
	    )
 	    ( "rect"
	      foreach( instancepointer instances
		wrOldName = instancepointer->net->name
		wrNewName = rexReplace( wrOldName wrReplaceValue 0)
		if( wrOldName != wrNewName
		then
		  wrSetRectName( wrNewName)
	          wrText = strcat( "set pin name: " wrNewName)
		  wrReplaced++
                )
	      ) ;; foreach        
	    )
 	    ( "label"
              foreach( instancepointer instances
		wrOldName = instancepointer->theLabel
		wrNewName = rexReplace( wrOldName wrReplaceValue 0)
		instancepointer->theLabel = wrNewName
		wrReplaced++
              )
              wrText = strcat( "set label name: " wrNewName)
	    )
	  ) ;; case
	)
      ) ;; cond
      if( wrReplaced == 0
      then
        wrText = "no names replaced"
      else
        wrText = strcat( wrText ", " pcExprToString( wrReplaced) " replacements")
      )
    ) ;; unless
    if( stringp( wrText)
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrSearchReplaceName: " wrText))
    )
  ) ;; let
;; test: wrSearchReplaceName( "abc" "cde")
)

procedure( wrCopyPath( copy)
  
  instancepointer = car( geGetSelectedSet( ))
  if( copy == "copy"
  then
    wrPathWidth = instancepointer->width
    wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyPath: copy width: " pcExprToString( wrPathWidth) ))
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyPath: paste width: " pcExprToString( wrPathWidth) ))
    foreach( instancepointer geGetSelectedSet( )    
      if( instancepointer->objType == "path"
      then
        if( wrPathWidth != 0
	then
	  instancepointer->width = wrPathWidth
	else
	  wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyPath: copy first"))
        ) ;; if
      ) ;; if
    ) ;; foreach
  ) ;; if
;; test: wrCopyPath( "copy")
)

procedure( wrCopyLabel( copy)
  
  instancepointer = car( geGetSelectedSet( ))
  if( copy == "copy"
  then
    wrLabelHeight = instancepointer->height
    wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyLabel: height: " pcExprToString( wrLabelHeight) ))
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrPasteLabel: height: " pcExprToString( wrLabelHeight) ))
    foreach( instancepointer geGetSelectedSet( )    
      if( instancepointer->objType == "path"
      then
        if( wrLabelHeight != 0
	then
	  instancepointer->height = wrLabelHeight
	else
	  wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyLabel: copy first"))
        ) ;; if
      ) ;; if
    ) ;; foreach
  ) ;; if
;; test: wrCopyLabel( "copy")
)

procedure( wrCopyVia( copy)
  
  instancepointer = car( geGetSelectedSet( ))
  if( copy == "copy"
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyVia: copy"))
    wrViaRow = dbFindProp( instancepointer "row")->value
    wrViaCol = dbFindProp( instancepointer "column")->value
    wrXSpace = dbFindProp( instancepointer "xCutSpacing")->value
    wrYSpace = dbFindProp( instancepointer "xCutSpacing")->value
    wrSpaceVia = max( wrXSpace wrYSpace)
  else
    foreach( instancepointer geGetSelectedSet( )    
      if( rexMatchp( strcat( wrMetalName "[1-9].*_" wrMetalName "[1-9].*") instancepointer->cellName)
      then
        if( wrViaRow != 0
	then
          dbReplaceProp( instancepointer "row" "integer" wrViaRow)
          dbReplaceProp( instancepointer "column" "integer" wrViaCol)
          dbReplaceProp( instancepointer "xCutSpacing" "float" wrSpaceVia)
          dbReplaceProp( instancepointer "yCutSpacing" "float" wrSpaceVia)
	else
	  wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyVia: copy first"))
        ) ;; if
      ) ;; if
    ) ;; foreach
  ) ;; if
;;c:  test: wrCopyVia( "copy")
)

procedure( wrCopyDevice( copy)

  ;; xxx add bulk contact?
  if( copy == "copy"
  then
    instancepointer = car( geGetSelectedSet( ))
    wrInstLibName = instancepointer->libName
    wrInstCellName = instancepointer->cellName
    wrInstName = instancepointer->name
    wrDeviceW = dbFindProp( instancepointer wrW)->value
    if( stringp( wrDeviceW)
     then
       wrDeviceW = evalstring( wrDeviceW)
       
     )
    wrDeviceL = dbFindProp( instancepointer wrL)->value
    if( stringp( wrDeviceL)
     then
       wrDeviceL = evalstring( wrDeviceL)
     )
    if( member( wrInstCellName wrTransistors)
    then
      wrDeviceF = dbFindProp( instancepointer wrF)->value
      if( stringp( wrDeviceF)
       then
	 wrDeviceF = round( evalstring( wrDeviceF))
       )
      if( dbFindProp( instancepointer "CustomLayout")->value == "TRUE"
      then
        wrDeviceCust = t
      else
        wrDeviceCust = nil
      )
      wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyDevice: " pcExprToString( wrDeviceW) "/" pcExprToString( wrDeviceL)))
    )
    if( member( wrInstCellName wrResistors)
    then
      wrDeviceNuB = dbFindProp( instancepointer wrNuB)->value
      wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyDevice: " pcExprToString( wrDeviceW) "/" pcExprToString( wrDeviceL) " NuB: " pcExprToString( wrDeviceNuB) ))
    )
  else
    wrError = nil
    unless( cv->mode != "r"
      wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyDevice: error: cell must be editable"))
       wrError = t
    )

    unless( wrError
      wrInst = setof( inst geGetSelectedSet( ) member( inst->cellName wrDevices))
      unless( wrInst
	cv = geGetEditCellView( )
	wrViewName = cv->viewName
	wrPoint = geWindowToEditPoint( hiGetCurrentWindow( ) hiGetPoint( hiGetCurrentWindow( )))
	case( wrViewName 
          ( "layout"
	    wrInst = list( dbCreateParamInstByMasterName( 
	      cv
	      wrInstLibName
	      wrInstCellName
	      wrViewName
	      wrInstName 
	      wrPoint 
	      wrOrient
	      1 )
	    )
          )
	  ( "schematic"
	    wrInst = list( dbCreateParamInstByMasterName( 
	      cv
	      wrInstLibName
	      wrInstCellName
	      "symbol"
	      wrInstName 
	      wrPoint 
	      "R0"
	      1 )
	    )
	  )
	)
      ) ;; unless
      foreach( instancepointer wrInst    
	wrInstCellName = instancepointer->cellName
	if( wrDeviceW != 0
	then
	  dbReplaceProp( instancepointer wrW "float" wrDeviceW)
	  dbReplaceProp( instancepointer wrL "float" wrDeviceL)
          wrInvokeInstCdfCallbacks( instancepointer wrW)
          wrInvokeInstCdfCallbacks( instancepointer wrL)
	  if( member( wrInstCellName wrTransistors)
	  then
	    ;; _update_ 060620 extra CustomLayout boolean required. Probably not general.
	    dbReplaceProp( instancepointer "CustomLayout" "boolean" wrDeviceCust)
	    dbReplaceProp( instancepointer wrF "int" wrDeviceF)
            wrInvokeInstCdfCallbacks( instancepointer wrF)
            wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyDevice: paste " pcExprToString( wrDeviceW) "/" pcExprToString( wrDeviceL)))
	  )
	  if( member( wrInstCellName wrResistors)
	  then
            dbReplaceProp( instancepointer wrNuB "integer" wrDeviceNuB)
            wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyDevice: paste " pcExprToString( wrDeviceW) "/" pcExprToString( wrDeviceL) " NuB: " pcExprToString( wrDeviceNuB)))
            wrInvokeInstCdfCallbacks( instancepointer wrNuB)
	  )
	  hiRedraw( )
	else
	  wrWindowName( strcat( wrDecodeBindKeysText ": wrCopyDevice: copy first"))
	) ;; if
      ) ;; foreach
    ) ;; unless
  ) ;; if
;; test: wrCopyDevice( "copy")
)

procedure( wrPropertiesBulk( )

  instancepointer = car( geGetSelectedSet( ))
  wrInstCellName = instancepointer->cellName
  wrDeviceB = dbFindProp( instancepointer wrBulk)->value
  
  if( member( wrInstCellName wrTransistors)
  then
    if( wrDeviceB == "TRUE"
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrPropertiesBulk: turn off"))
    else
      wrWindowName( strcat( wrDecodeBindKeysText ": wrPropertiesBulk: turn on"))
    ) ;; if
  ) ;; if

  foreach( instancepointer geGetSelectedSet( )    
    if( member( wrInstCellName wrTransistors)
    then
      if( wrDeviceB == "TRUE"
      then
        dbReplaceProp( instancepointer wrBulk "boolean" nil)
      else
        dbReplaceProp( instancepointer "CustomLayout" "boolean" t)
        dbReplaceProp( instancepointer wrBulk "boolean" t)      
      )
      wrInvokeInstCdfCallbacks( instancepointer wrBulk)
    ) ;; if
  ) ;; foreach
)

procedure( wrGrow( direction addPath addVia addDevice)

  let( ( instances wrError sel)
  
    cv = geGetEditCellView( )
    wrLibName = cv->libName

    instances = geGetSelectedSet( )
    instancepointer = car( instances)
    wrInstType = instancepointer->objType
    wrInstPurpose = instancepointer->purpose
    wrInstCellName = instancepointer->cellName
    wrError = nil
    cond( 
      ( wrInstPurpose == "pin"
        sel = setof( shape sel shape~>purpose != "pin")
	wrInstType = "pin"
      )
      ( wrInstType == "path" || wrInstType == "rect"
	sel = setof( shape instances shape~>objType != "path" && shape~>objType != "rect" || shape~>purpose == "pin")
	wrInstType = "path"
      )
      ( t
        sel = setof( shape instances shape~>objType != wrInstType)
      )
    )
    
    if( ! null( sel)
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrGrow: error: select only instances from the same type"))
      wrError = t
    )
    
    if( instancepointer != nil && cv->mode == "r"
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrGrow: error: cell must be editable"))
       wrError = t
    )

    wrEdit = ""
    unless( wrError
      case( wrInstType
	( "path"
	  wrGrowPath( direction addPath)
	)
	( "label"
	  wrGrowLabel( direction addDevice)
	)
	( "textDisplay"
	  wrGrowLabel( direction 0.5)
	)
	( "inst"
           wrGrowInst( direction addDevice)
	)
	( "pin"
           wrGrowPin( direction addDevice)
	)
	( t
	  case( direction
	    ( "left"
              wrStopLevel = max( 0 wrStopLevel - 1)
              wrWindowName( strcat( wrDecodeBindKeysText ": wrGrow: no selection: decrease stoplevel to " pcExprToString( wrStopLevel)))
	      hiGetCurrentWindow( )->stopLevel = wrStopLevel
            )
	    ( "right"
	      wrStopLevel = min( 20 wrStopLevel + 1)
              wrWindowName( strcat( wrDecodeBindKeysText ": wrGrow: no selection: increase stoplevel to " pcExprToString( wrStopLevel)))
	      hiGetCurrentWindow( )->stopLevel = wrStopLevel
            )
	  )
	)
      ) ;; case
    ) ;; unless
  ) ;; let
;; test: wrGrow( "up" 1)
)

procedure( wrGrowLabel( direction add)

  let( ( wrValue)
  
    instancepointer = car( geGetSelectedSet( ))
    wrValue = instancepointer->height
    case( direction 
      ( ("down" "left")
	add = -add
      )
    )
    cv = geGetEditCellView( )
    wrViewName = cv->viewName
    if( wrViewName == "schematic"
    then
      add = 0.2
      case( direction 
	( ("down" "left")
	  add = -0.2
	)
      )
    )
    if( wrValue + add < 0.05
    then
      add = 0
    )
    ;; wrValue = instancepointer->height
    ;; 051115 Strange enough when wrValue is 0.4, the resulting height is 0.1 higer!
    ;; with 
    ;; instancepointer->height = 0.4
    ;; the height is ok.
    foreach( instancepointer geGetSelectedSet( )    
      if( instancepointer->objType == "label" || instancepointer->objType == "textDisplay"
      then
	instancepointer->height = wrValue + add
      )
    )
    wrValue = instancepointer->height 
    wrWindowName( strcat( wrDecodeBindKeysText ": wrGrowLabel: " pcExprToString( direction) " to " pcExprToString( wrValue) ))
    hiRedraw( )
  ) ;; let
;; test: wrGrowLabel( "up" 1)
)

procedure( wrGrowPath( direction add)

  wrMessage = nil
  foreach( instancepointer geGetSelectedSet( )    
    if( add < wrPathStepMin
    then
      add = wrPathStepMin
    )
    if( instancepointer->objType == "path"
    then
      wrValue = instancepointer->width
      case( direction 
	("up"
          wrValue = wrValue+add
	)
	("down"
          wrValue = wrValue-add
	)
	("left"
          wrValue = wrValue-add
	)
	("right"
          wrValue = wrValue+add
	)
      )
      case( instancepointer->layerName  
	( wrPo
          wrPathMin = wrPathPoMin
	)
	( wrM1
          wrPathMin = wrPathM1Min
	)
	( t
          wrPathMin = wrPathMin
	)
      )
      if( wrValue < wrPathMin
      then
	wrValue = wrPathMin
        wrMessage = strcat( "\n wrGrowPath: clipped to " pcExprToString( wrPathMin))
      )
      if( wrValue > wrPathMax
      then
        wrValue = wrPathMax
        wrMessage = strcat( "\n wrGrowPath: clipped to " pcExprToString( wrPathMax))
      )
      instancepointer->width = wrValue
    ) ;; if
    if( instancepointer->objType == "rect"
    then
      wrBB = instancepointer->bBox
      wrPoint1X = caar( wrBB)
      wrPoint1Y = cadar( wrBB)
      wrPoint2X = caadr( wrBB)
      wrPoint2Y = cadadr( wrBB)
      wrPointX = (wrPoint1X + wrPoint2X)/2
      wrPointY = (wrPoint1Y + wrPoint2Y)/2
      if( wrPoint2X - wrPoint1X < wrPoint2Y - wrPoint1Y
      then
        wrValue = wrPoint2X - wrPoint1X
	wrOrient = "x"
      else
        wrValue = wrPoint2Y - wrPoint1Y
	wrOrient = "y"
      )
      case( direction 
	("up"
          wrValue = wrValue+add
	)
	("down"
          wrValue = wrValue-add
	)
	("left"
          wrValue = wrValue-add
	)
	("right"
          wrValue = wrValue+add
	)
      )
      case( instancepointer->layerName  
	( wrPo
          wrPathMin = wrPathPoMin
	)
	( wrM1
          wrPathMin = wrPathM1Min
	)
	( t
          wrPathMin = wrPathMin
	)
      )
      if( wrValue < wrPathMin
      then
	wrValue = wrPathMin
        wrMessage = strcat( "\n wrGrowPath: clipped to " pcExprToString( wrPathMin))
      )
      if( wrValue > wrPathMax
      then
        wrValue = wrPathMax
        wrMessage = strcat( "\n wrGrowPath: clipped to " pcExprToString( wrPathMax))
      )
      if( wrOrient == "x"
      then
        wrBBNew = list( list( wrPointX - wrValue/2 wrPoint1Y) list( wrPointX + wrValue/2 wrPoint2Y))
      else
        wrBBNew = list( list( wrPoint1X wrPointY - wrValue/2) list( wrPoint2X wrPointY + wrValue/2))
      )
      instancepointer->bBox = wrBBNew
    ) ;; if
  ) ;; foreach
  unless( ! wrMessage
    printf( wrMessage)
  )
  wrWindowName( strcat( wrDecodeBindKeysText ": wrGrowPath: " pcExprToString( direction) " to " pcExprToString( wrValue)))
  hiRedraw( )
;; test: wrGrowPath( "up" 1)
)

procedure( wrViaSpaceInit_089( )

  unless( wrRow
    wrRow = 1
  )
  unless( wrCol
    wrCol = 1
  )
  if( rexMatchp("M[6-9].*_M[5-9].*" type)
  then
    wrSpaceVia = 0.34
  else
    wrSpaceVia = 0.15
  )
  if( wrRow * wrCol > 3
  then
    if( rexMatchp("M[6-9].*_M[5-9].*" type)
    then
      wrSpaceVia = 0.54
    else
      wrSpaceVia = 0.17
    )
  )
  if( member( type list( wrViaTypeNPo wrViaTypePPo wrViaTypeN wrViaTypeP wrViaTypeN2 wrViaTypeP2))
  then
    if( wrRow * wrCol > 3
    then
      wrSpaceVia = 0.14
    else
      wrSpaceVia = 0.16
    )
  )
)



procedure( wrViaPost( )

  unless( wrRow
    wrRow = 1
  )
  unless( wrCol
    wrCol = 1
  )
  dbReplaceProp( wrVia "row" "integer" wrRow)
  dbReplaceProp( wrVia "column" "integer" wrCol)
  wrParams = techGetDeviceFParam( wrTechFile  wrVia~>cellName  wrVia~>viewName)
  if( member( "xPitch" mapcar( 'car wrParams))
  then
    if( wrRow > 1
    then
      dbReplaceProp( wrVia "xPitch" "float" wrSpaceVia + 0.22)
    )
    if( wrCol > 1
    then
      dbReplaceProp( wrVia "yPitch" "float" wrSpaceVia + 0.32)
    )
  else
    if( wrRow > 1
    then
      dbReplaceProp( wrVia "xCutSpacing" "float" wrSpaceVia)
    )
    if( wrCol > 1
    then
      dbReplaceProp( wrVia "yCutSpacing" "float" wrSpaceVia)
    )
  )
)

procedure( wrGrowInst( direction add)
  
  cond(
    ( member( wrInstCellName wrDevices)
      wrGrowDevice( direction addDevice)
      wrEdit = nil
    )
    ( instancepointer->mag != 1.0
      wrGrowMag( direction)
      wrEdit = nil
    )
    ( instancepointer->libName == wrLibName
      if( wrEdit == ""
      then
        wrEdit = t
       )
    )
    ( member( wrInstCellName wrViaTypes) || rexMatchp( "_" wrInstCellName)
      wrGrowVia( direction addVia)
      wrEdit = nil
    )
  )
)

procedure( wrGrowMag( direction)
  
    wrValue = instancepointer->mag
    if( stringp( wrValue)
     then
       wrValue = evalstring( wrValue)
     )
     case( direction 
       ( "up"
	 wrValue = wrValue * 1.05
       )
       ( "down"
	 wrValue = wrValue / 1.05
       )
     )
     wrValue = float( round( wrValue*100))/100
     wrWindowName( strcat( wrDecodeBindKeysText ": wrGrowMag: set to " pcExprToString( wrValue)))
     instancepointer->mag = wrValue
)

procedure( wrGrowPin( direction add)
  
  let( ( wrText wrPinInst wrAddX wrAddY wrBB wrPoint1 wrPoint2 wrPoint1X wrPoint1Y wrPoint2X wrPoint2Y wrPointX wrPointY wrWidthX wrWidthY wrWidth)

    wrPinInst = setof( inst geGetSelectedSet( ) inst->purpose == "pin")
    unless( wrPinInst
      wrText = "error: no pins selected"
      wrError = t
    )
    
   unless( wrError
     if( add == wrStepMin
     then
       add = 2 * add
     )
     case( direction 
       ( ("down" "left")
	 add = -add
       )
     )
     foreach( instancepointer wrPinInst
	wrBB = instancepointer->bBox
	wrAddX = 0
	wrAddY = 0
	wrPoint1X = caar( wrBB)
	wrPoint1Y = cadar( wrBB)
	wrPoint2X = caadr( wrBB)
	wrPoint2Y = cadadr( wrBB)
	wrPointX = round( (wrPoint1X + wrPoint2X)/2 / wrLayoutGrid) * wrLayoutGrid
	wrPointY = round( (wrPoint1Y + wrPoint2Y)/2 / wrLayoutGrid) * wrLayoutGrid
	wrWidthX = wrPoint2X - wrPoint1X
	wrWidthY = wrPoint2Y - wrPoint1Y
        case( direction 
	  ( ("up" "down")
	    wrWidthY = wrWidthY + add
	  )
	  ( ("left" "right")
	    wrWidthX = wrWidthX + add
	  )
        )
	if( wrWidthX < wrPathMin
	then
          wrWidthX = wrPathMin
	)
	if( wrWidthY < wrPathMin
	then
          wrWidthY = wrPathMin
	)
	wrPoint1X = wrPointX - wrWidthX / 2
	wrPoint1Y = wrPointY - wrWidthY / 2
	wrPoint2X = wrPointX + wrWidthX / 2
	wrPoint2Y = wrPointY + wrWidthY / 2
	wrPoint1 = list( wrPoint1X wrPoint1Y)
	wrPoint2 = list( wrPoint2X wrPoint2Y)
	instancepointer->bBox = list( wrPoint1 wrPoint2)
      ) ;; foreach
      unless( null( wrPoint2Y)
        case( direction 
	  ( ("up" "down")
	    wrWidth = wrPoint2Y - wrPoint1Y
	  )
	  ( ("left" "right")
	    wrWidth = wrPoint2X - wrPoint1X
	  )
        )
        wrText = strcat( pcExprToString( direction) " to " pcExprToString( wrWidth))
      )
    ) ;; unless
    if( stringp( wrText)
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrGrowPin: " wrText))
    else
      wrWindowName( strcat( wrDecodeBindKeysText ": wrGrowPin: unknown error"))
    )
  ) ;; let
)

procedure( wrGrowVia( direction add)
  
  let( ( wrError sel)
  
    wrError = nil
    sel = setof( inst geGetSelectedSet( ) not( member( inst->cellName wrViaTypes)) && not( rexMatchp( "_" inst->cellName)))
    if( ! null( sel)
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrGrow: error: select only transistors"))
      wrError = t
    )
    
    unless( wrError
      wrViaInst = setof( inst geGetSelectedSet( ) member( inst->cellName wrViaTypes) || rexMatchp( "_" inst->cellName))
      foreach( wrVia wrViaInst
	type = wrVia->cellName
	wrOrient = wrVia->orient
	wrParam = 1
	if( direction == "up" || direction == "down" 
	then
	  wrParam = -wrParam
	)
	case( wrOrient
	  ( ("R90" "R270" "MYR90" "MXR90")
	  wrParam = -wrParam
	  )
	)
	if( wrParam == -1
	then
	  wrParam = "row"
	  wrParamOther = "column"
	else
	  wrParam = "column"
	  wrParamOther = "row"
	)
	wrValue = dbFindProp( wrVia wrParam)->value
	wrValueOther = dbFindProp( wrVia wrParamOther)->value
	unless( wrValue
	  wrValue = 1
	)
	unless( wrValueOther
	  wrValueOther = 1
	)
	if( direction == "up" || direction == "right" 
	then
	  wrValue = wrValue+add
	else
	  wrValue = wrValue-add
	)
	if( wrValue < 1
	then
	  wrValue = 1
	)
	if( wrParam == "row"
	then
	  wrRow = wrValue
	  wrCol = wrValueOther
	else
	  wrCol = wrValue
	  wrRow = wrValueOther
	)
	dbReplaceProp( wrVia wrParam "integer" wrValue)
	wrViaSpaceInit( )
	wrViaPost( )
      ) ;; foreach
      wrWindowName( strcat( wrDecodeBindKeysText ": wrGrowVia: set " pcExprToString( wrParam) " to " pcExprToString( wrValue) ))
    ) ;; unless
  ) ;; let
;; test: wrGrowVia( "up" 1)
)

procedure( wrGetClosePoint( wrPoint wrPointOrg wrPointList)

  let( ( wrPointX wrPointY wrPointOrgX wrPointOrgY wrPointListPoint)

    wrPointX = xCoord( wrPoint)
    wrPointY = yCoord( wrPoint)
    wrPointOrgX = xCoord( wrPointOrg)
    wrPointOrgY = yCoord( wrPointOrg)
    foreach( wrPointListPoint wrPointList
      if( abs( xCoord( wrPointListPoint) - wrPointOrgX) < abs( wrPointX - wrPointOrgX)
      then
	;; printf( "x closer")
	wrPointX = xCoord( wrPointListPoint)
      )
      if( abs( yCoord( wrPointListPoint) - wrPointOrgY) < abs( wrPointY - wrPointOrgY)
      then
	;; printf( "y closer")
	wrPointY = yCoord( wrPointListPoint)
      )
    )
    wrPoint = list( wrPointX wrPointY)
    wrPoint
  ) ;; let
;; test: wrGetClosePoint( wrPoint wrPointOrg instancepointer~>points)
;; test: wrGetClosePoint( list(-90000 -90000) list(13.555 2.555) list(list(13.333 5.333) list(13.333 -0.333)))
)

procedure( wrAddVia( type @optional point)

  testType = wrViaTable[ type ]
  if( testType != 0
  then
    type = testType
  )
  
  wrViaView = "layout"
  unless( ddGetObj( wrDeviceTechLibName type wrViaView)
    wrViaView = "symbolic"
  )
  
  wrAddViaCount = 0
  wrNewVias = list( )
  cv = geGetEditCellView( )
  if( null( point)
  then
    wrPointOrg = geWindowToEditPoint( hiGetCurrentWindow( ) hiGetPoint( hiGetCurrentWindow( )))
    wrPoint = list( -90000 -90000)
    wrPointList = list( )
    wrBB = wrGetBBView( )
    wrViaInst = setof( inst geGetSelectedSet( ) inst->objType == "inst")
    wrViaInst = setof( inst wrViaInst member( inst->cellName wrViaTypes) || rexMatchp( strcat( wrMetalName "[1-9].*_" wrMetalName "[1-9].*") inst->cellName))
    foreach( instancepointer wrViaInst
      ;; Add vias on top of other vias.
      wrPoint = instancepointer->xy
      unless( member( wrPoint wrPointList)
        if( xCoord( wrPoint) > xCoord( car( wrBB)) && xCoord( wrPoint) < xCoord( cadr( wrBB)) && yCoord( wrPoint) > yCoord( car( wrBB)) && yCoord( wrPoint) < yCoord( cadr( wrBB))
	then
	  wrOrient = instancepointer->orient
	  wrRow = dbFindProp( instancepointer "row")->value
	  wrCol = dbFindProp( instancepointer "column")->value
	  wrPointList = cons( wrPoint wrPointList)
	  wrAddViaCount++
	  wrVia = dbCreateParamInstByMasterName( 
	    cv
	    wrDeviceTechLibName
	    type 
	    wrViaView 
	    nil 
	    wrPoint 
	    wrOrient
	    1
	  )
	  wrViaSpaceInit( )
          wrViaPost( )
	  geSelectObject( wrVia)
	  wrNewVias = cons( wrVia wrNewVias)
	)
      ) ;; unless
    ) ;; foreach
    if( not( null( wrViaInst))
    then
      case( wrAddViaCount
        ( 0
          wrWindowName( strcat( wrDecodeBindKeysText ": wrAddVia: added no " type " via, unknown problem"))
	)
	( 1
          wrWindowName( strcat( wrDecodeBindKeysText ": wrAddVia: add 1 " type " via"))
	)
	( t
        wrWindowName( strcat( wrDecodeBindKeysText ": wrAddVia: add " pcExprToString( wrAddViaCount) " " type " vias"))
        )
      )
    )
    if( null( wrViaInst)
    then
      wrPaths = setof( inst geGetSelectedSet( ) (inst->objType == "path" || inst->objType == "polygon"))
      foreach( instancepointer wrPaths
	wrPoint = wrGetClosePoint( wrPoint wrPointOrg instancepointer~>points)
	geDeselectFig( instancepointer)
      )
      unless( car( wrPointList)
	if( xCoord( wrPoint) < xCoord( car( wrBB)) || xCoord( wrPoint) > xCoord( cadr( wrBB))
	then
	  wrPoint = list( xCoord( wrPointOrg) yCoord( wrPoint))
	)
	if( yCoord( wrPoint) < yCoord( car( wrBB)) || yCoord( wrPoint) > yCoord( cadr( wrBB))
	then
	  wrPoint = list( xCoord( wrPoint) yCoord( wrPointOrg) )
	)
	wrAddViaCount++
	wrVia = dbCreateParamInstByMasterName( 
	  cv
	  wrDeviceTechLibName
	  type 
	  wrViaView 
	  nil 
	  wrPoint 
	  wrOrient
	  1
	)
	wrViaSpaceInit( )
	wrViaPost( )
	geSelectObject( wrVia)
	wrNewVias = cons( wrVia wrNewVias)
      ) ;; unless
    ) ;; if
  else
    wrAddViaCount++
    wrVia = dbCreateParamInstByMasterName( 
      cv
      wrDeviceTechLibName
      type 
      wrViaView 
      nil 
      point 
      wrOrient
      1
    )
    wrViaSpaceInit( )
    wrViaPost( )
    geSelectObject( wrVia)
    wrNewVias = cons( wrVia wrNewVias)
  )
)

procedure( wrRotateInst( )

  foreach( instancepointer geGetSelectedSet( )
    unless( null( instancepointer->orient)
      wrOrient = instancepointer->orient
      case( wrOrient
	( "R0"
	  wrOrient = "R90"
	)
	( "R90"
	  wrOrient = "R180"
	)
	( "R180"
	  wrOrient = "R270"
	)
	( "R270"
	  wrOrient = "R0"
	)
	( "MY"
	  wrOrient = "MYR90"
	)
	( "MYR90"
	  wrOrient = "MX"
	)
	( "MX"
	  wrOrient = "MXR90"
	)
	( "MXR90"
	  wrOrient = "MY"
	)
      )
      instancepointer->orient = wrOrient
    ) ;; unless
  ) ;; foreach
)

procedure( wrRotateVia( )

  wrViaInst = setof( inst geGetSelectedSet( ) member( inst->cellName wrViaTypes) || rexMatchp( strcat( wrMetalName "[1-9].*_" wrMetalName "[1-9].*") inst->cellName))
  foreach( wrVia wrViaInst
    unless( null( wrVia->orient)
      wrOrient = wrVia->orient
      case( wrOrient
	( "R0"
	  wrOrient = "R90"
	)
	( "R90"
	  wrOrient = "R180"
	)
	( "R180"
	  wrOrient = "R270"
	)
	( "R270"
	  wrOrient = "R0"
	)
	( "MY"
	  wrOrient = "MYR90"
	)
	( "MYR90"
	  wrOrient = "MX"
	)
	( "MX"
	  wrOrient = "MXR90"
	)
	( "MXR90"
	  wrOrient = "MY"
	)
      )
      wrVia->orient = wrOrient
      wrCol = dbFindProp( wrVia "row")->value
      wrRow = dbFindProp( wrVia "column")->value
      unless( wrRow
        wrRow = 1
      )
      unless( wrCol
        wrCol = 1
      )
      wrViaPost( )
    ) ;; unless
  ) ;; foreach
)


procedure( wrAddAutoVia( )

  wrAddViaCount = 0
  wrPointOrg = geWindowToEditPoint( hiGetCurrentWindow( ) hiGetPoint( hiGetCurrentWindow( )))
  wrSelectedPaths = setof( inst geGetSelectedSet( ) (inst->objType == "path" || inst->objType == "polygon"))
  wrNpaths = 0
  foreach( instancepointer wrSelectedPaths
    ;; wrSelectedPaths = cons( instancepointer wrSelectedPaths)
    wrNpaths = wrNpaths+1
  )
  if( onep( wrNpaths)
  then
    wrSelectedPaths = nil
    wrNpaths = 0
  )

  unless( wrSelectedPaths
    geDeselectAll( )
    geAddSelectPoint( )
    geAddSelectPoint( )
    geAddSelectPoint( )
    geAddSelectPoint( )
    geAddSelectPoint( )
    geAddSelectPoint( )
    geAddSelectPoint( )
    wrNpaths = 0
    foreach( instancepointer geGetSelectedSet( )    
      if( instancepointer->objType == "path" || instancepointer->objType == "polygon"
      then
	wrSelectedPaths = cons( instancepointer wrSelectedPaths)
	wrNpaths = wrNpaths+1
      )
    )
  ) ;; unless
  case( wrNpaths
    ( 0
      wrWindowName( strcat( wrDecodeBindKeysText ": wrAddAutoVia: no paths found"))
    )
    ( 1
      rexCompile( "[0-9]+")
      wrPathFirst = 99
      wrPathLast = 0
      foreach(db dbGetTrueOverlaps(cv list(wrPointOrg wrPointOrg) t 0:32)
	;; obtain the layerName and purpose and print
	layerPurposePair = CCSgetLayAndPurpose(db)
	case( cadr( layerPurposePair)
	  ( ("drawing" "pin")
	    rexExecute( car( layerPurposePair))
	    wrPathLayer = evalstring( rexSubstitute( "\\0"))
	    if( wrPathLayer > wrPathLast
	    then
	      wrPathFirst = wrPathLast
	      wrPathLast = wrPathLayer
	    )
	  )
	)
      );foreach
      wrBB = wrGetBBView( )
      if( xCoord( wrPoint) < xCoord( car( wrBB)) || xCoord( wrPoint) > xCoord( cadr( wrBB))
      then
	wrPoint = list( xCoord( wrPointOrg) yCoord( wrPoint))
      )
      if( yCoord( wrPoint) < yCoord( car( wrBB)) || yCoord( wrPoint) > yCoord( cadr( wrBB))
      then
	wrPoint = list( xCoord( wrPoint) yCoord( wrPointOrg) )
      )
      geDeselectAll( )
      if( ( wrPathFirst >= 1 && wrPathLast <= 6 && wrPathLast > wrPathFirst)
      then
	wrAutoNewVias = list( )
	wrViaList = ""
	for( wrI wrPathFirst wrPathLast-1
          wrAddVia( strcat( "v" pcExprToString( wrI)) wrPoint)
	  wrAutoNewVias = append( wrNewVias wrAutoNewVias)
	  wrViaList = strcat( wrViaList " via" pcExprToString( wrI))
	)
	wrNewVias = wrAutoNewVias
        wrWindowName( strcat( wrDecodeBindKeysText ": wrAddAutoVia: added 1x" wrViaList))
      else
	wrWindowName( strcat( wrDecodeBindKeysText ": wrAddAutoVia: no valid paths found"))
      )
      if( wrPath->objType == "path"
      then
	wrPoint = wrGetClosePoint( wrPoint wrPointOrg wrPath~>points)
      )
    )
    ( t
      ;; count paths
      rexCompile( "[0-9]+")
      wrPathFirst = 99
      wrPathLast = 0
      wrPoint = list( -90000 -90000)
      foreach( wrPath wrSelectedPaths
	if( rexExecute( wrPath->layerName)
	then
	  wrPathLayer = evalstring( rexSubstitute( "\\0"))
	  if( wrPathLayer < wrPathFirst
	  then
	    wrPathFirst = wrPathLayer
	    if( wrPath->objType == "path"
	    then
	      wrPoint = wrGetClosePoint( wrPoint wrPointOrg wrPath~>points)
	    )
	  )
          if( wrPathLayer > wrPathLast
	  then
	    wrPathLast = wrPathLayer
	    if( wrPath->objType == "path"
	    then
	      wrPoint = wrGetClosePoint( wrPoint wrPointOrg wrPath~>points)
	    )
	  )
	) ;; if
      ) ;; foreach
      wrBB = wrGetBBView( )
      if( xCoord( wrPoint) < xCoord( car( wrBB)) || xCoord( wrPoint) > xCoord( cadr( wrBB))
      then
	wrPoint = list( xCoord( wrPointOrg) yCoord( wrPoint))
      )
      if( yCoord( wrPoint) < yCoord( car( wrBB)) || yCoord( wrPoint) > yCoord( cadr( wrBB))
      then
	wrPoint = list( xCoord( wrPoint) yCoord( wrPointOrg) )
      )
      geDeselectAll( )
      if( ( wrPathFirst >= 1 && wrPathLast <= 6 && wrPathLast > wrPathFirst)
      then
	wrAutoNewVias = list( )
	wrViaList = ""
	for( wrI wrPathFirst wrPathLast-1
          wrAddVia( strcat( "v" pcExprToString( wrI)) wrPoint)
	  wrAutoNewVias = append( wrNewVias wrAutoNewVias)
	  wrViaList = strcat( wrViaList " via" pcExprToString( wrI))
	)
	wrNewVias = wrAutoNewVias
        wrWindowName( strcat( wrDecodeBindKeysText ": wrAddAutoVia: added 1x" wrViaList))
      else
	wrWindowName( strcat( wrDecodeBindKeysText ": wrAddAutoVia: no valid paths found"))
      )
    )
  ) ;; case
)

procedure( wrSelectNewVias( )

  let( ( instancepointer)
    
    geDeselectAll( )
    foreach( instancepointer wrNewVias
      geSelectObject( instancepointer)
    )
  )
)

procedure( wrGrowDevice( direction add)
  
  let( ( wrError sel)
  
    wrError = nil
    if( member( wrInstCellName wrTransistors)
    then
      sel = setof( inst geGetSelectedSet( ) not( member( inst->cellName wrTransistors)))
      if( ! null( sel)
      then
	wrWindowName( strcat( wrDecodeBindKeysText ": wrGrow: error: select only transistors"))
	wrError = t
      )
    )
    if( member( wrInstCellName wrResistors)
    then
      sel = setof( inst geGetSelectedSet( ) not( member( inst->cellName wrResistors)))      
      if( ! null( sel)
      then
	wrWindowName( strcat( wrDecodeBindKeysText ": wrGrow: error: select only resistors"))
	wrError = t
      )
    )
    
    unless( wrError
      foreach( instancepointer geGetSelectedSet( ) 
	wrInstCellName = instancepointer~>cellName
	if( member( wrInstCellName wrDevices)
	then
	  case( direction 
	    ("up"
              wrParam = wrL
	    )
	    ("down"
              wrParam = wrL
	    )
	    ("left"
              wrParam = wrW
	    )
	    ("right"
              wrParam = wrW
	    )
	  )
	  if( member( wrInstCellName wrTransistorsGO1)
	  then
	    wrParamWmin = wrParamGO1Wmin
	    wrParamLmin = wrParamGO1Lmin
	  )
	  if( member( wrInstCellName wrTransistorsGO2n)
	  then
	    wrParamWmin = wrParamGO2nWmin
	    wrParamLmin = wrParamGO2nLmin
	  )
	  if( member( wrInstCellName wrTransistorsGO2p)
	  then
	    wrParamWmin = wrParamGO2pWmin
	    wrParamLmin = wrParamGO2pLmin
	  )
	  if( member( wrInstCellName wrTransistorsGO3)
	  then
	    wrParamWmin = wrParamGO3Wmin
	    wrParamLmin = wrParamGO3Lmin
	  )
	  if( member( wrInstCellName wrResistors)
	  then
	    wrParamWmin = wrParamResWmin
	    wrParamLmin = wrParamResLmin
	    case( direction 
	      ("up"
        	wrParam = wrResL
	      )
	      ("down"
        	wrParam = wrResL
	      )
	      ("left"
        	wrParam = wrResW
	      )
	      ("right"
        	wrParam = wrResW
	      )
	    )
	  )
	  wrValue = dbFindProp( instancepointer wrParam)->value
	 if( stringp( wrValue)
	  then
            wrValue = evalstring( wrValue)
	  )
	  case( direction 
	    ("up"
              wrValue = wrValue+add
	    )
	    ("down"
              wrValue = wrValue-add
	    )
	    ("left"
              wrValue = wrValue-add
	    )
	    ("right"
              wrValue = wrValue+add
	    )
	  )
	  if( wrParam == wrW
	  then
            if( wrValue < wrParamWmin
	    then
	      wrValue = wrParamWmin
	    else
              wrDeviceF = dbFindProp( instancepointer wrF)->value
	      if( stringp( wrDeviceF)
	       then
        	 wrDeviceF = evalstring( wrDeviceF)
	       )
 	      unless( wrDeviceF
		wrDeviceF = 1
	      )
	      wrValue = float( round( wrValue / ( wrStepMin * wrDeviceF))) * wrStepMin * wrDeviceF
	    )
	    wrDeviceW = wrValue
	  )
	  if( wrParam == wrL
	  then
            if( wrValue < wrParamLmin
	    then
	      wrValue = wrParamLmin
	    else
	      wrValue = float( round( wrValue / wrStepMin)) * wrStepMin
	    )
	    wrDeviceL = wrValue
	  )
	  dbReplaceProp( instancepointer wrParam "float" wrValue)
	  wrValue = dbFindProp( instancepointer wrParam)->value
	  wrInvokeInstCdfCallbacks( instancepointer wrParam)
	  wrWindowName( strcat( wrDecodeBindKeysText ": wrGrowDevice: " pcExprToString( wrParam) " to " pcExprToString( wrValue) ))
	) ;; if
      ) ;; foreach
      hiRedraw( )
    ) ;; unless
  ) ;; let
  ;; test: wrGrowDevice( "up" 1)
)

procedure( wrMultW( value)
  
  instancepointer = car( geGetSelectedSet( ))
  if( null( instancepointer)
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrMultW: please select something first" ))
  )
  foreach( instancepointer geGetSelectedSet( ) 
    wrInstCellName = instancepointer~>cellName
    if( member( wrInstCellName wrDevices)
    then
      wrParam = wrW
      if( member( wrInstCellName wrTransistorsGO1)
      then
	wrParamWmin = wrParamGO1Wmin
      )
      if( member( wrInstCellName wrTransistorsGO2n)
      then
	wrParamWmin = wrParamGO2nWmin
      )
      if( member( wrInstCellName wrTransistorsGO2p)
      then
	wrParamWmin = wrParamGO2pWmin
      )
      if( member( wrInstCellName wrTransistorsGO3)
      then
	wrParamWmin = wrParamGO3Wmin
      )
      if( member( wrInstCellName wrResistors)
      then
	wrParamWmin = wrParamResWmin
        wrParam = wrResL
      )
      wrValue = dbFindProp( instancepointer wrParam)->value
     if( stringp( wrValue)
      then
        wrValue = evalstring( wrValue)
      )
      wrValue = wrValue*value
      if( wrValue < wrParamWmin
      then
	wrValue = wrParamWmin
      else
	wrValue = float( round( wrValue / wrStepMin)) * wrStepMin
      )
      wrDeviceW = wrValue
      wrWindowName( strcat( wrDecodeBindKeysText ": wrMultW: " pcExprToString( wrParam) " to " pcExprToString( wrValue) ))
      dbReplaceProp( instancepointer wrParam "float" wrValue)
      wrInvokeInstCdfCallbacks( instancepointer wrParam)
    ) ;; if
  ) ;; foreach
  hiRedraw( )
;; test: wrMultW( 2)
)

procedure( wrFold( direction add)
  
  instancepointer = car( geGetSelectedSet( ))
  if( null( instancepointer)
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrFold: please select something first" ))
  )
  foreach( instancepointer geGetSelectedSet( ) 
    wrInstCellName = instancepointer~>cellName
    if( member( wrInstCellName wrTransistors)
    then
      wrParam = wrF
    )
    if( member( wrInstCellName wrResistors)
    then
      wrParam = wrNuB
    )
    wrValue = dbFindProp( instancepointer wrParam)->value
    if( stringp( wrValue)
     then
       wrValue = evalstring( wrValue)
     )
     case( direction 
       ( "up"
	 wrValue = wrValue+add
       )
       ( "down"
	 wrValue = wrValue-add
       )
     )
     if( wrValue < 0
     then
       wrValue = 0
     )
     wrValue = round( wrValue)
     wrWindowName( strcat( wrDecodeBindKeysText ": wrFold: set to " pcExprToString( wrValue)))
     dbReplaceProp( instancepointer wrParam "int" wrValue)
     wrInvokeInstCdfCallbacks( instancepointer wrParam)
  ) ;; foreach
  hiRedraw( )
;; test: wrFold( "up" 1)
)

procedure( wrMult( direction add)
  
  instancepointer = car( geGetSelectedSet( ))
  if( null( instancepointer)
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrMult: please select something first" ))
  )
  foreach( instancepointer geGetSelectedSet( ) 
    wrInstCellName = instancepointer~>cellName
    if( member( wrInstCellName wrDevices)
    then
      wrParam = wrM
    )
    wrValue = dbFindProp( instancepointer wrParam)->value
    if( stringp( wrValue)
     then
       wrValue = evalstring( wrValue)
     )
     case( direction 
       ( "up"
	 wrValue = wrValue+add
       )
       ( "down"
	 wrValue = wrValue-add
       )
     )
     if( wrValue < 1
     then
       wrValue = 1
     )
     wrValue = round( wrValue)
     wrWindowName( strcat( wrDecodeBindKeysText ": wrMult: set to " pcExprToString( wrValue)))
     dbReplaceProp( instancepointer wrParam "int" wrValue)
     wrInvokeInstCdfCallbacks( instancepointer wrParam)
  ) ;; foreach
  hiRedraw( )
;; test: wrMult( "up" 1)
)

procedure( wrSpaceCoPo( direction add)
  
  instancepointer = car( geGetSelectedSet( ))
  if( null( instancepointer)
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrSpaceCoPo: please select something first" ))
  )
  foreach( instancepointer geGetSelectedSet( ) 
    wrInstCellName = instancepointer~>cellName
    wrParam = wrSpaceCoPoS
    wrValue = dbFindProp( instancepointer wrParam)->value
    if( stringp( wrValue)
     then
       wrValue = evalstring( wrValue)
     )
     case( direction 
       ( "up"
	 wrValue = wrValue+add
       )
       ( "down"
	 wrValue = wrValue-add
       )
     )
     if( wrValue < 0
     then
       wrValue = 0
     )
     wrWindowName( strcat( wrDecodeBindKeysText ": wrSpaceCoPo: set to " pcExprToString( wrValue)))
     dbReplaceProp( instancepointer wrParam "float" wrValue)
     wrInvokeInstCdfCallbacks( instancepointer wrParam)
     if( stringp( wrSpaceCoPoD)
     then
       dbReplaceProp( instancepointer wrSpaceCoPoD "float" wrValue)
       wrInvokeInstCdfCallbacks( instancepointer wrSpaceCoPoD)
     )
  ) ;; foreach
  hiRedraw( )
;; test: wrSpaceCoPo( "up" wrStepMin)
)

procedure( wrFilter( type)

  let( ( instances sel )
    
    instances = geGetSelectedSet( )
    wrLastSelection = instances

    unless( instances
      geAddSelectBox( hiGetCurrentWindow( ) t wrGetBBView( ))
      instances = geGetSelectedSet( )
      geDeselectAll( )
    )
    
    wrText = type
    case( type 
      ( "cells"
        sel = setof( shape instances ( shape~>objType == "inst" && shape~>libName == wrLibName))
      )
      ( "notCells"
        sel = setof( shape instances ( shape~>objType == "inst" && shape~>libName != wrLibName))
      )
      ( "devices"
        sel = setof( shape instances shape~>libName == wrDeviceTechLibName || shape~>libName == wrDeviceTechLibName2)
      )
      ( "notDevices"
        sel = setof( shape instances shape~>libName != wrDeviceTechLibName && shape~>libName != wrDeviceTechLibName2)
      )
      ( "text"
        sel = setof( shape instances shape~>objType == "label")						
      )
      ( "notText"
        sel = setof( shape instances shape~>objType != "label")						
      )
      ( "layer"
        sel = setof( shape instances shape~>objType != "inst" && car( shape~>lpp) == car( leGetEntryLayer( )))
        wrText = strcat( "items in layer " car( leGetEntryLayer( )))
      )
      ( "notLayer"
        sel = setof( shape instances shape~>objType != "inst" && car( shape~>lpp) != car( leGetEntryLayer( )))
        wrText = strcat( "items not in layer " car( leGetEntryLayer( )))
      )
      ( "markers"
        sel = setof( shape instances shape~>layerName == "marker")						
      )
      ( "notMarkers"
        sel = setof( shape instances shape~>layerName != "marker")						
      )
      ( "pins"
        sel = setof( shape instances shape~>objType == "rect" && shape~>purpose == "pin")						
      )
      ( "notPins"
        sel = setof( shape instances shape~>objType == "rect" && shape~>purpose != "pin")						
      )
      ( "paths"
        sel = setof( shape instances shape~>objType == "path" || shape~>objType == "rect")						
      )
      ( "notPaths"
        sel = setof( shape instances shape~>objType != "path")						
      )
      ( "vias"
        sel = setof( shape instances shape~>libName == wrDeviceTechLibName || shape~>libName == wrDeviceTechLibName2)
	sel = setof( inst sel member( inst->cellName wrViaTypes) || rexMatchp( strcat( wrMetalName "[1-9].*_" wrMetalName "[1-9].*") inst->cellName))
      )
      ( "notVias"
        sel1 = setof( shape instances not( shape~>libName == wrDeviceTechLibName || shape~>libName == wrDeviceTechLibName2))
        sel = setof( shape instances shape~>libName == wrDeviceTechLibName || shape~>libName == wrDeviceTechLibName2)
	sel = append( sel1 setof( inst sel not( member( inst->cellName wrViaTypes) || rexMatchp( strcat( wrMetalName "[1-9].*_" wrMetalName "[1-9].*") inst->cellName))))
      )
      ( "wires"
        sel = setof( shape instances shape~>purpose == "drawing" && shape~>layerName == "wire")						
      )
      ( "notWires"
        sel = setof( shape instances shape~>purpose == "drawing" && shape~>layerName != "wire")						
      )
      ( "search"
	sel = setof( shape instances rexExecute( pcExprToString( shape~>libName)) || rexExecute( pcExprToString( shape->cellName)) || rexExecute( pcExprToString( shape->theLabel)) || rexExecute( pcExprToString( shape->name)) || rexExecute( pcExprToString( shape->net->name)) || rexExecute( pcExprToString( shape~>width)) || rexExecute( pcExprToString( dbFindProp( shape wrW)->value)) || rexExecute( pcExprToString( dbFindProp( shape wrL)->value)))
      )
      ( t
        wrWindowName( strcat( wrDecodeBindKeysText ": wrFilter: unknown type: " type))
      )
    )
    if( null( car( sel))
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrFilter: " wrText " no match"))
    else
      geDeselectAll( )
      wrWindowName( strcat( wrDecodeBindKeysText ": wrFilter: " pcExprToString( length( sel)) " " wrText " found"))
      foreach(item sel
	geSelectObject( item)
      )
    )
  )
;; test: wrFilter( "devices")
;; test: wrFilter( "search")
)

procedure( wrFilterSize( type)

  let( ( instances wrInstTypeFirst wrPaths sel wrBB wrPoint1X wrPoint1Y wrPoint2X wrPoint2Y wrRow wrCol wrMin wrMax wrText)
    
    wrError = nil
    wrCount = geGetSelSetCount( )
    if( wrCount == 0
    then
       wrText = "error: please select something first"
       wrError = t
    )
    
    unless( wrError

      instances = geGetSelectedSet( )
      wrLastSelection = instances
      wrLastSelectionCount = geGetSelSetCount( )
      wrInstTypeFirst = car( instances)->objType
      if( wrInstTypeFirst == "rect"
	wrInstTypeFirst = "path"
      )
      wrError = nil
      foreach( instancepointer instances
        wrInstType = instancepointer->objType
	if( wrInstType == "rect"
	  wrInstType = "path"
	)
	if( wrInstType != wrInstTypeFirst
	then
	  wrText = "error: select only instances from the same type"
	  wrError = t
	)
      )

      case( wrInstType
	( "inst"
	  instances = setof( inst instances member( inst->cellName wrViaTypes) || rexMatchp( strcat( wrMetalName "[1-9].*_" wrMetalName "[1-9].*") inst->cellName))
	  wrCount = geGetSelSetCount( )
	  if( wrCount == 0
	  then
	    wrText = "error: Not able to filter cells other than vias on size"
	    wrError = t
	  )
	)
      )    
    )
    
    unless( wrError
    
      wrPaths = nil
      foreach( instancepointer instances
        wrInstType = instancepointer->objType
        case( wrInstType
	  ( "path"
	    ;; get biggest width
	    wrValue = instancepointer->width
	    wrPaths = "width"
	  )
	  ( "rect"
	    wrBB = instancepointer->bBox
	    wrPoint1X = caar( wrBB)
	    wrPoint1Y = cadar( wrBB)
	    wrPoint2X = caadr( wrBB)
	    wrPoint2Y = cadadr( wrBB)
	    wrValue = min( wrPoint2X - wrPoint1X wrPoint2Y - wrPoint1Y)
	  )
	  ( "inst"
	    wrRow = dbFindProp( instancepointer "row")->value
	    wrCol = dbFindProp( instancepointer "column")->value
	    unless( wrRow
              wrRow = 1
	    )
	    unless( wrCol
              wrCol = 1
	    )
	    wrValue = wrRow * wrCol
	  )
        ) ;; case
	unless( wrMin
          wrMin = wrValue
          wrMax = wrValue
	)
        wrMin = min( wrValue wrMin)
	wrMax = max( wrValue wrMax)
      ) ;; foreach
      
      case( wrInstType
	( "path"
	  if( wrMin == wrMax
	  then
	    wrPaths = "bBox"
	    wrMin = nil
	    wrmax = nil
	    foreach( instancepointer instances
              wrInstType = instancepointer->objType
	      wrBB = instancepointer->bBox
	      wrPoint1X = caar( wrBB)
	      wrPoint1Y = cadar( wrBB)
	      wrPoint2X = caadr( wrBB)
	      wrPoint2Y = cadadr( wrBB)
	      wrValue = max( wrPoint2X - wrPoint1X wrPoint2Y - wrPoint1Y)
	      unless( wrMin
        	wrMin = wrValue
        	wrMax = wrValue
	      )
              wrMin = min( wrValue wrMin)
	      wrMax = max( wrValue wrMax)
	    ) ;; foreach
	  )
	)
      )

      wrSmal = wrMin + 0.1 * (wrMax - wrMin)
      wrBig  = wrMin + 0.9 * (wrMax - wrMin)
      
      sel = list( )
      case( wrPaths
        ( "width"
	  case( type 
	     ( "bigger"
	       sel = setof( shape instances shape~>objType == "path" && shape~>width < wrSmal)
	     )
	     ( "smaller"
	       sel = setof( shape instances shape~>objType == "path" && shape~>width > wrBig)
	     )
	   )
	   foreach(item sel
	     geDeselectObject( item)
	   )
        )
        ( "bBox"
	  foreach( instancepointer setof( shape instances shape~>objType == "path")
	    wrBB = instancepointer->bBox
	    wrPoint1X = caar( wrBB)
	    wrPoint1Y = cadar( wrBB)
	    wrPoint2X = caadr( wrBB)
	    wrPoint2Y = cadadr( wrBB)
	    wrValue = max( wrPoint2X - wrPoint1X wrPoint2Y - wrPoint1Y)
	    cond(
	      ( type == "bigger" && wrValue < wrSmal
		geDeselectObject( instancepointer)
	      )
	      ( type == "smaller" && wrValue > wrBig
		geDeselectObject( instancepointer)
	      )
	    )
	  ) ;; foreach
        )
      )
      
      foreach( instancepointer setof( shape instances shape~>objType == "rect")
	wrBB = instancepointer->bBox
	wrPoint1X = caar( wrBB)
	wrPoint1Y = cadar( wrBB)
	wrPoint2X = caadr( wrBB)
	wrPoint2Y = cadadr( wrBB)
	wrValue = min( wrPoint2X - wrPoint1X wrPoint2Y - wrPoint1Y)
	cond(
	  ( type == "bigger" && wrValue < wrSmal
	    geDeselectObject( instancepointer)
	  )
	  ( type == "smaller" && wrValue > wrBig
	    geDeselectObject( instancepointer)
	  )
	)
      ) ;; foreach
	   
      foreach( instancepointer setof( shape instances shape~>objType == "inst")
	wrRow = dbFindProp( instancepointer "row")->value
	wrCol = dbFindProp( instancepointer "column")->value
	unless( wrRow
          wrRow = 1
	)
	unless( wrCol
          wrCol = 1
	)
	wrValue = wrRow * wrCol
	cond(
	  ( type == "bigger" && wrValue < wrSmal
	    geDeselectObject( instancepointer)
	  )
	  ( type == "smaller" && wrValue > wrBig
	    geDeselectObject( instancepointer)
	  )
	)
      ) ;; foreach
      
      wrCount = geGetSelSetCount( )
      if( wrCount == wrLastSelectionCount
      then
        wrText = strcat( pcExprToString( wrCount) " selected, no change")
      else
        wrText = strcat( pcExprToString( wrCount) " selected " type)
      )
    
    ) ;; unless
  ) ;; let
  ;; test: wrFilterSize( "smaller")
)

procedure( wrExtendSelection( )

  let( (wrCount wrError wrInstType wrNewInstances wrWidth wrPoint1 wrPoint1X wrPoint1Y wrPoint2X wrPoint2Y wrBB wrBBnew wrBBList)

    instances = geGetSelectedSet( )
    wrCount = geGetSelSetCount( )
    unless( boundp( 'wrLastSelection)
      wrLastSelection = list( )
      wrLastSelectionCount = 0
    )
    unless( boundp( 'wrLastSelectionCount)
      wrLastSelectionCount = 0
    )
    wrError = nil
    if( wrCount == 0
    then
       wrWindowName( strcat( wrDecodeBindKeysText ": wrExtendSelection: please select something first"))
       wrError = t
    )
    if( wrCount > 40000
    then
       wrWindowName( strcat( wrDecodeBindKeysText ": wrExtendSelection: to much selected"))
       wrError = t
    )
    unless( wrError
      wrWindow = hiGetCurrentWindow( )
      wrBBView = wrGetBBView( )
      wrBBList = list( )
      if( wrCount > wrLastSelectionCount && wrLastSelectionCount != 0
      then
	wrNewInstances = setof( element instances not( member( element wrLastSelection)))
      else
        wrNewInstances = instances
      )
      foreach( instancepointer wrNewInstances
	wrInstType = instancepointer->objType
	case( wrInstType
	  ( "path"
	    wrInstancepointer = instancepointer
	    wrPointList = instancepointer->points
	    wrWidth = 0.5 * instancepointer->width
	    wrPoint1 = nil
	    foreach( wrPoint wrPointList
	      unless( null( wrPoint1)
		
		wrPoint1X = min(  car( wrPoint1)  car( wrPoint)) - wrWidth - 0.1
		wrPoint1Y = min( cadr( wrPoint1) cadr( wrPoint)) - wrWidth - 0.1
		wrPoint2X = max(  car( wrPoint1)  car( wrPoint)) + wrWidth + 0.1
		wrPoint2Y = max( cadr( wrPoint1) cadr( wrPoint)) + wrWidth + 0.1
	        
		wrPoint1X = max( wrPoint1X xCoord(  car( wrBBView)))
		wrPoint1Y = max( wrPoint1Y yCoord(  car( wrBBView)))
		wrPoint2X = min( wrPoint2X xCoord( cadr( wrBBView)))
		wrPoint2Y = min( wrPoint2Y yCoord( cadr( wrBBView)))
	        
		wrBB = list( list( wrPoint1X wrPoint1Y) list( wrPoint2X wrPoint2Y))
		
		unless( member( wrBB wrBBList)
		  wrBBList = cons( wrBB wrBBList)
		)
              ) ;; unless
	      wrPoint1 = wrPoint
	    ) ;; foreach
	  )
	  ( ( "inst" "rect" "polygon")
	    wrBB = instancepointer->bBox
            wrPoint1X = xCoord(  car( wrBB)) - 0.1
	    wrPoint1Y = yCoord(  car( wrBB)) - 0.1
	    wrPoint2X = xCoord( cadr( wrBB)) + 0.1
	    wrPoint2Y = yCoord( cadr( wrBB)) + 0.1
	    
	    wrPoint1X = max( wrPoint1X xCoord(  car( wrBBView)))
	    wrPoint1Y = max( wrPoint1Y yCoord(  car( wrBBView)))
	    wrPoint2X = min( wrPoint2X xCoord( cadr( wrBBView)))
	    wrPoint2Y = min( wrPoint2Y yCoord( cadr( wrBBView)))
	        
            wrBB = list( list( wrPoint1X wrPoint1Y) list( wrPoint2X wrPoint2Y))
	    unless( member( wrBB wrBBList)
	      wrBBList = cons( wrBB wrBBList)
	    )
	  )
        ) ;; case
      ) ;; foreach
      wrLastSelection = instances
      wrLastSelectionCount = wrCount
      foreach( wrBB wrBBList
	wrBBNew = list( 
	  geEditToWindowPoint( wrWindow car( wrBB)) 
	  geEditToWindowPoint( wrWindow cadr( wrBB)))
	geAddSelectBox( wrWindow t wrBBNew)
      )
    ) ;; unless
  ) ;; let
)

procedure( wrCycleMetalLayers( b)

  wrSetLayersValid( append( list( wrPo wrCo) wrMetals) t)
  if( car( leGetEntryLayer( )) != wrOd
  then
    wrEntryLayerPrev = leGetEntryLayer( )
  )
  wrSetEntryLayer( list( wrOd "drawing"))
  ;; determine current position
  position = 1
  for( nlayer 1 wrMaxMetals 
    if( leIsLayerVisible( strcat(wrMetalName concat( nlayer)))
    then
      position = nlayer
    )
  ) ;; for
  ; print( position)
  foreach( layer append( list( wrPo wrCo) append( wrMetals wrVias))
    ;; wrIsLayerVisibleList = nconc( wrIsLayerVisibleList list( leIsLayerVisible( layer)))
    leSetLayerVisible( layer nil)
  )
  
  if( b
  then
    cond(
      ( onep( position)
	leSetLayerVisible( wrPo nil)
	leSetLayerVisible( wrCo nil)
	leSetLayerVisible( wrM1 t)
	leSetLayerVisible( wrVia1 t)
	leSetLayerVisible( wrM2 t)
      )
      ( position < wrMaxMetals
	leSetLayerVisible( strcat( wrMetalName concat( position)) t)
	leSetLayerVisible( strcat( wrMetalName concat( position + 1)) t)
	leSetLayerVisible( strcat( wrViaName concat( position)) t)
	leSetLayerVisible( strcat( wrMetalName concat( position - 1)) nil)
	leSetLayerVisible( strcat( wrViaName concat( position - 1)) nil)
	leSetLayerVisible( wrPo nil)
	leSetLayerVisible( wrCo nil)
      )
    )
  else
    if( position > 2
    then
      leSetLayerVisible( strcat( wrMetalName concat( position - 2)) t)
      leSetLayerVisible( strcat( wrMetalName concat( position - 1)) t)
      leSetLayerVisible( strcat( wrViaName concat( position - 2)) t)
      leSetLayerVisible( strcat( wrMetalName concat( position)) nil)
      leSetLayerVisible( strcat( wrViaName concat( position - 1)) nil)
    else
      leSetLayerVisible( wrPo t)
      leSetLayerVisible( wrCo t)
      leSetLayerVisible( wrM1 t)
      leSetLayerVisible( wrM2 nil)
      leSetLayerVisible( wrVia1 nil)
    )
  )
  hiRedraw( )
  
  ;; Eventhough the current entry layer is set to TMP and the orig. entry 
  ;; layer is hidden, it is still displayed after this function. It doesn't 
  ;; matter that leSetEntyLayer is performed after hiRedraw.
  ;; Doesn't work either:
  ; leSetLayerVisible( wrEntryLayer nil)
  ;; It is not possible now to keep the entry layer.
  ; wrSetEntryLayer( wrEntryLayer)
)

procedure( wrLSWToggleSelectableAllLayers( )

  if( leIsLayerSelectable( leGetEntryLayer( ))
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleSelectableAllLayers: toggle layers selectable off"))
    leSetAllLayerSelectable( nil)
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleSelectableAllLayers: toggle layers selectable on"))
    leSetAllLayerSelectable( t)
  )
)

procedure( wrLayoutPrefs( )

;; To determine the current value of an Environment Variable,
;; envGetVal( "layout" "variable_name" )

;; Changing Settings for Environment Variables in the CIW
;; envSetVal("graphic" "name" type value)

  let( ( wrWindowCoords wrWindowCoordsX wrWindowCoordsY schematicBBox layoutBBox lswBBox ciwBBox)

  /*******************************************************************************
  *  DISCLAIMER: The following code is provided for Cadence customers to use at  *
  *   their own risk. The code may require modification to satisfy the           *
  *   requirements of any user. The code and any modifications to the code may   *
  *   not be compatible with current or future versions of Cadence products.     *
  *   THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING WITHOUT     *
  *   LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES OF MERCHANTABILITY *
  *   OR FITNESS FOR A PARTICULAR USE.                                           *
  *******************************************************************************/

  ;;---------------From here---------------------
  ;;SKILL Lint Score: 100

  ;;The following code may be put in .cdsinit to control 
  ;;the sizes of schematic,layout and ciw windows when VXL 
  ;;is invoked

  ;;Feel free to play with the numbers within the code
  ;; to get the size/location as you want.


    wrWindowCoords = hiGetMaxScreenCoords()
    wrWindowCoordsX = xCoord(wrWindowCoords)
    wrWindowCoordsY = yCoord(wrWindowCoords)
    layoutBBox=list(wrWindowCoordsX/2:0 wrWindowCoordsX:0.97*wrWindowCoordsY) 
    schematicBBox=list( 0.15*wrWindowCoordsX:0.2*wrWindowCoordsY 0.5*wrWindowCoordsX:0.97*wrWindowCoordsY)
    lswBBox=list( wrWindowCoordsX-153:160 wrWindowCoordsX-2:wrWindowCoordsY-100)
    ciwBBox=list( wrWindowCoordsX-600:30 wrWindowCoordsX:200)

    envSetVal("layoutXL" "schematicWindow" 'string sprintf(nil "%L" schematicBBox)) 
    envSetVal("layoutXL" "layoutWindow" 'string sprintf(nil "%L" layoutBBox))
    envSetVal("layoutXL" "lswWindow" 'string sprintf(nil "%L" lswBBox))
    envSetVal("layoutXL" "ciwWindow" 'string sprintf(nil "%L" ciwBBox))
    leSetLSWBBox( list( list( wrWindowCoordsX-153 160) list( wrWindowCoordsX-10 wrWindowCoordsY-100)))
  )
  
  envSetVal( "layout" "useTrueBBox" 'boolean nil)
  envSetVal( "layout" "displayStretchHandles" 'boolean nil)
  envSetVal( "layout" "originMarkersOn" 'boolean nil)
  envSetVal( "layout" "dotsOn" 'boolean nil)
  envSetVal( "layout" "autoRefresh" 'boolean t)
  envSetVal( "layout" "filterSize" 'float 3)
  
  wrWindow = hiGetCurrentWindow( )
  wrWindow~>useTrueBBox = nil
  wrWindow~>displayStretchHandles = nil
  wrWindow~>originMarkersOn = nil
  wrWindow~>autoRefresh = t
  CCSrememberFormLocations( "~/.icfb_formlocations") 
  wrWindowName( strcat( wrDecodeBindKeysText ": wrLayoutPrefs: set preferences"))
)

procedure( wrLayoutZoomNext( @optional value)
  
  let( ( wrError wrCount wrLayoutZoomNextInstance wrBB wrXNumber wrYNumber)
  
    unless( boundp( 'wrLayoutZoomNextValue)
      wrLayoutZoomNextValue = "up"
    )
    if( ! null( value)
    then
      if( wrLayoutZoomNextValue == "repeat"
      then
        wrLayoutZoomNextValue = "stop"
      else
        wrLayoutZoomNextValue = value
      )
    )
    
    instances = geGetSelectedSet( )
    wrCount = geGetSelSetCount( )
    wrError = nil
    if( wrCount == 0
    then
       wrWindowName( strcat( wrDecodeBindKeysText ": wrLayoutZoomNextInstance: please select something first"))
       wrError = t
    )
  
    unless( wrError
      
      case( wrLayoutZoomNextValue 
	( "stop"
          wrWindowName( strcat( wrDecodeBindKeysText ": wrLayoutZoomNextInstance: stopped"))
	)
	( t
	  unless( boundp( 'wrLastSelectionCount)
	    wrLastSelectionCount = wrCount
	    wrLayoutZoomNextN = 1
	  )
	  
	  if( wrCount != wrLastSelectionCount
	  then
            wrLayoutZoomNextN = 1
	  )
	  if( wrLayoutZoomNextValue == "down"
	  then
	    wrLayoutZoomNextN = modulo( wrLayoutZoomNextN-2 wrCount)+1
	  else
	    wrLayoutZoomNextN = modulo( wrLayoutZoomNextN wrCount)+1
	  )
	  wrLastSelectionCount = wrCount
	  wrLayoutZoomNextInstance = nthelem( wrLayoutZoomNextN instances)
	  wrBB = wrLayoutZoomNextInstance->bBox
	  wrXNumber = ( xCoord( cadr( wrBB)) + xCoord( car( wrBB))) / 2
	  wrYNumber = ( yCoord( cadr( wrBB)) + yCoord( car( wrBB))) / 2 
	  wrZoomXY( list( wrXNumber wrYNumber))
	  wrWindowName( strcat( wrDecodeBindKeysText ": zoom to " pcExprToString( wrLayoutZoomNextN) " of " pcExprToString( wrCount)))
	  
	  if( wrLayoutZoomNextValue == "repeat"
	  then
	    hiRegTimer( "wrLayoutZoomNext( )" 10)
	  )
        )
      ) ;; case
    ) ;; unless
  ) ;; let
)

procedure( wrLayoutZoomIn( value)

  let( ( x y x1 y1 x2 y2 xD yD xMid yMid wrBB wrBBNew wrPointOrg)
  
    wrBB = wrGetBBView( )
    x1 = xCoord( cadr( wrBB))
    y1 = yCoord( cadr( wrBB))
    x2 = xCoord( car( wrBB))
    y2 = yCoord( car( wrBB))
    xD = value * ( x2 - x1) / 2
    yD = value * ( y2 - y1) / 2
    wrPointMid = geWindowToEditPoint( hiGetCurrentWindow( ) list( ( x2 + x1) / 2 ( y2 + y1) / 2))
    xMid = xCoord( wrPointMid)
    yMid = yCoord( wrPointMid)
    wrPointOrg = geWindowToEditPoint( hiGetCurrentWindow( ) hiGetPoint( hiGetCurrentWindow( )))
    xOrg = xCoord( wrPointOrg)
    yOrg = yCoord( wrPointOrg)
    x = xOrg + value * ( xMid - xOrg)
    y = yOrg + value * ( yMid - yOrg)
    wrBBNew = list( 
      geEditToWindowPoint( hiGetCurrentWindow( ) list( (x - xD) (y - yD))) 
      geEditToWindowPoint( hiGetCurrentWindow( ) list( (x + xD) (y + yD))))

    wrWindowName( strcat( wrDecodeBindKeysText ": Zoom to " pcExprToString( x) ", " pcExprToString( y)))
    hiZoomIn( hiGetCurrentWindow( ) wrBBNew)
  )
)

procedure( wrLayoutZoomLimit( )
  
  wrBB = hiGetViewBBox( hiGetCurrentWindow( ))
  x  = ( xCoord( cadr( wrBB)) + xCoord( car( wrBB))) / 2
  y  = ( yCoord( cadr( wrBB)) + yCoord( car( wrBB))) / 2
  xD = 1.5
  yD = 1.5
  wrBBNew = list( list( (x - xD) (y - yD)) list( (x + xD) (y + yD)))
  hiZoomIn( hiGetCurrentWindow( ) wrBBNew)
  wrWindowName( strcat( wrDecodeBindKeysText ": Zoom limit"))
)

procedure( wrLSWDefault( )

  leSetAllLayerValid( t)
  leSetAllLayerVisible( nil)
  leSetAllLayerValid( nil)
  getWarn( )
  wrSetLayersValid( wrLayers t)
  leSetAllLayerVisible( t)
  wrSetLayersValid( wrSchematicLayers nil)
  hiRedraw( )
)

procedure( wrLSWLayersUsedValid( )

  foreach(lpp cv~>lpps
    unless( leIsLayerValid( list(lpp~>layerName lpp~>purpose))
      leSetLayerValid(list(lpp~>layerName lpp~>purpose) t)
     )
  )
)

procedure( wrLSWToggleVisibleAllLayers( )

  if( leIsLayerVisible( wrNw)
  then
    ; leSetAllLayerValid( t)
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleVisibleAllLayers: toggle layers visible off"))
    leSetAllLayerVisible( nil)
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleVisibleAllLayers: toggle layers visible on"))
    leSetAllLayerVisible( t)
  )
  hiRedraw( )
)

procedure( wrSetLayerValid( layer value)

  unless( leIsLayerValid( layer)
    leSetLayerValid( layer value)
  )
)

procedure( wrSetLayersValid( layers value)

  foreach( layer layers
     unless( leIsLayerValid( layer)
       leSetLayerValid( layer value)
    )
  )
)

procedure( wrSetLayer( layers @optional type)
  
  let( ( instances wrError sel)
  
    unless( type
      type = "drawing"
    )
  
    instances = geGetSelectedSet( )
    instancepointer = car( instances)
    wrInstType = instancepointer->objType
    wrInstCellName = instancepointer->cellName
    wrError = nil
    sel = setof( shape instances shape~>objType != wrInstType)
    if( ! null( sel)
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrSetLayer: error: select only instances from the same type"))
      wrError = t
    )

    unless( wrError
      wrSetLayerValid( cons( car( layers) list( type)) t)
      wrType = cons( car( layers) list( type))

      foreach( instancepointer geGetSelectedSet( )
	if( instancepointer~>lpp
	then
	  instancepointer->lpp = wrType
	)
      )
      wrEntryLayerName = car( layers)
      wrWindowName( strcat( wrDecodeBindKeysText ": wrSetLayer: change to layer " wrEntryLayerName " " type))

    ) ;; unless

    if( type == wrMsub
    then
      wrLayerType = "drawing"
    )
  ) ;; let
;; test: wrSetLayer( list( "M2"))
)

procedure( wrLSWToggleVisibleLayers( layers @optional type)

  unless( type
    type = "drawing"
  )
  
  if( car( leGetEntryLayer( )) != wrOd
  then
    wrEntryLayerPrev = leGetEntryLayer( )
  )
  
  wrIsVissible = null( leIsLayerVisible( cons( car( layers) list( type))))
  if( wrEntryLayerName == "all metal" && not( wrIsVissible)
  then
    wrSetEntryLayer( list( wrOd))
  )
  
  case( type
    ( "pin"
      ;; with pin type, also labels are toggled.
      foreach( layer layers
	if( layer == car( leGetEntryLayer( )) && cadr( leGetEntryLayer( )) == type
	then
	  wrSetEntryLayer( list( wrOd))
	)
	wrSetLayerValid( cons( layer list( "pin")) t)
	leSetLayerVisible( cons( layer list( "pin")) wrIsVissible)
	leSetLayerVisible( cons( layer list( "label")) wrIsVissible)
      ) ;; foreach
    )
    ( t
      foreach( layer layers
	if( layer == car( leGetEntryLayer( )) && cadr( leGetEntryLayer( )) == type
	then
	  wrSetEntryLayer( list( wrOd))
	)
	wrSetLayerValid( cons( layer list( type)) t)
	leSetLayerVisible( cons( layer list( type)) wrIsVissible)
      ) ;; foreach
    )
  )
  
  if( not( null( wrEntryLayerPrev)) && leIsLayerVisible( wrEntryLayerPrev)
  then
    wrSetEntryLayer( list( car( wrEntryLayerPrev)) cadr( wrEntryLayerPrev))
    wrEntryLayerPrev = nil
  )
  
  hiRedraw( )
  if( type == wrMsub
  then
    wrLayerType = "drawing"
  )
  
  if( wrIsVissible
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleVisibleLayers: toggle visibility on "  wrEntryLayerName " " pcExprToString( type)))
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleVisibleLayers: toggle visibility off "  wrEntryLayerName " " pcExprToString( type)))
  )
)

procedure( wrLSWToggleSelectableLayers( layers @optional type)

  unless( type
    type = "drawing"
  )
  
  case( type
    ( "pin"
      ;; with pin type, also labels are toggled.
      wrIsSelectable = null( leIsLayerSelectable( cons( car( layers) list( "pin"))))
      foreach( layer layers
	wrSetLayerValid( cons( layer list( "pin")) t)
	wrSetLayerValid( cons( layer list( "label")) t)
        leSetLayerVisible( cons( layer list( "pin")) t)
        leSetLayerVisible( cons( layer list( "label")) t)
	leSetLayerSelectable( cons( layer list( "pin")) wrIsSelectable)
	leSetLayerSelectable( cons( layer list( "label")) wrIsSelectable)
      ) ;; foreach
    )
    ( t
      wrIsSelectable = null( leIsLayerSelectable( cons( car( layers) list( type))))
      foreach( layer layers
	 wrSetLayerValid( cons( layer list( type)) t)
	 leSetLayerVisible( cons( layer list( type)) t)
	 leSetLayerSelectable( cons( layer list( type)) wrIsSelectable)
      ) ;; foreach
    )
  ) ;; case
  hiRedraw( )
  
  if( type == wrMsub
  then
    type = "drawing"
  )
  
  if( wrIsSelectable
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleSelectableLayers: toggle selectability on "  wrEntryLayerName " " pcExprToString( type)))
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleSelectableLayers: toggle selectability off "  wrEntryLayerName " " pcExprToString( type)))
  )
)


procedure( wrSetEntryLayer( layer @optional type)

  unless( type
    type = "drawing"
  )
  wrSetLayerValid( cons( car( layer) list( type)) t)
  leSetEntryLayer( cons( car( layer) list( type)))
  if( type == wrMsub
  then
    type = "drawing"
  )
)

procedure( wrLSWToggleSelectableInst( )
  
  if( leIsInstSelectable( )
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleSelectableInst: toggle instances selectable off"))
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleSelectableInst: toggle instances selectable on"))
  )
  leSetInstSelectable( null( leIsInstSelectable( )))
)

procedure( wrLSWToggleSelectablePin( )
  
  if( leIsPinSelectable( )
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleSelectablePin: toggle pin selectable off"))
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggleSelectablePin: toggle pin selectable on"))
  )
  leSetPinSelectable( null( leIsPinSelectable( )))
)

procedure( wrMoveCursor( type, value)
  
  wrWindowName( strcat( wrDecodeBindKeysText ": wrMoveCursor: move " type " " pcExprToString( value)))
  case( type
    ( "up"
      leMoveCursor( 0  value)
    )
    ( "down"
      leMoveCursor( 0 -value)
    )
    ( "left"
      leMoveCursor( -value 0)
    )
    ( "right"
      leMoveCursor(  value 0)
    )
  )
)

procedure( wrToggleSnapMode( @optional mode)

  unless( boundp( 'wrSnapModeN)
    wrSnapModeN = 1
  )
  if( mode
  then
    wrSnapMode = mode
  else
    wrSnapModeList = list( "anyAngle" "diagonal" "orthogonal")
    wrSnapModeN = modulo( wrSnapModeN+1 3)
    wrSnapMode = nthelem( wrSnapModeN+1 wrSnapModeList )
  )
  wrWindowName( strcat( wrDecodeBindKeysText ": wrToggleSnapMode: snap mode: " wrSnapMode))
  leSetFormSnapMode( wrSnapMode)
)

procedure( wrToggleDrawSurrounding( @optional mode)

  wrWindow = hiGetCurrentWindow( )
  if( mode
  then
    wrToggleDrawSurrounding = mode
  else
    wrToggleDrawSurrounding = wrWindow~>drawSurroundingOn
  )

  if( null( wrToggleDrawSurrounding)
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrToggleDrawSurrounding: show surrounding"))
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrToggleDrawSurrounding: hide surrounding"))
  )
  wrWindow~>drawSurroundingOn = null( wrToggleDrawSurrounding)
)

procedure( wrSchematicNode( @optional value)

  let( ( instance wrError)
  
    cv = geGetEditCellView( )
    wrError = nil
    unless( cv->mode != "r"
      wrWindowName( strcat( wrDecodeBindKeysText ": wrSchematicNode: error: cell must be editable"))
       wrError = t
    )
    
    ;; xxx 060516 the cell must be editable. Or a copy of the device must be openend in a 
    ;; dummy view which is editable.
  
    unless( wrError
      ;; "pin name" "net name" "voltage" "current"

      unless( boundp( 'wrSchematicNodeValueN)
	wrSchematicNodeValueN = 0
      )

      if( ! null( value)
      then
	wrSchematicNodeValue = value
      else
	wrSchematicNodeValueList = list( "none" "pin name" "net name")
	wrSchematicNodeValueN = modulo( wrSchematicNodeValueN 3)+1
	wrSchematicNodeValue = nthelem( wrSchematicNodeValueN wrSchematicNodeValueList )
      )
      wrWindowName( strcat( wrDecodeBindKeysText ": wrSchematicNode: toggle terminal names: " wrSchematicNodeValue))
      wrShFile = outfile(".wrCadenceFile")
      fprintf( wrShFile "
    \n  instance = car( geGetSelectedSet( ))
    \n  if( null( instance)
    \n  then
    \n    instance = car( setof( shape cv->instances shape~>libName == wrDeviceLibName))
    \n  )
    \n  asaEditCompDisplay( )
    \n  hiiSetCurrentForm('_ahiiUniqueSymbolformannotateForm0)
    \n  _ahiiUniqueSymbolformannotateForm0->labelInfo->terminal->value = t
    \n  geSelectObject( instance)
    \n  _ahiiUniqueSymbolformannotateForm0->tdisplay->value = wrSchematicNodeValue
    \n  hiFormDone(_ahiiUniqueSymbolformannotateForm0)")
      close( wrShFile)
      load( ".wrCadenceFile")
      hiRedraw( )
    )
  )
)

procedure( wrLayoutDisplayName( @optional value)

  wrShFile = outfile(".wrCadenceFile")
  fprintf( wrShFile "
\n  leHiEditDisplayOptions( )
\n  hiiSetCurrentForm('leDisplayOptionsForm)
\n  ;; leDisplayOptionsForm = hiGetCurrentForm( )
\n  hiFormClose( leDisplayOptionsForm)
\n  leDisplayOptionsForm->options->stretchHandles->value =  nil
\n  wrLayoutSnapSpacingValue = leDisplayOptionsForm->instName->value
\n  if( ! null( value)
\n  then
\n    wrLayoutSnapSpacingValue = value
\n  else
\n    if( wrLayoutSnapSpacingValue == \"instance\"
\n    then
\n	wrLayoutSnapSpacingValue = \"master\"
\n    else
\n	wrLayoutSnapSpacingValue = \"instance\"
\n    )
\n  )
\n
\n  wrWindowName( strcat( \"Alt-n: layout name: \" pcExprToString( wrLayoutSnapSpacingValue)))
\n  leDisplayOptionsForm->instName->value = wrLayoutSnapSpacingValue
\n  hiFormDone( leDisplayOptionsForm)")
  close( wrShFile)
  load( ".wrCadenceFile")
)

procedure( wrSchematicSnapSpacing( @optional value)

  if( ! null( value)
  then
    wrSchematicSnapSpacingValue = value
  else
    if( wrSchematicSnapSpacingValue < 2
    then
      wrSchematicSnapSpacingValue = wrSchematicSnapSpacingValue * 2
    else
      wrSchematicSnapSpacingValue = 0.125
    )
  )
  wrWindowName( strcat( wrDecodeBindKeysText ": wrSchematicSnapSpacing: snap spacing: " pcExprToString( wrSchematicSnapSpacingValue)))
  wrShFile = outfile(".wrCadenceFile")
  fprintf( wrShFile "
\n  schHiDisplayOptions( )
\n  hiiSetCurrentForm( 'schDisplayOptionsForm)
\n  schDisplayOptionsForm->snapSpacing->value = wrSchematicSnapSpacingValue
\n  schDisplayOptionsForm->gridSpacing->value = wrSchematicSnapSpacingValue
\n  hiFormDone( schDisplayOptionsForm)")
  close( wrShFile)
  load( ".wrCadenceFile")
  hiRedraw( )
)

procedure( wrSchematicSnapToGrid( )

;; How to snap instances and shapes to grid
;; http://sourcelink.cadence.com/docs/db/kdb/1997/Oct/1814236.html
	
  let( ( cv count Set Settemp grid newpoints pointi shapeCoords)
    ;
    ; Open currently edited cellview
    cv = geGetEditCellView(getCurrentWindow())

    if( geGetObjectSelectedSet() != nil
    then
      ;; println("selected")
      Set = maplist( 'caar geGetObjectSelectedSet())
    else
      ;; println("nothing selected - operating on entire cellview")
      Set = append(cv~>instances cv~>shapes)
    )

    ; Get the current snap spacing
    grid = schGetEnv("schSnapSpacing")
    count = 0

    ; Loop through and find all the items off grid
    foreach( shape Set
      ; For instances
      shapeCoords = shape~>xy
      when( shapeCoords
        when( (int(xCoord(shapeCoords)/grid) != xCoord(shapeCoords)/grid ) ||
              (int(yCoord(shapeCoords)/grid) != yCoord(shapeCoords)/grid )
          count = count + 1
          shape~>xy = int(xCoord(shapeCoords)/grid+.5)*grid:int(yCoord(shapeCoords)/grid+.5)*grid
        )
      )

      ; For wires
      when( shape~>points
	newpoints=nil
	for(i 1 shape~>nPoints
          pointi = nth(i-1 shape~>points)
          if( (int(xCoord(pointi)/grid) != xCoord(pointi)/grid ) || (int(yCoord(pointi)/grid) != yCoord(pointi)/grid )
          then
            count = count + 1
            newpoints = cons( int(xCoord(pointi)/grid+.5)*grid:int(yCoord(pointi+.5)/grid)*grid newpoints)
          else
            newpoints = cons( nth(i-1 shape~>points) newpoints)
          ) 
	) ;foreach
	shape~>points = newpoints
      )
    ) ; foreach

    ; Print a report
    if( count > 0
    then
      wrWindowName( strcat( wrDecodeBindKeysText ": wrSchematicSnapToGrid: " pcExprToString( count) " offgrid items moved"))
    else
      wrWindowName( strcat( wrDecodeBindKeysText ": wrSchematicSnapToGrid: No offgrid items found"))
    )
  )
)

procedure( wrLayoutSnapSpacing( @optional value)

  wrShFile = outfile(".wrCadenceFile")
  fprintf( wrShFile "
\n  leHiEditDisplayOptions( )
\n  hiiSetCurrentForm('leDisplayOptionsForm)
\n  ;; leDisplayOptionsForm = hiGetCurrentForm( )
\n  hiFormClose( leDisplayOptionsForm)
\n  wrLayoutSnapSpacingValue = leDisplayOptionsForm->xSnap->value
\n
\n  if( ! null( value)
\n  then
\n    wrLayoutSnapSpacingValue = value
\n  else
\n    if( wrLayoutSnapSpacingValue == wrStepMin
\n    then
\n	wrLayoutSnapSpacingValue = wrLayoutGrid
\n    else
\n	wrLayoutSnapSpacingValue = wrStepMin
\n    )
\n  )
\n
\n  wrWindowName( strcat( \"Alt-m Alt-g: snap spacing: \" pcExprToString( wrLayoutSnapSpacingValue)))
\n  leDisplayOptionsForm->xSnap->value = wrLayoutSnapSpacingValue
\n  leDisplayOptionsForm->ySnap->value = wrLayoutSnapSpacingValue
\n  hiFormDone( leDisplayOptionsForm)")
  close( wrShFile)
  load( ".wrCadenceFile")
)

procedure( wrToggleLogFilter( )

  wrShFile = outfile(".wrCadenceFile")
  fprintf( wrShFile "
\n	hiSetFilter( )
\n	hiiSetCurrentForm('hiSetFilterForm)
\n	wrhiSetFilterFormValue = hiSetFilterForm->showInput->menuCommands->value
\n        hiSetFilterForm->showInput->menuCommands->value = null( wrhiSetFilterFormValue)
\n	if( wrhiSetFilterFormValue
\n	then
\n	  wrWindowName( \"Alt-x Alt-f: toggle filter off\")
\n	else
\n	  wrWindowName( \"Alt-x Alt-f: toggle filter on\")
\n	)
\n	hiFormDone(hiSetFilterForm)")
  close( wrShFile)
  load( ".wrCadenceFile")
)

procedure( wrWriteSkill( )

  let( ( instances text )

    wrShFile = outfile("save.wrCadenceFile")
    instances = geGetSelectedSet( )
    instancepointer = car( geGetSelectedSet( ))
    if( null( instances)
    then
      ;; Save cellview to file.
      cv = geGetEditCellView( )
      wrCellName = cv->cellName
      wrWindowName( strcat( wrDecodeBindKeysText ": wrWriteSkill: export " wrCellName " to skill"))
      fprintf( wrShFile ";; %s savefile for %s" wrDecodeBindKeysText wrCellName)
      dbWriteSkill(cv "save.wrCadenceFile" "a" "5.0")
    else
      wrWindowName( strcat( wrDecodeBindKeysText ": wrWriteSkill: export instances to skill"))
      foreach( instancepointer instances
        instancepointer = car( geGetSelectedSet( ))
        text1 = instancepointer~>??
        text2 = instancepointer->prop~>??
        wrInstName = instancepointer->cellName
	unless( wrInstName
	  wrInstName = instancepointer->objType
	)
	fprintf( wrShFile ";; %s savefile for %s\n" wrDecodeBindKeysText wrInstName)
	pprint( text1 wrShFile)
        fprintf( wrShFile "\n;; %s savefile for properties of %s\n" wrDecodeBindKeysText wrInstName)
	pprint( text2 wrShFile)
      ) ;; foreach
    )
    close( wrShFile)
    sh( "ksh -c \"/home/amos/bin/convertall RemoveSpace save.wrCadenceFile\"")
    sh( "/home/amos/bin/openall save_ns.wrcadencefile")
    ;; sh( "pager save.wrcadencefile")
  )
)

procedure( wrLSWToggle( )
    
  if( null( leIsLSWIconified( ))
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggle: hide LSW"))
    leIconifyLSW( )
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLSWToggle: show LSW"))
    leRaiseLSW( )
  )
)


procedure( wrLibManagerToggle( @optional mode)
    
  ;; don't toggle libmanager: to slow. Just open (bring to front) is easyer.
  wrLibManagerMode = nil
  
  unless( null( mode)
    wrLibManagerMode = mode
  )
  if( wrLibManagerMode
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLibManagerToggle: close library manager"))
    ddsCloseLibManager( )
    wrLibManagerMode = nil
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrLibManagerToggle: show library manager"))
    ddsOpenLibManager( )
    wrLibManagerMode = t
  )
)

procedure( wrWriteToggle( @optional mode)
    
  wrWriteMode = hiGetCurrentWindow()->cellView->mode

  unless( null( mode)
    wrWriteMode = mode
  )

  if( wrWriteMode != "r"
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrWriteToggle: make readonly"))
    geChangeEditMode( "r")
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrWriteToggle: make editable"))
    geChangeEditMode( "a")
  )
  
  wrWriteMode = hiGetCurrentWindow()->cellView->mode
  if( wrWriteMode == "r"
  then
    wrWriteModeTxt = "RO "
  else
    wrWriteModeTxt = ""
  )
)

procedure( wrSaveOpenViews( )

  let( ( wrShFile window wrViewName wrLibName wrCellName wrCellViewType wrCellViewBBox)
    
    wrShFile = outfile(".wrOpenViews")
    printf( "\nSaving viewlist")
    wrWindowName( strcat( wrDecodeBindKeysText ": wrSaveOpenViews: save viewlist"))
    foreach( window hiGetWindowList( )
      wrViewName = geGetWindowRep( window)->viewName
      getWarn( )
      if( null( wrViewName)
      then
        wrViewName = "empty"
      )
      if( rexMatchp( "schematic" wrViewName) || rexMatchp( "layout" wrViewName) || rexMatchp( "symbol" wrViewName)
      then
        wrLibName = geGetWindowRep( window)->libName
        wrCellName = geGetWindowRep( window)->cellName
        wrCellViewType = geGetWindowRep( window)->cellViewType
        wrCellViewBBox = hiGetAbsWindowScreenBBox( window)
	wrCellViewPoint1 = car( wrCellViewBBox)
	wrCellViewPoint2 = cadr( wrCellViewBBox)
	wrCellViewBBoxT = strcat( "list( list" pcExprToString( wrCellViewPoint1) " list" pcExprToString( wrCellViewPoint2) ")")
	fprintf( wrShFile "\ndeOpenCellView( \"%s\" \"%s\" \"%s\" \"%s\" %s \"r\")" wrLibName wrCellName wrViewName wrCellViewType wrCellViewBBoxT)
      )
    ) ;; foreach
    close( wrShFile)
  ) ;; let
  CCSrememberFormLocations( "~/.icfb_formlocations")
)

procedure( wrOpenLastViews( )
    
  if( isFile( "./.wrOpenViews" )
  then
    printf( "\nwrAltEdit.il: Loading viewlist")
    load( " ./.wrOpenViews")
    wrWindowName( strcat( wrDecodeBindKeysText ": wrOpenLastViews: open viewlist"))
  )
)

procedure( wrOpenOtherView( )
    
  let( ( cv wrLibName wrCellName wrViewName wrRaise)

    cv = geGetEditCellView( )
    wrCellName = cv->cellName
    wrLibName = cv->libName
    wrViewName = cv->viewName
    wrCellViewType = cv->cellViewType
    case( wrViewName
      ( "schematic"
	wrViewName = "layout"
	wrCellViewType = "maskLayout"
      )
      ( ( "layout" "symbol")
	wrViewName = "schematic"
	wrCellViewType = "schematic"
      )
    )
    wrRaise = nil
    foreach( window hiGetWindowList( )
      geGetWindowRep( window)->libName
      getWarn( )      
      if( 
        geGetWindowRep( window)->libName  == wrLibName &&
        geGetWindowRep( window)->cellName == wrCellName &&
        geGetWindowRep( window)->viewName == wrViewName
      then
        wrRaise = t
	wrRaiseWindow = window
      ) ;; if
    ) ;; foreach
    if( wrRaise
    then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrOpenOtherView: raise " wrViewName))
      hiDeiconifyWindow( wrRaiseWindow)
      hiRaiseWindow( wrRaiseWindow)
    else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrOpenOtherView: open " wrViewName))
      deOpenCellView( wrLibName wrCellName wrViewName wrCellViewType 'default "r")
    ) ;; if
  ) ;; let
)

procedure( wrOpenLastView( )
    
  ;; Get last cell
  wrShFile = outfile(".wrCadenceFile")
  fprintf( wrShFile "#!/bin/ksh")
  fprintf( wrShFile "\nPath=$PWD")
  fprintf( wrShFile "\ngrep -e '^[^#]*DEFINE' cds.lib 2>/dev/null | grep -v -e 'avTech' | sed -e 's|.*DEFINE *||' | read TestLib TestLibPath")
  fprintf( wrShFile "\nprint $TestLib > .wrCadenceFile2")
  fprintf( wrShFile "\ncd $TestLibPath")
  fprintf( wrShFile "\nCells=$(find . -type d -regex './[^#]*/\\(layout\\|schematic\\)' -maxdepth 2 | cut -f 2,3 -d '/' | grep -v -e 'HS65_LH' -e 'M._M' -e 'M.._M' -e 'M._.PO' -e 'M.._.PO' -e '_PO.*_' -e 'M._NW_' -e 'PcFill' -e 'PcCMOS' -e '^.TAP_')")
  fprintf( wrShFile "\nls -dt $Cells | read NewestCell")
  fprintf( wrShFile "\necho $NewestCell | sed -e 's|/| |g' | read CellName ViewName")
  fprintf( wrShFile "\nprint $CellName >> $Path/.wrCadenceFile2")
  fprintf( wrShFile "\nprint $ViewName >> $Path/.wrCadenceFile2")
  close( wrShFile)
  sh( "chmod 750 ./.wrCadenceFile")
  sh( "./.wrCadenceFile")
  sh( "rm ./.wrCadenceFile")
  wrShFile = infile(" ./.wrCadenceFile2")
  wrLabelName = pcExprToString( car( lineread( wrShFile)))
  wrShFile = infile(" ./.wrCadenceFile2")
  wrLibName     = pcExprToString( car( lineread( wrShFile)))
  wrCellName    = pcExprToString( car( lineread( wrShFile)))
  wrViewName    = pcExprToString( car( lineread( wrShFile)))
  close( wrShFile)
  sh( "rm ./.wrCadenceFile2")
  ;; dprint( wrLibName wrCellName wrViewName)
  
  ;; Open
  deOpenCellView( wrLibName wrCellName wrViewName "read")
  wrWindowName( strcat( wrDecodeBindKeysText ": wrOpenLastView: Opening: " wrLibName "," wrCellName ", " wrViewName))
)

procedure( wrProbeNets( )

  ;; add foreach over selectedset. Needed to put instancepointer in geaddnetprobe etc.

  instancepointer = car(geGetSelectedSet( ))
  unless( instancepointer
    geAddSelectPoint( )
    instancepointer = car( geGetSelectedSet( ))
  )
  wrNetName = instancepointer->net->name 
  if( member( wrNetName setof( x geGetAllProbe( )~>pathObjectName x))
  then
    wrWindowName( strcat( wrDecodeBindKeysText ": wrProbeNets: delete probe net" wrNetName))
    geDeleteNetProbe( hiGetCurrentWindow( ))
  else
    wrWindowName( strcat( wrDecodeBindKeysText ": wrProbeNets: add probe net" wrNetName))
    geAddNetProbe( hiGetCurrentWindow( ))
  )
)

procedure( wrSetOrigin( )

  schHiSetSymbolOrigin()
  wrWindowName( "Alt-o: wrSetOrigin")
)

procedure( wrDecodeBindKeysSchematics( key)

  wrGetProcess( )
  wrStartTime = getCurrentTime( )
  
  wrDecode = t
  wrDecodeBindKeysText = strcat( wrDecodeBindKeysTextPrev " " key)

  ;; Perform key-x key-y ... type commands:

  if( wrDecode
  then
    
    if( wrDecodeBindKeysTextPrev != ""
    then
      hiRegTimer( "wrClear( )" 1200)
    )
    
    case( wrDecodeBindKeysText

      ( ""
        
      )

      ( " Alt-0"
	wrDefault( )
      )
  
      ( " Alt-9"
	wrProbeNets( )
      )

      ( " Alt-8"
	wrMultW( 2)
      )

      ( " Alt-div"
	wrMultW( .5)
      )

      ( " Alt-up"
	wrGrow( "up" 0.1 1 0.1)
      )
      ( " Alt-down"
	wrGrow( "down" 0.1 1 0.1)
      )
      ( " Alt-left"
	wrGrow( "left" 0.1 1 0.1)
      )
      ( " Alt-right"
	wrGrow( "right" 0.1 1 0.1)
      )

      ( " Shift-Alt-up"
	wrGrow( "up" 1 10 1)
      )
      ( " Shift-Alt-down"
	wrGrow( "down" 1 10 1)
      )
      ( " Shift-Alt-left"
	wrGrow( "left" 1 10 1)
      )
      ( " Shift-Alt-right"
	wrGrow( "right" 1 10 1)
      )

      ( " Ctrl-Alt-up"
	wrGrow( "up" wrStepMin 1 wrStepMin)
      )
      ( " Ctrl-Alt-down"
	wrGrow( "down" wrStepMin 1 wrStepMin)
      )
      ( " Ctrl-Alt-left"
	wrGrow( "left" wrStepMin 1 wrStepMin)
      )
      ( " Ctrl-Alt-right"
	wrGrow( "right" wrStepMin 1 wrStepMin)
      )

      ( " help"
        wrWindowName( strcat( wrDecodeBindKeysText ": schematic help"))
	wrHelp( strcat( "
\n
\n Schematic help
\n
\n Default Cadence:
\n F1: help
\n F4: toggle partial select
\n BackSpace: delete
\n 9: add net probe - see also Alt-9
\n Ctrl a: select all
\n c: copy
\n Ctrl d: deselect all
\n e: descend read
\n Shift e: descend edit
\n Ctrl e: return
\n f: zoom to fit
\n Ctrl f: select options
\n g: find marker
\n Ctrl g: delete marker
\n h: highlite label
\n i: create instance
\n l: create wire label
\n m: stretch
\n n: create note shape
\n o: display options
\n Ctrl o: grid options
\n p: create pin
\n q: properties
\n r: rotate
\n u: undo
\n shift u: redo
\n Ctrl v: focus to CIW
\n w: create wire
\n z: zoom in
\n Ctrl z: zoom out
\n 
\n wrKeys:
\n Alt-0 clear mode
\n Alt-9: toggle probed nets
\n Alt-up: increase
\n Alt-down: decrease
\n Alt-left: decrease
\n Alt-right: increase
\n Shift-Alt-up: increase big
\n Shift-Alt-down: decrease big
\n Shift-Alt-left: decrease big
\n Shift-Alt-right: increase big
\n Ctrl-Alt-up: increase l " pcExprToString( wrStepMin) "
\n Ctrl-Alt-down: decrease l " pcExprToString( wrStepMin) "
\n Ctrl-Alt-left: decrease w " pcExprToString( wrStepMin) "
\n Ctrl-Alt-right: increase w " pcExprToString( wrStepMin) "
\n ~: help
\n Alt-f: filter mode ([Shift] c[els] d[evices] m[arkers] s[earch] t[ext] u[ndo] w[ires])
\n Alt-g: rotate grid accuracy between 0.125 and 2
\n Alt-i: libmanger mode (e[other view] l[ibmanager] o[pen viewlist] s[ave viewlist])
\n Alt-l: lsw mode (l[sw] v[default] e[prefs])
\n Alt-m Alt-g: rotate grid accuracy between 0.125 and 2
\n Alt-m Alt-s: snap selection (or everything) to grid
\n Alt-n: toggle terminal names
\n Alt-p: plot
\n Alt-s: create simulator netlist
\n Alt-q: properties mode (b c[opy] f[old] l m[ult] n v[paste] w KP_Enter Shift Ctrl cursors)"))
      )

      ( " Alt-f"
        wrWindowName( strcat( wrDecodeBindKeysText ": filter ([Shift] c[els] d[evices] m[arkers] s[earch] t[ext] u[ndo] w[ires])"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
       )

      ( " Alt-f Alt-f"
        wrWindowName( "Alt-f: filter ([Shift] c[els] d[evices] m[arkers] s[earch] t[ext] u[ndo] w[ires])")
       )

      ( " Alt-f help"
        wrWindowName( strcat( wrDecodeBindKeysText ": filter help"))
	wrHelp( "
\n
\n Alt-f LSW help:
\n
\n Alt-f [Shift] Alt-b: filter bigger or smaller paths, rectangles or vias. (smaller with Shift)
\n ** with Shift, the following filters are negated.
\n Alt-f [Shift] Alt-c: filter cells (filterout cells)
\n Alt-f [Shift] Alt-d: filter devices
\n Alt-f [Shift] Alt-m: filter markers
\n Alt-f [Shift] Alt-t: filter text / labels
\n Alt-f Alt-e: extend selection
\n Alt-f Alt-s: filter anything with text, case insensitive
\n Alt-f Alt-KP_Enter: repeat filter text
\n Alt-f Alt-u: undo selection, get previous selection")
      )

      ( " Alt-f Alt-c"
	wrFilter( "cells")
       )

      ( " Alt-f Shift-Alt-c"
	wrFilter( "notCells")
       )

      ( " Alt-f Alt-d"
	wrFilter( "devices")
       )

      ( " Alt-f Shift-Alt-d"
	wrFilter( "notDevices")
       )

      ( " Alt-f Alt-m"
	wrFilter( "markers")
       )

      ( " Alt-f Shift-Alt-m"
	wrFilter( "notMarkers")
       )

      ( " Alt-f Alt-s"
	wrSearch( )
      )

      ( " Alt-f Alt-s Alt-KP_Enter"
        wrDecodeBindKeysText = " Alt-f Alt-s"
	wrFilter( "search")
      )

      ( " Alt-f Alt-t"
	wrFilter( "text")
       )

      ( " Alt-f Shift-Alt-t"
	wrFilter( "notText")
       )

      ( " Alt-f Alt-u"
	if( boundp( 'wrLastSelection)
	then
	  geDeselectAll( )
	  foreach(item wrLastSelection
	    geSelectObject( item)
	  )
	  wrWindowName( strcat( wrDecodeBindKeysText ": filter undo, " pcExprToString( geGetSelSetCount( )) " items selected"))
	else
	  wrWindowName( strcat( wrDecodeBindKeysText ": filter nothing to undo"))
	)
      )

      ( " Alt-f Shift-Alt-w"
	wrFilter( "notWires")
       )

      ( " Alt-f Alt-w"
	wrFilter( "wires")
       )

      ( " Alt-g"
        wrSchematicSnapSpacing( )
      )
      
      ( " Alt-i"
	wrWindowName( strcat( wrDecodeBindKeysText ": e[other view] l[ibmanager] o[pen viewlist] w[ritable] s[ave viewlist]"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-i Alt-l"
	wrLibManagerToggle( )
      )

      ( " Alt-i Alt-e"
	wrOpenOtherView( )
      )

      ( " Alt-i Alt-o"
	wrOpenLastViews( )
      )

      ( " Alt-i Alt-w"
	wrWriteToggle( )
      )

      ( " Alt-i Alt-s"
	wrSaveOpenViews( )
      )

      ( " Alt-l"
        wrWindowName( strcat( wrDecodeBindKeysText ": lsw: (l[sw] v[default] e[prefs])"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-l help"
        wrWindowName( strcat( wrDecodeBindKeysText ": lsw help"))
	wrHelp( "
\n
\n Alt-l LSW help:
\n
\n Alt-l Alt-e:  set schematic preferences
\n Alt-l Alt-l: show/hide LSW
\n Alt-l Alt-v: view only default layers in LSW")
;; \n Alt-l Alt-e: set schematic preferences
      )

      ( " Alt-l Alt-e"
	;; wrSchematicPrefs( )
      )
      ( " Alt-l Alt-l"
	wrLSWToggle( )
      )
      ( " Alt-l Alt-v"
	wrLSWDefault( )
      )

      ( " Alt-m help"
        wrWindowName( strcat( wrDecodeBindKeysText ": move help"))
	wrHelp( "
\n
\n alt-m Move help:
\n
\n Alt-m Alt-g: rotate grid accuracy between 0.125 and 2
\n Alt-m Alt-s: snap selection (or everything) to grid")
      )

      ( " Alt-m"
        wrWindowName( strcat( wrDecodeBindKeysText ": move: (g[rid] s[nap to grid])"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-m Alt-m"
        wrWindowName( strcat( wrDecodeBindKeysText ": move: (g[rid] s[nap to grid])"))
      )

      ( " Alt-m Alt-g"
        wrSchematicSnapSpacing( )
      )
      
      ( " Alt-m Alt-s"
        wrSchematicSnapToGrid( )
      )
      
      ( " Alt-n"
        wrSchematicNode( )
      )
      
      ( " Alt-p"
	wrSchPlot( )
      )

      ( " Alt-s"
	wrWindowName( strcat( wrDecodeBindKeysText ": create simulator netlist"))
	wrCreateNetlistFromSchematic( )
      )

      ( " Alt-q"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties (b[ulk] c[opy] f[old] l m[ult] n[umber] s[pace] t[name] q[properties] v[paste] w KP_Enter Shift Ctrl cursors)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

	( " Alt-q help"
          wrWindowName( strcat( wrDecodeBindKeysText ": properties help"))
	  wrHelp( strcat( "
\n
\n alt-q Properties help:
\n
\n Alt-q Alt-b: properties bulk contact
\n Alt-q Alt-c: copy (w/l/fold etc. of paths, vias and devices)
\n Alt-q Alt-f: properties f[old] ( up down)
\n Alt-q Alt-l: properties l
\n Alt-q Alt-m: properties m[ult] to 0
\n Alt-q Alt-m: properties s[pace] contact-poly (for DfM)
\n Alt-q Alt-q: show properties
\n Alt-q Alt-s: properties s[pace] contact to poly ( up down)
\n Alt-q Alt-t: enter name/text
\n Alt-q Alt-v: paste (no undo with devices)
\n Alt-q Alt-w: properties w
\n Alt-q Alt-KP_Enter: apply
\n Alt-q Alt-up: increase
\n Alt-q Alt-down: decrease
\n Alt-q Alt-left: decrease
\n Alt-q Alt-right: increase
\n Alt-q Shift-Alt-up: increase big
\n Alt-q Shift-Alt-down: decrease big
\n Alt-q Shift-Alt-left: decrease big
\n Alt-q Shift-Alt-right: increase big
\n Alt-q: Ctrl-Alt-up: increase l " pcExprToString( wrStepMin) "
\n Alt-q: Ctrl-Alt-down: decrease l " pcExprToString( wrStepMin) "
\n Alt-q: Ctrl-Alt-left: decrease w " pcExprToString( wrStepMin) "
\n Alt-q: Ctrl-Alt-right: increase w " pcExprToString( wrStepMin)))
	)

      ( " Alt-q Alt-f"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties f[old] ( up down)"))
        wrPropNumber = wrDeviceF
	wrProperty = wrF
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-q Alt-f Alt-up"
	wrFold( "up" 1)
      )
      ( " Alt-q Alt-f Alt-down"
	wrFold( "down" 1)
      )

      ( " Alt-q Alt-up"
	wrGrow( "up" 0.1 1 0.1)
      )
      ( " Alt-q Alt-down"
	wrGrow( "down" 0.1 1 0.1)
      )
      ( " Alt-q Alt-left"
	wrGrow( "left" 0.1 1 0.1)
      )
      ( " Alt-q Alt-right"
	wrGrow( "right" 0.1 1 0.1)
      )

      ( " Alt-q Shift-Alt-up"
	wrGrow( "up" 1 10 1)
      )
      ( " Alt-q Shift-Alt-down"
	wrGrow( "down" 1 10 1)
      )
      ( " Alt-q Shift-Alt-left"
	wrGrow( "left" 1 10 1)
      )
      ( " Alt-q Shift-Alt-right"
	wrGrow( "right" 1 10 1)
      )

      ( " Alt-q Ctrl-Alt-up"
	wrGrow( "up" wrStepMin 1 wrStepMin)
      )
      ( " Alt-q Ctrl-Alt-down"
	wrGrow( "down" wrStepMin 1 wrStepMin)
      )
      ( " Alt-q Ctrl-Alt-left"
	wrGrow( "left" wrStepMin 1 wrStepMin)
      )
      ( " Alt-q Ctrl-Alt-right"
	wrGrow( "right" wrStepMin 1 wrStepMin)
      )

      ( " Alt-q Alt-b"
	wrPropertiesBulk( )
      )

      ( " Alt-q Alt-c"
	wrCopyProperties( "copy")
      )

      ( " Alt-q Alt-d"
	wrFilter( "devices")
       )

      ( " Alt-q Alt-p"
	wrFilter( "paths")
       )

      ( " Alt-q Alt-l"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties: l n[umber]. ( " pcExprToString( wrPropNumber) " )"))
        wrPropNumber = wrDeviceL
	wrProperty = wrL
      )

      ( " Alt-q Alt-m"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties: properties m[ult] ( up down)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-q Alt-m Alt-up"
	wrMult( "up" 1)
      )
      ( " Alt-q Alt-m Alt-down"
	wrMult( "down" 1)
      )

      ( " Alt-q Alt-m off"
	wrProperties( "mismatch" 0)
      )

      ( " Alt-q Alt-n"
	cond(
	  ( ! boundp( 'wrProperty)
            wrWindowName( strcat( wrDecodeBindKeysText ": select property first f[old] l m[ult] s[pace] w" ))
          )
	  ( listp( wrProperty)
            wrText = car( wrProperty)
          )
	  ( t
            wrText = wrProperty
          )
	) ;; cond
	
	if( boundp( 'wrProperty)
	then
	  wrEnterNumberWithForm( "Enter value" wrText)
	  wrPropNumber = wrNumber
	  wrProperties( wrProperty wrPropNumber)
        )
      )

      ( " Alt-q Alt-KP_Enter"
	if( boundp( 'wrProperty)
	then
	  wrProperties( wrProperty wrPropNumber)
        else
	  wrWindowName( strcat( wrDecodeBindKeysText ": select property first f[old] l m[ult] s[pace] w" ))
        )
      )

      ( " Alt-q Alt-8"
	wrMultW( 2)
      )

      ( " Alt-q Alt-div"
	wrMultW( .5)
      )

      ( " Alt-q Alt-q"
	wrShowProperties( )
      )

      ( " Alt-q Alt-s"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties: properties s[pace] ( up down)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
	wrProperty = wrSpaceCoPoSet
      )

      ( " Alt-q Alt-s Alt-up"
	wrSpaceCoPo( "up" wrStepMin)
      )
      ( " Alt-q Alt-s Alt-down"
	wrSpaceCoPo( "down" wrStepMin)
      )

      ( " Alt-q Alt-t"
	wrSet( )
        wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-q Alt-t Alt-t"
	wrSet( )
        wrDecodeBindKeysTextPrev = " Alt-q Alt-t"
      )

      ( " Alt-q Alt-t Alt-KP_Enter"
	wrSetName( wrLabelName)
      )

      ( " Alt-q Alt-v"
	wrCopyProperties( "paste")
      )

      ( " Alt-q Alt-w"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties w n[umber] (" pcExprToString( wrPropNumber) ")"))
        wrPropNumber = wrDeviceW
	wrProperty = wrW
      )

      ( " Alt-r"
	wrSearchReplace( )
      )

      ( " Alt-u"
	wrUpdCellCdf( )
      )

      ( " Alt-x"
	wrWindowName( strcat( wrDecodeBindKeysText ": debug (d[ebug toolbox] f[ilter] s[kill finder] t[est] w[rite skill]"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-x Alt-d"
	wrWindowName( strcat( wrDecodeBindKeysText ": debug toolbox"))
	ilDebugToolBox( )
      )

      ( " Alt-x Alt-f"
        wrToggleLogFilter( )
      )
      
      ( " Alt-x Alt-s"
	wrWindowName( strcat( wrDecodeBindKeysText ": debug skill finder"))
	startFinder( )
      )

      ( " Alt-x Alt-t"
	wrWindowName( strcat( wrDecodeBindKeysText ": debug test function"))
	wrTest( )
      )

      ( " Alt-x Alt-w"
	wrWriteSkill( )
      )

      ( t
	if( wrDecodeBindKeysTextPrev != ""
	then
          if( key != "Alt-0"
	  then
            printf( strcat( "unknown key combination " wrDecodeBindKeysText ", clear " wrDecodeBindKeysTextPrev " and try again: " key))
	    ;; restore mode function: When the current mode is interrupted by a simple one key command
	    ;; like toggle metal2 visibility (Alt-2) then the mode is restored after the simple command.
	    ;; This is done with variable wrDecodeBindKeysTextPrevOld.
            wrDecodeBindKeysTextPrevOld = wrDecodeBindKeysTextPrev
	  )
	  wrDecodeBindKeysTextPrev = ""
          wrDecodeBindKeysSchematics( key)
	  if( wrDecodeBindKeysTextPrev == "" && wrDecodeBindKeysTextPrevOld != ""
	  then
	    printf( strcat( "\nRestore previous mode again: " wrDecodeBindKeysTextPrevOld))
	    wrDecodeBindKeysTextPrev = wrDecodeBindKeysTextPrevOld
	    wrDecodeBindKeysTextPrevOld = ""
	  )
	else
	  wrWindowName( strcat( "unknown key " wrDecodeBindKeysText ))
	) ;; if
      )
    )
  ) ;if
)

procedure( wrDecodeBindKeysLayout( key)

  ;; dprint( key GetEntryLayer wrEntryLayer wrDecodeBindKeysTextPrev)
  wrGetProcess( )
  wrStartTime = getCurrentTime( )
  wrDecode = nil
  cond(
    ( GetEntryLayer
      wrEnterLayer( key)
    )
    ( t
      wrDecode = t
      wrDecodeBindKeysText = strcat( wrDecodeBindKeysTextPrev " " key)
    )
  )
  ;; dprint( wrDecodeBindKeysText)

  if( wrEntryLayer != ""
  then
       
    ;; Perform key <layer> type commands:
    wrDecode = nil
    GetEntryLayer = t
    case( wrDecodeBindKeysTextPrev

      ( " Alt-c"
	wrWindowName( strcat( wrDecodeBindKeysText ": change to layer "  wrEntryLayerName " " pcExprToString( wrLayerType)))
	wrSetLayer( wrEntryLayer wrLayerType)
      )

      ( " Alt-e"
	wrSetEntryLayer( wrEntryLayer wrLayerType)
	wrWindowName( strcat( wrDecodeBindKeysText ": set entry layer "  wrEntryLayerName " " pcExprToString( wrLayerType)))
	;; wrDecodeBindKeysTextPrev = ""
      )

      ( " Alt-s"
	wrLSWToggleSelectableLayers( wrEntryLayer wrLayerType)
      )

      ( " Alt-t"
	wrLSWToggleVisibleLayers( wrEntryLayer wrLayerType)
      )
      
      ( t
        wrDecode = t
        GetEntryLayer = nil
      )
    )
  ) ;; if

  ;; Perform key-x key-y ... type commands:

  if( wrDecode
  then
    
    if( wrDecodeBindKeysTextPrev != ""
    then
      hiRegTimer( "wrClear( )" 1200)
    )
    
    case( wrDecodeBindKeysText

      ( ""
        
      )

      ( " Alt-0"
	wrDefault( )
	if( not( null( wrEntryLayerPrev)) && leIsLayerVisible( wrEntryLayerPrev)
	then
	  wrSetEntryLayer( list( car( wrEntryLayerPrev)) cadr( wrEntryLayerPrev))
	  wrEntryLayerPrev = nil
	)
      )
  
      ( " Alt-,"
        wrCycleMetalLayers( nil)
      )

      ( " Alt-."
        wrCycleMetalLayers( t)
      )

      ( " Alt-8"
	wrMultW( 2)
      )

      ( " Alt-div"
	wrMultW( .5)
      )

      ( " Alt-up"
	wrGrow( "up" 0.1 1 0.1)
      )
      ( " Alt-down"
	wrGrow( "down" 0.1 1 0.1)
      )
      ( " Alt-left"
	wrGrow( "left" 0.1 1 0.1)
      )
      ( " Alt-right"
	wrGrow( "right" 0.1 1 0.1)
      )

      ( " Shift-Alt-up"
	wrGrow( "up" 1 10 1)
      )
      ( " Shift-Alt-down"
	wrGrow( "down" 1 10 1)
      )
      ( " Shift-Alt-left"
	wrGrow( "left" 1 10 1)
      )
      ( " Shift-Alt-right"
	wrGrow( "right" 1 10 1)
      )

      ( " Ctrl-Alt-up"
	wrGrow( "up" wrStepMin 1 wrStepMin)
      )
      ( " Ctrl-Alt-down"
	wrGrow( "down" wrStepMin 1 wrStepMin)
      )
      ( " Ctrl-Alt-left"
	wrGrow( "left" wrStepMin 1 wrStepMin)
      )
      ( " Ctrl-Alt-right"
	wrGrow( "right" wrStepMin 1 wrStepMin)
      )

      ( " Alt-1"
        wrEntryLayer = list( wrM1)
	wrEntryLayerName = car( wrEntryLayer)
	wrLSWToggleVisibleLayers( wrEntryLayer)
      )
      ( " Alt-2"
        wrEntryLayer = list( wrM2)
	wrEntryLayerName = car( wrEntryLayer)
	wrLSWToggleVisibleLayers( wrEntryLayer)
      )
      ( " Alt-3"
        wrEntryLayer = list( wrM3)
	wrEntryLayerName = car( wrEntryLayer)
	wrLSWToggleVisibleLayers( wrEntryLayer)
      )
      ( " Alt-4"
        wrEntryLayer = list( wrM4)
	wrEntryLayerName = car( wrEntryLayer)
	wrLSWToggleVisibleLayers( wrEntryLayer)
      )
      ( " Alt-5"
        wrEntryLayer = list( wrM5)
	wrEntryLayerName = car( wrEntryLayer)
	wrLSWToggleVisibleLayers( wrEntryLayer)
      )
      ( " Alt-6"
        wrEntryLayer = list( wrM6)
	wrEntryLayerName = car( wrEntryLayer)
	wrLSWToggleVisibleLayers( wrEntryLayer)
      )

      ( " Shift-Alt-1"
	wrSetLayer( list( wrM1))
      )
      ( " Shift-Alt-2"
	wrSetLayer( list( wrM2))
      )
      ( " Shift-Alt-3"
	wrSetLayer( list( wrM3))
      )
      ( " Shift-Alt-4"
	wrSetLayer( list( wrM4))
      )
      ( " Shift-Alt-5"
	wrSetLayer( list( wrM5))
      )
      ( " Shift-Alt-6"
	wrSetLayer( list( wrM6))
      )
      ( " Alt-9"
	;; Set wrPo entry layer because if Mx is entry, it cannot be turned off.
	wrEntryLayerName = "all metal"
	wrLSWToggleVisibleLayers( wrMetals)
      )

      ( " Shift-Alt-e"
	wrSetLayer( list( car( leGetEntryLayer( ))) cadr( leGetEntryLayer( )))
      )
      ( " Shift-Alt-p"
	wrSetLayer( list( wrPo))
      )
      ( " help"
        wrWindowName( strcat( wrDecodeBindKeysText ": layout help"))
	wrHelp( strcat( "
\n
\n Layout help:
\n
\n Default Cadence:
\n F4 select partial/full
\n F6 toggle maintain connections
\n a: select
\n Ctrl a: select all
\n Ctrl d: deselect all
\n g: toggle gravity
\n k: create ruler
\n Shift k: remove rulers
\n l: create label
\n m: move
\n Shift m: merge
\n Ctrl n: set snap mode
\n p: create path
\n q: edit properties
\n r: create rectangle
\n Shift r: reshape
\n Ctrl r: redraw
\n s: stretch
\n Ctrl s: split (user right mouse button to toggle selected part)
\n t: zoom to selected set
\n u: undo
\n shift u: redo
\n Ctrl v: focus to CIW
\n w: previous view
\n shift w: next view
\n Ctrl y: select next
\n Ctrl-left: Go to the left boundary
\n Ctrl-right: Go to the right boundary
\n 
\n wrKeys: 
\n Alt-0 clear mode
\n Alt-up: increase
\n Alt-down: decrease
\n Alt-left: decrease
\n Alt-right: increase
\n Shift-Alt-up: increase 10
\n Shift-Alt-down: decrease 10
\n Shift-Alt-left: decrease 10
\n Shift-Alt-right: increase 10
\n Ctrl-Alt-up: increase l " pcExprToString( wrStepMin) "
\n Ctrl-Alt-down: decrease l " pcExprToString( wrStepMin) "
\n Ctrl-Alt-left: decrease w " pcExprToString( wrStepMin) "
\n Ctrl-Alt-right: increase w " pcExprToString( wrStepMin) "
\n Alt-1: toggle visibility M1
\n Alt-2.. : toggle visibility M2
\n Shift-Alt-1: change to layer M1
\n Shift-Alt-2.. : change to layer M2
\n Shift-Alt-e : change to entry poly
\n Shift-Alt-p : change to layer poly
\n Alt-9: toggle visibility all metal layers (set entrylayer to poly)
\n Alt-<: Cycle down through the metal layers, inc. vias.
\n Alt->: Cycle up through the metal layers, inc. vias.
\n Alt-c: change to layer (layer) mode
\n Alt-e: set entry layer (layer) mode
\n Alt-f: filter mode ([Shift] c[els] d[evices] l[abels] m[arkers] s[earch] u[ndo] v[ias] w[ires])
\n Alt-g: Toggle grid accuracy between "  pcExprToString( wrStepMin) " and 0.2
\n Alt-i: libmanager mode (e[other view] l[ibmanager] o[pen viewlist] s[ave viewlist])
\n Alt-l: lsw mode (d[rf] i[nst] l[sw] p[in] s[el] t[vis] r[emove] v[default] e[prefs])
\n Alt-m: move mode (n Shift Ctrl cursors [align] h[or] l[eft] r[ight] n[umber] s[nap] g[rid] o[rigin])
\n Alt-n: toggle instance display name
\n Alt-o: via mode (1 2 3 4 5 9 f[ilter] l[atest] n p(n p) s r[otate]) Shift cursors
\n Alt-p: plot
\n Alt-q: properties mode (b[ulk] c[opy] f[old] l m[ult] n[umber] s[pace] q[properties] v[paste] w KP_Enter Shift Ctrl cursors)
\n Alt-s: toggle selectability (layer) mode
\n Alt-t: toggle visibility (layer) mode")
        )
      )

      ( " Alt-c"
        wrWindowName( strcat( wrDecodeBindKeysText ": change to layer (layer)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
	wrLayerType = "drawing"
        GetEntryLayer = t
      )

      ( " Alt-e"
        wrWindowName( strcat( wrDecodeBindKeysText ": set entry layer (current: " car( leGetEntryLayer( )) " " cadr( leGetEntryLayer( )) ")" ))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
	wrLayerType = "drawing"
        GetEntryLayer = t
      )

      ( " Alt-i"
	wrWindowName( strcat( wrDecodeBindKeysText ": e[other view] l[ibmanager] o[pen viewlist] w[ritable] s[ave viewlist]"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-i Alt-l"
	wrLibManagerToggle( )
      )

      ( " Alt-i Alt-e"
	wrOpenOtherView( )
      )

      ( " Alt-i Alt-o"
	wrOpenLastViews( )
      )

      ( " Alt-i Alt-s"
	wrSaveOpenViews( )
      )

      ( " Alt-i Alt-w"
	wrWriteToggle( )
      )

      ( " Alt-f"
        wrWindowName( strcat( wrDecodeBindKeysText ": filter ([Shift] b[iger] c[els] d[evices] e[xtend] l[ayer] m[arkers] p[ins] s[earch] t[ext] u[ndo] v[ias] w[ires])"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-f Alt-f"
        wrWindowName( "Alt-f: filter ([Shift] b[iger] c[els] d[evices] e[xtend] l[ayer] m[arkers] p[ins] s[earch] t[ext] u[ndo] v[ias] w[ires])")
       )

      ( " Alt-f help"
        wrWindowName( strcat( wrDecodeBindKeysText ": filter help"))
	wrHelp( "
\n
\n Alt-f LSW help:
\n
\n Alt-f [Shift] Alt-b: filter bigger or smaller paths, rectangles or vias. (smaller with Shift)
\n ** with Shift, the following filters are negated.
\n Alt-f [Shift] Alt-c: filter cells (filterout cells)
\n Alt-f [Shift] Alt-d: filter devices
\n Alt-f [Shift] Alt-m: filter markers
\n Alt-f [Shift] Alt-p: filter pins
\n Alt-f [Shift] Alt-t: filter text / labels
\n Alt-f [Shift] Alt-v: filter vias
\n Alt-f [Shift] Alt-w: filter wires 
\n Alt-f Alt-e: extend selection
\n Alt-f Alt-s: filter anything with text, case insensitive
\n Alt-f Alt-KP_Enter: repeat filter text
\n Alt-f Alt-u: undo selection, get previous selection")
      )

      ( " Alt-f Alt-b"
	wrFilterSize( "bigger")
       )

      ( " Alt-f Shift-Alt-b"
	wrFilterSize( "smaller")
       )

      ( " Alt-f Alt-c"
	wrFilter( "cells")
       )

      ( " Alt-f Shift-Alt-c"
	wrFilter( "notCells")
       )

      ( " Alt-f Alt-d"
	wrFilter( "devices")
       )

      ( " Alt-f Shift-Alt-d"
	wrFilter( "notDevices")
       )

      ( " Alt-f Alt-e"
	wrExtendSelection( )
       )

      ( " Alt-f Alt-l"
	wrFilter( "layer")
       )

      ( " Alt-f Shift-Alt-l"
	wrFilter( "notLayer")
       )

      ( " Alt-f Alt-m"
	wrFilter( "markers")
       )

      ( " Alt-f Shift-Alt-m"
	wrFilter( "notMarkers")
       )

      ( " Alt-f Alt-p"
	wrFilter( "pins")
       )

      ( " Alt-f Shift-Alt-p"
	wrFilter( "notPins")
       )

      ( " Alt-f Alt-s"
	wrSearch( )
      )

      ( " Alt-f Alt-s Alt-KP_Enter"
	wrDecodeBindKeysText = " Alt-f Alt-s"
        wrFilter( "search")
      )

      ( " Alt-f Alt-t"
	wrFilter( "text")
       )

      ( " Alt-f Shift-Alt-t"
	wrFilter( "notText")
       )

      ( " Alt-f Alt-u"
	if( boundp( 'wrLastSelection)
	then
	  geDeselectAll( )
	  foreach(item wrLastSelection
	    geSelectObject( item)
	  )
	else
	)
      )

      ( " Alt-f Alt-v"
	wrFilter( "vias")
      )

      ( " Alt-f Shift-Alt-v"
	wrFilter( "notVias")
      )

      ( " Alt-f Alt-w"
	wrFilter( "paths")
      )

      ( " Alt-f Shift-Alt-w"
	wrFilter( "notPaths")
      )

      ( " Alt-g"
        wrLayoutSnapSpacing( )
      )
      
      ( " Alt-l"
        wrWindowName( strcat( wrDecodeBindKeysText ": lsw: (d[rf] e[prefs] i[nst] l[sw] p[in] s[el] t[vis] o[around] r[emove] v[default] w[all used layers])"))
        wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-l help"
        wrWindowName( strcat( wrDecodeBindKeysText ": lsw help"))
	wrHelp( "
\n
\n Alt-l LSW help:
\n
\n Alt-l Alt-d: load custom DRF
\n Alt-l Alt-e: set layout preferences and save form locations
\n Alt-l Alt-i: toggle instances selectable
\n Alt-l Alt-l: show/hide LSW
\n Alt-l Alt-o: toggle surrounding (for decend-in-place)
\n Alt-l Alt-p: toggle pin selectable
\n Alt-l Alt-r: remove all layers from LSW
\n Alt-l Alt-s: toggle layers selectable
\n Alt-l Alt-t: toggle layers visible
\n Alt-l Alt-v: view only default layers in LSW
\n Alt-l Alt-w: show all layers in current window")
      )

      ( " Alt-l Alt-i"
	wrLSWToggleSelectableInst( )
      )
      ( " Alt-l Alt-d"
	wrLoadDrf( )
      )
      ( " Alt-l Alt-e"
	wrLayoutPrefs( )
      )
      ( " Alt-l Alt-l"
	wrLSWToggle( )
      )
      ( " Alt-l Alt-o"
	wrToggleDrawSurrounding( )
      )
      ( " Alt-l Alt-p"
	wrLSWToggleSelectablePin( )
      )
      ( " Alt-l Alt-s"
	wrLSWToggleSelectableAllLayers( )
      )
      ( " Alt-l Alt-t"
	wrLSWToggleVisibleAllLayers( )
      )
      ( " Alt-l Alt-r"
	wrWindowName( strcat( wrDecodeBindKeysText ": remove all layers from LSW"))
	leSetAllLayerValid( nil)
      )
      ( " Alt-l Alt-v"
	wrLSWDefault( )
      )
      ( " Alt-l Alt-w"
	wrLSWLayersUsedValid( )
      )

      ( " Alt-m"
        wrWindowName( strcat( wrDecodeBindKeysText ": move: (n[umber] [Shift] [Ctrl] cursors [align] h[or] l[eft] r[ight] s[nap] f[it limit] g[rid] o[rigin] x[postion] c[opy] v[paste])"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-m Alt-m"
        wrWindowName( "Alt-m move: (n[umber] [Shift] [Ctrl] cursors [align] h[or] l[eft] r[ight] s[nap] f[it limit] g[rid] o[rigin] x[postion] c[opy] v[paste])")
      )

      ( " Alt-m help"
        wrWindowName( strcat( wrDecodeBindKeysText ": move help"))
	wrHelp( "
\n
\n Alt-m Move help:
\n
\n Alt-m Alt-n: enter number
\n Alt-m Alt-up: move up 
\n Alt-m Alt-down: move down 
\n Alt-m Alt-left: move left 
\n Alt-m Alt-right: move right 
\n Alt-m Shift-Alt-up: move up 0.5
\n Alt-m Shift-Alt-down: move down 0.5
\n Alt-m Shift-Alt-left: move left 0.5
\n Alt-m Shift-Alt-right: move right 0.5
\n Alt-m Ctrl-Alt-up: move up " pcExprToString( wrStepMin) "
\n Alt-m Ctrl-Alt-down: move down " pcExprToString( wrStepMin) "
\n Alt-m Ctrl-Alt-left: move left " pcExprToString( wrStepMin) "
\n Alt-m Ctrl-Alt-right: move right " pcExprToString( wrStepMin) "
\n Alt-m Alt-c: copy window area from a window
\n Alt-m Alt-v: paste window area in another window
\n Alt-m Alt-d: change snap mode - anyangle etc.
\n Alt-m Alt-f: zoom fit limit
\n Alt-m Alt-g: Toggle grid accuracy between "  pcExprToString( wrStepMin) " and 0.2
\n Alt-m Alt-r: align right
\n Alt-m Alt-h: align horizontal
\n Alt-m Alt-l: align left
\n Alt-m Alt-o: move to origin
\n Alt-m Alt-s: magnify selection
\n Alt-m Alt-x: zoom to xy coordinates") 
      )

      ( " Alt-m Alt-up"
	wrMoveCursor( "up" wrMoveNumber)
      )
      ( " Alt-m Alt-down"
	wrMoveCursor( "down" wrMoveNumber)
      )
      ( " Alt-m Alt-left"
	wrMoveCursor( "left" wrMoveNumber)
      )
      ( " Alt-m Alt-right"
	wrMoveCursor( "right" wrMoveNumber)
      )

      ( " Alt-m Shift-Alt-up"
	wrMoveCursor( "up" 0.5)
      )
      ( " Alt-m Shift-Alt-down"
	wrMoveCursor( "down" 0.5)
      )
      ( " Alt-m Shift-Alt-left"
	wrMoveCursor( "left" 0.5)
      )
      ( " Alt-m Shift-Alt-right"
	wrMoveCursor( "right" 0.5)
      )

      ( " Alt-m Alt-,"
	wrLayoutZoomNext( "down")
      )
      
      ( " Alt-m Alt-."
	wrLayoutZoomNext( "up")
      )
      
      ( " Alt-m Shift-Alt-."
	wrLayoutZoomNext( "repeat")
      )
      
      ( " Alt-m Ctrl-Alt-up"
	wrMoveCursor( "up" wrStepMin)
      )
      ( " Alt-m Ctrl-Alt-down"
	wrMoveCursor( "down" wrStepMin)
      )
      ( " Alt-m Ctrl-Alt-left"
	wrMoveCursor( "left" wrStepMin)
      )
      ( " Alt-m Ctrl-Alt-right"
	wrMoveCursor( "right" wrStepMin)
      )

      ( " Alt-m Alt-d"
        wrToggleSnapMode( )
      )

      ( " Alt-m Alt-f"
        wrLayoutZoomLimit( )
      )
      
      ( " Alt-m Alt-g"
        wrLayoutSnapSpacing( )
      )
      
      ( " Alt-m Alt-c"
        wrWindowName( strcat( wrDecodeBindKeysText ": copy window area"))
        wrBBcopy = hiGetViewBBox( hiGetCurrentWindow( ))
      )
      
      ( " Alt-m Alt-v"
        if( boundp( 'wrBBcopy)
	then
	  wrWindowName( strcat( wrDecodeBindKeysText ": paste window area"))
	  hiZoomIn( hiGetCurrentWindow( ) wrBBcopy)
	else
	  wrWindowName( strcat( wrDecodeBindKeysText ": copy window area first"))
	)
      )
      
      ( " Alt-m Alt-r"
        wrWindowName( strcat( wrDecodeBindKeysText ": align right"))
        wrAlign( ?dir "right")
      )
      ( " Alt-m Alt-h"
        wrWindowName( strcat( wrDecodeBindKeysText ": align horizontal"))
        wrAlign( ?dir "down")
      )
      ( " Alt-m Alt-l"
        wrWindowName( strcat( wrDecodeBindKeysText ": align left"))
        wrAlign( ?dir "left")
      )
      
      ( " Alt-m Alt-n"
	wrText = "move"
	wrNumber = wrMoveNumber
	wrEnterNumberWithForm( "Enter value" "Move")
	wrMoveNumber = wrNumber
	wrWindowName( strcat( wrDecodeBindKeysText ": set " wrText " = " wrNumberText))
      )

      ( " Alt-m Alt-o"
	wrWindowName( strcat( wrDecodeBindKeysText ": move to origin"))
	hiZoomIn( hiGetCurrentWindow( ) list( list(-.1 -.1) list(.1 .1)))
      )

      ( " Alt-m Alt-s"
        wrMagnify( )
      )

      ( " Alt-m Alt-x"
        wrZoomXYInput( )
      )

      ( " Alt-n"
        wrLayoutDisplayName( )
      )
      
      ( " Alt-o"
	wrWindowName( strcat( wrDecodeBindKeysText ": via (1 2 3 4 5 9 f[ilter] l[atest] n p(n p) s w r[otate]) Shift cursors"))
        wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-o Alt-o"
	wrWindowName( " Alt-o: via (1 2 3 4 5 9 f[ilter] l[atest] n p(n p) s w r[otate]) Shift cursors")
      )

      ( " Alt-o help"
        wrWindowName( strcat( wrDecodeBindKeysText ": via help"))
	wrHelp( "
\n
\n Alt-o Via help:
\n
\n Alt-o Alt-d: deselect all
\n Alt-o Alt-1: add via1
\n Alt-o Alt-2: add via2
\n Alt-o Alt-3: add via3
\n Alt-o Alt-4: add via4
\n Alt-o Alt-5: add via5
\n Alt-o Alt-9: add auto via
\n Alt-o Alt-l: select only the last added vias
\n Alt-o Alt-f: filter vias
\n Alt-o Alt-n: add nplus via
\n Alt-o Alt-p: add poly via (n p)
\n Alt-o Alt-p Alt-n: add npoly via
\n Alt-o Alt-p Alt-p: add ppoly via
\n Alt-o Alt-r: rotate layer enclosure of via
\n Alt-o Alt-s: add pplus via
\n Alt-o Alt-w: add nwell via
\n Alt-o Alt-up: increase rows
\n Alt-o Alt-down: decrease rows
\n Alt-o Alt-left: decrease columns
\n Alt-o Alt-right: increase columns
\n Alt-o: Shift-Alt-up: increase 10 rows
\n Alt-o: Shift-Alt-down: decrease 10 rows
\n Alt-o: Shift-Alt-left: decrease 10 columns
\n Alt-o: Shift-Alt-right: increase 10 columns")
      )

      ( " Alt-o Alt-d"
	wrWindowName( strcat( wrDecodeBindKeysText ": deselect all"))
	geDeselectAll( )
      )
      ( " Alt-o Alt-1"
	wrAddVia( "v1")
      )
      ( " Alt-o Alt-2"
	wrAddVia( "v2")
      )
      ( " Alt-o Alt-3"
	wrAddVia( "v3")
      )
      ( " Alt-o Alt-4"
	wrAddVia( "v4")
      )
      ( " Alt-o Alt-5"
	wrAddVia( "v5")
      )

      ( " Alt-o Alt-9"
	wrAddAutoVia( )
      )

      ( " Alt-o Alt-up"
	wrGrow( "up" 0.1 1 0.1)
      )
      ( " Alt-o Alt-down"
	wrGrow( "down" 0.1 1 0.1)
      )
      ( " Alt-o Alt-left"
	wrGrow( "left" 0.1 1 0.1)
      )
      ( " Alt-o Alt-right"
	wrGrow( "right" 0.1 1 0.1)
      )

      ( " Alt-o Shift-Alt-up"
	wrGrow( "up" 1 10 1)
      )
      ( " Alt-o Shift-Alt-down"
	wrGrow( "down" 1 10 1)
      )
      ( " Alt-o Shift-Alt-left"
	wrGrow( "left" 1 10 1)
      )
      ( " Alt-o Shift-Alt-right"
	wrGrow( "right" 1 10 1)
      )

      ( " Alt-o Alt-f"
	wrFilter( "vias")
      )

      ( " Alt-o Alt-l"
	wrWindowName( strcat( wrDecodeBindKeysText ": select only the added vias"))
	wrSelectNewVias( )
      )

      ( " Alt-o Alt-n"
	wrAddVia( "no")
      )

      ( " Alt-o Alt-p"
	wrWindowName( strcat( wrDecodeBindKeysText ": add poly via (n p)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-o Alt-p Alt-n"
	wrDecodeBindKeysTextPrev = " Alt-o"
	wrAddVia( "np")
      )

      ( " Alt-o Alt-p Alt-p"
	wrDecodeBindKeysTextPrev = " Alt-o"
	wrAddVia( "pp")
      )

      ( " Alt-o Alt-r"
	wrWindowName( strcat( wrDecodeBindKeysText ": rotate layer enclosure of via"))
	wrRotateVia( )
      )

      ( " Alt-o Alt-s"
	wrAddVia( "po")
      )

      ( " Alt-o Alt-w"
	wrAddVia( "nw")
      )

      ( " Alt-p"
	wrLayoutPlot( )
      )

      ( " Alt-q"
        wrWindowName( strcat( wrDecodeBindKeysText ": properties (b[ulk] c[opy] f[old] l m[ult] n[umber] s[pace] q[properties] v[paste] w KP_Enter Shift Ctrl cursors)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-q help"
        wrWindowName( strcat( wrDecodeBindKeysText ": properties help"))
	wrHelp( strcat( "
\n
\n Alt-q Properties help:
\n
\n Alt-q Alt-b: properties bulk contact
\n Alt-q Alt-c: copy
\n Alt-q Alt-f: properties f[old] ( up down)
\n Alt-q Alt-l: properties l
\n Alt-q Alt-m: properties m[ult] to 0
\n Alt-q Alt-q: show properties
\n Alt-q Alt-s: properties s[pace] contact to poly ( up down)
\n Alt-q Alt-t: enter name/text
\n Alt-q Alt-v: paste
\n Alt-q Alt-w: properties w
\n Alt-q Alt-KP_Enter: apply
\n Alt-q Alt-up: increase
\n Alt-q Alt-down: decrease
\n Alt-q Alt-left: decrease
\n Alt-q Alt-right: increase
\n Alt-q Shift-Alt-up: increase 10
\n Alt-q Shift-Alt-down: decrease 10
\n Alt-q Shift-Alt-left: decrease 10
\n Alt-q Shift-Alt-right: increase 10
\n Alt-q: Ctrl-Alt-up: increase l " pcExprToString( wrStepMin) "
\n Alt-q: Ctrl-Alt-down: decrease l " pcExprToString( wrStepMin) "
\n Alt-q: Ctrl-Alt-left: decrease w " pcExprToString( wrStepMin) "
\n Alt-q: Ctrl-Alt-right: increase w " pcExprToString( wrStepMin)))
      )

      ( " Alt-q Alt-n"
	cond(
	  ( ! boundp( 'wrProperty)
            wrWindowName( strcat( wrDecodeBindKeysText ": select property first f[old] l m[ult] s[pace] w" ))
          )
	  ( listp( wrProperty)
            wrText = car( wrProperty)
          )
	  ( t
            wrText = wrProperty
          )
	) ;; cond
	
	if( boundp( 'wrProperty)
	then
	  wrEnterNumberWithForm("Enter value" wrText)
	  wrPropNumber = wrNumber
	  wrProperties( wrProperty wrPropNumber)
        )
      )

      ( " Alt-q Alt-KP_Enter"
	if( boundp( 'wrProperty)
	then
	  wrProperties( wrProperty wrPropNumber)
        else
	  wrWindowName( strcat( wrDecodeBindKeysText ": select property first f[old] l m[ult] s[pace] w" ))
        )
      )

      ( " Alt-q Alt-8"
	wrMultW( 2)
      )

      ( " Alt-q Alt-div"
	wrMultW( .5)
      )

      ( " Alt-q Alt-up"
	wrWindowName( strcat( wrDecodeBindKeysText ": increase"))
	wrGrow( "up" 0.1 1 0.1)
      )
      ( " Alt-q Alt-down"
	wrWindowName( strcat( wrDecodeBindKeysText ": decrease"))
	wrGrow( "down" 0.1 1 0.1)
      )
      ( " Alt-q Alt-left"
	wrWindowName( strcat( wrDecodeBindKeysText ": decrease"))
	wrGrow( "left" 0.1 1 0.1)
      )
      ( " Alt-q Alt-right"
	wrWindowName( strcat( wrDecodeBindKeysText ": increase"))
	wrGrow( "right" 0.1 1 0.1)
      )

      ( " Alt-q Shift-Alt-up"
	wrWindowName( strcat( wrDecodeBindKeysText ": increase l 10"))
	wrGrow( "up" 1 10 1)
      )
      ( " Alt-q Shift-Alt-down"
	wrWindowName( strcat( wrDecodeBindKeysText ": decrease l 10"))
	wrGrow( "down" 1 10 1)
      )
      ( " Alt-q Shift-Alt-left"
	wrWindowName( strcat( wrDecodeBindKeysText ": decrease w 10"))
	wrGrow( "left" 1 10 1)
      )
      ( " Alt-q Shift-Alt-right"
	wrWindowName( strcat( wrDecodeBindKeysText ": increase w 10"))
	wrGrow( "right" 1 10 1)
      )

      ( " Alt-q Ctrl-Alt-up"
	wrWindowName( strcat( wrDecodeBindKeysText ": Ctrl-Alt-up: increase l " pcExprToString( wrStepMin)))
	wrGrow( "up" wrStepMin 1 wrStepMin)
      )
      ( " Alt-q Ctrl-Alt-down"
	wrWindowName( strcat( wrDecodeBindKeysText ": Ctrl-Alt-down: decrease l " pcExprToString( wrStepMin)))
	wrGrow( "down" wrStepMin 1 wrStepMin)
      )
      ( " Alt-q Ctrl-Alt-left"
	wrWindowName( strcat( wrDecodeBindKeysText ": Ctrl-Alt-left: decrease w " pcExprToString( wrStepMin)))
	wrGrow( "left" wrStepMin 1 wrStepMin)
      )
      ( " Alt-q Ctrl-Alt-right"
	wrWindowName( strcat( wrDecodeBindKeysText ": Ctrl-Alt-right: increase w " pcExprToString( wrStepMin)))
	wrGrow( "right" wrStepMin 1 wrStepMin)
      )

      ( " Alt-q Alt-b"
	wrWindowName( strcat( wrDecodeBindKeysText ": toggle bulk"))
	wrPropertiesBulk( )
      )

      ( " Alt-q Alt-c"
	wrCopyProperties( "copy")
      )

      ( " Alt-q Alt-d"
	wrFilter( "devices")
       )

      ( " Alt-q Alt-f"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties f[old] ( up down)"))
        wrPropNumber = wrDeviceF
	wrProperty = wrF
        wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-q Alt-f Alt-up"
	wrFold( "up" 1)
      )
      ( " Alt-q Alt-f Alt-down"
	wrFold( "down" 1)
      )

      ( " Alt-q Alt-l"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties l. Number = " pcExprToString( wrPropNumber)))
        wrPropNumber = wrDeviceL
	wrProperty = wrL
      )

      ( " Alt-q Alt-m"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties m[ult] ( up down)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-q Alt-m Alt-up"
	wrMult( "up" 1)
      )
      ( " Alt-q Alt-m Alt-down"
	wrMult( "down" 1)
      )

      ( " Alt-q Alt-m off"
	wrProperties( "mismatch" 0)
      )

      ( " Alt-q Alt-r"
	wrWindowName( strcat( wrDecodeBindKeysText ": rotate instances"))
	wrRotateInst( )
      )

      ( " Alt-q Alt-t"
	wrSet( )
        wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-q Alt-t Alt-t"
	wrSet( )
        wrDecodeBindKeysTextPrev = " Alt-q Alt-t"
      )

      ( " Alt-q Alt-t Alt-KP_Enter"
	wrSetName( wrLabelName)
      )

      ( " Alt-q Alt-p"
	wrFilter( "paths")
      )

      ( " Alt-q Alt-q"
	wrShowProperties( )
      )

      ( " Alt-q Alt-s"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties s[pace] ( up down)"))
        wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
	wrProperty = wrSpaceCoPoSet
      )

      ( " Alt-q Alt-s Alt-up"
	wrSpaceCoPo( "up" wrStepMin)
      )
      ( " Alt-q Alt-s Alt-down"
	wrSpaceCoPo( "down" wrStepMin)
      )

      ( " Alt-q Alt-v"
	wrCopyProperties( "paste")
      )

      ( " Alt-q Alt-w"
	wrWindowName( strcat( wrDecodeBindKeysText ": properties: w. Number = " pcExprToString( wrPropNumber)))
        wrPropNumber = wrDeviceW
	wrProperty = wrW
      )

      ( " Alt-r"
	wrSearchReplace( )
      )

      ( " Alt-s"
        wrWindowName( strcat( wrDecodeBindKeysText ": toggle selectability (layer)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
	wrLayerType = "drawing"
        GetEntryLayer = t
      )

      ( " Alt-t"
        wrWindowName( strcat( wrDecodeBindKeysText ": toggle visibility (layer)"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
	wrLayerType = "drawing"
        GetEntryLayer = t
      )

      ( " Alt-u"
	PiaUpdCellCdfCB( )
      )

      ( " Alt-x"
	wrWindowName( strcat( wrDecodeBindKeysText ": debug (d[ebug toolbox] f[ilter] s[kill finder] t[est] w[rite skill]"))
	wrDecodeBindKeysTextPrev = wrDecodeBindKeysText
      )

      ( " Alt-x Alt-d"
	wrWindowName( strcat( wrDecodeBindKeysText ": debug toolbox"))
	ilDebugToolBox( )
      )

      ( " Alt-x Alt-f"
        wrToggleLogFilter( )
      )
      
      ( " Alt-x Alt-s"
	wrWindowName( strcat( wrDecodeBindKeysText ": debug skill finder"))
	startFinder( )
      )

      ( " Alt-x Alt-t"
	wrWindowName( strcat( wrDecodeBindKeysText ": debug test function"))
	wrTest( )
      )

      ( " Alt-x Alt-w"
	wrWriteSkill( )
      )

      ( t
	if( wrDecodeBindKeysTextPrev != ""
	then
          if( key != "Alt-0"
	  then
            printf( strcat( "unknown key combination " wrDecodeBindKeysText ", clear " wrDecodeBindKeysTextPrev " and try again: " key))
	    ;; restore mode function: When the current mode is interrupted by a simple one key command
	    ;; like toggle metal2 visibility (Alt-2) then the mode is restored after the simple command.
	    ;; This is done with variable wrDecodeBindKeysTextPrevOld.
            wrDecodeBindKeysTextPrevOld = wrDecodeBindKeysTextPrev
	  )
	  wrDecodeBindKeysTextPrev = ""
          wrDecodeBindKeysLayout( key)
	  if( wrDecodeBindKeysTextPrev == "" && wrDecodeBindKeysTextPrevOld != ""
	  then
	    printf( strcat( "\nRestore previous mode again: " wrDecodeBindKeysTextPrevOld))
	    wrDecodeBindKeysTextPrev = wrDecodeBindKeysTextPrevOld
	    wrDecodeBindKeysTextPrevOld = ""
	  )
	else
	  wrWindowName( strcat( "unknown key " wrDecodeBindKeysText ))
	) ;; if
      )
    ) ;; case
  ) ;if
)

  hiSetBindKey( "Command Interpreter"	"Alt<Key>l"		"load( strcat( wrAltEditPath \"/wrAltEdit.il\")) wrWindowName( \"Loaded wrAltEdit.il again.\")")
;; load "~/Skill/wrAltEdit.il"

  ;; 060323 Note that I replaced my open command by nedit. Now cadence hangs when 
  ;; nedit is opened, so it is better to replace nedit by some open command 
  ;; which directly returns. Or start nedit in server mode and use nedit -server mode. 
  
  ;; _update_ 060323 Add the right path to this file on your system.
  hiSetBindKey( "Command Interpreter"	"Shift Alt<Key>l"	"sh( \"nedit /enter_path_here/wrAltEdit.il\")")

  hiSetBindKey( "Command Interpreter"	"Alt<Key>c"		"sh( \"nedit cds.lib\")")
  hiSetBindKey( "Command Interpreter"	"Alt<Key>t"		"sh( \"nedit CDS.log\")")

  hiSetBindKey( "Command Interpreter"	"Alt<Key>f"		"wrToggleLogFilter( )")
  hiSetBindKey( "Command Interpreter"	"Alt<Key>i"		"wrLibManagerToggle( )")
  hiSetBindKey( "Command Interpreter"	"Alt<Key>s"		"wrSaveOpenViews( )")
  hiSetBindKey( "Command Interpreter"	"Alt<Key>o"		"wrOpenLastViews( )")
  hiSetBindKey( "Command Interpreter"	"Alt<Key>q"		"wrSaveOpenViews( ) hiQuit()")

  hiSetBindKey( "Symbol" "<Key>F3"			"wrSave( )")
  hiSetBindKey( "Symbol" "Alt<Key>e"			"wrOpenOtherView( )")
  hiSetBindKey( "Symbol" "Alt<Key>o"			"wrSetOrigin( )")
  hiSetBindKey( "Symbol" "Alt<Key>w"			"wrWriteToggle( )")

  ;; Note that the Shift<key>9 binding does not use the Alt key
  hiSetBindKey( "Schematics" "Shift<Key>9"		"geDeleteAllProbe( )")
  hiSetBindKey( "Layout"	"Alt<Key>["		"hiZoomRelativeScale(getCurrentWindow( ) 0.5)")
  hiSetBindKey( "Layout"	"Alt<Key>]"		"hiZoomRelativeScale(getCurrentWindow( ) 2.0)")

  ;; Changed F1 to prevent hitting help button accidentally when Esc is wanted. F1 is now Ctrl-F1.
  ;; 050221 help is not working in reflextion.
  hiSetBindKey( "Layout" "Alt<Key>F1"			"wrDecodeBindKeysLayout( \"help\")")
  hiSetBindKey( "Layout" "Alt<Key>`"			"wrDecodeBindKeysLayout( \"help\")")
  hiSetBindKey( "Layout" "Alt<Key>/"			"wrDecodeBindKeysLayout( \"Alt-div\")")
  hiSetBindKey( "Layout" "<Key>F3"			"wrSave( )")

  hiSetBindKey( "Layout" "Alt<Key>comma"		"wrDecodeBindKeysLayout( \"Alt-,\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>comma"		"wrDecodeBindKeysLayout( \"Shift-Alt-,\")")
  hiSetBindKey( "Layout" "Alt<Key>."			"wrDecodeBindKeysLayout( \"Alt-.\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>."		"wrDecodeBindKeysLayout( \"Shift-Alt-.\")")
  hiSetBindKey( "Layout" "Alt<Key>;"			"wrDecodeBindKeysLayout( \"Alt-:\")")

  hiSetBindKey( "Layout" "<Btn4Down>"			"geScroll(nil \"n\" nil)")
  hiSetBindKey( "Layout" "<Btn5Down>"			"geScroll(nil \"s\" nil)")
  hiSetBindKey( "Layout" "Shift <Btn4Down>"		"geScroll(nil \"e\" nil)")
  hiSetBindKey( "Layout" "Shift <Btn5Down>"		"geScroll(nil \"w\" nil)")
  hiSetBindKey( "Layout" "Ctrl <Btn4Down>"		"wrLayoutZoomIn( 2)")
  hiSetBindKey( "Layout" "Ctrl <Btn5Down>"		"wrLayoutZoomIn( 0.5)")
  
  hiSetBindKey( "Layout" "Alt<Key>Delete"		"wrDecodeBindKeysLayout( \"Alt-delete\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Enter"		"wrDecodeBindKeysLayout( \"Alt-KP_Enter\")")
  hiSetBindKey( "Layout" "Alt<Key>Up"			"wrDecodeBindKeysLayout( \"Alt-up\")")
  hiSetBindKey( "Layout" "Alt<Key>Down"			"wrDecodeBindKeysLayout( \"Alt-down\")")
  hiSetBindKey( "Layout" "Alt<Key>Left"			"wrDecodeBindKeysLayout( \"Alt-left\")")
  hiSetBindKey( "Layout" "Alt<Key>Right"		"wrDecodeBindKeysLayout( \"Alt-right\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>Up"		"wrDecodeBindKeysLayout( \"Shift-Alt-up\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>Down"		"wrDecodeBindKeysLayout( \"Shift-Alt-down\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>Left"		"wrDecodeBindKeysLayout( \"Shift-Alt-left\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>Right" 		"wrDecodeBindKeysLayout( \"Shift-Alt-right\")")
  hiSetBindKey( "Layout" "Ctrl Alt<Key>Up"		"wrDecodeBindKeysLayout( \"Ctrl-Alt-up\")")
  hiSetBindKey( "Layout" "Ctrl Alt<Key>Down"		"wrDecodeBindKeysLayout( \"Ctrl-Alt-down\")")
  hiSetBindKey( "Layout" "Ctrl Alt<Key>Left"		"wrDecodeBindKeysLayout( \"Ctrl-Alt-left\")")
  hiSetBindKey( "Layout" "Ctrl Alt<Key>Right"		"wrDecodeBindKeysLayout( \"Ctrl-Alt-right\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Delete"		"wrDecodeBindKeysLayout( \"Alt-KP_.\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Insert"		"wrDecodeBindKeysLayout( \"Alt-KP_0\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_End"		"wrDecodeBindKeysLayout( \"Alt-KP_1\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Down"		"wrDecodeBindKeysLayout( \"Alt-KP_2\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Next"		"wrDecodeBindKeysLayout( \"Alt-KP_3\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Left"		"wrDecodeBindKeysLayout( \"Alt-KP_4\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Begin"		"wrDecodeBindKeysLayout( \"Alt-KP_5\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Right"		"wrDecodeBindKeysLayout( \"Alt-KP_6\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Home"		"wrDecodeBindKeysLayout( \"Alt-KP_7\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Up"		"wrDecodeBindKeysLayout( \"Alt-KP_8\")")
  hiSetBindKey( "Layout" "Alt<Key>KP_Prior"		"wrDecodeBindKeysLayout( \"Alt-KP_9\")")
  hiSetBindKey( "Layout" "Alt<Key>0"			"wrDecodeBindKeysLayout( \"Alt-0\")")
  hiSetBindKey( "Layout" "Alt<Key>1"			"wrDecodeBindKeysLayout( \"Alt-1\")")
  hiSetBindKey( "Layout" "Alt<Key>2"			"wrDecodeBindKeysLayout( \"Alt-2\")")
  hiSetBindKey( "Layout" "Alt<Key>3"			"wrDecodeBindKeysLayout( \"Alt-3\")")
  hiSetBindKey( "Layout" "Alt<Key>4"			"wrDecodeBindKeysLayout( \"Alt-4\")")
  hiSetBindKey( "Layout" "Alt<Key>5"			"wrDecodeBindKeysLayout( \"Alt-5\")")
  hiSetBindKey( "Layout" "Alt<Key>6"			"wrDecodeBindKeysLayout( \"Alt-6\")")
  hiSetBindKey( "Layout" "Alt<Key>7"			"wrDecodeBindKeysLayout( \"Alt-7\")")
  hiSetBindKey( "Layout" "Alt<Key>8"			"wrDecodeBindKeysLayout( \"Alt-8\")")
  hiSetBindKey( "Layout" "Alt<Key>9"			"wrDecodeBindKeysLayout( \"Alt-9\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>0"		"wrDecodeBindKeysLayout( \"Shift-Alt-0\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>1"		"wrDecodeBindKeysLayout( \"Shift-Alt-1\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>2"		"wrDecodeBindKeysLayout( \"Shift-Alt-2\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>3"		"wrDecodeBindKeysLayout( \"Shift-Alt-3\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>4"		"wrDecodeBindKeysLayout( \"Shift-Alt-4\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>5"		"wrDecodeBindKeysLayout( \"Shift-Alt-5\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>6"		"wrDecodeBindKeysLayout( \"Shift-Alt-6\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>9"		"wrDecodeBindKeysLayout( \"Shift-Alt-9\")")
  hiSetBindKey( "Layout" "Alt<Key>-"			"wrDecodeBindKeysLayout( \"Alt-_\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>a"		"wrDecodeBindKeysLayout( \"Alt-a\")")
  hiSetBindKey( "Layout" "Alt<Key>b"			"wrDecodeBindKeysLayout( \"Alt-b\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>b"		"wrDecodeBindKeysLayout( \"Shift-Alt-b\")")
  hiSetBindKey( "Layout" "Alt<Key>c"			"wrDecodeBindKeysLayout( \"Alt-c\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>c"		"wrDecodeBindKeysLayout( \"Shift-Alt-c\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>d"		"wrDecodeBindKeysLayout( \"Shift-Alt-d\")")
  hiSetBindKey( "Layout" "Alt<Key>d"			"wrDecodeBindKeysLayout( \"Alt-d\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>d"		"wrDecodeBindKeysLayout( \"Shift-Alt-d\")")
  hiSetBindKey( "Layout" "Alt<Key>e"			"wrDecodeBindKeysLayout( \"Alt-e\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>e"		"wrDecodeBindKeysLayout( \"Shift-Alt-e\")")
  hiSetBindKey( "Layout" "Alt<Key>f"			"wrDecodeBindKeysLayout( \"Alt-f\")")
  hiSetBindKey( "Layout" "Alt<Key>g"			"wrDecodeBindKeysLayout( \"Alt-g\")")
  hiSetBindKey( "Layout" "Alt<Key>h"			"wrDecodeBindKeysLayout( \"Alt-h\")")
  hiSetBindKey( "Layout" "Alt<Key>i"			"wrDecodeBindKeysLayout( \"Alt-i\")")
  hiSetBindKey( "Layout" "Alt<Key>j"			"wrDecodeBindKeysLayout( \"Alt-j\")")
  hiSetBindKey( "Layout" "Alt<Key>k"			"wrDecodeBindKeysLayout( \"Alt-k\")")
  hiSetBindKey( "Layout" "Alt<Key>l"			"wrDecodeBindKeysLayout( \"Alt-l\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>l"		"wrDecodeBindKeysLayout( \"Shift-Alt-l\")")
  hiSetBindKey( "Layout" "Alt<Key>m"			"wrDecodeBindKeysLayout( \"Alt-m\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>n"		"wrDecodeBindKeysLayout( \"Shift-Alt-n\")")
  hiSetBindKey( "Layout" "Alt<Key>n"			"wrDecodeBindKeysLayout( \"Alt-n\")")
  hiSetBindKey( "Layout" "Alt<Key>o"			"wrDecodeBindKeysLayout( \"Alt-o\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>p"		"wrDecodeBindKeysLayout( \"Shift-Alt-p\")")
  hiSetBindKey( "Layout" "Alt<Key>p"			"wrDecodeBindKeysLayout( \"Alt-p\")")
  hiSetBindKey( "Layout" "Alt<Key>q"			"wrDecodeBindKeysLayout( \"Alt-q\")")
  hiSetBindKey( "Layout" "Alt<Key>r"			"wrDecodeBindKeysLayout( \"Alt-r\")")
  hiSetBindKey( "Layout" "Alt<Key>s"			"wrDecodeBindKeysLayout( \"Alt-s\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>t"		"wrDecodeBindKeysLayout( \"Shift-Alt-t\")")
  hiSetBindKey( "Layout" "Alt<Key>t"			"wrDecodeBindKeysLayout( \"Alt-t\")")
  hiSetBindKey( "Layout" "Alt<Key>u"			"wrDecodeBindKeysLayout( \"Alt-u\")")
  hiSetBindKey( "Layout" "Alt<Key>v"			"wrDecodeBindKeysLayout( \"Alt-v\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>v"		"wrDecodeBindKeysLayout( \"Shift-Alt-v\")")
  hiSetBindKey( "Layout" "Alt<Key>w"			"wrDecodeBindKeysLayout( \"Alt-w\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>w"		"wrDecodeBindKeysLayout( \"Shift-Alt-w\")")
  hiSetBindKey( "Layout" "Alt<Key>x"			"wrDecodeBindKeysLayout( \"Alt-x\")")
  hiSetBindKey( "Layout" "Alt<Key>y"			"wrDecodeBindKeysLayout( \"Alt-y\")")
  hiSetBindKey( "Layout" "Shift Alt<Key>z"		"wrDecodeBindKeysLayout( \"Shift-Alt-z\")")
  hiSetBindKey( "Layout" "Alt<Btn3Down>" 		"geHiExplainMarker( )")

  hiSetBindKey( "Schematics" "Alt<Key>F1"		"wrDecodeBindKeysSchematics( \"help\")")
  hiSetBindKey( "Schematics" "Alt<Key>`"		"wrDecodeBindKeysSchematics( \"help\")")
  hiSetBindKey( "Schematics" "Alt<Key>/"		"wrDecodeBindKeysSchematics( \"Alt-div\")")
  hiSetBindKey( "Schematics" "<Key>F3"		"wrSave( )")

  hiSetBindKey( "Schematics" "Alt<Key>,"		"wrDecodeBindKeysSchematics( \"Alt-,\")")
  hiSetBindKey( "Schematics" "Alt<Key>."		"wrDecodeBindKeysSchematics( \"Alt-.\")")
  hiSetBindKey( "Schematics" "Alt<Key>;"		"wrDecodeBindKeysSchematics( \"Alt-:\")")

  hiSetBindKey( "Schematics" "Alt<Key>Delete"		"wrDecodeBindKeysSchematics( \"Alt-delete\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Enter"	"wrDecodeBindKeysSchematics( \"Alt-KP_Enter\")")
  hiSetBindKey( "Schematics" "Alt<Key>Up"		"wrDecodeBindKeysSchematics( \"Alt-up\")")
  hiSetBindKey( "Schematics" "Alt<Key>Down"		"wrDecodeBindKeysSchematics( \"Alt-down\")")
  hiSetBindKey( "Schematics" "Alt<Key>Left"		"wrDecodeBindKeysSchematics( \"Alt-left\")")
  hiSetBindKey( "Schematics" "Alt<Key>Right"		"wrDecodeBindKeysSchematics( \"Alt-right\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>Up"	"wrDecodeBindKeysSchematics( \"Shift-Alt-up\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>Down"	"wrDecodeBindKeysSchematics( \"Shift-Alt-down\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>Left"	"wrDecodeBindKeysSchematics( \"Shift-Alt-left\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>Right"	"wrDecodeBindKeysSchematics( \"Shift-Alt-right\")")
  hiSetBindKey( "Schematics" "Ctrl Alt<Key>Up"	"wrDecodeBindKeysSchematics( \"Ctrl-Alt-up\")")
  hiSetBindKey( "Schematics" "Ctrl Alt<Key>Down"	"wrDecodeBindKeysSchematics( \"Ctrl-Alt-down\")")
  hiSetBindKey( "Schematics" "Ctrl Alt<Key>Left"	"wrDecodeBindKeysSchematics( \"Ctrl-Alt-left\")")
  hiSetBindKey( "Schematics" "Ctrl Alt<Key>Right"	"wrDecodeBindKeysSchematics( \"Ctrl-Alt-right\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Delete"	"wrDecodeBindKeysSchematics( \"Alt-KP_.\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Insert"	"wrDecodeBindKeysSchematics( \"Alt-KP_0\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_End"		"wrDecodeBindKeysSchematics( \"Alt-KP_1\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Down"	"wrDecodeBindKeysSchematics( \"Alt-KP_2\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Next"	"wrDecodeBindKeysSchematics( \"Alt-KP_3\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Left"	"wrDecodeBindKeysSchematics( \"Alt-KP_4\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Begin"	"wrDecodeBindKeysSchematics( \"Alt-KP_5\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Right"	"wrDecodeBindKeysSchematics( \"Alt-KP_6\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Home"	"wrDecodeBindKeysSchematics( \"Alt-KP_7\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Up"		"wrDecodeBindKeysSchematics( \"Alt-KP_8\")")
  hiSetBindKey( "Schematics" "Alt<Key>KP_Prior"	"wrDecodeBindKeysSchematics( \"Alt-KP_9\")")
  hiSetBindKey( "Schematics" "Alt<Key>0"		"wrDecodeBindKeysSchematics( \"Alt-0\")")
  hiSetBindKey( "Schematics" "Alt<Key>1"		"wrDecodeBindKeysSchematics( \"Alt-1\")")
  hiSetBindKey( "Schematics" "Alt<Key>2"		"wrDecodeBindKeysSchematics( \"Alt-2\")")
  hiSetBindKey( "Schematics" "Alt<Key>3"		"wrDecodeBindKeysSchematics( \"Alt-3\")")
  hiSetBindKey( "Schematics" "Alt<Key>4"		"wrDecodeBindKeysSchematics( \"Alt-4\")")
  hiSetBindKey( "Schematics" "Alt<Key>5"		"wrDecodeBindKeysSchematics( \"Alt-5\")")
  hiSetBindKey( "Schematics" "Alt<Key>6"		"wrDecodeBindKeysSchematics( \"Alt-6\")")
  hiSetBindKey( "Schematics" "Alt<Key>7"		"wrDecodeBindKeysSchematics( \"Alt-7\")")
  hiSetBindKey( "Schematics" "Alt<Key>8"		"wrDecodeBindKeysSchematics( \"Alt-8\")")
  hiSetBindKey( "Schematics" "Alt<Key>9"		"wrDecodeBindKeysSchematics( \"Alt-9\")")
  hiSetBindKey( "Schematics" "Alt<Key>-"		"wrDecodeBindKeysSchematics( \"Alt-_\")")
  hiSetBindKey( "Schematics" "Alt<Key>="		"wrDecodeBindKeysSchematics( \"Alt-+\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>0"	"wrDecodeBindKeysSchematics( \"Shift-Alt-0\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>1"	"wrDecodeBindKeysSchematics( \"Shift-Alt-1\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>2"	"wrDecodeBindKeysSchematics( \"Shift-Alt-2\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>3"	"wrDecodeBindKeysSchematics( \"Shift-Alt-3\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>4"	"wrDecodeBindKeysSchematics( \"Shift-Alt-4\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>5"	"wrDecodeBindKeysSchematics( \"Shift-Alt-5\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>6"	"wrDecodeBindKeysSchematics( \"Shift-Alt-6\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>9"	"wrDecodeBindKeysSchematics( \"Shift-Alt-9\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>a"	"wrDecodeBindKeysSchematics( \"Alt-a\")")
  hiSetBindKey( "Schematics" "Alt<Key>b"		"wrDecodeBindKeysSchematics( \"Alt-b\")")
  hiSetBindKey( "Schematics" "Alt<Key>c"		"wrDecodeBindKeysSchematics( \"Alt-c\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>c"	"wrDecodeBindKeysSchematics( \"Shift-Alt-c\")")
  hiSetBindKey( "Schematics" "Alt<Key>d"		"wrDecodeBindKeysSchematics( \"Alt-d\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>d"	"wrDecodeBindKeysSchematics( \"Shift-Alt-d\")")
  hiSetBindKey( "Schematics" "Alt<Key>e"		"wrDecodeBindKeysSchematics( \"Alt-e\")")
  hiSetBindKey( "Schematics" "Alt<Key>f"		"wrDecodeBindKeysSchematics( \"Alt-f\")")
  hiSetBindKey( "Schematics" "Alt<Key>g"		"wrDecodeBindKeysSchematics( \"Alt-g\")")
  hiSetBindKey( "Schematics" "Alt<Key>h"		"wrDecodeBindKeysSchematics( \"Alt-h\")")
  hiSetBindKey( "Schematics" "Alt<Key>i"		"wrDecodeBindKeysSchematics( \"Alt-i\")")
  hiSetBindKey( "Schematics" "Alt<Key>j"		"wrDecodeBindKeysSchematics( \"Alt-j\")")
  hiSetBindKey( "Schematics" "Alt<Key>k"		"wrDecodeBindKeysSchematics( \"Alt-k\")")
  hiSetBindKey( "Schematics" "Alt<Key>l"		"wrDecodeBindKeysSchematics( \"Alt-l\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>l"	"wrDecodeBindKeysSchematics( \"Shift-Alt-l\")")
  hiSetBindKey( "Schematics" "Alt<Key>m"		"wrDecodeBindKeysSchematics( \"Alt-m\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>m"	"wrDecodeBindKeysSchematics( \"Shift-Alt-m\")")
  hiSetBindKey( "Schematics" "Alt<Key>n"		"wrDecodeBindKeysSchematics( \"Alt-n\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>n"	"wrDecodeBindKeysSchematics( \"Shift-Alt-n\")")
  hiSetBindKey( "Schematics" "Alt<Key>o"		"wrDecodeBindKeysSchematics( \"Alt-o\")")
  hiSetBindKey( "Schematics" "Alt<Key>p"		"wrDecodeBindKeysSchematics( \"Alt-p\")")
  hiSetBindKey( "Schematics" "Alt<Key>q"		"wrDecodeBindKeysSchematics( \"Alt-q\")")
  hiSetBindKey( "Schematics" "Alt<Key>r"		"wrDecodeBindKeysSchematics( \"Alt-r\")")
  hiSetBindKey( "Schematics" "Alt<Key>s"		"wrDecodeBindKeysSchematics( \"Alt-s\")")
  hiSetBindKey( "Schematics" "Alt<Key>t"		"wrDecodeBindKeysSchematics( \"Alt-t\")")
  hiSetBindKey( "Schematics" "Alt<Key>u"		"wrDecodeBindKeysSchematics( \"Alt-u\")")
  hiSetBindKey( "Schematics" "Alt<Key>v"		"wrDecodeBindKeysSchematics( \"Alt-v\")")
  hiSetBindKey( "Schematics" "Alt<Key>w"		"wrDecodeBindKeysSchematics( \"Alt-w\")")
  hiSetBindKey( "Schematics" "Alt<Key>x"		"wrDecodeBindKeysSchematics( \"Alt-x\")")
  hiSetBindKey( "Schematics" "Alt<Key>y"		"wrDecodeBindKeysSchematics( \"Alt-y\")")
  hiSetBindKey( "Schematics" "Shift Alt<Key>z"		"wrDecodeBindKeysSchematics( \"Alt-z\")")
;; doesn't work:
  ; hiSetBindKey( "Schematics" "Alt<Key>Backspace"		"printf( \"Alt-backspace\")")
  hiSetBindKey( "Schematics" "<Key>u"			"hiUndo( ) hiRedraw( )")

;; *WARNING* drDefinePacket( ) can only be used in a display resource file.
;; Use drGetPacket to get drf layer info.
;; drGetPacket("display" "MKRrp")


;; 060323 _update_ Add the important layers for your technology in a wrLoadDrf_tech function.


procedure( wrLoadDrf_089( )
  
  drLoadDrf( strcat( wrAltEditPath "/wr.drf"))
  
  drSetPacket( "display" wrNw "wrDots5a" "solid" "gray" "gray" "outlineStipple")
  drSetPacket( "display" wrNp "wrDots5a" "solid" "orange" "orange" "outlineStipple")
  drSetPacket( "display" wrPp "wrDots5b" "solid" "lime" "lime" "outlineStipple")
  drSetPacket( "display" wrOd "wrDots5a" "solid" "gold" "gold" "outlineStipple")
  drSetPacket( "display" wrOd_2 "dots_rareb" "mLine" "gold" "red" "outlineStipple")
  drSetPacket( "display" wrOd_3 "dots_rareb" "mLine" "gold" "red" "outlineStipple")
  drSetPacket( "display" wrPo  "fineCross" "solid" "maroon" "red" "outlineStipple")
  drSetPacket( "display" wrM1 "wrStripe6a" "solid" "blue" "blue" "outlineStipple") 
  drSetPacket( "display" wrM2 "wrStripe6d" "solid" "magenta" "magenta" "outlineStipple")
  drSetPacket( "display" wrM3 "wrStripe6b" "solid" "green" "green" "outlineStipple")
  drSetPacket( "display" wrM4 "wrStripe6e" "solid" "pink" "pink" "outlineStipple")
  drSetPacket( "display" wrM5 "wrStripe6c" "solid" "gold" "gold" "outlineStipple")
  drSetPacket( "display" wrM6 "wrStripe6f" "solid" "silver" "silver" "outlineStipple")
  drSetPacket( "display" strcat( wrPo "pin") "blank" "solid" "maroon" "red")
  drSetPacket( "display" strcat( wrM1 "pin") "X" "solid" "cadetBlue" "cadetBlue" "X") 
  drSetPacket( "display" strcat( wrM2 "pin") "X" "thickLine" "purple" "purple" "X")
  drSetPacket( "display" strcat( wrM3 "pin") "X" "thickLine" "lime" "lime" "X")
  drSetPacket( "display" strcat( wrM4 "pin") "X" "thickLine" "tan" "tan" "X")
  drSetPacket( "display" strcat( wrM5 "pin") "X" "thickLine" "yellow" "yellow" "X")
  drSetPacket( "display" strcat( wrM6 "pin") "X" "thickLine" "cream" "cream" "X")
  drSetPacket( "display" "substrate" "wrDots5a" "solid" "cream" "cream" "outlineStipple")

  drSetPacket( "display" strcat( wrOd "tile") "wrTile" "dashed" "gold" "gold" "outlineStipple")
  drSetPacket( "display" strcat( wrPo "tile") "wrTile" "dashed" "maroon" "red" "outlineStipple")
  drSetPacket( "display" strcat( wrM1 "tile") "wrTile" "dashed" "blue"    "blue"    "outlineStipple")
  drSetPacket( "display" strcat( wrM2 "tile") "wrTile" "dashed" "magenta" "magenta" "outlineStipple")
  drSetPacket( "display" strcat( wrM3 "tile") "wrTile" "dashed" "green"   "green"   "outlineStipple")
  drSetPacket( "display" strcat( wrM4 "tile") "wrTile" "dashed" "pink"    "pink"    "outlineStipple")
  drSetPacket( "display" strcat( wrM5 "tile") "wrTile" "dashed" "gold"    "gold"    "outlineStipple")
  drSetPacket( "display" strcat( wrM6 "tile") "wrTile" "dashed" "silver"  "silver"  "outlineStipple")

  drSetPacket( "display" strcat( wrOd "tileNot") "wrTileOff" "dashed" "gold" "gold" "outlineStipple")
  drSetPacket( "display" strcat( wrPo "tileNot") "wrTileOff" "dashed" "maroon" "red" "outlineStipple")
  drSetPacket( "display" strcat( wrM1 "tileNot") "wrTileOff" "dashed" "blue"    "blue"    "outlineStipple")
  drSetPacket( "display" strcat( wrM2 "tileNot") "wrTileOff" "dashed" "magenta" "magenta" "outlineStipple")
  drSetPacket( "display" strcat( wrM3 "tileNot") "wrTileOff" "dashed" "green"   "green"   "outlineStipple")
  drSetPacket( "display" strcat( wrM4 "tileNot") "wrTileOff" "dashed" "pink"    "pink"    "outlineStipple")
  drSetPacket( "display" strcat( wrM5 "tileNot") "wrTileOff" "dashed" "gold"    "gold"    "outlineStipple")
  drSetPacket( "display" strcat( wrM6 "tileNot") "wrTileOff" "dashed" "silver"  "silver"  "outlineStipple")
  hiRedraw( )
)



procedure( wrTest( @optional type)

  ;; 060616 I use this function to do adhoc changes to perform one time manipulations 
  ;; like solving DRC errors in several modules after a DRC update. 
  instancepointer = car( geGetSelectedSet( ))
;;  dbReplaceProp( instancepointer "area" "string" "1000.15")
;;  dbReplaceProp( instancepointer "peri" "string" "131.2")
)

if( isFile( "wrAltEditLocal.il" )
then
   printf( "Loading wrAltEditLocal.il .\n")
   load( "wrAltEditLocal.il" )
)

;=============================================================================== 
; File Name : CCSsuppressDispForm.il 
; Date Created : 02-07-2006 
; Group : Custom IC, Cadence Design Systems Inc. 
; Language : SKILL 
; 
; Last Modified : 04-13-2006 
; Revision No. : 1 
; 
; Description : This code will suppress the save display information 
; that pops up when user is about to exit after making 
; changes to the packet definition using drSetPacket in .cdsinit. 
; 
; How to Run : In CIW load the file CCSsuppressDispForm.il run - 
; CCSsuppressDispForm() 
; Tested in : IC5141 
; SKILL Lint Score IC5141 (Max=100) : 100 
; SKILL Audit IC5141: Passed, no private functions were found. 

procedure( CCSsuppressDispForm( )

  hiRegTimer("hiFormCancel(techSaveDrmForm)" 10) 
)

regExitBefore('CCSsuppressDispForm)

/*

Copyright (C) 2007 W. Relyveld

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
or brouwse http://www.gnu.org/copyleft/gpl.html

*/
