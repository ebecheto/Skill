;=> renvoie la difference d'un liste par elle meme => N(N-1)/2 elements
defun(list2minus (@optional (difs difs)) let((w wn id idr)
idr=difs
remove(nil foreach(mapcan row difs idr=cdr(idr)
foreach(mapcar col idr
eval(row)-eval(col)
)))))
