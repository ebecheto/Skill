;; copyleft ebecheto

ineed('prop02f)

;; cv=geGetWindowCellView()
;; insts=cv~>instances
;; bBox=cv~>bBox;=> ((-2.725 -2.78125) (11.2875 5.41875))
;; ; insts~>cellName
;; inst=car(insts)



defun(printfMosSize (@optional (cv geGetWindowCellView()) )
let((insts tri_dump tri inst)
insts=cv~>instances
tri_dump=foreach(mapcar inst insts list(cadr(mapcar('difference inst~>xy car(bBox))) inst ))
tri=sortcar(tri_dump 'greaterp)
remove(nil foreach(mapcan tr tri 
inst=cadr(tr)
cond(
(rexMatchp("mos4$" inst~>cellName) list( strcat(inst~>name ":" prop02f(inst "wtot") "/" prop02f(inst "l"))))
(t 
;;printf("NO? %L %L\n" inst~>name inst~>cellName) 
nil)
)
))
))





;; seds='((".00" "" 0) ("[.][1-9]0/" "/" 0 "0/") (".[1-9]0$" "" 0 "0$"))
;; rm0=foreach(mapcar re ret
;; tmp=re
;; foreach(sed seds re=tmp
;; when(rexMatchp(car(sed) re) printf("%L\n" list(re car(sed) tmp))
;; rexCompile(nth(3 sed)||nth(0 sed)) list(tmp=rexReplace(re nth(1 sed) nth(2 sed)||1)))
;; )
;; re)

;; ;Check bug :
;; remove(nil foreach(mapcan rr mapcar('list rm0 ret) 
;; wl1=parseString(car(rr) "/")
;; wl2=parseString(cadr(rr) "/")
;; cond(
;; (evalstring(car(wl1)) !=evalstring(car(wl2)) rr)
;; (evalstring(cadr(wl1))!=evalstring(cadr(wl2)) rr)
;; (t nil)
;; ))
;; )



;; str="11/0.70"
;; rexCompile( "0$")
;; rexReplace( str "" 1)

;; rexMatchp(".[1-9]0/" "270/9") ;=> t ;=> match but should not. FAIL => escape with [.], or \\.
;; rexMatchp("\\.[1-9]0/" "270/9") ;=> nil
;; rexMatchp("[.][1-9]0/" "270/9") ;=> nil
