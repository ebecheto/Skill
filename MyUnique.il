;; http://www.cadence.com/Community/forums/p/22498/1317054.aspx#1317054
;; https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/22498/remove-duplicates-from-a-list

procedure(MyUnique(lst)
  let(((seen makeTable('seen nil)))
    setof(elem lst
      unless(seen[elem]
        seen[elem]=t
      )
    )
  )
)
