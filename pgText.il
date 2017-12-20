/*
load("~/Skill/pgText.il")
Program Name    : pgText.il 
Author          : Matt MacConnel [Cadence, Orlando ]
Date            : 12/16/91
Revision        : 1.0
SW Release      : 4.2.1
Prerequisites   : None
Synopsis        : pgText() => nil
Users Guide     : None
Description     : 

pgText is a program to create text that can be used for pattern
generation. This is accomplished by drawing each character as
a polygon.  The program will prompt for a text string. The
text string can contain any charater that is defined by
symbol as described below and spaces. The program will then draw
the polygons on the user specified layer. Presently, the text patterns
are generated on the 'drawing' purpose only.

The output is always generated as UPPERCASE letters eventhough both 
lower and upper case characters can be specified in the input.
The following character set is supported:
ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:;"',./\[]()!$%*=+_-?

*/


procedure(pgText()
    let((snapMode snapeShape text_string magAmount mtextString mSpaceBetween userGrid)
    userGrid = leDisplayOptionsForm->xSnap->value
    printf("Character input is case insensitive but output will be UPPER CASE\n")
    printf("Any Integer May Be Used With The Following Grids: (x/y Snap)\n")
    printf("Multiples of 20 - Use Grid (x/y Snap of 1.0)\n")
    printf("Multiples of 10 - Use Grid (x/y Snap of 0.5)\n")
    printf("Multiples of  5 - Use Grid (x/y Snap of 0.25)\n")
    printf("Even Multiples Other Than Above - Use a Grid (x/y Snap) of 0.1\n")
    printf("Odd Multiples Other Than Above - Use a Grid (x/y Snap) of 0.05\n")
    printf("Other Grids May Result In Line Mismatch\n")


    pgTextForm()

   )
)

procedure( pgTextForm()
    (text_string = (hiCreateStringField ?name
        'text_string ?prompt "Enter Text"
        ?value "Hello" ?defValue "" ?callback
        "" ?editable t
    ))

    (magAmount = (hiCreateStringField ?name
        'magAmount ?prompt "Enter Mag"
        ?value "1" ?defValue "" ?callback
        "" ?editable t
    ))

    (layerField = hiCreateLayerCyclicField(
                techGetTechFile(geGetEditCellView())
        "Layer for Polygon Text"
            ""
                nil
                (if boundp('pgMLayer) list(pgMLayer "drawing") leGetEntryLayer() )
        ))


    (formId = (hiCreateForm
        'pgTextForm "Programmable Text Generator" "pgTextCB()"
        list(text_string magAmount layerField)
        ""
    ))

    hiDisplayForm(formId)
   )

procedure(pgTextCB()
    (text_string = stringToLower( ((pgTextForm->text_string)->value)) )
    pgMLayer = hiLayerStringToLPP(
techGetTechFile(geGetEditCellView())
               cadddr(pgTextForm-> hiLayerField->value))~>name
    printf("pgMLayer set to ")
        println(pgMLayer)
    (magAmount = float(evalstring(((pgTextForm->magAmount)->value))))
    (dspace = 2)
    (sspace = 5.000000)
    (pntr = 0)
    (mtextString = parseString(text_string "" ))
    (characterWidth = "norm")
    foreach( character mtextString
        case( characterWidth
        ("norm"
            (pntr = (pntr + (magAmount * dspace))))
        ("wide"
            (pntr = (pntr + (magAmount * dspace * 1.200000))))
        ("narrow"
            (pntr = (pntr + (magAmount * dspace * 0.600000))))
        )
        case( character
        ("m"
            (characterWidth = "wide"))
        ("w"
            (characterWidth = "wide"))
        (("i" "'" ":" ";" "(" ")" "!" "." "[" "]" "1" "\"")
            (characterWidth = "narrow"))
        (t
            (characterWidth = "norm"))
        )
        ;printf("drawing character %s\n" character)
        case( character
        (" "
           ; println("added space character")
        )
        ("a"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listAMS1 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listAMS2 pntr magAmount)
            ))
        ("b"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listBMS1 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listBMS2 pntr magAmount)
            ))
        ("c"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listCMS pntr magAmount)
            ))
        ("d"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listDMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listDMS1 pntr magAmount)
            ))
        ("e"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listEMS pntr magAmount)
            ))
        ("f"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listFMS pntr magAmount)
            ))
        ("g"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listGMS pntr magAmount)
            ))
        ("h"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listHMS pntr magAmount)
            ))
        ("i"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listIMS pntr magAmount)
            ))
        ("j"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listJMS pntr magAmount)
            ))
        ("k"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listKMS pntr magAmount)
            ))
        ("l"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listLMS pntr magAmount)
            ))
        ("m"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMMS pntr magAmount)
            ))
        ("n"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listNMS pntr magAmount)
            ))
        ("o"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listOMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listOMS1 pntr magAmount)
            ))
        ("p"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listPMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listPMS1 pntr magAmount)
            ))
        ("q"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listQMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listQMS1 pntr magAmount)
            ))
        ("r"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listRMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listRMS1 pntr magAmount)
            ))
        ("s"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listSMS pntr magAmount)
            ))
        ("t"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listTMS pntr magAmount)
            ))
        ("u"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listUMS pntr magAmount)
            ))
        ("v"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listVMS pntr magAmount)
            ))
        ("w"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listWMS pntr magAmount)
            ))
        ("x"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listXMS pntr magAmount)
            ))
        ("y"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listYMS pntr magAmount)
            ))
        ("z"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listZMS pntr magAmount)
            ))
        ("0"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS0 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS01 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS02 pntr magAmount)
            ))
        ("1"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS1 pntr magAmount)
            ))
        ("2"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS2 pntr magAmount)
            ))
        ("3"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS3 pntr magAmount)
            ))
        ("4"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS4 pntr magAmount)
            ))
        ("5"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS5 pntr magAmount)
            ))
        ("6"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS6 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS61 pntr magAmount)
            ))
        ("7"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS7 pntr magAmount)
            ))
        ("8"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS8 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS81 pntr magAmount)
            ))
        ("9"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS9 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listMS91 pntr magAmount)
            ))
        ("."
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listPERMS pntr magAmount)
            ))
        (","
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listCOMMS pntr magAmount)
            ))
        ("-"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listDASMS pntr magAmount)
            ))
        ("/"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listSLMS pntr magAmount)
            ))
        ("!"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listEXMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listEXMS1 pntr magAmount)
            ))
        ("?"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listQMMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listQMMS1 pntr magAmount)
            ))
        (":"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listCOLMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listCOLMS1 pntr magAmount)
            ))
        (";"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listSCMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listSCMS1 pntr magAmount)
            ))
        ("_"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listUSMS pntr magAmount)
            ))
        ("="
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listEQMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listEQMS1 pntr magAmount)
            ))
        ("+"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listPLUMS pntr magAmount)
            ))
        ("*"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listASTMS pntr magAmount)
            ))
        ("'"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listAPMS pntr magAmount)
            ))
        ("("
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listLPMS pntr magAmount)
            ))
        (")"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listRPMS pntr magAmount)
            ))
        ("["
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listLBMS pntr magAmount)
            ))
        ("]"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listRBMS pntr magAmount)
            ))
        ("\\"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listBSMS pntr magAmount)
            ))
        ("\""
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listQUMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listQUMS1 pntr magAmount)
            ))
        ("%"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listPCTMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listPCTMS1 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listPCTMS2 pntr magAmount)
            ))
        ("$"
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listDSMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listDSMS1 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  pgMLayer
             
            modifyCoords(coords_listDSMS2 pntr magAmount)
            ))

                (t printf("The '%s' character is not supported by pgText.\n" character)
                   printf("Skipping the '%s' character and leaving space for the user to insert it.\n" character)
        )
        );end case
    )
)

