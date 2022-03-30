Given 'as is', 
from microelectronic EDA tool Cadence © icfb 5141 to virtuoso 615, here is a bunch of skill function written over the years.
Some function where written in the beginning and so less 'clean'.

1. in ~/.bashrc : export SKILLDIR=$HOME/Skill
2. copy skillMode.el in ~/.emacs.d/
3. add load("~/.emacs.d/skillMode.el") in ~/.emacs
4. add loadi(strcat(getShellEnvVar("SKILLDIR") "/menu.il")) in your ~/.cdsinit_personal

Since i created the function (file) named 'ineed' (ineed.il), I used the convention : one function, one file. It is similar to "require/import/include"-like feature. From that command, i load all the files that << I need >>.

I still do not know how to handle package for skill function properly. Something like python 'import' philosophy would be nice.

ab*.il files are not mine obviously, but since i use them once in a while i added them here to keep my scripts functionnal

See  &#x1F34E;
 [ example directory ](example/) 
&#x1F34E;
:star: :star: :star: 
for explained pictures


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
