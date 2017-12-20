for file in *.il ; do cat $file | emacs -batch -l text2rtf.el > RTF/$file.rtf;done


# cat loard.org |emacs -batch -l text2rtf.el -f "(process-color-file)"
