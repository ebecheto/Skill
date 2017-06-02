



*addCell* function example
--------------------------
Here is an example that puts the element written in a list, into the open (empty or no) schematic.
`addCell('("gnd" "vdc" "vdd" "noConn" "vbit" "vpulse" "vsin"))`.
The library names can be specified with the fifth parameter list.
`addCell('("gnd" "noConn") t nil t '("analogLib"  "basic"))`

Personnal comment : this function is given for 'howto' puspose, i do not really use it generally. I prefer function array2sch, see below.
![example addCell](./addCell.png)


*freeLCK* function example
--------------------------
When a schematic view is opened in Read mode.
Remove existing lock that belongs to you (that you have the right to delete). Opened from a crashed session for instance. And it puts the schematic in the edit mode

![example addCell](./freeLCK.png)


*array2sch* function example
--------------------------
Take, or generate for your needs a list with the cellName and its input and output incremanted (or notà names. Then is creates an array of cells with net and labels on top in the opened schematic cellView.

<pre>
<span style="color: #b22222; font-weight: bold;">; array2sch tutorial USAGE
; semi-automatic schematic generate
</span>
<span style="color: #b22222; font-weight: bold;">;needed function load
</span>ineed('(array2sch getPropList nthcdr2) <span style="color: #0000ff; font-weight: bold; text-decoration: underline;">t</span>)
<span style="color: #b22222; font-weight: bold;">; array2sch('test) ;&lt;== uncomment the dummy example for instance
</span>
<span style="color: #b22222; font-weight: bold;">; cellName of the instance to generate
</span>cell2pose=<span style="color: #006400; font-weight: bold;">"phase_detector_Rst_simu"</span><span style="color: #b22222; font-weight: bold;">;&lt;== [TODO] : MODIFY this name for your purpose
; if you have one such cell on your schematic, select it and 
</span>getPropList()<span style="color: #b22222; font-weight: bold;">;=&gt;("phase_detector_Rst"  ("SLOW" "FAST" "VOUT" "vdd!" "gnd!"      "Rst"    ) nil)
; ne prendre que les premiers parametres
</span>nthcdr2(0 2 getPropList() )
<span style="color: #b22222; font-weight: bold;">;=&gt; ("phase_detector_Rst" ("SLOW" "FAST" "VOUT" "vdd!" "gnd!" "Rst"))
; WARNING, in this example, the net vdd! and gnd! are global and should not be put in the parameter list.
</span>
<span style="color: #b22222; font-weight: bold;">; faire une matrice pour dire a la fonction array2sch ce qu'il faut generer.
</span>cells=<span style="color: #a020f0; font-weight: bold;">foreach</span>(<span style="color: #a020f0; font-weight: bold;">mapcar</span> i linRg(1 9 1)<span style="color: #b22222; font-weight: bold;">;=&gt; (1 2 3 4 5 6 7 8 9 10)
</span><span style="color: #a020f0; font-weight: bold;">foreach</span>(<span style="color: #a020f0; font-weight: bold;">mapcar</span> j linRg(1 9 1)<span style="color: #b22222; font-weight: bold;">;=&gt; (1 2 3 4 5 6 7 8 9 10)
</span>row=<span style="color: #a020f0; font-weight: bold;">list</span>(cell2pose <span style="color: #a020f0; font-weight: bold;">list</span>(
<span style="color: #a020f0; font-weight: bold;">sprintf</span>(<span style="color: #0000ff; font-weight: bold; text-decoration: underline;">nil</span> <span style="color: #006400; font-weight: bold;">"S&lt;%d&gt;"</span> i) <span style="color: #b22222; font-weight: bold;">;=&gt; "S_1"
</span><span style="color: #a020f0; font-weight: bold;">sprintf</span>(<span style="color: #0000ff; font-weight: bold; text-decoration: underline;">nil</span> <span style="color: #006400; font-weight: bold;">"F&lt;%d&gt;"</span> i) <span style="color: #b22222; font-weight: bold;">;=&gt; "F_1"
</span><span style="color: #a020f0; font-weight: bold;">sprintf</span>(<span style="color: #0000ff; font-weight: bold; text-decoration: underline;">nil</span> <span style="color: #006400; font-weight: bold;">"PD_%d&lt;%d&gt;"</span> i j)  <span style="color: #006400; font-weight: bold;">"Rst"</span>))
))
<span style="color: #b22222; font-weight: bold;">;=&gt; ((("phase_detector_Rst_simu" ("S&lt;1&gt;" "F&lt;1&gt;" "PD_1&lt;1&gt;" "Rst")) ...("phase_detector_Rst_simu" ("S&lt;9&gt;" "F&lt;9&gt;" "PD_9&lt;9&gt;" "Rst"))))
</span>
<span style="color: #b22222; font-weight: bold;">;EXECUTION OF THE GENERATION FONCTION
</span>array2sch(cells <span style="color: #0000ff; font-weight: bold; text-decoration: underline;">nil</span> <span style="color: #0000ff; font-weight: bold; text-decoration: underline;">nil</span>)
<span style="color: #b22222; font-weight: bold;">; OPTIONNAL =&gt; add input and output pins
</span>PD_pins=<span style="color: #a020f0; font-weight: bold;">foreach</span>(<span style="color: #a020f0; font-weight: bold;">mapcar</span> i linRg(1 9 1) <span style="color: #a020f0; font-weight: bold;">sprintf</span>(<span style="color: #0000ff; font-weight: bold; text-decoration: underline;">nil</span> <span style="color: #006400; font-weight: bold;">"PD_%d&lt;1:9&gt;"</span> i))
<span style="color: #b22222; font-weight: bold;">;=&gt; ("PD_1&lt;1:9&gt;" "PD_2&lt;1:9&gt;" "PD_3&lt;1:9&gt;" "PD_4&lt;1:9&gt;" "PD_5&lt;1:9&gt;" "PD_6&lt;1:9&gt;" "PD_7&lt;1:9&gt;" "PD_8&lt;1:9&gt;" "PD_9&lt;1:9&gt;")
</span>ineed('terminalGen <span style="color: #0000ff; font-weight: bold; text-decoration: underline;">t</span>)
terminalGen(<span style="color: #a020f0; font-weight: bold;">reverse</span>(PD_pins))
</pre>


![example array2sch](./array2sch.png)
