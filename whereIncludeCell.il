;; copyleft ebecheto

;pattern=".*_sim"

;; cv= geGetWindowCellView()
;; pattern="^ota$"
;; pattern="ota"
;; pattern="ramp"
;; pattern="nand"
;; views='("schematic" "cmos_sch")
;; cv~>cellName
;; cv~>libName

;pattern;=> ".*_sim"
;(setq libNames ddGetLibList()~>name)
;(setq libNames '("analogLib"))

defun(whereIncludeCell (@optional (pattern "inv") (libNames nil) (views nil) (open nil)(short t))
" check in views schematic cmos_sch, in cells, in libs, if a cell is instanciated  "
let( (ddLibs libCellView libName cellName viewName cells)
unless(libNames libNames=ddGetLibList()~>name)
unless(views views=list("schematic" "cmos_sch"))
unless(listp(libNames) libNames=list(libNames))
unless(listp(views) views=list(views))
ddLibs=setof(dd ddGetLibList() member(dd~>name libNames))
;<= ^^ database to search
libCellView=remove( nil foreach(mapcan dd ddLibs foreach(mapcan cc dd~>cells foreach(mapcan vv cc~>views 
if(member(vv~>name views)
list(list(dd~>name cc~>name vv~>name))
nil
)))))
;<== ^^ get named list of (lib cell view) we want to search in
lcv=car(libCellView);=> ("CORELIB" "XNR41" "cmos_sch")
remove(nil foreach(mapcar lcv libCellView
libName=nth(0 lcv) cellName=nth(1 lcv) viewName=nth(2 lcv)
cv=dbOpenCellViewByType( libName cellName viewName)
cells=(setof cell cv~>instances rexMatchp(pattern cell~>cellName))
when(cells && open geOpen(?lib libName ?cell cellName ?view viewName))
res=if(short car(cells~>cellName) cells~>cellName)
if(cells list(libName cellName res) nil)
))))


;; _USAGE_
;; whereIncludeCell( "inv" list("CORELIB" "A_CELLS" "IOLIB_ANA_4M") nil)
;; whereIncludeCell( "DF" list("A_CELLS" "IOLIB_ANA_4M") nil)
;; whereIncludeCell( "DF" list("A_CELLS" "IOLIB_ANA_4M") "schematic")
;; whereIncludeCell( "ramp" "xtract_v2" nil)
;; whereIncludeCell( "ramp" "xtract_v2" nil t) ;<= open graphically every found cellview
;; flipFliops=whereIncludeCell( "DF" list("A_CELLS") nil)
;; length(flipFliops);=> 2

printf("whereIncludeCell( \"DF\" list(\"A_CELLS\" \"IOLIB_ANA_4M\") nil)\n")
printf("whereIncludeCell( \"DF\" list(\"A_CELLS\" \"IOLIB_ANA_4M\") nil t);<= open found views\n")
printf("\n")
printf("\n")


