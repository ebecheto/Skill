Problem statement: 	

I have contacts placed in an array. The contacts are rectangles on the “CS” layer. The contact to contact spacing in our layout is violating the DRC rules. Therefore I would like to remove contacts, so that they start either from the top most contact or left most contact and then remove every other contact. How can this be done?

		
				
		Solution: 	

You can use this SKILL routine to remove the contacts. The function leSearchHierarchy is used in this procedure and is hardcoded to search “any shape” on layer “CS”. The code can be modified to search for “contact” or “inst” with leSearchHierarchy and will delete every other “contact” or “inst”.



/******************************************************************** 
* DISCLAIMER: The following code is provided for Cadence customers * 
* to use at their own risk. The code may require modification to   * 
* satisfy the requirements of any user. The code and any    * 
* modifications to the code may not be compatible with current or  * 
* future versions of Cadence products. * 
* THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING   * 
* WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES  * 
* OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE. * 
********************************************************************/
procedure(CCSDeleteAltCont(@optional (cv geGetWindowCellView()))
     let((firstPoint secondPoint list_cont sort_xy rows columns X bBox new_list
     first_xy)

	 firstPoint=enterPoint(?prompts list("Enter first point of Bounding Box"))
	    secondPoint=enterPoint(?prompts list("Enter second point of Bounding
	    Box"))
  
		bBox=list(firstPoint secondPoint)

		   list_cont=leSearchHierarchy(cv bBox 0 "any shape"
		   list(list("layer" "==" list("CS" "drawing"))))

		   first_xy=nil
		      foreach(bBox1 list_cont~>bBox
			first_xy=cons(car(bBox1) first_xy)
		      )
		   first_xy=reverse(first_xy)
	      sort_xy=sort(first_xy lambda((a b) CCScompareList(a b '(1 2))))
	printf("\n %L \n%L" length(sort_xy) sort_xy)
   new_list=list()
X=car(nth(0 sort_xy))

rows=length(setof(x sort_xy car(x)==X))
columns=length(sort_xy)/rows

printf("\n Rows = %L \n Columns = %L" rows columns)
  new_list=nil

      for(i 0 columns-1
	  if(evenp(i) then
		for(j 0 rows-1
		      if(oddp(j) then
	     new_list=cons(nth(j+i*rows sort_xy) new_list)
	  ) ;if 
	) ; for j
else
	for(j 0 rows-1
		if(evenp(j) then
		new_list=cons(nth(j+i*rows sort_xy) new_list)
	     ) ;if
	 ) ; for
       ) ;if
)

foreach(xx list_cont
if(!member(car(xx~>bBox) new_list) then nil
else
dbDeleteObject(xx)
) ;if
) ; foreach

printf("\n Alternate contacts deleted ..")
) ; let
) ; procedure

procedure(CCScompareList(a b order)
 let((less v1 v2)
   forall(n order
     (v1=nthelem(n a))==(v2=nthelem(n b)) || (less=lessp(v1 v2)) && nil
   ) ; forall
   less
 ) ; let
) ; procedure


