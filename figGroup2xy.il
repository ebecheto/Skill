;ineed('figGroup2xy t)

;; cv=geGetWindowCellView()
;; cv~>figGroups
;; groups=geGetSelectedSet()
;; groups=geGetWindowCellView()~>figGroups
;; group=car(groups)
;; xy=0:1
;; there is no real sens to move all the groups in the same place.
;; the standard usage is more to select only one fig object
; dbMoveFig(M4shield nil list(35*199.92:0 "R0")) ;<= relative move

defun(figGroup2xy (@optional (xy 0:1) (groups nil))
"Move the selected groups to the xy absolute position"
"If you want relative displacement, use dbMoveFig(group nil list(X:Y \"R0\") directly ) "
unless(groups groups=geGetSelectedSet())
unless(groups groups=geGetWindowCellView()~>figGroups)
unless(listp(groups) groups=list(groups))
foreach(mapcar group groups
dbMoveFig(group nil list(mapcar('difference xy lowerLeft(group~>bBox)) "R0"))
))


"Whatif moves all groups only in X? usefull ?"
defun(figGroup2x (@optional (x 10) (groups nil))
unless(groups groups=geGetSelectedSet())
unless(groups groups=geGetWindowCellView()~>figGroups)
unless(listp(groups) groups=list(groups))
foreach(mapcar group groups
figGroup2xy(x:cadar(group~>bBox) groups)
))
