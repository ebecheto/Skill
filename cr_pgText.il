; load("cr_pgText.il")
/*

Program Name    : cr_pgText.il

cr_pgText is a program to create text that can be used for pattern
generation. This is accomplished by drawing each character as
a polygon.  The program will prompt for a text string. The
text string can contain any charater that is defined by
symbol as described below and spaces. The program will then draw
the polygons on the user specified layer. Presently, the text patterns
are generated on the 'drawing' purpose only.
*/


procedure(cr_pgText()
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


    cr_pgTextForm()

   )
)

procedure( cr_pgTextForm()
    (text_string = (hiCreateStringField ?name
        'text_string ?prompt "Enter Text"
        ?value "" ?defValue "" ?callback
        "" ?editable t
    ))

    (magAmount = (hiCreateStringField ?name
        'magAmount ?prompt "Enter Mag"
        ?value "" ?defValue "" ?callback
        "" ?editable t
    ))

    (layerField = hiCreateLayerCyclicField(
                techGetTechFile(geGetEditCellView())
        "Layer for Polygon Text"
            ""
                nil
                (if boundp('cr_pgMLayer) list(cr_pgMLayer "drawing") leGetEntryLayer() )
        ))


    (formId = (hiCreateForm
        'cr_pgTextForm "Programmable Text Generator" "cr_pgTextCB()"
        list(text_string magAmount layerField)
        ""
    ))

    hiDisplayForm(formId)
   )

procedure(cr_pgTextCB()
    (text_string = stringToLower( ((cr_pgTextForm->text_string)->value)) )
    cr_pgMLayer = hiLayerStringToLPP(
techGetTechFile(geGetEditCellView())
               cadddr(cr_pgTextForm-> hiLayerField->value))~>name
    printf("cr_pgMLayer set to ")
        println(cr_pgMLayer)
    (magAmount = float(evalstring(((cr_pgTextForm->magAmount)->value))))
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
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listAMS1 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listAMS2 pntr magAmount)
            ))
        ("b"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listBMS1 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listBMS2 pntr magAmount)
            ))
        ("c"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listCMS pntr magAmount)
            ))
        ("d"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listDMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listDMS1 pntr magAmount)
            ))
        ("e"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listEMS pntr magAmount)
            ))
        ("f"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listFMS pntr magAmount)
            ))
        ("g"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listGMS pntr magAmount)
            ))
        ("h"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listHMS pntr magAmount)
            ))
        ("i"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listIMS pntr magAmount)
            ))
        ("j"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listJMS pntr magAmount)
            ))
        ("k"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listKMS pntr magAmount)
            ))
        ("l"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listLMS pntr magAmount)
            ))
        ("m"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMMS pntr magAmount)
            ))
        ("n"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listNMS pntr magAmount)
            ))
        ("o"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listOMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listOMS1 pntr magAmount)
            ))
        ("p"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listPMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listPMS1 pntr magAmount)
            ))
        ("q"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listQMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listQMS1 pntr magAmount)
            ))
        ("r"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listRMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listRMS1 pntr magAmount)
            ))
        ("s"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listSMS pntr magAmount)
            ))
        ("t"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listTMS pntr magAmount)
            ))
        ("u"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listUMS pntr magAmount)
            ))
        ("v"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listVMS pntr magAmount)
            ))
        ("w"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listWMS pntr magAmount)
            ))
        ("x"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listXMS pntr magAmount)
            ))
        ("y"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listYMS pntr magAmount)
            ))
        ("z"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listZMS pntr magAmount)
            ))
        ("0"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS0 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS01 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS02 pntr magAmount)
            ))
        ("1"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS1 pntr magAmount)
            ))
        ("2"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS2 pntr magAmount)
            ))
        ("3"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS3 pntr magAmount)
            ))
        ("4"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS4 pntr magAmount)
            ))
        ("5"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS5 pntr magAmount)
            ))
        ("6"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS6 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS61 pntr magAmount)
            ))
        ("7"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS7 pntr magAmount)
            ))
        ("8"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS8 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS81 pntr magAmount)
            ))
        ("9"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS9 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listMS91 pntr magAmount)
            ))
        ("."
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listPERMS pntr magAmount)
            ))
        (","
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listCOMMS pntr magAmount)
            ))
        ("-"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listDASMS pntr magAmount)
            ))
        ("/"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listSLMS pntr magAmount)
            ))
        ("!"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listEXMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listEXMS1 pntr magAmount)
            ))
        ("?"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listQMMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listQMMS1 pntr magAmount)
            ))
        (":"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listCOLMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listCOLMS1 pntr magAmount)
            ))
        (";"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listSCMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listSCMS1 pntr magAmount)
            ))
        ("_"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listUSMS pntr magAmount)
            ))
        ("="
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listEQMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listEQMS1 pntr magAmount)
            ))
        ("+"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listPLUMS pntr magAmount)
            ))
        ("*"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listASTMS pntr magAmount)
            ))
        ("'"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listAPMS pntr magAmount)
            ))
        ("("
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listLPMS pntr magAmount)
            ))
        (")"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listRPMS pntr magAmount)
            ))
        ("["
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listLBMS pntr magAmount)
            ))
        ("]"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listRBMS pntr magAmount)
            ))
        ("\\"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listBSMS pntr magAmount)
            ))
        ("\""
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listQUMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listQUMS1 pntr magAmount)
            ))
        ("%"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listPCTMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listPCTMS1 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listPCTMS2 pntr magAmount)
            ))
        ("$"
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listDSMS pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listDSMS1 pntr magAmount)
            )
            (dbCreatePolygon 
            getEditRep()  cr_pgMLayer
             
            modifyCoords(coords_listDSMS2 pntr magAmount)
            ))

                (t printf("The '%s' character is not supported by cr_pgText.\n" character)
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


;; or try this one :

/*******************************************************************************
*  DISCLAIMER: The following code is provided for Cadence customers to use at  *
*   their own risk. The code may require modification to satisfy the           *
*   requirements of any user. The code and any modifications to the code may   *
*   not be compatible with current or future versions of Cadence products.     *
*   THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING WITHOUT     *
*   LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES OF MERCHANTABILITY *
*   OR FITNESS FOR A PARTICULAR USE.
*
*******************************************************************************/     /*
     Function Name :    PGtext
     Title         :    Yet another pg-able text routine.

     Synopsis      :    PGtext() => nil
     Users guide   :    None
     Description   :

     */
     ; PGtext is a program to create text that can be used
     ; for pattern generation of MEBES lithography. This is
     ; accomplished by drawing each character as a polygon.
     ; The program will prompt for a text string. The text
     ; string can contain any character that is defined by
     ; symbol as described below and spaces. The program
     ; will then draw the polygons on the current layer.
     ; The coordinate information for each of these polygons
     ; is stored as a symbol with the name of character.
     ; As an example a file containing a definition for the
     ; character "A" with the prefix "a_" would be:
     ; a_A=list( (1.000000:0.000000) (1.000000:6.500000) (2.500000:8.000000) (4.500000:8.000000) (6.000000:6.500000) (6.000000:4.000000) (1.000000:4.000000) (1.000000:3.000000) (6.000000:3.000000) (6.000000:0.000000) (7.000000:0.000000) (7.000000:7.000000) (5.000000:9.000000) (2.000000:9.000000) (0.000000:7.000000) (0.000000:0.000000))
     ; Any file containing character definitions must first be loaded.
     ; A program to create this file is provided. See "makeLetter" below.
     ; An example file containing characters a-z,A-Z and 0-9 is
     ; provided with the name "PGtext.il". ( the characters
     ; in this file are 9 units tall)
     ; The prefix is determined by setting the symbol "PGtextPreFix".
     ; A character to character spacing is determined by setting the
     ; symbol "PGtextSpacing". A grid is also specified by setting the
     ; symbol "PGtextGrid". This will force all points to this grid.
     ; PGtext also prompts for a magnification to be applied to the
     ; text. As an example: the character "A" defined above is 9 units
     ; high. If a mag of 2.0 is applied then the resultant polygon
     ; would be 18 units high. This mag is also applied to the text
     ; spacing. PGtext will allways put the text string in with a justification
     ; of lower left with no rotation or reflection. The program will
     ; leave the characters selected so that a orientation can be
     ; acomplished with reguler rotate and reflect commands.
     ;
     ; ******  makeLetter  ************
     ; makeLetter will create a definition as described above into the
     ; file defined by setting the variable "PGtextFile". This is done
     ; by first drawing the letter with a single polygon. (only one
     ; polygon can be used and no rectangles!!) Select the polygon
     ; and execute "makeLetter". This program will use the symbol
     ; "PGtextPreFix" and prompt for the character definition. It
     ; will automaticly justify the letter at the lower left extent
     ; of the polygon. (this means lower case letters cannot extend
     ; below the bottom of the line). By changing the "PGtextPreFix"
     ; different fonts can be defined. These programs use a symbol
     ; for each character, therefore only characters valid for "il"
     ; symbol names can be used. (sorry, this was the simplest way for
     ; me to accomplish this program). A space is defined as the
     ; width of the previous character.

     PGtextPreFix="a_"
     PGtextSpacing=1.5
     PGtextGrid=0.25
     PGtextFile="PGtextFile.il"

     a_B=list(  ( 1.000000:0.000000 ) ( 1.000000:8.000000 ) ( 5.250000:8.000000 ) ( 6.000000:7.250000 ) ( 6.000000:5.750000 ) ( 5.250000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:4.000000 ) ( 5.250000:4.000000 ) ( 6.000000:3.250000 ) ( 6.000000:1.750000 ) ( 5.250000:1.000000 ) ( 1.000000:1.000000 ) ( 1.000000:0.000000 ) ( 5.500000:0.000000 ) ( 7.000000:1.500000 ) ( 7.000000:3.500000 ) ( 6.000000:4.500000 ) ( 7.000000:5.500000 ) ( 7.000000:7.500000 ) ( 5.500000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) )
     a_A=list(  ( 1.000000:0.000000 ) ( 1.000000:6.500000 ) ( 2.500000:8.000000 ) ( 4.500000:8.000000 ) ( 6.000000:6.500000 ) ( 6.000000:4.000000 ) ( 1.000000:4.000000 ) ( 1.000000:3.000000 ) ( 6.000000:3.000000 ) ( 6.000000:0.000000 ) ( 7.000000:0.000000 ) ( 7.000000:7.000000 ) ( 5.000000:9.000000 ) ( 2.000000:9.000000 ) ( 0.000000:7.000000 ) ( 0.000000:0.000000 ) )
     a_C=list(  ( 7.000000:3.000000 ) ( 6.000000:3.000000 ) ( 6.000000:2.500000 ) ( 4.500000:1.000000 ) ( 2.500000:1.000000 ) ( 1.000000:2.500000 ) ( 1.000000:6.500000 ) ( 2.500000:8.000000 ) ( 4.500000:8.000000 ) ( 6.000000:6.500000 ) ( 6.000000:6.000000 ) ( 7.000000:6.000000 ) ( 7.000000:7.000000 ) ( 5.000000:9.000000 ) ( 2.000000:9.000000 ) ( 0.000000:7.000000 ) ( 0.000000:2.000000 ) ( 2.000000:0.000000 ) ( 5.000000:0.000000 ) ( 7.000000:2.000000 ) )
     a_D=list(  ( 7.000000:7.000000 ) ( 5.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:8.000000 ) ( 4.500000:8.000000 ) ( 6.000000:6.500000 ) ( 6.000000:2.500000 ) ( 4.500000:1.000000 ) ( 1.000000:1.000000 ) ( 1.000000:0.000000 ) ( 5.000000:0.000000 ) ( 7.000000:2.000000 ) )
     a_E=list(  ( 6.000000:1.000000 ) ( 1.000000:1.000000 ) ( 1.000000:4.000000 ) ( 4.000000:4.000000 ) ( 4.000000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:8.000000 ) ( 6.000000:8.000000 ) ( 6.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) ( 6.000000:0.000000 ) )
     a_F=list(  ( 1.000000:1.000000 ) ( 1.000000:1.000000 ) ( 1.000000:4.000000 ) ( 4.000000:4.000000 ) ( 4.000000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:8.000000 ) ( 6.000000:8.000000 ) ( 6.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) )
     a_G=list(  ( 7.000000:4.000000 ) ( 4.000000:4.000000 ) ( 4.000000:3.000000 ) ( 6.000000:3.000000 ) ( 6.000000:2.500000 ) ( 4.500000:1.000000 ) ( 2.500000:1.000000 ) ( 1.000000:2.500000 ) ( 1.000000:6.500000 ) ( 2.500000:8.000000 ) ( 4.500000:8.000000 ) ( 6.000000:6.500000 ) ( 6.000000:6.000000 ) ( 7.000000:6.000000 ) ( 7.000000:7.000000 ) ( 5.000000:9.000000 ) ( 2.000000:9.000000 ) ( 0.000000:7.000000 ) ( 0.000000:2.000000 ) ( 2.000000:0.000000 ) ( 5.000000:0.000000 ) ( 7.000000:2.000000 ) )
     a_H=list(  ( 6.000000:9.000000 ) ( 5.000000:9.000000 ) ( 5.000000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:4.000000 ) ( 5.000000:4.000000 ) ( 5.000000:0.000000 ) ( 6.000000:0.000000 ) )
     a_I=list(  ( 0.000000:8.000000 ) ( 1.000000:8.000000 ) ( 1.000000:1.000000 ) ( 0.000000:1.000000 ) ( 0.000000:0.000000 ) ( 3.000000:0.000000 ) ( 3.000000:1.000000 ) ( 2.000000:1.000000 ) ( 2.000000:8.000000 ) ( 3.000000:8.000000 ) ( 3.000000:9.000000 ) ( 0.000000:9.000000 ) )
     a_J=list(  ( 7.000000:9.000000 ) ( 2.000000:9.000000 ) ( 2.000000:8.000000 ) ( 4.000000:8.000000 ) ( 4.000000:1.500000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:3.000000 ) ( 0.000000:3.000000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) ( 5.000000:8.000000 ) ( 7.000000:8.000000 ) )
     a_K=list(  ( 1.000000:0.000000 ) ( 1.000000:4.000000 ) ( 2.500000:4.000000 ) ( 5.000000:1.500000 ) ( 5.000000:0.000000 ) ( 6.000000:0.000000 ) ( 6.000000:2.000000 ) ( 3.500000:4.500000 ) ( 6.000000:7.000000 ) ( 6.000000:9.000000 ) ( 5.000000:9.000000 ) ( 5.000000:7.500000 ) ( 2.500000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) )
     a_L=list(  ( 0.000000:0.000000 ) ( 6.000000:0.000000 ) ( 6.000000:1.000000 ) ( 1.000000:1.000000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) )
     a_M=list(  ( 1.000000:0.000000 ) ( 1.000000:8.000000 ) ( 1.500000:8.000000 ) ( 4.000000:5.500000 ) ( 6.500000:8.000000 ) ( 7.000000:8.000000 ) ( 7.000000:0.000000 ) ( 8.000000:0.000000 ) ( 8.000000:9.000000 ) ( 6.000000:9.000000 ) ( 4.000000:7.000000 ) ( 2.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) )
     a_N=list(  ( 1.000000:0.000000 ) ( 1.000000:6.750000 ) ( 7.000000:0.750000 ) ( 7.000000:0.000000 ) ( 8.000000:0.000000 ) ( 8.000000:9.000000 ) ( 7.000000:9.000000 ) ( 7.000000:2.250000 ) ( 1.000000:8.250000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) )
     a_P=list(  ( 6.000000:6.500000 ) ( 5.000000:6.500000 ) ( 5.000000:5.750000 ) ( 4.250000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:8.000000 ) ( 4.250000:8.000000 ) ( 5.000000:7.250000 ) ( 5.000000:6.500000 ) ( 6.000000:6.500000 ) ( 6.000000:7.500000 ) ( 4.500000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:1.000000 ) ( 1.000000:1.000000 ) ( 1.000000:4.000000 ) ( 4.500000:4.000000 ) ( 6.000000:5.500000 ) )
     a_Q=list(  ( 7.000000:2.000000 ) ( 6.500000:1.500000 ) ( 7.000000:1.000000 ) ( 7.000000:0.750000 ) ( 7.000000:0.000000 ) ( 6.500000:0.000000 ) ( 5.750000:0.750000 ) ( 5.000000:0.000000 ) ( 2.000000:0.000000 ) ( 0.000000:2.000000 ) ( 0.000000:7.000000 ) ( 2.000000:9.000000 ) ( 5.000000:9.000000 ) ( 7.000000:7.000000 ) ( 7.000000:4.500000 ) ( 6.000000:4.500000 ) ( 6.000000:6.500000 ) ( 4.500000:8.000000 ) ( 2.500000:8.000000 ) ( 1.000000:6.500000 ) ( 1.000000:2.500000 ) ( 2.500000:1.000000 ) ( 4.500000:1.000000 ) ( 5.000000:1.500000 ) ( 4.000000:2.500000 ) ( 4.000000:3.000000 ) ( 5.000000:3.000000 ) ( 5.750000:2.250000 ) ( 6.000000:2.500000 ) ( 6.000000:4.500000 ) ( 7.000000:4.500000 ) )
     a_R=list(  ( 6.000000:3.500000 ) ( 5.000000:4.500000 ) ( 6.000000:5.500000 ) ( 6.000000:7.500000 ) ( 4.500000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:8.000000 ) ( 4.250000:8.000000 ) ( 5.000000:7.250000 ) ( 5.000000:5.750000 ) ( 4.250000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:4.000000 ) ( 4.250000:4.000000 ) ( 5.000000:3.250000 ) ( 5.000000:0.000000 ) ( 6.000000:0.000000 ) )
     a_S=list(  ( 6.000000:8.000000 ) ( 5.000000:9.000000 ) ( 1.000000:9.000000 ) ( 0.000000:8.000000 ) ( 0.000000:5.000000 ) ( 1.000000:4.000000 ) ( 4.500000:4.000000 ) ( 5.000000:3.500000 ) ( 5.000000:1.500000 ) ( 4.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:2.250000 ) ( 0.000000:2.250000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 5.000000:0.000000 ) ( 6.000000:1.000000 ) ( 6.000000:4.000000 ) ( 5.000000:5.000000 ) ( 1.500000:5.000000 ) ( 1.000000:5.500000 ) ( 1.000000:7.500000 ) ( 1.500000:8.000000 ) ( 4.500000:8.000000 ) ( 5.000000:7.500000 ) ( 5.000000:6.750000 ) ( 6.000000:6.750000 ) )
     a_T=list(  ( 0.000000:8.000000 ) ( 3.000000:8.000000 ) ( 3.000000:0.000000 ) ( 4.000000:0.000000 ) ( 4.000000:8.000000 ) ( 7.000000:8.000000 ) ( 7.000000:9.000000 ) ( 0.000000:9.000000 ) )
     a_U=list(  ( 7.000000:9.000000 ) ( 6.000000:9.000000 ) ( 6.000000:2.500000 ) ( 4.500000:1.000000 ) ( 2.500000:1.000000 ) ( 1.000000:2.500000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:2.000000 ) ( 2.000000:0.000000 ) ( 5.000000:0.000000 ) ( 7.000000:2.000000 ) )
     a_O=list(  ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) ( 0.000000:2.000000 ) ( 2.000000:0.000000 ) ( 5.000000:0.000000 ) ( 7.000000:2.000000 ) ( 7.000000:7.000000 ) ( 5.000000:9.000000 ) ( 2.000000:9.000000 ) ( 0.000000:7.000000 ) ( 0.000000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:6.500000 ) ( 2.500000:8.000000 ) ( 4.500000:8.000000 ) ( 6.000000:6.500000 ) ( 6.000000:2.500000 ) ( 4.500000:1.000000 ) ( 2.500000:1.000000 ) ( 1.000000:2.500000 ) )
     a_V=list(  ( 7.000000:9.000000 ) ( 6.000000:9.000000 ) ( 6.000000:3.500000 ) ( 3.500000:1.000000 ) ( 3.500000:1.000000 ) ( 1.000000:3.500000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:3.000000 ) ( 3.000000:0.000000 ) ( 4.000000:0.000000 ) ( 7.000000:3.000000 ) )
     a_W=list(  ( 1.000000:9.000000 ) ( 1.000000:1.000000 ) ( 1.500000:1.000000 ) ( 4.000000:3.500000 ) ( 6.500000:1.000000 ) ( 7.000000:1.000000 ) ( 7.000000:9.000000 ) ( 8.000000:9.000000 ) ( 8.000000:0.000000 ) ( 6.000000:0.000000 ) ( 4.000000:2.000000 ) ( 2.000000:0.000000 ) ( 0.000000:0.000000 ) ( 0.000000:9.000000 ) )
     a_X=list(  ( 7.000000:1.750000 ) ( 4.250000:4.500000 ) ( 7.000000:7.250000 ) ( 7.000000:9.000000 ) ( 6.000000:9.000000 ) ( 6.000000:7.750000 ) ( 3.500000:5.250000 ) ( 1.000000:7.750000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:7.250000 ) ( 2.750000:4.500000 ) ( 0.000000:1.750000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:1.250000 ) ( 3.500000:3.750000 ) ( 6.000000:1.250000 ) ( 6.000000:0.000000 ) ( 7.000000:0.000000 ) )
     a_Y=list(  ( 7.000000:9.000000 ) ( 6.000000:9.000000 ) ( 6.000000:7.750000 ) ( 3.500000:5.250000 ) ( 1.000000:7.750000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:7.250000 ) ( 3.000000:4.250000 ) ( 3.000000:0.000000 ) ( 4.000000:0.000000 ) ( 4.000000:4.250000 ) ( 7.000000:7.250000 ) )
     a_a=list(  ( 5.000000:0.000000 ) ( 5.000000:2.500000 ) ( 4.000000:2.500000 ) ( 4.000000:1.750000 ) ( 3.250000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:3.500000 ) ( 1.500000:4.000000 ) ( 3.250000:4.000000 ) ( 4.000000:3.250000 ) ( 4.000000:2.500000 ) ( 5.000000:2.500000 ) ( 5.000000:5.000000 ) ( 4.000000:5.000000 ) ( 4.000000:4.500000 ) ( 3.500000:5.000000 ) ( 1.000000:5.000000 ) ( 0.000000:4.000000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 3.500000:0.000000 ) ( 4.000000:0.500000 ) ( 4.000000:0.500000 ) ( 4.000000:0.000000 ) )
     a_b=list(  ( 0.000000:0.000000 ) ( 0.000000:2.500000 ) ( 1.000000:2.500000 ) ( 1.000000:1.750000 ) ( 1.750000:1.000000 ) ( 3.500000:1.000000 ) ( 4.000000:1.500000 ) ( 4.000000:3.500000 ) ( 3.500000:4.000000 ) ( 1.750000:4.000000 ) ( 1.000000:3.250000 ) ( 1.000000:2.500000 ) ( 0.000000:2.500000 ) ( 0.000000:9.000000 ) ( 1.000000:9.000000 ) ( 1.000000:4.500000 ) ( 1.500000:5.000000 ) ( 4.000000:5.000000 ) ( 5.000000:4.000000 ) ( 5.000000:1.000000 ) ( 4.000000:0.000000 ) ( 1.500000:0.000000 ) ( 1.000000:0.500000 ) ( 1.000000:0.500000 ) ( 1.000000:0.000000 ) )
     a_c=list(  ( 5.000000:1.000000 ) ( 4.000000:0.000000 ) ( 1.000000:0.000000 ) ( 0.000000:1.000000 ) ( 0.000000:4.000000 ) ( 1.000000:5.000000 ) ( 4.000000:5.000000 ) ( 5.000000:4.000000 ) ( 5.000000:3.000000 ) ( 4.000000:3.000000 ) ( 4.000000:3.500000 ) ( 3.500000:4.000000 ) ( 1.500000:4.000000 ) ( 1.000000:3.500000 ) ( 1.000000:1.500000 ) ( 1.500000:1.000000 ) ( 3.500000:1.000000 ) ( 4.000000:1.500000 ) ( 4.000000:2.000000 ) ( 5.000000:2.000000 ) )
     a_d=list(  ( 5.000000:0.000000 ) ( 5.000000:2.500000 ) ( 4.000000:2.500000 ) ( 4.000000:1.750000 ) ( 3.250000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:3.500000 ) ( 1.500000:4.000000 ) ( 3.250000:4.000000 ) ( 4.000000:3.250000 ) ( 4.000000:2.500000 ) ( 5.000000:2.500000 ) ( 5.000000:9.000000 ) ( 4.000000:9.000000 ) ( 4.000000:4.500000 ) ( 3.500000:5.000000 ) ( 1.000000:5.000000 ) ( 0.000000:4.000000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 3.500000:0.000000 ) ( 4.000000:0.500000 ) ( 4.000000:0.500000 ) ( 4.000000:0.000000 ) )
     a_e=list(  ( 5.000000:1.500000 ) ( 4.000000:1.500000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:3.500000 ) ( 1.500000:4.000000 ) ( 3.500000:4.000000 ) ( 4.000000:3.500000 ) ( 4.000000:3.000000 ) ( 1.000000:3.000000 ) ( 1.000000:2.000000 ) ( 5.000000:2.000000 ) ( 5.000000:4.000000 ) ( 4.000000:5.000000 ) ( 1.000000:5.000000 ) ( 0.000000:4.000000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) )
     a_f=list(  ( 2.000000:0.000000 ) ( 2.000000:4.000000 ) ( 3.000000:4.000000 ) ( 3.000000:5.000000 ) ( 2.000000:5.000000 ) ( 2.000000:7.500000 ) ( 2.500000:8.000000 ) ( 3.500000:8.000000 ) ( 4.000000:7.500000 ) ( 4.000000:7.000000 ) ( 5.000000:7.000000 ) ( 5.000000:8.000000 ) ( 4.000000:9.000000 ) ( 2.000000:9.000000 ) ( 1.000000:8.000000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) ( 0.000000:4.000000 ) ( 1.000000:4.000000 ) ( 1.000000:0.000000 ) )
     a_g=list(  ( 5.000000:4.000000 ) ( 4.000000:4.000000 ) ( 4.000000:3.750000 ) ( 3.500000:3.250000 ) ( 1.500000:3.250000 ) ( 1.000000:3.750000 ) ( 1.000000:4.500000 ) ( 1.500000:5.000000 ) ( 3.500000:5.000000 ) ( 4.000000:4.500000 ) ( 4.000000:4.000000 ) ( 5.000000:4.000000 ) ( 5.000000:5.000000 ) ( 4.000000:6.000000 ) ( 1.000000:6.000000 ) ( 0.000000:5.000000 ) ( 0.000000:3.250000 ) ( 1.000000:2.250000 ) ( 4.000000:2.250000 ) ( 4.000000:1.500000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:1.750000 ) ( 0.000000:1.750000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) )
     a_h=list(  ( 5.000000:4.000000 ) ( 4.000000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:3.500000 ) ( 1.500000:4.000000 ) ( 3.500000:4.000000 ) ( 4.000000:3.500000 ) ( 4.000000:0.000000 ) ( 5.000000:0.000000 ) )
     a_i=list(  ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) )
     a_j=list(  ( 5.000000:6.000000 ) ( 4.000000:6.000000 ) ( 4.000000:1.500000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:2.000000 ) ( 0.000000:2.000000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) )
     a_k=list(  ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:2.000000 ) ( 3.000000:0.000000 ) ( 4.000000:0.000000 ) ( 4.000000:0.500000 ) ( 2.000000:2.500000 ) ( 4.000000:4.500000 ) ( 4.000000:5.500000 ) ( 3.500000:5.500000 ) ( 1.000000:3.000000 ) ( 1.000000:9.000000 ) ( 0.000000:9.000000 ) )
     a_l=list(  ( 2.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:8.000000 ) ( 1.000000:8.000000 ) ( 1.000000:0.000000 ) ( 2.000000:0.000000 ) )
     a_m=list(  ( 6.000000:4.000000 ) ( 5.000000:5.000000 ) ( 3.500000:5.000000 ) ( 3.000000:4.500000 ) ( 2.500000:5.000000 ) ( 1.500000:5.000000 ) ( 1.000000:4.500000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:3.000000 ) ( 1.000000:3.250000 ) ( 1.750000:4.000000 ) ( 2.000000:4.000000 ) ( 2.500000:3.500000 ) ( 2.500000:0.000000 ) ( 3.500000:0.000000 ) ( 3.500000:3.500000 ) ( 4.000000:4.000000 ) ( 4.500000:4.000000 ) ( 5.000000:3.500000 ) ( 5.000000:3.000000 ) ( 5.000000:0.000000 ) ( 6.000000:0.000000 ) )
     a_n=list(  ( 5.000000:4.000000 ) ( 4.000000:5.000000 ) ( 1.500000:5.000000 ) ( 1.000000:4.500000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:3.250000 ) ( 1.750000:4.000000 ) ( 3.500000:4.000000 ) ( 4.000000:3.500000 ) ( 4.000000:0.000000 ) ( 5.000000:0.000000 ) )
     a_o=list(  ( 5.000000:1.000000 ) ( 4.000000:0.000000 ) ( 1.000000:0.000000 ) ( 0.000000:1.000000 ) ( 0.000000:4.000000 ) ( 1.000000:5.000000 ) ( 4.000000:5.000000 ) ( 5.000000:4.000000 ) ( 5.000000:2.500000 ) ( 4.000000:2.500000 ) ( 4.000000:3.500000 ) ( 3.500000:4.000000 ) ( 1.500000:4.000000 ) ( 1.000000:3.500000 ) ( 1.000000:1.500000 ) ( 1.500000:1.000000 ) ( 3.500000:1.000000 ) ( 4.000000:1.500000 ) ( 4.000000:2.500000 ) ( 5.000000:2.500000 ) )
     a_p=list(  ( 0.000000:7.000000 ) ( 0.000000:4.500000 ) ( 1.000000:4.500000 ) ( 1.000000:5.250000 ) ( 1.750000:6.000000 ) ( 3.500000:6.000000 ) ( 4.000000:5.500000 ) ( 4.000000:3.500000 ) ( 3.500000:3.000000 ) ( 1.750000:3.000000 ) ( 1.000000:3.750000 ) ( 1.000000:4.500000 ) ( 0.000000:4.500000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:2.500000 ) ( 1.500000:2.000000 ) ( 4.000000:2.000000 ) ( 5.000000:3.000000 ) ( 5.000000:6.000000 ) ( 4.000000:7.000000 ) ( 1.500000:7.000000 ) ( 1.000000:6.500000 ) ( 1.000000:6.500000 ) ( 1.000000:7.000000 ) )
     a_q=list(  ( 5.000000:7.000000 ) ( 5.000000:4.500000 ) ( 4.000000:4.500000 ) ( 4.000000:5.250000 ) ( 3.250000:6.000000 ) ( 1.500000:6.000000 ) ( 1.000000:5.500000 ) ( 1.000000:3.500000 ) ( 1.500000:3.000000 ) ( 3.250000:3.000000 ) ( 4.000000:3.750000 ) ( 4.000000:4.500000 ) ( 5.000000:4.500000 ) ( 5.000000:0.000000 ) ( 4.000000:0.000000 ) ( 4.000000:2.500000 ) ( 3.500000:2.000000 ) ( 1.000000:2.000000 ) ( 0.000000:3.000000 ) ( 0.000000:6.000000 ) ( 1.000000:7.000000 ) ( 3.500000:7.000000 ) ( 4.000000:6.500000 ) ( 4.000000:6.500000 ) ( 4.000000:7.000000 ) )
     a_r=list(  ( 4.000000:5.000000 ) ( 1.750000:5.000000 ) ( 1.000000:4.250000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:3.000000 ) ( 2.000000:4.000000 ) ( 4.000000:4.000000 ) )
     a_s=list(  ( 5.000000:2.000000 ) ( 4.000000:3.000000 ) ( 1.500000:3.000000 ) ( 1.250000:3.000000 ) ( 1.000000:3.250000 ) ( 1.000000:3.750000 ) ( 1.250000:4.000000 ) ( 1.500000:4.000000 ) ( 3.500000:4.000000 ) ( 3.750000:4.000000 ) ( 4.000000:3.750000 ) ( 4.000000:3.500000 ) ( 5.000000:3.500000 ) ( 5.000000:4.000000 ) ( 4.000000:5.000000 ) ( 1.000000:5.000000 ) ( 0.000000:4.000000 ) ( 0.000000:3.000000 ) ( 1.000000:2.000000 ) ( 3.500000:2.000000 ) ( 3.750000:2.000000 ) ( 4.000000:1.750000 ) ( 4.000000:1.250000 ) ( 3.750000:1.000000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.250000:1.000000 ) ( 1.000000:1.250000 ) ( 1.000000:1.500000 ) ( 0.000000:1.500000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) )
     a_u=list(  ( 5.000000:5.000000 ) ( 4.000000:5.000000 ) ( 4.000000:1.500000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) )
     a_v=list(  ( 5.000000:5.000000 ) ( 4.000000:5.000000 ) ( 4.000000:2.500000 ) ( 2.500000:1.000000 ) ( 2.500000:1.000000 ) ( 1.000000:2.500000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) ( 0.000000:2.000000 ) ( 2.000000:0.000000 ) ( 3.000000:0.000000 ) ( 5.000000:2.000000 ) )
     a_w=list(  ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 2.500000:0.000000 ) ( 3.000000:0.500000 ) ( 3.500000:0.000000 ) ( 4.500000:0.000000 ) ( 5.000000:0.000000 ) ( 6.000000:1.000000 ) ( 6.000000:5.000000 ) ( 5.000000:5.000000 ) ( 5.000000:1.500000 ) ( 4.500000:1.000000 ) ( 4.000000:1.000000 ) ( 3.500000:1.500000 ) ( 3.500000:5.000000 ) ( 2.500000:5.000000 ) ( 2.500000:1.500000 ) ( 2.000000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:2.000000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) )
     a_x=list(  ( 0.000000:4.000000 ) ( 1.500000:2.500000 ) ( 0.000000:1.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:0.500000 ) ( 2.500000:2.000000 ) ( 4.000000:0.500000 ) ( 4.000000:0.000000 ) ( 5.000000:0.000000 ) ( 5.000000:1.000000 ) ( 3.500000:2.500000 ) ( 5.000000:4.000000 ) ( 5.000000:5.000000 ) ( 4.000000:5.000000 ) ( 4.000000:4.500000 ) ( 2.500000:3.000000 ) ( 1.000000:4.500000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) )
     a_y=list(  ( 5.000000:6.000000 ) ( 4.000000:6.000000 ) ( 4.000000:4.000000 ) ( 3.500000:3.500000 ) ( 1.500000:3.500000 ) ( 1.000000:4.000000 ) ( 1.000000:6.000000 ) ( 0.000000:6.000000 ) ( 0.000000:3.500000 ) ( 1.000000:2.500000 ) ( 4.000000:2.500000 ) ( 4.000000:1.500000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:1.750000 ) ( 0.000000:1.750000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) )
     a_0=list(  ( 6.000000:5.250000 ) ( 5.000000:5.250000 ) ( 5.000000:3.250000 ) ( 1.375000:6.875000 ) ( 2.500000:8.000000 ) ( 3.500000:8.000000 ) ( 5.000000:6.500000 ) ( 5.000000:5.250000 ) ( 6.000000:5.250000 ) ( 6.000000:7.000000 ) ( 4.000000:9.000000 ) ( 2.000000:9.000000 ) ( 0.000000:7.000000 ) ( 0.000000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:5.750000 ) ( 4.625000:2.125000 ) ( 3.500000:1.000000 ) ( 2.500000:1.000000 ) ( 1.000000:2.500000 ) ( 1.000000:5.000000 ) ( 0.000000:5.000000 ) ( 0.000000:2.000000 ) ( 2.000000:0.000000 ) ( 4.000000:0.000000 ) ( 6.000000:2.000000 ) )
     a_1=list(  ( 1.000000:7.000000 ) ( 1.000000:1.000000 ) ( 0.000000:1.000000 ) ( 0.000000:0.000000 ) ( 3.000000:0.000000 ) ( 3.000000:1.000000 ) ( 2.000000:1.000000 ) ( 2.000000:9.000000 ) ( 1.000000:9.000000 ) ( 0.000000:8.000000 ) ( 0.000000:7.000000 ) )
     a_2=list(  ( 1.000000:6.000000 ) ( 1.000000:7.000000 ) ( 2.000000:8.000000 ) ( 3.000000:8.000000 ) ( 4.000000:7.000000 ) ( 4.000000:6.000000 ) ( 0.000000:2.000000 ) ( 0.000000:0.000000 ) ( 5.000000:0.000000 ) ( 5.000000:1.000000 ) ( 1.000000:1.000000 ) ( 1.000000:1.500000 ) ( 5.000000:5.500000 ) ( 5.000000:7.500000 ) ( 3.500000:9.000000 ) ( 1.500000:9.000000 ) ( 0.000000:7.500000 ) ( 0.000000:6.000000 ) )
     a_3=list(  ( 1.000000:6.500000 ) ( 1.000000:7.500000 ) ( 1.500000:8.000000 ) ( 3.500000:8.000000 ) ( 4.000000:7.500000 ) ( 4.000000:6.000000 ) ( 3.000000:5.000000 ) ( 2.000000:5.000000 ) ( 2.000000:4.000000 ) ( 3.000000:4.000000 ) ( 4.000000:3.000000 ) ( 4.000000:1.500000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:2.500000 ) ( 0.000000:2.500000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) ( 5.000000:3.500000 ) ( 4.000000:4.500000 ) ( 5.000000:5.500000 ) ( 5.000000:8.000000 ) ( 4.000000:9.000000 ) ( 1.000000:9.000000 ) ( 0.000000:8.000000 ) ( 0.000000:6.500000 ) )
     a_4=list(  ( 1.000000:4.000000 ) ( 1.000000:5.000000 ) ( 3.500000:7.500000 ) ( 3.500000:5.000000 ) ( 1.000000:5.000000 ) ( 1.000000:4.000000 ) ( 3.500000:4.000000 ) ( 3.500000:0.000000 ) ( 4.500000:0.000000 ) ( 4.500000:4.000000 ) ( 5.500000:4.000000 ) ( 5.500000:5.000000 ) ( 4.500000:5.000000 ) ( 4.500000:9.000000 ) ( 3.500000:9.000000 ) ( 0.000000:5.500000 ) ( 0.000000:4.000000 ) )
     a_5=list(  ( 5.000000:8.000000 ) ( 1.000000:8.000000 ) ( 1.000000:5.000000 ) ( 4.000000:5.000000 ) ( 5.000000:4.000000 ) ( 5.000000:1.000000 ) ( 4.000000:0.000000 ) ( 1.000000:0.000000 ) ( 0.000000:1.000000 ) ( 0.000000:2.000000 ) ( 1.000000:2.000000 ) ( 1.000000:1.500000 ) ( 1.500000:1.000000 ) ( 3.500000:1.000000 ) ( 4.000000:1.500000 ) ( 4.000000:3.500000 ) ( 3.500000:4.000000 ) ( 0.000000:4.000000 ) ( 0.000000:9.000000 ) ( 5.000000:9.000000 ) )
     a_6=list(  ( 4.000000:7.000000 ) ( 4.000000:7.500000 ) ( 3.500000:8.000000 ) ( 1.500000:8.000000 ) ( 1.000000:7.500000 ) ( 1.000000:5.000000 ) ( 4.000000:5.000000 ) ( 5.000000:4.000000 ) ( 5.000000:2.500000 ) ( 4.000000:2.500000 ) ( 4.000000:3.500000 ) ( 3.500000:4.000000 ) ( 1.500000:4.000000 ) ( 1.000000:3.500000 ) ( 1.000000:1.500000 ) ( 1.500000:1.000000 ) ( 3.500000:1.000000 ) ( 4.000000:1.500000 ) ( 4.000000:2.500000 ) ( 5.000000:2.500000 ) ( 5.000000:1.000000 ) ( 4.000000:0.000000 ) ( 1.000000:0.000000 ) ( 0.000000:1.000000 ) ( 0.000000:8.000000 ) ( 1.000000:9.000000 ) ( 4.000000:9.000000 ) ( 5.000000:8.000000 ) ( 5.000000:7.000000 ) )
     a_7=list(  ( 1.000000:7.000000 ) ( 1.000000:8.000000 ) ( 4.000000:8.000000 ) ( 4.000000:7.000000 ) ( 0.000000:3.000000 ) ( 0.000000:0.000000 ) ( 1.000000:0.000000 ) ( 1.000000:2.500000 ) ( 5.000000:6.500000 ) ( 5.000000:9.000000 ) ( 0.000000:9.000000 ) ( 0.000000:7.000000 ) )
     a_8=list(  ( 4.000000:6.500000 ) ( 4.000000:7.500000 ) ( 3.500000:8.000000 ) ( 1.500000:8.000000 ) ( 1.000000:7.500000 ) ( 1.000000:5.500000 ) ( 1.500000:5.000000 ) ( 3.500000:5.000000 ) ( 4.000000:5.500000 ) ( 4.000000:6.500000 ) ( 5.000000:6.500000 ) ( 5.000000:5.000000 ) ( 4.500000:4.500000 ) ( 5.000000:4.000000 ) ( 5.000000:2.500000 ) ( 4.000000:2.500000 ) ( 4.000000:3.500000 ) ( 3.500000:4.000000 ) ( 1.500000:4.000000 ) ( 1.000000:3.500000 ) ( 1.000000:1.500000 ) ( 1.500000:1.000000 ) ( 3.500000:1.000000 ) ( 4.000000:1.500000 ) ( 4.000000:2.500000 ) ( 5.000000:2.500000 ) ( 5.000000:1.000000 ) ( 4.000000:0.000000 ) ( 1.000000:0.000000 ) ( 0.000000:1.000000 ) ( 0.000000:4.000000 ) ( 0.500000:4.500000 ) ( 0.000000:5.000000 ) ( 0.000000:8.000000 ) ( 1.000000:9.000000 ) ( 4.000000:9.000000 ) ( 5.000000:8.000000 ) ( 5.000000:6.500000 ) )
     a_9=list(  ( 0.000000:8.000000 ) ( 0.000000:7.000000 ) ( 1.000000:7.000000 ) ( 1.000000:7.500000 ) ( 1.500000:8.000000 ) ( 3.500000:8.000000 ) ( 4.000000:7.500000 ) ( 4.000000:5.500000 ) ( 3.500000:5.000000 ) ( 1.500000:5.000000 ) ( 1.000000:5.500000 ) ( 1.000000:7.000000 ) ( 0.000000:7.000000 ) ( 0.000000:5.000000 ) ( 1.000000:4.000000 ) ( 4.000000:4.000000 ) ( 4.000000:1.500000 ) ( 3.500000:1.000000 ) ( 1.500000:1.000000 ) ( 1.000000:1.500000 ) ( 1.000000:2.000000 ) ( 0.000000:2.000000 ) ( 0.000000:1.000000 ) ( 1.000000:0.000000 ) ( 4.000000:0.000000 ) ( 5.000000:1.000000 ) ( 5.000000:8.000000 ) ( 4.000000:9.000000 ) ( 1.000000:9.000000 ) )
     a_Z=list(  ( 0.000000:1.750000 ) ( 6.000000:7.750000 ) ( 6.000000:8.000000 ) ( 1.000000:8.000000 ) ( 1.000000:7.000000 ) ( 0.000000:7.000000 ) ( 0.000000:9.000000 ) ( 7.000000:9.000000 ) ( 7.000000:7.250000 ) ( 1.000000:1.250000 ) ( 1.000000:1.000000 ) ( 6.000000:1.000000 ) ( 6.000000:2.000000 ) ( 7.000000:2.000000 ) ( 7.000000:0.000000 ) ( 0.000000:0.000000 ) )
     a_z=list(  ( 0.000000:5.000000 ) ( 4.000000:5.000000 ) ( 4.000000:4.000000 ) ( 4.000000:4.000000 ) ( 1.000000:1.000000 ) ( 4.000000:1.000000 ) ( 4.000000:0.000000 ) ( 0.000000:0.000000 ) ( 0.000000:1.250000 ) ( 2.750000:4.000000 ) ( 0.000000:4.000000 ) )
     a_t=list(  ( 4.000000:6.000000 ) ( 2.500000:6.000000 ) ( 2.500000:9.000000 ) ( 1.500000:9.000000 ) ( 1.500000:6.000000 ) ( 0.000000:6.000000 ) ( 0.000000:5.000000 ) ( 1.500000:5.000000 ) ( 1.500000:0.000000 ) ( 2.500000:0.000000 ) ( 2.500000:5.000000 ) ( 4.000000:5.000000 ) )
     a_?=list(  ( 1.000000:6.750000 ) ( 1.000000:7.500000 ) ( 1.500000:8.000000 ) ( 3.500000:8.000000 ) ( 4.000000:7.500000 ) ( 4.000000:5.250000 ) ( 2.000000:3.250000 ) ( 2.000000:0.000000 ) ( 3.000000:0.000000 ) ( 3.000000:3.000000 ) ( 5.000000:5.000000 ) ( 5.000000:8.000000 ) ( 4.000000:9.000000 ) ( 1.000000:9.000000 ) ( 0.000000:8.000000 ) ( 0.000000:6.750000 ) )

     procedure( PGtext()
     prog( ( str mag crd cnt char crds ocrds xcrd
         ycrd ocrds opoint obj objlist letterWidth )

         if( !boundp( 'activeLayList ) then
           activeLayList=list( "" )
          )
         laylistmsg=""
         foreach( llay activeLayList
            sprintf( laylistmsg "%s %s", laylistmsg llay )
          )

         hiEdgeMakeForm( "PGtext info..."
            list( 'str "Input text string" "string" "PART NUMBER" )
            list( 'mag "Input text magnification, ( a mag of 1.0 = text 9.0 microns tall )" "string" "1" )
            list( 'buildOn "Current active layer list for PGtext." "string" laylistmsg )
          )

         foreach( ss geGetSelSet( hiGetCurrentWindow() )
            geDeselectObject( ss )
          )

         mag=float( evalstring( mag ) )
         activeLayList=string2List( buildOn )

         oricrd=enterPoint(  ?prompts list( "Point to lower left corner of text" ) )

         objlist=nil

         foreach( multil activeLayList
            if( multil != nil then
               crd=oricrd
               cnt=0
               while( cnt
                    cnt=cnt+1
                    char=substring( str cnt 1 )
                    if( char!=" " then
                        sprintf( char "%s%s" PGtextPreFix char )
                        if( !boundp( concat( char ) ) then
                            hiGetAttention()
                           println( "no symbol defined for character %s" char )
                            if(  ( atom objlist ) ( dbDeleteObject objlist ) ( mapcar '( lambda ( x ) ( dbDeleteObject x ) )  objlist )  )
                            return( nil )
                         )
                        crds=eval( concat( char ) )
                        ocrds=nil
                        foreach( point crds
                            xcrd=mag*car( point )
                            xcrd=float( round( xcrd/PGtextGrid ) )*PGtextGrid
                            ycrd=mag*cadr( point )
                            ycrd=float( round( ycrd/PGtextGrid ) )*PGtextGrid
                            opoint=list( ( xcrd+car( crd ) ) ( ycrd+cadr( crd ) ) )
                            ocrds=cons( opoint ocrds )
                         )
                        obj=dbCreatePolygon(  getEditRep() list( multil "drawing" ) ocrds  )
                       dbReplaceProp( obj "STREAM PROPERTY 1" "string"
                                substring( char strlen( char ) strlen( char ) ) )
                        objlist=cons( obj objlist )
                        letterWidth=car( cadr( obj~>bBox ) )-car( car( obj~>bBox ) )
                     )
                    spacing=float( round( ( mag*PGtextSpacing )/PGtextGrid ) )*PGtextGrid
                    crd=list( ( car( crd )+letterWidth+spacing ) cadr( crd ) )
                )
               foreach( ss objlist
                  geSelectObject( ss )
                )
             )
          )
      ) )



     ; Procedure:    makeLetter

     procedure( makeLetter( @optional charName PGtextFile "tt" )
     prog( ( crds offset xo yo str )
         if( length( geGetSelSet(  hiGetCurrentWindow() ) )!=1 then
              hiGetAttention()
             println( "you must have exactly one item selected" )
              return( nil )
          )
         if( car( geGetSelSet(  hiGetCurrentWindow() ) )~>type!="geomInst" then
              hiGetAttention()
             println( "selected item must be a polygon" )
              return( nil )
         else if( car( geGetSelSet(  hiGetCurrentWindow() ) )~>shape!="polygon" then
              hiGetAttention()
             println( "selected item must be a polygon" )
              return( nil )
          ) )
         if( !charName then charName=textEntry( "input character" ) )
         if( !PGtextFile then PGtextFile=textEntry( "output file" ) )
         if( strlen( charName )!=1 then
              hiGetAttention()
             println( "must input exactly one character" )
              return( nil )
          )
         if( isFile( PGtextFile ) then
              port=outfile( PGtextFile "a" )
         else
              port=outfile( PGtextFile "w" )
          )
         crds=car( geGetSelSet(  hiGetCurrentWindow() ) )~>path
         offset=car( car( geGetSelSet(  hiGetCurrentWindow() ) )~>bBox )
         xo=car( offset )
         yo=cadr( offset )
         sprintf( str "%s%s=list( " PGtextPreFix charName )
         foreach( crd crds
              sprintf( str "%s ( %f:%f )" str ( car( crd ) - xo ) ( cadr( crd ) - yo ) )
          )
         sprintf( str "%s )\n" str )
         fprintf( port "%s" str )
         close( port )
      ) )

     /*
     This function takes a string of white-space separated words, and converts
     it to a list of strings which it then returns.

              input:          theString -- string
              return:         tmpList -- list of strings
     */

     procedure(  string2List(  theString  )
         prog(  ( first last char tmpList done )

             ;***** initialize the string and the character indexes into the string
              tmpList = nil
              first = 1
              last = 1
             if( theString == nil then ;***** check to see if nil string was provided
                  return( nil )
               )
             ;***** while there are characters in the string
             while(  ( char = getchar( theString first ) ) != nil
                 ;***** if character is "whitespace" go for next one
                  if(  ( char == '\  ) || ( char == '\t ) || ( char == '\n ) then
                      first = first + 1
                 else ;***** otherwise look for the last character in the word
                      last = first + 1
                      done = nil
                     ;***** while there are characters and we've not encountered
                     ;       whitespace keep looking for the end of word
                      while(  ( ( char = getchar( theString last ) ) != nil  ) && !done
                          if(  ( char == '\  ) || ( char == '\t ) || ( char == '\n ) then
                              done = t
                          else
                              last = last + 1
                           )
                       )
                     ;***** now add the substring to the list
                      if(  tmpList == nil then
                          tmpList = tconc(  nil substring( theString first ( last - first ) ) )
                      else
                          tconc(  tmpList substring( theString first ( last - first ) ) )
                       )
                      first = last
                   )
               )
              return(  car( tmpList )  )
          )
      )

     /* End of Script  */