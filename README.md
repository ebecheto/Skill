Given 'as is', 
from icfb 5141 to virtuoso 615, here is a bunch of skill function written over the years.
Some function where written in the beginning and so less 'clean'.

1) in ~/.bashrc : export SKILLDIR=$HOME/Skill
2) copy skillMode.el in ~/.emacs.d/
3) add load("~/.emacs.d/skillMode.el") in ~/.emacs

Since i created the funcion (file) named 'ineed' (ineed.il), I used the convention : one function, one file.

I still do not know how to handle package for skill function properly. Something like python 'import' philosophy would be nice.

ab*.il files are not mine obviously, but since i use them once in a while i added them here to keep my scripts functionnal


``` lisp
;; syntax coloring test for lisp like on github
(foreach mapcar x  logRg(1e-15 1e+15 1.0/3) aelSuffixNotation(x))

```

``` clojure
;; syntax coloring test for clojure like on github
(foreach mapcar x  logRg(1e-15 1e+15 1.0/3) aelSuffixNotation(x))
``` 

``` scheme
;; syntax coloring test for scheme like on github
(foreach mapcar x  logRg(1e-15 1e+15 1.0/3) aelSuffixNotation(x))
``` 

``` common lisp 
;; common lisp ?
(foreach mapcar x  logRg(1e-15 1e+15 1.0/3) aelSuffixNotation(x))
``` 
