;; copyleft ebecheto
;ineed('selection2log)

;;USAGE : dummy script that whan you select a rectangle into a layout view, it log the skill command to replay the creation of this rectangle.
; Could be generaliste to a loop on selected sets and check if it is a rectable or a poly line or a path, but too much job. That was jsut for a simple usage in the first attempt..

defun(selection2log (@optional (inst css()) (fname nil))
let((fp libName cellName viewName lpp bBox)
unless(fname fname=sprintf(nil "%s/%s.il" pwd() "layers_log" ) )
fp = outfile(fname "a")
mapcar('setq '(libName cellName viewName)  list(inst~>cellView~>libName inst~>cellView~>cellName inst~>cellView~>viewName))
lpp=inst~>lpp
bBox=inst~>bBox
fprintf(fp "dbCreateRect(dbOpenCellViewByType( %L %L %L \"maskLayout\" \"r\") '%L '%L) \n" libName cellName viewName lpp bBox)
close(fp)
fname))
