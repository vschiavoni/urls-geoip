set term postscript eps enhanced color 22
#set terminal pdf monochrome
set output "hypergraph_cluster_map.eps"
load "styles.inc"

set style fill transparent solid 0.5

set title "hypergraph Clustering (K=16)"
unset key
unset border
unset yzeroaxis
unset xtics
unset ytics

#
# plot world map and correspondent locations as a +
plot \
	'data/world_10m.txt' with lines ls 400 , \
	'data/cluster_coordinates_hypergraph_16_1.txt'  with points ls 40,\
	'data/cluster_coordinates_hypergraph_16_2.txt'  with points ls 41,\
	'data/cluster_coordinates_hypergraph_16_3.txt'  with points ls 42,\
	'data/cluster_coordinates_hypergraph_16_4.txt'  with points ls 43,\
	'data/cluster_coordinates_hypergraph_16_5.txt'  with points ls 44,\
	'data/cluster_coordinates_hypergraph_16_6.txt'  with points ls 45,\
	'data/cluster_coordinates_hypergraph_16_7.txt'  with points ls 46,\
	'data/cluster_coordinates_hypergraph_16_8.txt'  with points ls 47,\
	'data/cluster_coordinates_hypergraph_16_9.txt'  with points ls 48,\
	'data/cluster_coordinates_hypergraph_16_10.txt' with points ls 49,\
	'data/cluster_coordinates_hypergraph_16_11.txt' with points ls 50,\
	'data/cluster_coordinates_hypergraph_16_12.txt' with points ls 51,\
	'data/cluster_coordinates_hypergraph_16_13.txt' with points ls 52,\
	'data/cluster_coordinates_hypergraph_16_14.txt' with points ls 53,\
	'data/cluster_coordinates_hypergraph_16_15.txt' with points ls 54,\
	'data/cluster_coordinates_hypergraph_16_16.txt' with points ls 55
	
#set title ""
set key on
set border
set yzeroaxis
set xtics
set ytics

!epstopdf "hypergraph_cluster_map.eps"
!rm "hypergraph_cluster_map.eps"
quit