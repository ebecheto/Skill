;; copyleft ebecheto

procedure(getMaxPoints(LIST)
let((dY dX Xmin Xmax Ymin Ymax first)
(cond
((null LIST) LIST)
((atom car(LIST)) printf("getMaxPoints(%L) should be a list of list. bBox 'like'\n" LIST) LIST)
(t  first=car(LIST) 
Xmin=caar(first) Xmax=caadr(first)
Ymin=cadar(first) Ymax=cadadr(first)
;printf("1Box=%L \tX0:%L \tY0:%L  \tX1:%L \tY1:%L\t\n"  first caar(first) cadar(first) caadr(first) cadadr(first) )
foreach(bBox LIST
;printf("bBox=%L \tX0:%L \tY0:%L  \tX1:%L \tY1:%L\t%L\n"  bBox caar(bBox) cadar(bBox) caadr(bBox) cadadr(bBox) list(caar(bBox)>caadr(bBox) cadar(bBox)>cadadr(bBox) ))
when((dX=caar(bBox))<Xmin Xmin=dX   )
when((dY=cadar(bBox))<Ymin Ymin=dY  )
when((dX=caadr(bBox))>Xmax Xmax=dX  )
when((dY=cadadr(bBox))>Ymax Ymax=dY )
)
list(list(Xmin Ymin) list(Xmax Ymax))))
))
