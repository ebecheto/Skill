;; copyleft ebecheto
defun(busMemeInst (@optional (busIn "A<0:1>") (memInst "I6<10:13>"))
let((memInstList memInstName memInstMin busInList busInName busInMin respIndex netxi nextj noMem noBus)
;;; ________ name flattening and compose it back __________ ;;;
;memInst=atach~>inst~>name              ;=> "I6<10:13>"
printf("busIn:%L memInst:%L\n" busIn memInst)
memInstList=parseString(memInst "<:>") ;=> ("I6" "10" "13")
if(length(memInstList)>1 then
memInstName=nth(0 memInstList)         ;=> "I6"
memInstMin=atoi(nth(1 memInstList))    ;=> 10
else noMem=t
)

;busIn=atach~>name                  ;=> "A<0:1>"
busInList=parseString(busIn "<:>") ;=> ("A" "0" "1")
if(length(busInList)>1 then
busInName=nth(0 busInList)           ;=> "A"
busInMin=atoi(nth(1 busInList))      ;=> 0
else noBus=t
)
respIndex='(); __ vvv this is a choise base on Layout XL proposal vvv __ could be shuffle?__
for(j 0 dbGetNameNumBit(memInst)-1
nextj=if(noMem memInst sprintf(nil "%s<%d>" memInstName memInstMin+j))
for(i 0 dbGetNameNumBit(busIn)-1
nexti=if(noBus busIn sprintf(nil "%s<%d>" busInName busInMin+i))
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


printf("busMemeInst()\n")
printf("busMemeInst(%L %L);<== default\n" "A<0:1>" "I6<10:13>")
printf("busMemeInst(%L %L)\n" "A1" "I6<10:13>")
printf("busMemeInst(%L %L)\n" "A<1:2>" "I28")
printf("busMemeInst(%L %L)\n" "AQ" "I28")
printf("busMemeInst(%L %L)\n" "AKOI<1>" "I28")


; busMemeInst("A1" "I6<10:13>")
; busMemeInst("A<0:1>" "I6")


