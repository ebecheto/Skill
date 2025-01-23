; ineed('masterTagCreate t)
ineed('shout)
libName="PICMIC1_DAC"
;; cells~>writePath
;; cell=car(cells)
;; car(last(parseString(cell~>writePath "/")));=> "AFE"
;; foreach(mapcar cell cells cell~>cellName=car(last(parseString(cell~>writePath "/"))))
;; cells~>lib~>name
;; cells~>name
;; libName

;; cell=car(setof(cell cells cell~>name=="DAC_multi_purpose_sim"));=> dd:0x37466890


defun(masterTagCreate (@optional (libName nil)(default nil))
"loop in the library directories to create the master.tag file if does not exit"
let((ddId cellsdir cmd ret reps target comment fp masterFilename)
unless(default default='(("layout" "layout.oa") ("schematic" "sch.oa")("symbol" "symbol.oa") ("maestro" "maestro.sdb") ("config" "expand.cfg")))
;printf("libName=%s\n" libName||nil)
unless(libName libName=geGetWindowCellView()~>libName);=> "PICMIC1_ANALOG"
when(libName 
printf("libName=%s\n" libName)
ddId=ddGetObj(libName)
cells=ddId~>cells
;;cell=car(cells);=> dd:0x36550650

remove(nil foreach(mapcar cell cells
dir=cell~>writePath;=> "/uelec/Projets/Picmic/TOWER/TS18IS/picmic1/work_libs/ebecheto/cds/PICMIC1_ANALOG/DDR_interface_190_pnm"
;;cmd=sprintf(nil "ls %s"  cell~>writePath)
;ret=shout(cmd);=> "calibre\nlayout\nschematic\nsymbol\n"
if(isDir(dir)==nil then printf("Wierd %s\n" dir||"nil") else
reps=remove(".." remove("." ls(dir)));=> ("schematic")
;reps=parseString(ret "\n");=> ("calibre" "layout" "schematic" "symbol")
;rep=nth(2 reps);=> "layout"
foreach(mapcar rep reps
unless(isFile(sprintf(nil "%s/%s/master.tag" dir rep))
;rexMatchp("cannot access"  ret);=> t
target=cadr(assoc(rep default));=> "layout.oa"
;; cmd=sprintf(nil "echo %s \n\n >> %s/%s/master.tag" target dir rep)
;; shout(cmd)
if(target==nil then printf("default target %s not treated\n" rep||"nil") else
masterFilename=sprintf(nil "%s/%s/master.tag" dir rep)
comment="-- Master.tag File, Rev:1.0\n"
comment=""
fp=outfile(masterFilename "w")
when(outportp(fp) fprintf(fp "%s%s \n" comment target) close(fp) ;;edit(eval(masterFilename))
)
masterFilename
)))))))))

printf("masterTagCreate(%L)\n" "PICMIC1_ANALOG")
printf("masterTagCreate(geGetWindowCellView()~>libName)\n")
printf("masterTagCreate(nil '((\"schematic\" \"sch.oa\")))\n")
