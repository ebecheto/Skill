;bof ...
defun(listit (listornotlist)
unless(listp(listornotlist) listornotlist=list(listornotlist))
foreach(element listornotlist
unless(listp(element) element=list(listornotlist))
))
