procedure( PrintMessages(msginfo msgtype)
    foreach(msg cnGetMsgs( msginfo )
    when( cnGetMsgType( msg ) == msgtype
        printf( "%s\n", cnGetMsgString( msg ) )
        )
    )
)

procedure( DistanceSquared(point1, point2)
    let( (dx dy)
        dx = cnGetPointX( point1 ) - cnGetPointX( point2 )
        dy = cnGetPointY( point1 ) - cnGetPointY( point2 )
        dx * dx + dy * dy ; return value
    )
)

procedure( NearestComp(importHandle, xy)
    let( (command res opts msginfo group)
    command = strcat("SELECT BODIES ", cnCreateMousePressString(xy,3), ";")
    opts = cnSetRunOptions(?display cnOUT_SILENT, ?result cnOUT_VERBOSE)
    res = cnSendCommand(importHandle, command, ?runOptions opts)
    msginfo = cnGetMsgInfo(res)
    if( msginfo && cnGetMsgCount(msginfo, cnMSG_ERROR) > 0 then
        PrintMessages(msginfo, cnMSG_ERROR)
        nil ; return value
    else    ; no errors, so proceed
        ;; recycle group
        group = cnGetGroupName(res)
        command = strcat("EXCLUDE ", group, " ", group, ";")
        cnSendCommand(importHandle, command)         

        ;; return comp
        car(cnGetComps(cnGetGroupedObjectSet(res)))
         
    ); else
    ); let
); proc

procedure( NearestPin(importHandle, compPins, xy)
    let( (nearest nearestDist dist)
    ;; determine nearest pin
    nearest = nil
    nearestDist = 0x7FFFFFFF ; 32-bit MAXINT
    foreach(compPin compPins
        dist = DistanceSquared(cnGetCompPinXY(compPin), xy)
        when( dist < nearestDist
        nearest = compPin
        nearestDist = dist
        )
    )

    nearest ; return
    ); let
); proc

procedure( NearestCompPin(importHandle, xy)
    let( (comp compPins compPin)
    comp = NearestComp( importHandle, xy )
       
    when( comp
        compPins = cnCreateCompPins( comp,
                    cnGetCompSymInfo( importHandle, comp ) )
        compPin = NearestPin( importHandle, compPins, xy )
        when( compPin
            list( comp, compPin ) ; return
        )
    )
    )
)
procedure (addprogpart(event obj)

        progval = cnGetStringText(event)
        ;cnRequestUserInput(importHandle,nil, nil, "Enter the value of the programmable part number\n",cnTEXTINPUT_EVENT)
        tpl_list = ncons(cnCreatePropTemplate(
                         ?name "PROG_PART"
                         ?value progval
                         ?color "YELLOW"
                         ?attachXY cnGetCompOriginXY(comp)
                         ?XY cnGetCompOriginXY(comp)
                         ?visibility 1
                         ?justification 0
                         ?size 50
                         ?angle 0
                        ))

         cnCreateProps( importHandle, tpl_list)
)

procedure( PrintPickedPin(EvObject HandleSymbol)
    let( (res comp compPin)
        res = NearestCompPin( symeval( HandleSymbol ),
                  cnGetMouseXY( EvObject ) )
    when( res
        value=sprintf( nil,"echo Component selected to add progpart is %s\n ",
                cnGetCompName( car( res ) ) )
          cnSendCommand( importHandle,value )
          comp=car(res)
          cnRequestString(importHandle,'addprogpart, nil, "Enter the value of the programmable part number\n")
          cnSendCommand( importHandle,"echo value added" )
        )
    )
)

procedure( addprog()

      cnRequestMousePress( importHandle, 'PrintPickedPin, 'importHandle, "Pick a Component to add prog part" )
)

procedure(
csWaitForCnHandle(sleepHandle, exitHandler)
   let(((sleeptime 2), (sleptfor 0), handle, filename, fp)
       while((not(cnmpsIsExported()) && (sleptfor < 20))
           mpsSleep( sleepHandle, sleeptime )
           sleptfor = sleptfor + sleeptime
       ); while
       if(not(cnmpsIsExported()) then
           filename = strcat(sleepHandle->serviceName,".errlog")
           fp = outfile(filename, "w")
           fprintf(fp, "\nLogfile:   %s\n", filename)
           fprintf(fp, "\nService: %s\n", sleepHandle->serviceName)
           fprintf(fp, "Error:   Unable to Obtain a Concept Handle\n")
           close(fp)
           exit(1)
           nil
       else
           handle = cnmpsImport()
           handle->exitHandler = exitHandler
           handle
       );if
   );let
);procedure

; This is the event handler. The event is defined
; and then used as an argument in the main logic.

procedure( addprogCallback( event, usrArg )
   let( ( evType )

      unless( importHandle
         importHandle = csWaitForCnHandle( importHandle, 'ConceptExitHandler )
         importHandle->timeout = 1200  
      )

      evType = cnGetEventType( event )

      cond(
            ( ( evType == cnSTART_EVENT )
                addprog()
            )
            ( t
                printf( "Error 1000: Event (%d) is unrecognized\n", evType )
            )
)))


; This return value of procedure addprog was captured as "event". Now it is
; passed to the main logic as an argument. The argument is parsed by cnGetStringText
; and the parsed string value is passed to the variable loc.

procedure( ConceptExitHandler( handle )
   mpsClose( exportHandle )
   exit( 0 )
)

procedure( cnCommands_addprogServer()
   list(
      list( "addprog",
         list(
            list( cnSTART_EVENT
            ),
            'addprogCallback
         )
      )
   )
);procedure


importHandle = nil
exportHandle = mpsExport( "addprogServer", "addprogServer", "1.0",
                          '( cnCommands_addprogServer, addprogCallback )
                          ?session cnmpsGetDefaultSessionName() )

unless( getShellEnvVar( "ComSpec" )
   mpsSleep( exportHandle, 5 )
);unless