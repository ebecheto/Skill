;; https://community.cadence.com/cadence_technology_forums/f/48/t/35964
libName= "myLib"
ddId= ddGetObj(libName)
topCatId=ddCatOpen( ddId  "mosfet"   "a" )
subCatname="mosfet_nondefault"
subCatId=ddCatOpen( topCatId  subCatname   "a" )
Then I am getting list of cells I need to add to this new category. Those cells already exist in "mosfet" category. 
finalCellList=list("nch"  "pch"  "nch_dnw") 
 

After getting the cell names I copy schematic and symbol views of that cell in a new cell named <cellName>_nondefault.

foreach(cell finalCellList
   originalSchId=dbOpenCellViewByType(libName cell "schematic"  ""   "a")
   originalSymId=dbOpenCellViewByType(libName cell "symbol"   ""   "a")
   cell=strcat(cell "_nondefault")    
   duplicateSchId=dbCopyCellView(originalSchId libName cell "schematic" nil nil t)
   duplicateSymId=dbCopyCellView(originalSymId libName cell "symbol" nil nil t)      
   dbClose(originalSchId)
   dbClose(originalSymId)   
   cellList=append1(cellList cell)
)    

; I get the list of new cells and then try to add them to new category.

foreach(cell cellList
  itemId=ddCatAddItem(subCatId cell "cell")
  unless(itemId
     error("failed to add cell\n"))
)
    
ddCatSave(subCatId)
ddCatSave(topCatId)

ddCatClose(subCatId)
ddCatClose(topCatId)
ddUpdateLibList()

;cellList=nil 
; dbOpenCellViewByType functions (replacing the 4th argument from "" to "schematic" and "schematicSymbol" respectively) 
;  dbSave() before the dbClose 
; Was able to debug the cause for it. I was using ddCatOpen function. I was able to solve the problem by using ddCatOpenEx instead