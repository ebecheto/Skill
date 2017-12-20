procedure(MYtraverseHier(cvId @optional (done makeTable('cellViewsDone nil)))
  ; do whatever change you want here - e.g. layer change
  ; now traverse the hierarchy
  foreach(master cvId~>instanceMasters
      ; filter out anything done before, or pcell instances
      ; could extend this condition to filter out certain libraries - do what you want
      unless(done[master] || master~>superMaster  
        done[master]=t
        MYtraverseHier(master done)
      )
  )
); This is not tested, but it's a fairly standard recursive hierarchy traversal. 

