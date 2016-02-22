/* abMute.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Dec 22, 2011 
Modified   
By         

A macro to mute the output from printf() calls etc.

abMute(printf("test this\n"))

will produce nothing.

Relies on SKILL's dynamic scoping, so will not work in SKILL++
unless you do:

inSkill(abMute(printf("test this\n")))

***************************************************

SCCS Info: @(#) abMute.il 12/22/11.11:03:17 1.1

*/

(defmacro abMute (@rest body)
  `(progn
     (unless (openportp (getqq abMute nullport))
       (putpropqq abMute (outfile "/dev/null") nullport))
     (let ((poport (getqq abMute nullport)))
       ,@body
       )
     )
  )