;ineed('checkAddSkillPath t)

;; setq(path list("$HOME/Skill"))
;; setq(path "$HOME/Skill")

defun(checkAddSkillPath @optional( (path list("$HOME/Skill")))
let(( dirs)
unless(type(path)=='list path=list(path))
dirs=path
foreach(mapcar dir  dirs
dir=simplifyFilename(dir)
when(system(strcat("ls " dir ">/dev/null" ))==0
when(not(rexMatchList(dir getSkillPath())) setSkillPath(cons(dir getSkillPath()))
printf("[SKILL] Adding %s in getSkillPath()\n" dir||"nilDir?")
))) getSkillPath()
))


;; ineed('checkAddSkillPath)
;; checkAddSkillPath(list("$HOME/Skill" "$HOME/Skill/PICMIC/V1"))
;; ineed('ROnb_xy_v1)

