;; copyleft ebecheto

defun(ibBox (@optional (inst css())) dbTransformBBox(car(setof(x inst~>master~>shapes x~>layerName=="instance" && x~>objType=="rect")~>bBox) inst~>transform))
