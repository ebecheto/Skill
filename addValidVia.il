;; copyleft ebecheto
; ** add M1_PO via to the possible interconnection **
;; inspired from Virtuoso Layout Suite Frequently Asked Questions

defun( addValidVia (@optional (cv nil)  (viaDefinition "M1_PO"))
let((viaDefinition currCG techId cstG validVia)
unless(cv cv=geGetWindowCellView())
viaDefinition="M1_PO"
currCG=envGetVal("layout" "wireConstraintGroup");=> "virtuosoDefaultSetup"
techId=techGetTechFile(cv)
cstG=cstFindConstraintGroupIn(techId currCG)
validVia=car(setof(x cstG~>objects  x~>defName=="validVias"))
unless(member(viaDefinition validVia~>value ) validVia~>value=append(validVia~>value list(viaDefinition)))
))