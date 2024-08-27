;; copyleft ebecheto

ineed('MyUnique)
;procedure(MyUnique(lst) let(((seen makeTable('seen nil))) setof(elem lst unless(seen[elem] seen[elem]=t))))
defun(getCdsDefTechLib (@optional (force nil)) let((techLibNames)
when(force ddSetForcedLib("") ddUpdateLibList())
techLibNames=remove(nil foreach(mapcan lib  ddGetLibList() foreach(mapcan pro setof(prop lib~>prop prop~>name=="techLibName") list(pro~>value))))
remove("cdsDefTechLib" MyUnique(techLibNames));=> ("cdsDefTechLib" "SG13_dev")
))