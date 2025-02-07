;; copyleft ebecheto

defun(grepFile (@optional (imadPositionFile "~/Skill/PICMIC/V1/imad_color_2024_07_09_fix.txt") (pattern " Yellow  -834"))
let((fp line nextLine ret)
"simple grep function to search for a pattern in a given file"
fp=infile(imadPositionFile) while(line=gets(nextLine fp) when( rexMatchp(pattern line) ret=line )) close(fp) ret
))