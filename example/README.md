



*addCell* function example
--------------------------
Here is an example that puts the elements written in a list, into the open (empty or no) schematic.
`addCell('("gnd" "vdc" "vdd" "noConn" "vbit" "vpulse" "vsin"))`.
The library names can be specified with the fifth parameter list.
`addCell('("gnd" "noConn") t nil t '("analogLib"  "basic"))`

Personnal comment : this function is given for 'howto' puspose, i do not really use it generally. I prefer function array2sch, see below.
![example addCell](./addCell.png)


*freeLCK* function example
--------------------------
When a schematic view is opened in Read mode.
Remove existing lock that belongs to you (that you have the right to delete). Opened from a crashed session for instance. And it puts the schematic in the edit mode.

![example addCell](./freeLCK.png)


*array2sch* function example
--------------------------
Take, or generate for your needs, a list with the cellName and its input and output incremanted (or not) names. Then is creates an array of cells with net and labels on top in the opened schematic cellView.


![example array2sch](./array2sch.png)



*schematic2symbol* function example
--------------------------
From an open schematic with pins, generate a rectangle symbol with the pins at the same location distance of the schematic.
For practical simplicity, i use named label to put pins in a nearby area.

![example](./schematic2symbol.png)


*vdcGen* function example
--------------------------
From an open schematic, generates an array or a list of analogLib vdc with shifted verilog syntax bit, in order to use the parameter in a simulation (ADE, ADEXL, or whatever new maestro tool).

![example](./vdcGen.png)


*menu* function example
--------------------------
Add a menu in CIW ( former icfb ), the pull down menus with the function a generally use.

![example](./menu.png)


*rexFindCell* function example
--------------------------
search in the libraries defined in the cds.lib where exist a pattern

rexFindCell("or" "CORELIB" t)	;<== search in the library CORELIB where there an 'or' with case insensitivity.

rexFindCell("^mos" )	   	;<== search everywhere a cell starting with 'mos'

;=>(("ahdlLib" "mos_tft") 
    ("ahdlLib" "mos_level1"));<== answer


![example](./rexFindCell.png)


