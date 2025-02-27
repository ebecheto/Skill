; ineed('csvRow4 t)
;; copyleft ebecheto

defun(csvRow4 (@optional (i 0) (r1 "padPosition")(r2 "padName")(r3 "padType")(r4 "padCell") (padListFile nil))
let((cmd)
"USES THE POWER OF WAWK TO MAKE A TABLEUR"
"DOES NOT WORK WITH # or ; in given strings though..."
unless(padListFile padListFile="/uelec/Projets/Picmic/TOWER/TS18IS/picmic1/work_libs/ebecheto/cds/PICMIC1_ebecheto/padList.csv")
cmd=sprintf(nil "~/bin/modify_csv.sh %s %d 1 %s" padListFile i r1||"") system(cmd)
cmd=sprintf(nil "~/bin/modify_csv.sh %s %d 2 %s" padListFile i r2||"") system(cmd)
cmd=sprintf(nil "~/bin/modify_csv.sh %s %d 3 %s" padListFile i r3||"") system(cmd)
cmd=sprintf(nil "~/bin/modify_csv.sh %s %d 4 %s" padListFile i r4||"") system(cmd)
))


;; #!/bin/bash

;; # Usage: ./modify_csv.sh data.csv 3 3 32
;; FILE="$1"   # CSV filename
;; ROW="$2"    # Target row (1-based)
;; COL="$3"    # Target column (1-based)
;; NEW_VALUE="$4"  # New value to insert

;; # Ensure file exists
;; touch "$FILE"

;; awk -F',' -v row="$ROW" -v col="$COL" -v new_val="$NEW_VALUE" '
;; BEGIN { OFS="," }
;; {
;;     max_rows = NR > max_rows ? NR : max_rows
;;     max_cols = NF > max_cols ? NF : max_cols
;;     data[NR] = $0
;; }

;; END {
;;     # Ensure the row exists
;;     for (i = 1; i <= max_rows || i <= row; i++) {
;;         if (!(i in data)) {
;;             data[i] = ""  # Create empty row if missing
;;         }
;;         split(data[i], fields, ",")

;;         # Ensure we have enough columns
;;         for (j = 1; j <= max_cols || j <= col; j++) {
;;             if (!(j in fields)) {
;;                 fields[j] = (i == row && j == col) ? new_val : ""
;;             }
;;         }

;;         # Update value at target cell
;;         if (i == row) {
;;             fields[col] = new_val
;;         }

;;         # Reconstruct row properly, preserving all columns
;;         data[i] = fields[1]
;;         for (j = 2; j <= (max_cols > col ? max_cols : col); j++) {
;;             data[i] = data[i] "," fields[j]
;;         }
;;     }

;;     # Print updated file
;;     for (i = 1; i <= max_rows || i <= row; i++) {
;;         print data[i]
;;     }
;; }' "$FILE" > temp.csv && mv temp.csv "$FILE"
