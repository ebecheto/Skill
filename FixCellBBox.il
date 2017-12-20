procedure(myFixCellBBox(@optional (cv geGetEditCellView()) (quiet nil))
  let((bbox akey textDisplays)
    bbox = cv~>bBox
    ; lowerLeft
    akey = dbCreateRect(cv leGetEntryLayer() list(xCoord(lowerLeft(bbox))-5.0:
      yCoord(lowerLeft(bbox))-5.0 lowerLeft(bbox)))
    when(akey dbDeleteObject(akey) ) ; when
    ; upperRight
    akey = dbCreateRect(cv leGetEntryLayer() list(xCoord(upperRight(bbox))+5.0:
      yCoord(upperRight(bbox))+5.0 upperRight(bbox)))
    when(akey dbDeleteObject(akey) ) ; when
    ;Fix textDisplay bounding boxes
    textDisplays = setof(x cv~>shapes x~>objType=="textDisplay")
    foreach(td textDisplays
        schSetTextDisplayBBox(td nil) ;This also works in layout
    )
    dbComputeBBox(cv)
    akey = dbCreateRect(cv leGetEntryLayer() cv~>bBox)
    when(akey dbDeleteObject(akey) ) ; when
    unless(quiet
        printf("Now execute \"Fit All\" and see if your cell extents are fixed\n")
    )
    t
  ) ; let
)