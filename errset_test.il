unless(errset(load("bad.il") nil)
     printf("Problem during %s\n" car(errset.errset))
     printf("Error was %s\n" buildString(nth(4 errset.errset)))
     )


unless(errset(load("bad.il") nil)
printf("ERR:%L\n" errset.errset))


unless(errset(load("bad.il") nil)
printf("ERR:%L\n" 
errset.errset
))

error( "Prints the red color" )



unless(errset(load("bad.il") nil)
error(car(parseString(nth(5 errset.errset)  "*Error* "))
))
