/*

Group           Custom IC, Cadence Design Systems
Language        SKILL
Revision No.    1.0
Date Created    27th Aug 2009
Last Modified   27th Aug 2009
Tested in       IC6.1.3.500.13
Lint score      100

Description: This program will replace a cell for all schematics/layouts
  in a library

***************************************************

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

Save this program as "migrate.il" in your working directory
Then key in the following in the CIW input panel :
load("migrate.il")
*/

procedure( CCSupdate()
   prog( (newTechLib targetLib oldCellName newCellName oldParameter1
     newParameter1 oldParameter2 newParameter2 view updateForm)
   newTechLib = hiCreateStringField(
    ?name  'newTechLib
    ?prompt  "Name of new technology library"
    ?callback ""
    ?editable t
   )
 
   targetLib = hiCreateStringField(
    ?name  'targetLib
    ?prompt  "Name of target library"
    ?callback ""
    ?editable t
   )

   oldCellName = hiCreateStringField(
    ?name  'oldCellName
    ?prompt  "Cell name to change(e.g. pmos)"
    ?callback ""
    ?editable t
   )

   newCellName = hiCreateStringField(
    ?name  'newCellName
    ?prompt  "New Cell name(e.g. pmos4)"
    ?callback ""
    ?editable t
   )
 
   oldParameter1 = hiCreateStringField(
    ?name  'oldParameter1
    ?prompt  "Old parameter name 1(e.g. w)"
    ?callback ""
    ?editable t
   )

   newParameter1 = hiCreateStringField(
    ?name  'newParameter1
    ?prompt  "Corresponding new parameter name 1(e.g. wn)"
    ?callback ""
    ?editable t
   )

   oldParameter2 = hiCreateStringField(
    ?name  'oldParameter2
    ?prompt  "Old parameter name 2(e.g. l)"
    ?callback ""
    ?editable t
   )

   newParameter2 = hiCreateStringField(
    ?name  'newParameter2
    ?prompt  "Corresponding new parameter name 2(e.g. ln)"
    ?callback ""
    ?editable t
   )

   view = hiCreateRadioField(
    ?name  `view
    ?prompt  "Choose view"
    ?choices list("schematic" "layout")
   )

   hiCreateAppForm(
    ?name  'updateForm
    ?formTitle "Library migration helper"
    ?callback "CCSmigrate(hiGetCurrentForm())"
    ?fields  list(newTechLib targetLib oldCellName newCellName
      oldParameter1 newParameter1 oldParameter2
      newParameter2 view)
    ?help  ""
    ?unmapAfterCB nil
   )
 
   hiDisplayForm( updateForm )
   ) ;prog
) ;procedure


procedure(CCSmigrate(theForm)
  prog((cv newTlib viewName libName oldCell newCell libId
    oldPara1 oldPara2 newPara1 newPara2 cellList temp1 temp2)

    newTlib = theForm->newTechLib->value
    viewName = theForm->view->value
    libName = theForm->targetLib->value
    oldCell = theForm->oldCellName->value
    newCell = theForm->newCellName->value
    oldPara1 = theForm->oldParameter1->value
    oldPara2 = theForm->oldParameter2->value
    newPara1 = theForm->newParameter1->value
    newPara2 = theForm->newParameter2->value

    libId = ddGetObj(libName)
    cellList = libId~>cells
    foreach(cell cellList 
      foreach(view cell~>views
        if(view~>name == viewName && (cv=dbOpenCellViewByType(libName  
          cell->name view~>name "" "a")) then
          printf("\nOpened view %L from cell %L of library %L for update.\n"
            cv~>viewName cv~>cellName
            cv~>libName)
          foreach( instId cv~>instances
            if( instId~>cellName == oldCell then
              foreach(param1 cdfGetInstCDF(instId)~>parameters
                if(param1~>name == oldPara1 
                  temp1 = param1~>value
                ) ;if
              ) ;foreach
              foreach(param2 cdfGetInstCDF(instId)~>parameters
                if(param2~>name == oldPara2
                  temp2 = param2~>value
                ) ;if
              ) ;foreach
        
              leReplaceAnyInstMaster(instId newTlib newCell nil)
        
              foreach(param3 cdfGetInstCDF(instId)~>parameters
                if(param3~>name == newPara1
                  param3~>value = temp1
                ) ;if  
              ) ;foreach
              foreach(param4 cdfGetInstCDF(instId)~>parameters
                if(param4~>name == newPara2
                  param4~>value = temp2
                ) ;if
              ) ;foreach
            );if
          ) ;foreach
          dbCheck(cv)
          dbSave(cv)
          dbClose(cv)
        ) ;if
      ) ;foreach
    );foreach
    ddReleaseObj(libId)
  );prog
  printf("\nJob Done...\n")
);procedure

CCSupdate()
