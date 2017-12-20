procedure( uwlSpiralPaths( inner outer width space nc)
  let( ( n nq ns nx xo x y chCos chSin c r twopi d pointLists points

;   compute the number of turns:
    n = (outer - inner) / 2. / (width + space)

;   compute number of quarter turns and sides per quarter turn:
    nq = fix( n * 4)
    ns = fix( nc / 4)

;   calculate some intermediate parameters:
    twopi = 2 * 3.1415926
    d = twopi / nc           ;nc is number of chords per 360 degrees
    chCos = cos( d)
    chSin = sin( d)
    c = (width + space) / nc
    r = outer * .5

;   build the point lists:
    pointLists = nil
    x = r
    y = 0.
    points = list( x:y x+width+space:y)
    for( i 1 nq
    nx = ns
    for( j 1 nx
        xo = x
        x = (chCos * xo - chSin * y) * (1. - c / r)
        y = (chCos * y + chSin * xo) * (1. - c / r)
        points = cons( x:y points)
        r = r - c
     )
    pointLists = cons( points pointLists)
    points = list( car( points) cadr( points))
    )
    pointLists       ;the procedure returns this list
  )
)
procedure( uwlMakePin( cv netName figure direction)
    let( ( net trm pin)

    net = dbCreateNet( cv netName)
    trm = dbCreateTerm( net netName "inputOutput")
    pin = dbCreatePin( net figure netName)
    pin~>accessDir = direction
    pin ; return the pin object id
  )
)


;label =  dbCreateLabel(geGetWindowCellView() '("text" "drawing") 0:0 "cdsName()" "lowerLeft" "R0" "stick" 5.0  )
;label~>labelType = "ILLabel"
 