procedure( modifyCoords(wholelist pntrNum magAmount)
    prog( nil
    (newwholelist = list())
    (finalnewwholelist = list())
    foreach( sublistm wholelist
        (xnumberm =
        (pntrNum + ((car(sublistm) * magAmount * 1000.000000) / 1000.000000)))
        (ynumberm = ((cadr(sublistm) * magAmount * 1000.000000) / 1000.000000))
        (newsublistm = geWindowToEditPoint(getCurrentWindow()
                           list(xnumberm ynumberm))
            )
        (newwholelist = xcons(newwholelist newsublistm))
        (finalnewwholelist = reverse(newwholelist))
        (newsublistm = nil)
    )
    return(finalnewwholelist)
    )
)

;coords data

    (coords_listAMS1 = list((0.800000:0.600000)
        (0.800000:1.000000)
        (0.400000:1.000000)
        (0.400000:1.400000)
        (0.600000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.400000:2.000000)
        (0.0:1.600000)
        (0.0:0.0)
        (0.400000:0.0)
        (0.400000:0.600000)
        (0.800000:0.600000)
    ))
    (coords_listAMS2 = list((0.800000:0.600000)
        (1.200000:0.600000)
        (1.200000:0.0)
        (1.600000:0.0)
        (1.600000:1.600000)
        (1.200000:2.000000)
        (0.800000:2.000000)
        (0.800000:1.600000)
        (1.000000:1.600000)
        (1.200000:1.400000)
        (1.200000:1.000000)
        (0.800000:1.000000)
        (0.800000:0.600000)
    ))
    (coords_listBMS1 = list((0.800000:0.0)
        (0.800000:0.400000)
        (0.400000:0.400000)
        (0.400000:0.800000)
        (0.800000:0.800000)
        (0.800000:1.200000)
        (0.400000:1.200000)
        (0.400000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
        (0.800000:0.0)
    ))
    (coords_listBMS2 = list((0.800000:0.0)
        (0.800000:0.400000)
        (1.100000:0.400000)
        (1.200000:0.500000)
        (1.200000:0.700000)
        (1.100000:0.800000)
        (0.800000:0.800000)
        (0.800000:1.200000)
        (1.100000:1.200000)
        (1.200000:1.300000)
        (1.200000:1.500000)
        (1.100000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (1.300000:2.000000)
        (1.600000:1.700000)
        (1.600000:1.200000)
        (1.400000:1.000000)
        (1.600000:0.800000)
        (1.600000:0.300000)
        (1.300000:0.0)
        (0.800000:0.0)
    ))
    (coords_listCMS = list((0.0:0.400000)
        (0.400000:0.0)
        (1.200000:0.0)
        (1.600000:0.400000)
        (1.600000:0.600000)
        (1.200000:0.600000)
        (1.000000:0.400000)
        (0.600000:0.400000)
        (0.400000:0.600000)
        (0.400000:1.400000)
        (0.600000:1.600000)
        (1.000000:1.600000)
        (1.200000:1.400000)
        (1.600000:1.400000)
        (1.600000:1.600000)
        (1.200000:2.000000)
        (0.400000:2.000000)
        (0.0:1.600000)
        (0.0:0.400000)
    ))
    (coords_listDMS = list((0.800000:0.0)
        (0.800000:0.400000)
        (0.400000:0.400000)
        (0.400000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
        (0.800000:0.0)
    ))
    (coords_listDMS1 = list((0.800000:0.0)
        (1.200000:0.0)
        (1.600000:0.400000)
        (1.600000:1.600000)
        (1.200000:2.000000)
        (0.800000:2.000000)
        (0.800000:1.600000)
        (1.000000:1.600000)
        (1.200000:1.400000)
        (1.200000:0.600000)
        (1.000000:0.400000)
        (0.800000:0.400000)
        (0.800000:0.0)
    ))
    (coords_listEMS = list((0.0:0.0)
        (1.600000:0.0)
        (1.600000:0.400000)
        (0.400000:0.400000)
        (0.400000:0.800000)
        (1.200000:0.800000)
        (1.200000:1.200000)
        (0.400000:1.200000)
        (0.400000:1.600000)
        (1.600000:1.600000)
        (1.600000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
    ))
    (coords_listFMS = list((0.0:0.0)
        (0.400000:0.0)
        (0.400000:0.800000)
        (1.200000:0.800000)
        (1.200000:1.200000)
        (0.400000:1.200000)
        (0.400000:1.600000)
        (1.600000:1.600000)
        (1.600000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
    ))
    (coords_listGMS = list((0.400000:0.0)
        (1.200000:0.0)
        (1.600000:0.400000)
        (1.600000:1.000000)
        (0.800000:1.000000)
        (0.800000:0.700000)
        (1.200000:0.700000)
        (1.200000:0.600000)
        (1.000000:0.400000)
        (0.600000:0.400000)
        (0.400000:0.600000)
        (0.400000:1.400000)
        (0.600000:1.600000)
        (1.000000:1.600000)
        (1.200000:1.400000)
        (1.600000:1.400000)
        (1.600000:1.600000)
        (1.200000:2.000000)
        (0.400000:2.000000)
        (0.0:1.600000)
        (0.0:0.400000)
        (0.400000:0.0)
    ))
    (coords_listHMS = list((0.0:0.0)
        (0.400000:0.0)
        (0.400000:0.800000)
        (1.200000:0.800000)
        (1.200000:0.0)
        (1.600000:0.0)
        (1.600000:2.000000)
        (1.200000:2.000000)
        (1.200000:1.200000)
        (0.400000:1.200000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
    ))
    (coords_listIMS = list((0.0:0.0)
        (0.800000:0.0)
        (0.800000:0.400000)
        (0.600000:0.400000)
        (0.600000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.0:2.000000)
        (0.0:1.600000)
        (0.200000:1.600000)
        (0.200000:0.400000)
        (0.0:0.400000)
        (0.0:0.0)
    ))
    (coords_listJMS = list((0.400000:0.0)
        (1.200000:0.0)
        (1.600000:0.400000)
        (1.600000:2.000000)
        (1.200000:2.000000)
        (1.200000:0.600000)
        (1.000000:0.400000)
        (0.600000:0.400000)
        (0.400000:0.600000)
        (0.400000:0.700000)
        (0.0:0.700000)
        (0.0:0.400000)
        (0.400000:0.0)
    ))
    (coords_listKMS = list((0.0:0.0)
        (0.400000:0.0)
        (0.400000:0.800000)
        (0.600000:0.800000)
        (1.200000:0.200000)
        (1.200000:0.0)
        (1.600000:0.0)
        (1.600000:0.400000)
        (1.000000:1.000000)
        (1.600000:1.600000)
        (1.600000:2.000000)
        (1.200000:2.000000)
        (1.200000:1.800000)
        (0.600000:1.200000)
        (0.400000:1.200000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
    ))
    (coords_listLMS = list((0.0:0.0)
        (1.600000:0.0)
        (1.600000:0.400000)
        (0.400000:0.400000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
    ))
    (coords_listMMS = list((0.0:0.0)
        (0.400000:0.0)
        (0.400000:1.200000)
        (0.600000:1.200000)
        (1.000000:0.800000)
        (1.400000:1.200000)
        (1.600000:1.200000)
        (1.600000:0.0)
        (2.000000:0.0)
        (2.000000:2.000000)
        (1.600000:2.000000)
        (1.000000:1.400000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
    ))
    (coords_listNMS = list((0.0:0.0)
        (0.400000:0.0)
        (0.400000:1.000000)
        (0.500000:1.000000)
        (1.500000:0.0)
        (1.600000:0.0)
        (1.600000:2.000000)
        (1.200000:2.000000)
        (1.200000:1.000000)
        (1.100000:1.000000)
        (0.100000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
    ))
    (coords_listOMS = list((0.800000:0.0)
        (0.800000:0.400000)
        (0.600000:0.400000)
        (0.400000:0.600000)
        (0.400000:1.400000)
        (0.600000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.400000:2.000000)
        (0.0:1.600000)
        (0.0:0.400000)
        (0.400000:0.0)
        (0.800000:0.0)
    ))
    (coords_listOMS1 = list((0.800000:0.0)
        (1.200000:0.0)
        (1.600000:0.400000)
        (1.600000:1.600000)
        (1.200000:2.000000)
        (0.800000:2.000000)
        (0.800000:1.600000)
        (1.000000:1.600000)
        (1.200000:1.400000)
        (1.200000:0.600000)
        (1.000000:0.400000)
        (0.800000:0.400000)
        (0.800000:0.0)
    ))
    (coords_listPMS = list((0.800000:0.800000)
        (0.800000:1.200000)
        (0.400000:1.200000)
        (0.400000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
        (0.400000:0.0)
        (0.400000:0.800000)
        (0.800000:0.800000)
    ))
    (coords_listPMS1 = list((0.800000:0.800000)
        (1.300000:0.800000)
        (1.600000:1.100000)
        (1.600000:1.700000)
        (1.300000:2.000000)
        (0.800000:2.000000)
        (0.800000:1.600000)
        (1.100000:1.600000)
        (1.200000:1.500000)
        (1.200000:1.300000)
        (1.100000:1.200000)
        (0.800000:1.200000)
        (0.800000:0.800000)
    ))
    (coords_listQMS = list((0.800000:0.0)
        (0.800000:0.400000)
        (0.600000:0.400000)
        (0.400000:0.600000)
        (0.400000:1.400000)
        (0.600000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.400000:2.000000)
        (0.0:1.600000)
        (0.0:0.400000)
        (0.400000:0.0)
        (0.800000:0.0)
    ))
    (coords_listQMS1 = list((0.800000:0.0)
        (1.200000:0.0)
        (1.400000:-0.200000)
        (1.800000:0.200000)
        (1.600000:0.400000)
        (1.600000:1.600000)
        (1.200000:2.000000)
        (0.800000:2.000000)
        (0.800000:1.600000)
        (1.000000:1.600000)
        (1.200000:1.400000)
        (1.200000:0.600000)
        (1.000000:0.400000)
        (0.800000:0.400000)
        (0.800000:0.0)
    ))
    (coords_listRMS = list((0.600000:0.800000)
        (0.600000:1.200000)
        (0.400000:1.200000)
        (0.400000:1.600000)
        (0.600000:1.600000)
        (0.600000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
        (0.400000:0.0)
        (0.400000:0.800000)
        (0.600000:0.800000)
    ))
    (coords_listRMS1 = list((0.600000:0.800000)
        (0.800000:0.800000)
        (1.200000:0.400000)
        (1.200000:0.0)
        (1.600000:0.0)
        (1.600000:0.500000)
        (1.300000:0.800000)
        (1.600000:1.100000)
        (1.600000:1.700000)
        (1.300000:2.000000)
        (0.600000:2.000000)
        (0.600000:1.600000)
        (1.100000:1.600000)
        (1.200000:1.500000)
        (1.200000:1.300000)
        (1.100000:1.200000)
        (0.600000:1.200000)
        (0.600000:0.800000)
    ))
    (coords_listSMS = list((0.300000:0.0)
        (1.300000:0.0)
        (1.600000:0.300000)
        (1.600000:0.900000)
        (1.300000:1.200000)
        (0.500000:1.200000)
        (0.400000:1.300000)
        (0.400000:1.500000)
        (0.500000:1.600000)
        (1.100000:1.600000)
        (1.200000:1.500000)
        (1.600000:1.500000)
        (1.600000:1.700000)
        (1.300000:2.000000)
        (0.300000:2.000000)
        (0.0:1.700000)
        (0.0:1.100000)
        (0.300000:0.800000)
        (1.100000:0.800000)
        (1.200000:0.700000)
        (1.200000:0.500000)
        (1.100000:0.400000)
        (0.500000:0.400000)
        (0.400000:0.500000)
        (0.0:0.500000)
        (0.0:0.300000)
        (0.300000:0.0)
    ))
    (coords_listTMS = list((0.600000:0.0)
        (1.000000:0.0)
        (1.000000:1.600000)
        (1.600000:1.600000)
        (1.600000:2.000000)
        (0.0:2.000000)
        (0.0:1.600000)
        (0.600000:1.600000)
        (0.600000:0.0)
    ))
    (coords_listUMS = list((0.400000:0.0)
        (1.200000:0.0)
        (1.600000:0.400000)
        (1.600000:2.000000)
        (1.200000:2.000000)
        (1.200000:0.600000)
        (1.000000:0.400000)
        (0.600000:0.400000)
        (0.400000:0.600000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:0.400000)
        (0.400000:0.0)
    ))
    (coords_listVMS = list((0.700000:0.0)
        (0.900000:0.0)
        (1.600000:0.700000)
        (1.600000:2.000000)
        (1.200000:2.000000)
        (1.200000:0.900000)
        (0.800000:0.500000)
        (0.400000:0.900000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:0.700000)
        (0.700000:0.0)
    ))
    (coords_listWMS = list((0.0:0.0)
        (0.400000:0.0)
        (1.000000:0.600000)
        (1.600000:0.0)
        (2.000000:0.0)
        (2.000000:2.000000)
        (1.600000:2.000000)
        (1.600000:0.800000)
        (1.400000:0.800000)
        (1.000000:1.200000)
        (0.600000:0.800000)
        (0.400000:0.800000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:0.0)
    ))
    (coords_listXMS = list((0.0:0.0)
        (0.400000:0.0)
        (0.400000:0.400000)
        (0.800000:0.800000)
        (1.200000:0.400000)
        (1.200000:0.0)
        (1.600000:0.0)
        (1.600000:0.600000)
        (1.200000:1.000000)
        (1.600000:1.400000)
        (1.600000:2.000000)
        (1.200000:2.000000)
        (1.200000:1.600000)
        (0.800000:1.200000)
        (0.400000:1.600000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:1.400000)
        (0.400000:1.000000)
        (0.0:0.600000)
        (0.0:0.0)
    ))
    (coords_listYMS = list((0.600000:0.0)
        (1.000000:0.0)
        (1.000000:0.700000)
        (1.600000:1.300000)
        (1.600000:2.000000)
        (1.200000:2.000000)
        (1.200000:1.500000)
        (0.800000:1.100000)
        (0.400000:1.500000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:1.300000)
        (0.600000:0.700000)
        (0.600000:0.0)
    ))
    (coords_listZMS = list((0.0:0.0)
        (1.600000:0.0)
        (1.600000:0.400000)
        (0.600000:0.400000)
        (0.600000:0.500000)
        (1.600000:1.500000)
        (1.600000:2.000000)
        (0.0:2.000000)
        (0.0:1.600000)
        (1.000000:1.600000)
        (1.000000:1.500000)
        (0.0:0.500000)
        (0.0:0.0)
    ))
    (coords_listMS0 = list((0.800000:0.0)
        (0.800000:0.400000)
        (0.600000:0.400000)
        (0.400000:0.600000)
        (0.400000:1.400000)
        (0.600000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.400000:2.000000)
        (0.0:1.600000)
        (0.0:0.400000)
        (0.400000:0.0)
        (0.800000:0.0)
    ))
    (coords_listMS01 = list((0.800000:0.0)
        (1.200000:0.0)
        (1.600000:0.400000)
        (1.600000:1.600000)
        (1.200000:2.000000)
        (0.800000:2.000000)
        (0.800000:1.600000)
        (1.000000:1.600000)
        (1.200000:1.400000)
        (1.200000:0.600000)
        (1.000000:0.400000)
        (0.800000:0.400000)
        (0.800000:0.0)
    ))
    (coords_listMS02 = list((0.700000:0.700000)
        (1.100000:1.100000)
        (0.900000:1.300000)
        (0.500000:0.900000)
        (0.700000:0.700000)
    ))
    (coords_listMS1 = list((0.0:0.0)
        (0.800000:0.0)
        (0.800000:0.400000)
        (0.600000:0.400000)
        (0.600000:2.000000)
        (0.200000:2.000000)
        (0.0:1.800000)
        (0.0:1.600000)
        (0.200000:1.600000)
        (0.200000:0.400000)
        (0.0:0.400000)
        (0.0:0.0)
    ))
    (coords_listMS2 = list((0.0:0.0)
        (1.600000:0.0)
        (1.600000:0.400000)
        (0.400000:0.400000)
        (0.400000:0.600000)
        (0.500000:0.700000)
        (1.300000:0.700000)
        (1.600000:1.000000)
        (1.600000:1.700000)
        (1.300000:2.000000)
        (0.300000:2.000000)
        (0.0:1.700000)
        (0.0:1.500000)
        (0.400000:1.500000)
        (0.500000:1.600000)
        (1.100000:1.600000)
        (1.200000:1.500000)
        (1.200000:1.200000)
        (1.100000:1.100000)
        (0.300000:1.100000)
        (0.0:0.800000)
        (0.0:0.0)
    ))
    (coords_listMS3 = list((0.300000:0.0)
        (1.300000:0.0)
        (1.600000:0.300000)
        (1.600000:0.800000)
        (1.400000:1.000000)
        (1.600000:1.200000)
        (1.600000:1.700000)
        (1.300000:2.000000)
        (0.300000:2.000000)
        (0.0:1.700000)
        (0.0:1.500000)
        (0.400000:1.500000)
        (0.500000:1.600000)
        (1.100000:1.600000)
        (1.200000:1.500000)
        (1.200000:1.300000)
        (1.100000:1.200000)
        (0.700000:1.200000)
        (0.700000:0.800000)
        (1.100000:0.800000)
        (1.200000:0.700000)
        (1.200000:0.500000)
        (1.100000:0.400000)
        (0.500000:0.400000)
        (0.400000:0.500000)
        (0.0:0.500000)
        (0.0:0.300000)
        (0.300000:0.0)
    ))
    (coords_listMS4 = list((0.0:0.800000)
        (1.000000:0.800000)
        (1.000000:0.0)
        (1.400000:0.0)
        (1.400000:0.800000)
        (1.600000:0.800000)
        (1.600000:1.200000)
        (1.400000:1.200000)
        (1.400000:2.000000)
        (1.000000:2.000000)
        (1.000000:1.200000)
        (0.400000:1.200000)
        (0.400000:2.000000)
        (0.0:2.000000)
        (0.0:0.800000)
    ))
    (coords_listMS5 = list((0.300000:0.0)
        (1.300000:0.0)
        (1.600000:0.300000)
        (1.600000:1.000000)
        (1.300000:1.300000)
        (0.500000:1.300000)
        (0.400000:1.400000)
        (0.400000:1.600000)
        (1.600000:1.600000)
        (1.600000:2.000000)
        (0.0:2.000000)
        (0.0:1.200000)
        (0.300000:0.900000)
        (1.100000:0.900000)
        (1.200000:0.800000)
        (1.200000:0.500000)
        (1.100000:0.400000)
        (0.500000:0.400000)
        (0.400000:0.500000)
        (0.0:0.500000)
        (0.0:0.300000)
        (0.300000:0.0)
    ))
    (coords_listMS6 = list((0.800000:0.0)
        (0.800000:0.400000)
        (0.500000:0.400000)
        (0.400000:0.500000)
        (0.400000:0.700000)
        (0.500000:0.800000)
        (0.800000:0.800000)
        (0.800000:1.200000)
        (0.400000:1.200000)
        (0.400000:1.500000)
        (0.500000:1.600000)
        (1.100000:1.600000)
        (1.200000:1.500000)
        (1.600000:1.500000)
        (1.600000:1.700000)
        (1.300000:2.000000)
        (0.300000:2.000000)
        (0.0:1.700000)
        (0.0:0.300000)
        (0.300000:0.0)
        (0.800000:0.0)
    ))
    (coords_listMS61 = list((0.800000:0.0)
        (1.300000:0.0)
        (1.600000:0.300000)
        (1.600000:0.900000)
        (1.300000:1.200000)
        (0.800000:1.200000)
        (0.800000:0.800000)
        (1.100000:0.800000)
        (1.200000:0.700000)
        (1.200000:0.500000)
        (1.100000:0.400000)
        (0.800000:0.400000)
        (0.800000:0.0)
    ))
    (coords_listMS7 = list((0.600000:0.0)
        (1.000000:0.0)
        (1.000000:0.800000)
        (1.600000:1.400000)
        (1.600000:2.000000)
        (0.0:2.000000)
        (0.0:1.600000)
        (1.200000:1.600000)
        (1.200000:1.500000)
        (0.600000:0.900000)
        (0.600000:0.0)
    ))
    (coords_listMS8 = list((0.800000:0.0)
        (0.800000:0.400000)
        (0.500000:0.400000)
        (0.400000:0.500000)
        (0.400000:0.700000)
        (0.500000:0.800000)
        (0.800000:0.800000)
        (0.800000:1.200000)
        (0.500000:1.200000)
        (0.400000:1.300000)
        (0.400000:1.500000)
        (0.500000:1.600000)
        (0.800000:1.600000)
        (0.800000:2.000000)
        (0.300000:2.000000)
        (0.0:1.700000)
        (0.0:1.200000)
        (0.200000:1.000000)
        (0.0:0.800000)
        (0.0:0.300000)
        (0.300000:0.0)
        (0.800000:0.0)
    ))
    (coords_listMS81 = list((0.800000:0.0)
        (1.300000:0.0)
        (1.600000:0.300000)
        (1.600000:0.800000)
        (1.400000:1.000000)
        (1.600000:1.200000)
        (1.600000:1.700000)
        (1.300000:2.000000)
        (0.800000:2.000000)
        (0.800000:1.600000)
        (1.100000:1.600000)
        (1.200000:1.500000)
        (1.200000:1.300000)
        (1.100000:1.200000)
        (0.800000:1.200000)
        (0.800000:0.800000)
        (1.100000:0.800000)
        (1.200000:0.700000)
        (1.200000:0.500000)
        (1.100000:0.400000)
        (0.800000:0.400000)
        (0.800000:0.0)
    ))
    (coords_listMS9 = list((0.800000:1.600000)
        (0.800000:2.000000)
        (0.300000:2.000000)
        (0.0:1.700000)
        (0.0:1.100000)
        (0.300000:0.800000)
        (0.800000:0.800000)
        (0.800000:1.200000)
        (0.500000:1.200000)
        (0.400000:1.300000)
        (0.400000:1.500000)
        (0.500000:1.600000)
        (0.800000:1.600000)
    ))
    (coords_listMS91 = list((0.800000:1.600000)
        (1.100000:1.600000)
        (1.200000:1.500000)
        (1.200000:1.300000)
        (1.100000:1.200000)
        (0.800000:1.200000)
        (0.800000:0.800000)
        (1.200000:0.800000)
        (1.200000:0.500000)
        (1.100000:0.400000)
        (0.500000:0.400000)
        (0.400000:0.500000)
        (0.0:0.500000)
        (0.0:0.300000)
        (0.300000:0.0)
        (1.300000:0.0)
        (1.600000:0.300000)
        (1.600000:1.700000)
        (1.300000:2.000000)
        (0.800000:2.000000)
        (0.800000:1.600000)
    ))
    (coords_listPERMS = list((0.100000:0.100000)
        (0.300000:0.100000)
        (0.400000:0.200000)
        (0.400000:0.400000)
        (0.300000:0.500000)
        (0.100000:0.500000)
        (0.0:0.400000)
        (0.0:0.200000)
        (0.100000:0.100000)
    ))
    (coords_listCOMMS = list((0.100000:0.100000)
        (-0.100000:-0.100000)
        (0.0:-0.200000)
        (0.400000:0.200000)
        (0.400000:0.400000)
        (0.300000:0.500000)
        (0.100000:0.500000)
        (0.0:0.400000)
        (0.0:0.200000)
        (0.100000:0.100000)
    ))
    (coords_listDASMS = list((0.0:0.900000)
        (1.600000:0.900000)
        (1.600000:1.200000)
        (0.0:1.200000)
        (0.0:0.900000)
    ))
    (coords_listSLMS = list((0.200000:0.200000)
        (1.600000:1.600000)
        (1.400000:1.800000)
        (0.0:0.400000)
        (0.200000:0.200000)
    ))
    (coords_listEXMS = list((0.100000:0.800000)
        (0.300000:0.800000)
        (0.400000:0.900000)
        (0.400000:1.900000)
        (0.300000:2.000000)
        (0.100000:2.000000)
        (0.0:1.900000)
        (0.0:0.900000)
        (0.100000:0.800000)
    ))
    (coords_listEXMS1 = list((0.100000:0.0)
        (0.300000:0.0)
        (0.400000:0.100000)
        (0.400000:0.300000)
        (0.300000:0.400000)
        (0.100000:0.400000)
        (0.0:0.300000)
        (0.0:0.100000)
        (0.100000:0.0)
    ))
    (coords_listQMMS = list((0.500000:0.600000)
        (0.900000:0.600000)
        (1.000000:0.700000)
        (1.200000:0.700000)
        (1.500000:1.000000)
        (1.500000:1.700000)
        (1.200000:2.000000)
        (0.300000:2.000000)
        (0.0:1.700000)
        (0.0:1.400000)
        (0.400000:1.400000)
        (0.400000:1.500000)
        (0.500000:1.600000)
        (1.000000:1.600000)
        (1.100000:1.500000)
        (1.100000:1.200000)
        (1.000000:1.100000)
        (0.800000:1.100000)
        (0.500000:0.800000)
        (0.500000:0.600000)
    ))
    (coords_listQMMS1 = list((0.600000:0.0)
        (0.800000:0.0)
        (0.900000:0.100000)
        (0.900000:0.300000)
        (0.800000:0.400000)
        (0.600000:0.400000)
        (0.500000:0.300000)
        (0.500000:0.100000)
        (0.600000:0.0)
    ))
    (coords_listCOLMS = list((0.100000:0.0)
        (0.300000:0.0)
        (0.400000:0.100000)
        (0.400000:0.300000)
        (0.300000:0.400000)
        (0.100000:0.400000)
        (0.0:0.300000)
        (0.0:0.100000)
        (0.100000:0.0)
    ))
    (coords_listCOLMS1 = list((0.100000:0.800000)
        (0.300000:0.800000)
        (0.400000:0.900000)
        (0.400000:1.100000)
        (0.300000:1.200000)
        (0.100000:1.200000)
        (0.0:1.100000)
        (0.0:0.900000)
        (0.100000:0.800000)
    ))
    (coords_listSCMS = list((0.100000:0.0)
        (-0.100000:-0.200000)
        (0.0:-0.300000)
        (0.400000:0.100000)
        (0.400000:0.300000)
        (0.300000:0.400000)
        (0.100000:0.400000)
        (0.0:0.300000)
        (0.0:0.100000)
        (0.100000:0.0)
    ))
    (coords_listSCMS1 = list((0.100000:0.800000)
        (0.300000:0.800000)
        (0.400000:0.900000)
        (0.400000:1.100000)
        (0.300000:1.200000)
        (0.100000:1.200000)
        (0.0:1.100000)
        (0.0:0.900000)
        (0.100000:0.800000)
    ))
    (coords_listUSMS = list((0.0:0.0)
        (1.600000:0.0)
        (1.600000:0.300000)
        (0.0:0.300000)
        (0.0:0.0)
    ))
    (coords_listEQMS = list((0.0:0.500000)
        (1.400000:0.500000)
        (1.400000:0.800000)
        (0.0:0.800000)
        (0.0:0.500000)
    ))
    (coords_listEQMS1 = list((0.0:1.200000)
        (1.400000:1.200000)
        (1.400000:1.500000)
        (0.0:1.500000)
        (0.0:1.200000)
    ))
    (coords_listPLUMS = list((0.0:0.900000)
        (0.600000:0.900000)
        (0.600000:0.300000)
        (0.900000:0.300000)
        (0.900000:0.900000)
        (1.500000:0.900000)
        (1.500000:1.200000)
        (0.900000:1.200000)
        (0.900000:1.800000)
        (0.600000:1.800000)
        (0.600000:1.200000)
        (0.0:1.200000)
        (0.0:0.900000)
    ))
    (coords_listASTMS = list((0.0:0.900000)
        (0.500000:0.900000)
        (0.100000:0.500000)
        (0.200000:0.400000)
        (0.600000:0.800000)
        (0.600000:0.300000)
        (0.800000:0.300000)
        (0.800000:0.800000)
        (1.200000:0.400000)
        (1.300000:0.500000)
        (0.900000:0.900000)
        (1.400000:0.900000)
        (1.400000:1.100000)
        (0.900000:1.100000)
        (1.300000:1.500000)
        (1.200000:1.600000)
        (0.800000:1.200000)
        (0.800000:1.700000)
        (0.600000:1.700000)
        (0.600000:1.200000)
        (0.200000:1.600000)
        (0.100000:1.500000)
        (0.500000:1.100000)
        (0.0:1.100000)
        (0.0:0.900000)
    ))
    (coords_listAPMS = list((0.0:1.700000)
        (0.100000:1.600000)
        (-0.100000:1.400000)
        (0.0:1.300000)
        (0.400000:1.700000)
        (0.400000:1.900000)
        (0.300000:2.000000)
        (0.100000:2.000000)
        (0.0:1.900000)
        (0.0:1.700000)
    ))
    (coords_listLPMS = list((0.400000:-0.200000)
        (0.700000:-0.200000)
        (0.700000:0.100000)
        (0.500000:0.100000)
        (0.300000:0.300000)
        (0.300000:1.700000)
        (0.500000:1.900000)
        (0.700000:1.900000)
        (0.700000:2.200000)
        (0.400000:2.200000)
        (0.0:1.800000)
        (0.0:0.200000)
        (0.400000:-0.200000)
    ))
    (coords_listRPMS = list((0.0:-0.200000)
        (0.300000:-0.200000)
        (0.700000:0.200000)
        (0.700000:1.800000)
        (0.300000:2.200000)
        (0.0:2.200000)
        (0.0:1.900000)
        (0.200000:1.900000)
        (0.400000:1.700000)
        (0.400000:0.300000)
        (0.200000:0.100000)
        (0.0:0.100000)
        (0.0:-0.200000)
    ))
    (coords_listLBMS = list((0.0:-0.200000)
        (0.700000:-0.200000)
        (0.700000:0.100000)
        (0.300000:0.100000)
        (0.300000:1.900000)
        (0.700000:1.900000)
        (0.700000:2.200000)
        (0.0:2.200000)
        (0.0:-0.200000)
    ))
    (coords_listRBMS = list((0.0:-0.200000)
        (0.700000:-0.200000)
        (0.700000:2.200000)
        (0.0:2.200000)
        (0.0:1.900000)
        (0.400000:1.900000)
        (0.400000:0.100000)
        (0.0:0.100000)
        (0.0:-0.200000)
    ))
    (coords_listBSMS = list((1.400000:0.200000)
        (1.600000:0.400000)
        (0.200000:1.800000)
        (0.0:1.600000)
        (1.400000:0.200000)
    ))
    (coords_listQUMS = list((0.0:1.400000)
        (0.300000:1.400000)
        (0.300000:2.200000)
        (0.0:2.200000)
        (0.0:1.400000)
    ))
    (coords_listQUMS1 = list((0.600000:1.400000)
        (0.900000:1.400000)
        (0.900000:2.200000)
        (0.600000:2.200000)
        (0.600000:1.400000)
    ))
    (coords_listPCTMS = list((0.200000:0.200000)
        (1.600000:1.600000)
        (1.400000:1.800000)
        (0.0:0.400000)
        (0.200000:0.200000)
    ))
    (coords_listPCTMS1 = list((0.100000:1.400000)
        (0.300000:1.400000)
        (0.400000:1.500000)
        (0.400000:1.700000)
        (0.300000:1.800000)
        (0.100000:1.800000)
        (0.0:1.700000)
        (0.0:1.500000)
        (0.100000:1.400000)
    ))
    (coords_listPCTMS2 = list((1.300000:0.200000)
        (1.500000:0.200000)
        (1.600000:0.300000)
        (1.600000:0.500000)
        (1.500000:0.600000)
        (1.300000:0.600000)
        (1.200000:0.500000)
        (1.200000:0.300000)
        (1.300000:0.200000)
    ))
    (coords_listDSMS = list((0.0:1.400000)
        (0.200000:1.400000)
        (0.200000:1.700000)
        (0.300000:1.800000)
        (0.700000:1.800000)
        (0.700000:1.400000)
        (0.900000:1.400000)
        (0.900000:1.800000)
        (1.300000:1.800000)
        (1.400000:1.700000)
        (1.600000:1.700000)
        (1.600000:1.800000)
        (1.400000:2.000000)
        (0.900000:2.000000)
        (0.900000:2.200000)
        (0.700000:2.200000)
        (0.700000:2.000000)
        (0.200000:2.000000)
        (0.0:1.800000)
        (0.0:1.400000)
    ))
    (coords_listDSMS1 = list((0.0:1.400000)
        (0.0:1.100000)
        (0.200000:0.900000)
        (0.700000:0.900000)
        (0.700000:0.600000)
        (0.900000:0.600000)
        (0.900000:0.900000)
        (1.300000:0.900000)
        (1.400000:0.800000)
        (1.400000:0.600000)
        (1.600000:0.600000)
        (1.600000:0.900000)
        (1.400000:1.100000)
        (0.900000:1.100000)
        (0.900000:1.400000)
        (0.700000:1.400000)
        (0.700000:1.100000)
        (0.300000:1.100000)
        (0.200000:1.200000)
        (0.200000:1.400000)
        (0.0:1.400000)
    ))
    (coords_listDSMS2 = list((0.200000:0.0)
        (0.700000:0.0)
        (0.700000:-0.200000)
        (0.900000:-0.200000)
        (0.900000:0.0)
        (1.400000:0.0)
        (1.600000:0.200000)
        (1.600000:0.600000)
        (1.400000:0.600000)
        (1.400000:0.300000)
        (1.300000:0.200000)
        (0.900000:0.200000)
        (0.900000:0.600000)
        (0.700000:0.600000)
        (0.700000:0.200000)
        (0.300000:0.200000)
        (0.200000:0.300000)
        (0.0:0.300000)
        (0.0:0.200000)
        (0.200000:0.0)
    ))

