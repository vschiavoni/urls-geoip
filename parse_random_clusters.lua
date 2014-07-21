dofile("it-2004.sites.gpscoords.lua") --precomputed by: lua parse_latlong.lua
assert(sites)
dofile("analyze_clusters.lua")

parts={16,32,64,128,256,512,1024}

for _,p in pairs(parts) do
	dofile("random_cluster_"..p..".lua")
	assert(clusters)
	analyze(clusters)	
	clusters=nil 
end