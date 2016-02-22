;; copyleft ebecheto

; load("dateStamp.il")
; unless(fboundp('dateStamp) load("dateStamp.il"))

defun(dateStamp () let((t0 tabMois gt pt mm hms st)
t0=stringToTime(getCurrentTime());=> 1360749446
tabMois='(("Jan" "01") ("Feb" "02") ("Mar" "03") ("Apr" "04") ("May" "05") ("Jun" "06") ("Jul" "07") ("Aug" "08") ("Sep" "09") ("Oct" "10") ("Nov" "11") ("Dec" "12"))
gt=getCurrentTime();=> "Feb 13 13:24:17 2013"
; Je veux : 2013_02_12_13-20-11
;           year_mm_dd_hh-mm-ss
pt=parseString(gt " ")
mm=cadr(assoc(car(pt) tabMois))
hms=nth(2 pt)
st=strcat(car(last(pt)) "_" mm "_" cadr(pt) "_" hms)
rexCompile(":")
rexReplace(st "-" 0)
))


;; t0=stringToTime(getCurrentTime());=> 1360749446
;; minute=60*1;*1sseconde
;; timeToString(0*minute+t0)
;; timeToString(1*minute+t0)
;; heure=60*minute
;; jour=24*heure
;; mois=30*jour
;; timeToString(1*mois+t0)
;; foreach(mapcar m linRg(1 12 1) timeToString(m*mois+t0))

;; foreach(mapcar m linRg(1 12 1) car(parseString(timeToString(m*mois+t0) " ")))
;; foreach(mapcar m linRg(1 12 1) car(parseString(timeToString((m-2)*mois+t0) " ")))
;; mois12='("Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
;; i=0 foreach(mapcar m mois12 i++ sprintf(nil "%0.2d" i) )
;; i=0 tabMois=foreach(mapcar m mois12 i++ list(m sprintf(nil "%0.2d" i) ))
;; cadr(assoc("Feb" tabMois));=> "02"


;; println tabMois
;; (("Jan" "01") ("Feb" "02") ("Mar" "03") ("Apr" "04") ("May" "05") ("Jun" "06") ("Jul" "07") ("Aug" "08") ("Sep" "09") ("Oct" "10") ("Nov" "11") ("Dec" "12"))
