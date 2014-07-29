dofile("it-2004.sites.gpscoords_dom.lua") --precomputed by: lua parse_latlong.lua
assert(sites)
dofile("analyze_clusters.lua")
init_gps_dom_cache()
parts={16,32,64,128,256,512,1024}

for _,p in pairs(parts) do
	dofile("k-means-result_k_"..p..".lua")
	assert(clusters)
	analyze(clusters,"kmeans",p,sites)	
	clusters=nil 
end
