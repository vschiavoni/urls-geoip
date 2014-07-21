dofile("it-2004.sites.gpscoords.lua") --precomputed by: lua parse_latlong.lua
assert(sites)
dofile("analyze_clusters.lua")

parts={16,32,64,128,256}

for _,p in pairs(parts) do
	dofile("../k-means-geographic-clustering/k-means-result_k_"..p..".lua")
	assert(clusters)
	analyze(clusters)	
	clusters=nil 
end