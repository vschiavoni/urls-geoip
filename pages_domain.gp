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
set xtics ("1" 1, "10" 10,"100" 100,"1K" 1000, "10K" 10000, "100K" 100000)
#set xrange [0.1:]
set grid y
set ytics 0,20,100
set yrange [11:100]
#set logscale y
set logscale x
set key bottom left samplen 1 width 1

plot \
	'data/cdf_pages_domain_all.txt'  u ($1):($6*100)\
		 w l ls 1 title 'All: 141.252 sites, 41.291.594 pages',\
 	'data/cdf_pages_domain_valid.txt'  u ($1):($6*100)\
 		 w l ls 2 title 'Valid: 109.380 sites, 33.132.146 pages',\
  	'data/cdf_pages_domain_invalid.txt'  u ($1):($6*100)\
  		 w l ls 3 title 'Invalid: 31.872 sites, 8.159.448 pages'		 		                  
!epstopdf "pages_domain.eps"
!rm "pages_domain.eps"
quit
