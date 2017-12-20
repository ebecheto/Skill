defun(busMemeInst (@optional (busIn "A<0:1>") (memInst "I6<10:13>"))
let((memInstList memInstName memInstMin busInList busInName busInMin respIndex netxi nextj)
;;; ________ name flattening and compose it back __________ ;;;
;memInst=atach~>inst~>name              ;=> "I6<10:13>"
printf("%L %L\n" busIn memInst)
memInstList=parseString(memInst "<:>") ;=> ("I6" "10" "13")
memInstName=nth(0 memInstList)         ;=> "I6"
memInstMin=atoi(nth(1 memInstList))    ;=> 10

;busIn=atach~>name                  ;=> "A<0:1>"
busInList=parseString(busIn "<:>") ;=> ("A" "0" "1")
busInName=nth(0 busList)           ;=> "A"
busInMin=atoi(nth(1 busList))      ;=> 0

respIndex='()
for(j 0 dbGetNameNumBit(memInst)-1
nextj=sprintf(nil "%s<%d>" memInstName memInstMin+j)
for(i 0 dbGetNameNumBit(busIn)-1
nexti=sprintf(nil "%s<%d>" busInName busInMin+i)
respIndex=append(respIndex list(list(nexti nextj)))
))
respIndex
))

;; (("A<0>" "I6<10>") 
;;     ("A<1>" "I6<10>") 
;;     ("A<0>" "I6<11>") 
;;     ("A<1>" "I6<11>") 
;;     ("A<0>" "I6<12>")
;;     ("A<1>" "I6<12>") 
;;     ("A<0>" "I6<13>") 
;;     ("A<1>" "I6<13>")
;; )


printf("busMemeInst(%L %L);<== default" "A<0:1>" "I6<10:13>")
printf("busMemeInst(%L %L)" "A1" "I6<10:13>")

