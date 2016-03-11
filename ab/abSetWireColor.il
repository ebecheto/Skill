/* abSetWireColor.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       May 13, 2015 
Modified   
By         

Two functions which should work in releases prior to IC616
to get and set the wire color on wires in the schematic.

abSetWireColor(wireObject "red")
abGetWireColor(wireObject) => "red"

You also need to call hiRedraw() to redraw the window so that
the changes can be seen.

Note, this relies on the internal structure of how the wire
color data is stored; however, the functions are written such
that they will use schGetWireColor and schSetWireColor if they are
available, so the code should be future-proof.

The code only tries to set solid linestyles - so it assumes that
you have solid linestyle defined in your display.drf. I did not
try to make the code provide a schSetWireLineStyle equivalent
in the interests of simplicity.

***************************************************

SCCS Info: @(#) abSetWireColor.il 05/13/15.15:31:33 1.1

*/

/***************************************************************
*                                                              *
*                   abGetWireColor(wire "d")                   *
*                                                              *
*             Return the color of a piece of wire              *
*                                                              *
***************************************************************/

procedure(abGetWireColor(wire "d")
    if(isCallable('schGetWireColor) then
        schGetWireColor(wire)
    else
        let((colorGroup parsed tf packet)
            ;------------------------------------------------------------
            ; Find a color group with the right name which is
            ; associated with the wire, and is also a member of
            ; the root group for color information
            ;------------------------------------------------------------
            colorGroup=car(exists(group wire~>groupMembers~>group
                rexMatchp("^sch_" group~>name) &&
                exists(mainGroup group~>groupMembers~>group
                    mainGroup~>name=="schDisplayPacketsGroup"
                )
            ))
            if(colorGroup then
                parsed=parseString(colorGroup~>name "_")
                cadr(parsed)
            ;------------------------------------------------------------
            ; Default is to get the color from the wire drawing LPP packet
            ;------------------------------------------------------------
            else
                tf=techGetTechFile(wire~>cellView)
                packet=techGetLPPacketName(techGetLP(tf list("wire" "drawing")))
                nth(5 drGetPacket("display" packet))
            )
        )
    )
)

/***************************************************************
*                                                              *
*                abGetExistingColorGroup(wire)                 *
*                                                              *
*  Utility function to get the group associated with the wire  *
*          which is related to the color information           *
*                                                              *
***************************************************************/

procedure(abGetExistingColorGroup(wire)
    car(exists(group wire~>groupMembers~>group
        rexMatchp("^sch_" group~>name) &&
        exists(mainGroup group~>groupMembers~>group
            mainGroup~>name=="schDisplayPacketsGroup"
        )
    ))
)

/***************************************************************
*                                                              *
*               abSetWireColor(wire color "dt")                *
*                                                              *
*                   Set the color on a wire.                   *
*                                                              *
***************************************************************/

procedure(abSetWireColor(wire color "dt")
    if(isCallable('schSetWireColor) then
        schSetWireColor(wire color)
    else
        if(drGetColor("display" color) then
            let((groupName currentGroup currentColor (add t) cv
                    mainGroup)
                ;--------------------------------------------------------
                ; If the wire already has color information, either
                ; delete the object from the current color group,
                ; or leave it as is (add=nil)
                ;--------------------------------------------------------
                currentGroup=abGetExistingColorGroup(wire)
                when(currentGroup
                    currentColor=cadr(parseString(currentGroup~>name))
                    if(currentColor==color then
                        add=nil
                    else
                        dbDeleteObjectFromGroup(wire currentGroup)
                    )
                )
                when(add
                    cv=wire~>cellView
                    ;----------------------------------------------------
                    ; Either find the existing group for the color
                    ; requested, or create it
                    ;----------------------------------------------------
                    sprintf(groupName "sch_%s_solid_solid" color)
                    currentGroup=car(
                        exists(group cv~>groups group~>name==groupName))
                    unless(currentGroup
                        currentGroup=dbCreateGroup(cv groupName 
                            list("deleteLast" "collection" "unordered" 
                                "uniqueName")
                        )
                    )
                    ;----------------------------------------------------
                    ; Add the wire to the color group
                    ;----------------------------------------------------
                    dbAddObjectToGroup(currentGroup wire)
                    ;----------------------------------------------------
                    ; Now see if the root group exists, and if not create
                    ; it
                    ;----------------------------------------------------
                    unless(exists(group currentGroup~>groupMembers~>group
                        group~>name=="schDisplayPacketsGroup")
                        mainGroup=car(
                            exists(group cv~>groups 
                                group~>name=="schDisplayPacketsGroup"))
                        unless(mainGroup
                            mainGroup=dbCreateGroup(cv "schDisplayPacketsGroup"
                                list("deleteLast" "collection" "unordered" 
                                    "uniqueName")
                            )
                        )
                        ;------------------------------------------------
                        ; Add the color group to the root group
                        ;------------------------------------------------
                        dbAddObjectToGroup(mainGroup currentGroup)
                    )
                    t
                )
            )
        else
            warn("Color %L for display \"display\" was not found" color)
        )
    )
)
