set term postscript monochrome eps enhanced 22
set output "pages_domain.eps"
load "styles.inc"
set size 1,0.65
set bmargin 2.5
set tmargin 2
set lmargin 9
set rmargin 5
set title "Pages per site" offset 0,-0.5
set ylabel "CDF (% sites)"
#set xrange [0:4000]
#set xtics ("100B" 0.1, "1KB" 1,"10KB" 10,"100KB" 100, "1MB" 1000)
#set xrange [0.1:]
set grid y
set ytics 0,20,100
set yrange [0:100]
set key bottom right samplen 1 width 1

plot \
	'data/cdf_pages_domain.txt'  u ($1/1024):($6*100)\
		 w l ls 1 title '141.252 sites, 41.291.594 pages'
		 		                  
!epstopdf "pages_domain.eps"
!rm "pages_domain.eps"
quit
