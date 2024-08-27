;ineed('csvReadFile t)
;; csvReadFile()
;list2D=csvReadFile(strcat("/xusers/1_profils/linux/ebecheto/Skill" "/" "dataFrame.csv")
;list2D=csvReadFile(strcat("/xusers/1_profils/linux/ebecheto/Skill" "/" "dataFrame.csv") nil nil 3)
;csvReadFile(sprintf(nil "%s/%s" pwd() "dataFrame.csv"))
;; csvReadFile(sprintf(nil "%s/%s" pwd() "dataFrame.csv") " +" ";" )
defun(csvReadFile (@optional (file nil)(separator nil) (comment nil)(skip 0))
let((list2D line sline myPort)
unless(comment comment=";") ;comment="#"
unless(separator separator=" +" );<= one or more space ;separator=","
unless(skip skip=0)
unless(file file=sprintf(nil "%s/%s" "/xusers/1_profils/linux/ebecheto/Skill" "dataFrame.csv"))
;pwd();=> "/xusers/3_projets/fastic/cadence2122/ebecheto_lhcb_ecal2"
myPort=infile(file)
(while skip>0 gets(nextLine myPort) skip--)
list2D='()
while(line=gets(nextLine myPort)
line=car(parseString(line "\n")) ;<= remove end of line
sline=parseString( line separator)
unless(car(parseString(car(sline) ""))==comment
list2D=append(list2D list(sline))
))
list2D))


;; car(list2D)  ;=> ("0" "R" "C" "Count" "offset" "name")
;; x=nth(1 list2D);=> ("0" "51.0" "5.0" "2.0" "105.5" "Y<342>")
;; last(x);=> ("Y<70>")
;; foreach(mapcan x list2D nthcdr(5 x)) ;<== OK
;; ;;;;;foreach(mapcan x list2D list(last(x))) ;;;<= bugggy this one ?
