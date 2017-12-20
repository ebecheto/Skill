;; https://community.cadence.com/cadence_technology_forums/f/38/p/33480/1342368#1342368

/* abExportCSVafterSim.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Jun 10, 2015 
Modified   
By         

Call abInitExportCSV() - this will automatically export 
a CSV file to the documents directory after simulations are
finished. 

***************************************************

SCCS Info: @(#) abExportCSVafterSim.il 06/10/15.10:41:38 1.1

*/

/***************************************************************
*                                                              *
*           abExportCSVrunFinished(sess _runId hist)           *
*                                                              *
*    The trigger that gets called on runFinished (actually     *
*     chose runFinishedPrePlot, but it's not too critical)     *
*                                                              *
***************************************************************/
procedure(abExportCSVrunFinished(sess _runId hist)
    let((sdb documentsDir histName CSVfile)
        sdb=axlGetMainSetupDB(sess)
        documentsDir=strcat(axlGetSetupDBDir(sdb) "/documents")
        histName=axlGetHistoryName(hist)
        CSVfile=strcat(documentsDir "/" histName ".csv")
        axlExportOutputView(sess 
            strcat(documentsDir "/" histName ".csv") 
            "Detail-Transpose" 
            ?history histName
        )
        printf("INFO: Exported CSV file to %s\n" CSVfile)
    )
)

/***************************************************************
*                                                              *
*            abRegExportCSVrunFinishedTrigger(sess)            *
*                                                              *
*           Add the trigger into the current session           *
*                                                              *
***************************************************************/
procedure(abRegExportCSVrunFinishedTrigger(sess)
    axlSessionConnect(sess "runFinishedPrePlot" 'abExportCSVrunFinished)
)

/****************************************************************
*                                                               *
*                       abInitExportCSV()                       *
*                                                               *
* Ensure that the trigger gets added whenever ADE XL is opened. *
*                                                               *
****************************************************************/
procedure(abInitExportCSV()
    axlSessionRegisterCreationCallback('abRegExportCSVrunFinishedTrigger)
)