;;http://www.cadence.com/Community/forums/p/22498/1317054.aspx#1317054

procedure(MyUnique(lst)
  let(((seen makeTable('seen nil)))
    setof(elem lst
      unless(seen[elem]
        seen[elem]=t
      )
    )
  )
)
