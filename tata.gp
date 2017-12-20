set grid; replot
set cntrparam levels auto 30; replot
set contour; replot
; unset contour; replot

splot '/home/validmgr/ebecheto/Work/IC6_soft/file_temp_-150.dat' every 50  with lines,\
      '/home/validmgr/ebecheto/Work/IC6_soft/file_temp_27.dat'  every 50 with lines
set isosample 2; replot
unset isosample ; replot
unset surface
set cntrparam levels incremental 1.65, 0.1, 3; replot
set view 0,0; replot
set surface

splot    '/home/validmgr/ebecheto/Work/IC6_soft/file_temp_-150.dat'  every 20 with lines

splot    '/home/validmgr/ebecheto/Work/IC6_soft/file_temp_-150.dat'   with lines

set cntrparam levels incremental 2.17, 0.001, 3; replot
