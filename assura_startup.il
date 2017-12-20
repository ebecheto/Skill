/*******************************************************************************

*  DISCLAIMER: The following code is provided for Cadence customers to use at  *

*   their own risk. The code may require modification to satisfy the           *

*   requirements of any user. The code and any modifications to the code may   *

*   not be compatible with current or future versions of Cadence products.     *

*   THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING WITHOUT     *

*   LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES OF MERCHANTABILITY *

*   OR FITNESS FOR A PARTICULAR USE.                                           *

*******************************************************************************/

 

;;-------------------------From Here---------------------------

 

 

 

procedure( vuiUserDefinedSetupCB(form)

 

       let( ( runDir  cellName (runExt "Run") )

 

 

                ; set runDir for DRC job

                when( form->hiFormSym == 'vuiDRCForm

 

                        ;get the name of the current cell

                        cellName =geGetEditCellView()~>cellName

 

                        runDir = strcat("./ASSURA/" getShellEnvVar("USER") "/DRC")

system(sprintf(nil "mkdir -p %s" runDir))

 

                        form->runDir->value = runDir

 

                ); when form is the drc form

 

 

 

 

                ; set runDir for LVS job

                when( form->hiFormSym == 'vuiLVSForm

 

                        ;get the name of the current cell

                        cellName =geGetEditCellView()~>cellName

 

                        runDir = strcat("./ASSURA/" getShellEnvVar("USER") "/LVS")

system(sprintf(nil "mkdir -p %s" runDir))

 

                        form->runDir->value = runDir

                        form->runDir->editable = t

                ); when form is the lvs form

 

 

       t ; a true return value is necessary

 

   ); let

 

); procedure

;====================

 

You can load this file through the .cdsinit file; then re-invoke the tool OR you

can load the code (e.g.  load "~/assuraFormSetup.il") before opening the Assura

DRC/LVS form.
