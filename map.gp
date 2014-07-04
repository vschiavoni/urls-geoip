set term postscript monochrome eps enhanced 22
set output "map.eps"
load "styles.inc"

#set title "Geographical Coordinates"
unset key
unset border
unset yzeroaxis
unset xtics
unset ytics
#
# plot world map and correspondent locations as a +
plot \
	'data/world_10m.txt' with lines ls 40 , \
	'data/urls_coordinates.txt' with points ls 41 
set title ""
set key on
set border
set yzeroaxis
set xtics
set ytics

!epstopdf "map.eps"
!rm "map.eps"
quit