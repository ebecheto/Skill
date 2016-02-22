;; copyleft ebecheto

; '((x1 y1)(x2 y2)...)

defun( list2wave (lfile) let((maxn X Y) 
maxn=length(lfile)
X=drCreateVec('double maxn-1)
Y=drCreateVec('double maxn-1) for( i 0 maxn-1
drSetElem(X i  car(nth(i lfile)))
drSetElem(Y i cadr(nth(i lfile))))
drCreateWaveform(X Y) ))


defun(list2wave2 (lfile) let((i) i=0
list2wave(foreach(mapcar dl lfile list(i++ dl)))))
;quand on a qu'un element dans la list => prendre cette fonction. J'aurais du l'appeler list2wave1
; list2wave2('(1 3 89 7 6));=>srrWave:0x27165040
; list2wave('((1 1)(3 2)(89 3)(7 4)(6 5)));=>srrWave:0x27165050

;; file=strcat(pwd() "/" "ENC500fF.data")
;; ocnPrint(ENC_PA4 ?output file ?format "engineering")
;; listIn=ocnPrint2list(file)
;; plot(list2wave(listIn))

