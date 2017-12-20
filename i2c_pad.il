;; load("~/Skill/i2c_pad.il")
load("~/Skill/names.il")


g=gets(nextLine myPort)


nextLine = nil
myPort = infile("~/Skill/names.il")
nextLine=cons(nextLine list(gets(nextLine myPort)))


wordList=nil
myPort = infile("~/Skill/names.il")
while(fscanf( myPort "%d:Ctrl-C" number)
fscanf( myPort "%s" word)
wordList=cons(word wordList)
     ) 
myPort=nil


wordList