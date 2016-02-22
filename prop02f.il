;; copyleft ebecheto
;; inst=css()

defun(prop02f (@optional (inst css())(prop "wtot")(shift 1e6))
let((dbp val v1)
if(dbp=dbFindProp(inst prop) then 
val=sprintf(nil "%0.2f" evalstring(dbp~>value||"0")*shift)
;=> "221.00"
;; v1=val
;val="221.10"
rexCompile("[.]00") v1=rexReplace(val "" 1)
if(rexMatchp("[.][1-9]0$" v1) then rexCompile("0$") rexReplace(v1 "" 1) else v1)
else
printf("NIL=>%s<=prop, try with: \n%L\n" prop inst~>prop~>name)
nil)
))

;; seds='((".00" "" 0) ("[.][1-9]0/" "/" 0 "0/")

