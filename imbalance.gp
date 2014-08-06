set term postscript monochrome eps enhanced 22
set output "imbalance.eps"
load "styles.inc"
set size 1,0.65
set bmargin 2.5
set tmargin 2
set lmargin 9
set rmargin 5
set title "Clustering Imbalance" offset 0,-0.5
set ylabel "Imbalance"
set xrange [0.5:7.5]
set yrange [0:4.5]
#set xlabel ""
set xtics ("16" 1, "32" 2,"64" 3,"128" 4, "256" 5, "512" 6, "1024" 7)
#set xrange [0.1:]
set grid y
#set ytics 0,20,100
#set yrange [11:100]
set key top left samplen 1 width 0.5

plot \
	'data/nl_imbalance_hypergraph.txt'  u ($1):($3)\
		 w lp ls 2 title 'Hypergraph',\
	'data/imbalance_random_partitions.txt'  u ($1):($3)\
		 w lp ls 4 title 'Random',\
 	'data/imbalance_random_partitions.txt'  u ($1):($3):($4)\
 		 w yerrorbars ls 4 notitle '',\
  	'data/nl_imbalance_kmeans.txt'  u ($1):($3)\
  		 w lp ls 3 title 'KMeans'
		 	 		                  
!epstopdf "imbalance.eps"
!rm "imbalance.eps"
quit
