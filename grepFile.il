;; copyleft ebecheto

; rexMagic( nil ) can prevent meta-characters (^, $, *, +, \, [, ], etc.) 
; rexMagic( t ) 
defun(grepFile (@optional (imadPositionFile "~/Skill/PICMIC/V1/imad_color_2024_07_09_fix.txt") (pattern " Yellow  -834"))
let((fp line nextLine ret)
"simple grep function to search for a pattern in a given file"
fp=infile(imadPositionFile) while(line=gets(nextLine fp) when( rexMatchp(pattern line) ret=line )) close(fp) ret
))

defun(grepFile2 (@optional (imadPositionFile "~/Skill/PICMIC/V1/imad_color_2024_07_09_fix.txt") (pattern " Yellow  -834"))
let((fp line nextLine ret)
"simple grep function to search for a pattern in a given file"
fp=infile(imadPositionFile) while(line=gets(nextLine fp) when( rexMatchp(pattern line) ret=append(ret list(line)) )) close(fp) ret
))


;; line="fff"
;; ret=nil
;; ret=append(ret list(line));=> ("fff");=> ("fff" "fff")

;; USEAGE 
;; txt=grepFile2(file "ADPIX")
;; ;parseString(txt "\t\n, ")
;; foreach(mapcar tx txt rexCompile("\t") tx=rexReplace(tx "" 1) rexCompile("\n") tx=rexReplace(tx "" 1) rexCompile(", ") tx=rexReplace(tx "" 1) )