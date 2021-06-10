procedure(CCFyankFigs()
    enterBox(
        ?prompts list(
            "Point at the first corner of the yank rectangle"
            "Point at the opposite corner of the yank rectangle"
        )
        ?cmdName "CCFyankFigs"
        ?doneProc "CCFyankFigsDone")
)

procedure(CCFyankFigsDone(win ok points)
    let((cv rect refPoint)
        when(ok
            cv=geGetEditCellView(win)
            refPoint=enterPoint(
                ?prompts list("Point at reference point for yank")
            )
            destructuringBind(((llx lly) (urx ury)) points
                rect=list(llx:lly urx:lly urx:ury llx:ury)
                leYankFigs(cv rect 32 refPoint)
            )
        )
    )
)