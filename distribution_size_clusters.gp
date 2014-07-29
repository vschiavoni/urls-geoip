set term postscript monochrome eps enhanced 22
set output "distribution_size_clusters.eps"
load "styles.inc"
#set size 1,0.65

X_MARGIN=0.10
Y_MARGIN=0.04
WIDTH_IND=0.475
HEIGHT_IND=0.5
WIDTH_BETWEEN_X=0.01
WIDTH_BETWEEN_Y=0

set size 2.1,1.05


set bmargin 1
set tmargin 2
set lmargin 4.8
set rmargin 1
unset key
set multiplot

set ylabel "CDF"
#set xlabel "Nodes in cluster"
#set xrange [0:4000]
#set xtics ("0.1KB" 0.1, "1KB" 1,"10KB" 10,"100KB" 100, "1MB" 1000)
#set logscale x
#set xrange [0.1:]
set grid y
#set ytics 97,0.5,100
set yrange [0:100]
#set xrange [0.1:20000]
#set logscale x
set xtics font "Arial,11pt"
#set key bottom right samplen 1 width 1

X_POS=0
Y_POS=1
set title "16 clusters" offset 0,-0.8
#unset key
#unset ylabel
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND
#f(x)=1000000
plot \
	'data/cdf_size_clusters_hypergraph_16.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_size_clusters_random_16.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_size_clusters_kmeans_16.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'
		 
X_POS=1
Y_POS=1
set title "32 clusters" offset 0,-0.8
unset ylabel
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND
plot \
	'data/cdf_size_clusters_hypergraph_32.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_size_clusters_random_32.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_size_clusters_kmeans_32.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'
		
X_POS=2
Y_POS=1
set title "64 clusters" offset 0,-0.8

set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND

plot \
	'data/cdf_size_clusters_hypergraph_64.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_size_clusters_random_64.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_size_clusters_kmeans_64.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'

X_POS=3
Y_POS=1
set title "128 clusters" offset 0,-0.8

set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND

plot \
	'data/cdf_size_clusters_hypergraph_128.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_size_clusters_random_128.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_size_clusters_kmeans_128.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'


X_POS=0
Y_POS=0
set title "256 clusters" offset 0,-0.8
set ylabel "CDF"
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND

plot \
	'data/cdf_size_clusters_hypergraph_256.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_size_clusters_random_256.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_size_clusters_kmeans_256.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'



X_POS=1
Y_POS=0
set title "512 clusters" offset 0,-0.8
unset ylabel
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND
#set xtics 0,2000,12000
plot \
	'data/cdf_size_clusters_hypergraph_512.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_size_clusters_random_512.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_size_clusters_kmeans_512.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'


X_POS=2
Y_POS=0
set title "1024 clusters" offset 0,-0.8

set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND
set key samplen 1 width -1 at 2500,100
plot \
	'data/cdf_size_clusters_kmeans_1024.txt'  u ($1):($6*100)\
		 w l ls 3 title 'KMeans',\
  	'data/cdf_size_clusters_random_1024.txt'  u ($1):($6*100)\
  		 w l ls 4 title 'Random',\
	'data/cdf_size_clusters_hypergraph_1024.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph'
 	
	              
!epstopdf "distribution_size_clusters.eps"
!rm "distribution_size_clusters.eps"
quit