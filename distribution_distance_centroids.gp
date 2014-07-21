set term postscript monochrome eps enhanced 22
set output "distribution_distance_centroids.eps"
load "styles.inc"
#set size 1,0.65

X_MARGIN=0.10
Y_MARGIN=0.04
WIDTH_IND=0.475
HEIGHT_IND=0.5
WIDTH_BETWEEN_X=0.01
WIDTH_BETWEEN_Y=0

set size 2.6,1.1


set bmargin 1
set tmargin 2
set lmargin 4.8
set rmargin 1
unset key
set multiplot

set ylabel "Distance from\n cluster centroid (CDF)"
#set xrange [0:4000]
#set xtics ("0.1KB" 0.1, "1KB" 1,"10KB" 10,"100KB" 100, "1MB" 1000)
#set logscale x
#set xrange [0.1:]
set grid y
#set ytics 97,0.5,100
set yrange [0:100]
set xrange [1:]
#set logscale x
set xtics font "Arial,16pt"
#set key bottom right samplen 1 width 1

X_POS=0
Y_POS=0
set title "16 clusters" offset 0,-0.8
unset key
#unset ylabel
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND
f(x)=1000000
plot \
	'data/cdf_distances_hypergraph_16.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_distances_random_16.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_distances_kmeans_16.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'
		 
X_POS=1
Y_POS=0
set title "32 clusters" offset 0,-0.8
unset ylabel
set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND
plot \
	'data/cdf_distances_hypergraph_32.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_distances_random_32.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_distances_kmeans_32.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'
		
X_POS=2
Y_POS=0
set title "64 clusters" offset 0,-0.8

set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND

plot \
	'data/cdf_distances_hypergraph_64.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_distances_random_64.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_distances_kmeans_64.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'

X_POS=3
Y_POS=0
set title "128 clients" offset 0,-0.8

set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
set size WIDTH_IND,HEIGHT_IND

plot \
	'data/cdf_distances_hypergraph_128.txt'  u ($1):($6*100)\
		 w l ls 2 title 'HyperGraph',\
 	'data/cdf_distances_random_128.txt'  u ($1):($6*100)\
 		 w l ls 4 title 'Random',\
 	'data/cdf_distances_kmeans_128.txt'  u ($1):($6*100)\
 		 w l ls 3 title 'KMeans'

#
#X_POS=4
#Y_POS=0
#set title "100 clients" offset 0,-0.8
#
#set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
#set size WIDTH_IND,HEIGHT_IND
#
#plot \
#	'data/cdf_read_100_dummy.txt'  u ($1):($2*100)\
#		 w l ls 2 title 'Naive',\
# 	'data/cdf_read_100_atomic.txt'  u ($1):($2*100)\
# 		 w l ls 4 title 'AtomicMap',\
# 	'data/cdf_read_100_treemap.txt'  u ($1):($2*100)\
# 		 w l ls 3 title 'TreeMap',\
# 	'data/cdf_read_100_shardedtree.txt'  u ($1):($2*100)\
# 	     w l ls 5 title 'ShardedTree'		 		 					  					  
#
#set ylabel "Read-Range Latencies\nCDF (% of queries)"
#X_POS=0
#Y_POS=1
#set title "10 clients" offset 0,-0.8
#
#set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
#set size WIDTH_IND,HEIGHT_IND
#
#plot \
#	'data/cdf_readranges_10_dummy.txt'  u ($1):($2*100)\
#		 w l ls 2 title 'Naive',\
# 	'data/cdf_readranges_10_atomic.txt'  u ($1):($2*100)\
# 		 w l ls 4 title 'AtomicMap',\
# 	'data/cdf_readranges_10_treemap.txt'  u ($1):($2*100)\
# 		 w l ls 3 title 'TreeMap',\
#  	'data/cdf_readranges_10_shardedtree.txt'  u ($1):($2*100)\
#  		 w l ls 5 title 'ShardedTree'
#		 				  
#					  
#unset ylabel		
#X_POS=1
#Y_POS=1
#set title "25 clients" offset 0,-0.8
#
#set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
#set size WIDTH_IND,HEIGHT_IND
#plot \
# 	'data/cdf_readranges_25_dummy.txt'  u ($1):($2*100)\
# 		 w l ls 2 title 'Naive',\
#  	'data/cdf_readranges_25_atomic.txt'  u ($1):($2*100)\
#  		 w l ls 4 title 'AtomicMap',\
#  	'data/cdf_readranges_25_treemap.txt'  u ($1):($2*100)\
#  		 w l ls 3 title 'TreeMap',\
#   	'data/cdf_readranges_25_shardedtree.txt'  u ($1):($2*100)\
#   		 w l ls 5 title 'ShardedTree'
#		 
#
#X_POS=2
#Y_POS=1
#set title "50 clients" offset 0,-0.8
#
#set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
#set size WIDTH_IND,HEIGHT_IND
#
#plot \
#	'data/cdf_readranges_50_dummy.txt'  u ($1):($2*100)\
#		 w l ls 2 title 'Naive',\
# 	'data/cdf_readranges_50_atomic.txt'  u ($1):($2*100)\
# 		 w l ls 4 title 'AtomicMap',\
# 	'data/cdf_readranges_50_treemap.txt'  u ($1):($2*100)\
# 		 w l ls 3 title 'TreeMap',\
#   	'data/cdf_readranges_50_shardedtree.txt'  u ($1):($2*100)\
#   		 w l ls 5 title 'ShardedTree'
#		 					  
#
#X_POS=3
#Y_POS=1
#set title "75 clients" offset 0,-0.8
#
#set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
#set size WIDTH_IND,HEIGHT_IND
#plot \
# 	'data/cdf_readranges_75_dummy.txt'  u ($1):($2*100)\
# 		 w l ls 2 title 'Naive',\
#  	'data/cdf_readranges_75_atomic.txt'  u ($1):($2*100)\
#  		 w l ls 4 title 'AtomicMap',\
#  	'data/cdf_readranges_75_treemap.txt'  u ($1):($2*100)\
#  		 w l ls 3 title 'TreeMap',\
#   	'data/cdf_readranges_75_shardedtree.txt'  u ($1):($2*100)\
#   		 w l ls 5 title 'ShardedTree'
#		 
#
#X_POS=4
#Y_POS=1
#set title "100 clients" offset 0,-0.8
#
#set origin X_MARGIN+(X_POS*(WIDTH_IND+WIDTH_BETWEEN_X)), Y_MARGIN+(Y_POS*(HEIGHT_IND+WIDTH_BETWEEN_Y))
#set size WIDTH_IND,HEIGHT_IND
#set key  samplen 1 width -1 bottom right
#
#plot \
#	'data/cdf_readranges_100_dummy.txt'  u ($1):($2*100)\
#		 w l ls 2 title 'Naive',\
# 	'data/cdf_readranges_100_atomic.txt'  u ($1):($2*100)\
# 		 w l ls 4 title 'HashMap',\
# 	'data/cdf_readranges_100_treemap.txt'  u ($1):($2*100)\
# 		 w l ls 3 title 'TreeMap',\
#  	'data/cdf_readranges_100_shardedtree.txt'  u ($1):($2*100)\
#  		 w l ls 5 title 'ShardedTree'
#		 					  
#			  
#			  
#					              
!epstopdf "distribution_distance_centroids.eps"
!rm "distribution_distance_centroids.eps"
quit