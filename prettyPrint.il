;; copyleft ebecheto

(procedure prettyPrint(@optional (cvId nil) (imprimante nil) (hierarchy nil))
let( (cmd cvId i pt filename eko disp)
unless(imprimante imprimante = "lprdcrv")
cmd=sprintf(nil "if grep \"^%s|\" ~/.cdsplotinit; then echo yes; else echo \"%s|default: :type=postscript2: :resolution#600: :maximumPages#30: :paperSize=\\\"A4\\\" 4810 6330 172 132:\n\" >> ~/.cdsplotinit; fi" imprimante imprimante)
(system cmd)
;; eko=sprintf(nil "%s" cmd)
eko=sprintf(nil "echo Using printer \"%s\"" imprimante)
(system eko)

(unless cvId cvId=geGetWindowCellView())
;; when(not(cvId)||not(cvId~>libName)||not(cvId~>cellName)||not(cvId~>viewName) return(1)) ;<= return only from progb
;schematic or symbol plot
if( member(cvId~>viewName list("schematic" "schematic_smallSig" "cmos_sch" "symbol")) then pt="sch" else pt="le" ) i=0;
while( isFile( filename=sprintf(nil "%s-%s-%s_%d.ps" cvId~>libName cvId~>cellName cvId~>viewName i)) i++)

printf("%L => %L\n" cvId~>viewName pt )

set(concat(pt "PlotOptions") '(nil area "whole" plot "cellview" header nil plotToFile t plotterType "postscript2" papersize "A4"  display "display" tmpdir "/tmp" fit t center t orientation "automatic") )
;; set(concat(pt "PlotOptions") '(nil area "whole" plot "Viewing Area" header nil plotToFile t plotterType "postscript2" papersize "A4"  display "display" tmpdir "/tmp" center t orientation "automatic") )
eval(concat(pt "PlotOptions"))->view=eval(cvId~>viewName)
eval(concat(pt "PlotOptions"))->cell=eval(cvId~>cellName)
eval(concat(pt "PlotOptions"))->library=eval(cvId~>libName)
;eval(concat(pt "PlotOptions"))->bBox=cvId~>bBox
eval(concat(pt "PlotOptions"))->bBox=geGetWindowBox( hiGetCurrentWindow())
eval(concat(pt "PlotOptions"))->viewlist=eval(cvId~>viewName)
eval(concat(pt "PlotOptions"))->outputfile=filename
eval(concat(pt "PlotOptions"))->plotter=imprimante
eval(concat(pt "PlotOptions"))->cv=cvId
;eval(concat(pt "PlotOptions"))->fullarea=t

when(hierarchy
eval(concat(pt "PlotOptions"))->ignorelibs=buildString(remove(geGetWindowCellView()~>libName ddGetLibList()~>name) " ")
eval(concat(pt "PlotOptions"))->hierarchy = t
)

; plot schematic or layout
;; schPlot() || lePlot()
; eval(concat(pt "Plot()"));<== ... does not work
evalstring(strcat(pt "Plot()"));<== yeah Works

cmd=sprintf(nil "convert -trim -rotate 90 %s %s.png" filename filename filename )
cmd=sprintf(nil "%s;cat %s |sed \"s/1 setlinewidth/5 setlinewidth/\">%s.sed.ps" cmd  filename filename )
cmd=sprintf(nil "%s;convert -trim -rotate 90 %s.sed.ps %s.png" cmd  filename filename )
cmd=sprintf(nil "%s;cat %s.sed.ps |sed \"s/lineBlue *exch def/lineBlue def/;s/lineRed *exch def/lineRed def/;s/lineGreen exch def/lineGreen def/;\"  > %s.sed_bw.ps" cmd  filename filename )
LIBPATH_OLD=getShellEnvVar("LIBPATH")
SHLIB_PATH_OLD=getShellEnvVar("SHLIB_PATH")
LD_LIBRARY_PATH_OLD=getShellEnvVar("LD_LIBRARY_PATH")
setShellEnvVar("LIBPATH=/usr/lib")
setShellEnvVar("SHLIB_PATH=/usr/lib")
setShellEnvVar("LD_LIBRARY_PATH=/usr/lib")
cmd=sprintf(nil "%s;gs -I/usr/lib/ -dNOPAUSE -sDEVICE=png16m -dGraphicsAlphaBits=4 -r600 -sOutputFile=%s.gs.png -c \"<</Orientation 3>> setpagedevice\" -f %s.sed_bw.ps -c quit" cmd  filename filename )
cmd=sprintf(nil "%s;convert %s.gs.png -trim -matte -transparent 'rgb(255,255,255)' %s.t_ps.png" cmd  filename filename )
;; cmd=sprintf(nil "%s;convert -trim -rotate 90 %s.sed_bw.ps %s_bw.png" cmd  filename filename )
cmd=sprintf(nil "%s;rm %s.sed.ps  %s.gs.png %s.png" cmd  filename filename filename  ) ;; %s.sed_bw.ps On GARDE ;filename
unless(hierarchy
(system cmd)
)
printf("%s" cmd)

when(LIBPATH_OLD setShellEnvVar(strcat("LIBPATH=" LIBPATH_OLD)))
when(SHLIB_PATH_OLD setShellEnvVar(strcat("SHLIB_PATH=" SHLIB_PATH_OLD)))
when(LD_LIBRARY_PATH_OLD setShellEnvVar(strcat("LD_LIBRARY_PATH=" LD_LIBRARY_PATH_OLD)))
;; Workaround for RHEL3 : PB de Lib path

;; fp=outfile("tata.txt")
;; fprintf(fp "\t\t[** %s **]\n",cmd)
;; close(fp)
;; (system "echo -e GS")
;; (system "which gs")
;; (system "gs --version")
;; (system "echo -e GS")

eko=sprintf(nil "Following files had been created in %s :\n%s\n%s.t_gs.png\n" pwd()  filename filename)

printf("%s" eko)
eko=sprintf(nil "echo \"%s\"" eko)
disp=sprintf(nil "echo display \"%s/%s.t_ps.png\" &" pwd() filename)
(system eko)
(system disp)
eko=sprintf(nil "\nTODO:\nlp %s/%s.sed_bw.ps\n" pwd() filename)
eko=sprintf(nil "echo \"%s\"" eko)
(system eko)
printf("(system %L)"  sprintf(nil "echo \"%s\"" sprintf(nil "lp %s/%s.sed_bw.ps" pwd() filename)))
);let
);proc


printf("prettyPrint(@optional (cvId nil) (imprimante nil) (hierarchy nil))\n")
printf("prettyPrint(); == prettyPrint(nil nil nil);<==defaul\n")
printf("prettyPrint(nil nil t);<== prints the whole hierachy of the current cell & sub cells in the current library\n")

;filename="TDC-phase_detect-schematic_4.ps"

; hierarchy [TODO]
; ls *@*.ps

;; cmd=""
;; cmd=strcat(cmd sprintf(nil "for file in %s-*ps;do epsBetterLine.sh $file;done\n" cvId~>libName ))
;; cmd=strcat(cmd sprintf(nil "gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=TOP.pdf %s-*.ps" cvId~>libName ))
;; printf(cmd)

;; cmd="function helloWolrd(){ echo \"Prompt> \" $1; }"
;; cmd="function helloWolrd(){ echo 'Prompt> ' $1; }"
;; cmd="helloWolrd(){ echo 'Prompt> ' $1; }"
;; (system cmd)
;; cmd="helloWolrd YOUHOU"
;; (system cmd)
;; ;; ;[OK]
;; ;; cmd="helloWolrd(){ echo 'Prompt> ' $@; }; helloWolrd after shell dies function dies"
;; ;; (system cmd)
;; ;[OK]

;; cmd="helloWolrd(){ echo 'Prompt> ' ${1%.*}; }; helloWolrd after.sh"
;; (system cmd)

; [TODO] : insert this funciton inside prettyPrint()
defun( prettyPrintH (@optional (cvId nil) (imprimante nil))
(unless cvId cvId=geGetWindowCellView())
(unless imprimante imprimante = "printers_ipnl")
prettyPrint(cvId imprimante t)
cmd="epsBetterLine(){ cat $1|sed 's/1 setlinewidth/5 setlinewidth/;s/lineBlue *exch def/lineBlue 0 def/;s/lineGreen exch def/lineGreen 0 def/;s/lineRed *exch def/lineRed 0 def/' > _${1%.*}.ps 2>/dev/null; gs -dBATCH -dNOPAUSE -sDEVICE=ps2write -dPDFFitPage -sOutputFile=${1%.*}.ps  -c \"/Courier findfont 12 scalefont setfont 50 765 moveto (${1%.*}) show\" -f _${1%.*}.ps 2>/dev/null; rm _${1%.*}.ps; }; "
cmd=strcat(cmd sprintf(nil "for file in %s-*ps;do epsBetterLine $file 2>/dev/null;done\n" cvId~>libName ))
cmd=strcat(cmd sprintf(nil "echo '[TOP.pdf]'\n"))
cmd=strcat(cmd sprintf(nil "gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=TOP.pdf %s-*.ps" cvId~>libName ))
system(cmd)
system("echo $PWD/TOP.pdf")
)

printf("\nprettyPrintH() ;<== prints the HIERARCHY\n")

;; cmd=sprintf(nil "for file in %s-*ps;do echo $file;done\n" geGetWindowCellView()~>libName )
;; system(cmd)
