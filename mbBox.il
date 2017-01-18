;; copyleft ebecheto

ineed('getMaxPoints)
defun(mbBox (@optional (inst css())) dbTransformBBox(getMaxPoints(inst~>master~>shapes~>bBox) inst~>transform))
