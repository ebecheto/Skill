;ineed('busListMerge t)
ineed('abCollapseAdjacentSignals)
ineed('sort123);=> nil define alphaNum
procedure(MyUnique(lst)  let(((seen makeTable('seen nil)))    setof(elem lst      unless(seen[elem]        seen[elem]=t      )    )  ))

;nets
defun(busListMerge (@optional (nets '("net<0>" "net<1>" "net<2>" "clk" "data<0>" "data<1>" "data<3>" "reset" "sig<10>" "sig<9>" "sig<12>" "sig<11>" "bug<7:0>")))
let((result aa RETOUR)
;; oblagie the expand if some nets ar not expanded
nets=foreach(mapcan net nets dbProduceMemName(net))
;; sort nets
nets=sort(copy(nets) 'alphalessp)
;; or my home made sort
nets=alphaNum(nets)
nets=MyUnique(nets)

;il faut trier avant
result=abCollapseAdjacentSignals(nets)

;=> ("net<0:2>" "clk" "data<0:1,3>" "reset" "sig<10:9,12:11>" "bug<7>")
RETOUR=foreach(mapcan a result
aa=parseString(a ",")
if(length(aa
)==2 then
name=car(parseString(car(aa) "<"));=> "data"
printf("AA:%L\n" aa)
list(strcat(car(aa) ">") strcat(name "<" cadr(aa)));=> ("data<0:1>" "<3>")
else
list(a)
))
RETOUR
))

;busListMerge()
; busListMerge(cv~>sigNames)
