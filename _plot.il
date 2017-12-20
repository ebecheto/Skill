ron1=pv( "MO1" "ron" ?result "dcOpInfo-info")
ron2=pv( "MO2" "ron" ?result "dcOpInfo-info")
sign="<"  when( ron1>ron2 sign=">")
printf("ron12 : %.0f %s %.0f\n" ron1 sign ron2)

when(!(w_windowId=awvGetCurrentWindow()) w_windowId = awvCreatePlotWindow())
x_subwindow = awvAddSubwindow( w_windowId ) 
Imo1=pv( "I0.MO1" "ids" ?result "dcOpInfo-info")
Imo2=pv( "I0.MO2" "ids" ?result "dcOpInfo-info")
plot(Imo2+Imo1)
;; ^ ne marche pas pour DC sweep

Imo1=i( "/I0/MO1/D" ?result "dc-dc" )
Imo2=i( "/I0/MO2/D" ?result "dc-dc" )
plot(Imo2+Imo1)
plot(Imo2-Imo1)

sign="<"  when( ron1>ron2 sign=">")
printf("ron12 : %.0f %s %.0f\n" ron1 sign ron2)
