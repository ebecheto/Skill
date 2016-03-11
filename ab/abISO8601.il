/* abISO8601.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Aug 08, 2012 
Modified   
By         

Functions to convert dates in ISO8601 format to either "tm"
structures or a SKILL date string.

Note that this doesn't handle time zones - so may need some
adjustment for timezones / daylight saving time (not sure).

***************************************************

SCCS Info: @(#) abISO8601.il 08/08/12.06:36:34 1.1

*/

/***************************************************************
*                                                              *
*                  (abISO8601toTm dateString)                  *
*                                                              *
* Attempts to convert an ISO8601 formatted date string into a  *
*                       "tm" structure.                        *
*                                                              *
***************************************************************/

(defun abISO8601toTm (dateString)
  (let (pattern tm slot)
    ;--------------------------------------------------------------------
    ; Note ignores anything after decimal point in seconds, as time
    ; functions in SKILL do not support finer granularity. Also the
    ; time zone is ignored. The pattern below should support both
    ; basic and extended format
    ;--------------------------------------------------------------------
    (setq pattern (pcreCompile
                    "(\\d{4})-?(\\d{2})-?(\\d{2})[T ]?(\\d{2}):?(\\d{2}):?(\\d{2})"
                    ))
    (when
      (pcreExecute pattern dateString)
      ;------------------------------------------------------------------
      ; Create an "empty" tm structure
      ;------------------------------------------------------------------
      (setq tm (timeToTm 0))
      (setq slot 1)
      (foreach (field correction) 
               '(tm_year tm_mon tm_mday tm_hour tm_min tm_sec)
               '(1900 1 0 0 0 0)
               ;---------------------------------------------------------
               ; Pull out each field from the pattern, convert to
               ; integer, and apply a correction (subtraction) 
               ; and then store in the correct field in the tm
               ; structure
               ;---------------------------------------------------------
               (putprop tm (difference
                             (atoi (pcreSubstitute
                                     pattern 
                                     (sprintf nil "\\%d" (postincrement slot))))
                             correction)
                        field)
               )
      ;------------------------------------------------------------------
      ; could do timeToTm(tmToTime(tm)) here to fill in other fields
      ; but doesn't seem really necessary
      ;------------------------------------------------------------------
      tm
      )
    )
  )

/****************************************************************
*                                                               *
*                (abISO8601toString dateString)                 *
*                                                               *
* Convert an ISO8601 date string into SKILL's usual date format *
*                                                               *
****************************************************************/

(defun abISO8601toString (dateString)
  (timeToString (tmToTime (abISO8601toTm dateString)))
  )

