foreach(void AllVoids    ; voids in shapes on ETCH/BOTTOM LAYER
void_bBox = void->bBox
void_bBox_x1 = xCoord(car(void_bBox))
void_bBox_y1 = yCoord(car(void_bBox))
void_bBox_x2 = xCoord(lastelem(void_bBox))
void_bBox_y2 = yCoord(lastelem(void_bBox))
void_xy = axlDBAltOrigin('center void)

void_size_x = max(void_bBox_x1, void_bBox_x2) - min(void_bBox_x1, void_bBox_x2)
void_size_y = max(void_bBox_y1, void_bBox_y2) - min(void_bBox_y1, void_bBox_y2)

if(void_size_x > minimum_size_shape || void_size_y > minimum_size_shape then

check_area = list(axlMXYSub(car(void_bBox) add_value_list) axlMXYAdd(lastelem(void_bBox) add_value_list))

axlVisibleDesign(nil)
axlVisibleLayer(keepout_layer t) ; ROUTE KEEPOUT/BOTTOM layer
axlShell("redisplay")
axlSetFindFilter(?enabled '(noall Shapes ) ?onButtons '(noall Shapes))
data_in_box = axlGetSelSet(axlSingleSelectBox(check_area))
axlClearSelSet()

if(length(data_in_box) > 0 then
    foreach(item data_in_box
        air_gap = axlAirGap(void item nil 'anyLayer)
        ;if(air_gap < airgap_value then
            ;axlDeleteObject(item)    
            fprintf(writeOutFile "%L %L\n", air_gap, void_xy)
        ;);end if
    );end foreach
);end if
);end if

);end foreach