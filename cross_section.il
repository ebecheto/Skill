/*

Generate an input file for gen_cross_section
End users will want to customise RALGenCrossSection().

*/

/*
The functions XyzGetLppsAtPoint and XyzGetOvlpObj, which do most of the work 
getting the layer information, were written by Jim Newton, part of the Cadence 
VCAD team. As such, Jim has given me permission to distribute the code but
that does mean it is not covered by the license in COPYING.

The original thread where Jim provided the functions can be seen at:

http://groups.google.com/group/comp.cad.cadence/browse_thread/thread/503a417a2bc94e33/c12d840b2066e820

The Cadence VCAD (Virtual CAD) team provide, amongst other things, high
quality SKILL IP to help users get around various shortcomings in the Cadence
tools. More information on Cadence VCAD can be found at:

http://www.cadence-europe.com/solutions/vpage.cfm
*/

;; return a list of layer purpose pairs at the given point
;; considering the top level of hierarchy down the specified (depth)
;; number of levels.
(defun XyzGetLppsAtPoint (d_cv pt @key (depth (dbGetMaxHierDepth)))
  (let ((hash (makeTable 'lpps nil)))
	(foreach ovlp_obj (dbGetTrueOverlaps d_cv (list pt pt) t depth)
             (let ((obj (XyzGetOvlpObj ovlp_obj)))
               (when (obj~>isShape)
                 hash[obj~>lpp]=t)))
	hash->?))

;; ovlp_obj is an element of the return value of dbGetOverlaps
;; RETURNS the object at the bottom of the hierachy which is described
;; by the ovlp_obj.
(defun XyzGetOvlpObj (ovlp_obj)
  (cond
   ((null ovlp_obj)
    nil)
   ((dbobjectp ovlp_obj)
    ovlp_obj)
   ((atom ovlp_obj)
    (error "list or dbobject expected %L" ovlp_obj))
   ((null (cdr ovlp_obj))
    (car ovlp_obj))
   ((listp (cadr ovlp_obj))
    (XyzGetOvlpObj (cadr ovlp_obj)))
   (t
    (XyzGetOvlpObj (cdr ovlp_obj))))) 

/* line must be orthogonal or diagonal */
(defun RALSaveLayersAlongLine (cv line grid filename)
  (let (x dx x1 x2 y dy y1 y2 count ofile lpps)

	x1 = (car (car line))
	y1 = (cadr (car line))
	y2 = (cadr line) /* just hold this temporarily */
	x2 = (car y2)
	y2 = (cadr y2)

	/* As the line is orthogonal or diagonal
	** it does not matter if count is set by
	** the x or y axis
	*/
	(if x1 == x2 then
	  dx = 0
	  else
	  (if x1 > x2 then
		dx = -grid
		count = (floor (x1 - x2)/grid)
		else
		dx = grid
		count = (floor (x2 - x1)/grid)
		)
	  )

	(if y1 == y2 then
	  dy = 0
	  else
	  (if y1 > y2 then
		dy = -grid
		count = (floor (y1 - y2)/grid)
		else
		dy = grid
		count = (floor (y2 - y1)/grid)
		)
	  )
	
	x = x1
	y = y1

	ofile = (outfile filename, "w")
	(fprintf ofile "%d\n" count)
	(for i 1 count
		 (fprintf ofile ".\n")

		 lpps = (XyzGetLppsAtPoint cv (list x y))

		 (foreach lpp lpps
				  (fprintf ofile "%s%s\n" (car lpp) (cadr lpp)))

		 (fprintf ofile "\n")
		 x = x + dx
		 y = y + dy
		 )
	(close ofile)
	)
  )

(defun RALGenCrossSection (layersFile paletteFile width)
  (let (cv grid line cfile pfile)
	cv = geGetEditCellView()
	grid = (techGetMfgGridResolution (techGetTechFile cv))
	line = (enterLine ?wantPoints 2 ?prompts (list "Enter line to generate cross section"))
	cfile = (strcat "/tmp/cross." (sprintf nil "%d" ipcGetPid()))
	pfile = (strcat "/home/validmgr/" (getShellEnvVar "USER") "/cross_section.png")
	(RALSaveLayersAlongLine cv line grid cfile)
	(system (strcat "gen_cross_section -i " cfile " -o " pfile " -p " paletteFile " -m " (sprintf nil "%d" width) " -l " layersFile))
	(deleteFile cfile)
	(system (strcat "display " pfile " &"))
	)
  )

/*
tech = techGetTechFile(cell)
tech = techGetTechFile(geGetWindowCellView())
lpp = techGetLP(tech (list "MET2" "drawing"))
packetname = techGetLPPacketName(lpp)
display = drGetDisplay("display")
packet = drGetPacket(display packetname)
colour = car(cddddr(packet))
rgb = drGetColor(display colour)
red = caddr(rgb)
green = cadddr(rgb)
blue = car(cddddr(rgb))
*/
