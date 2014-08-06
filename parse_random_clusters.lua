dofile("it-2004.sites.gpscoords_dom.lua") --precomputed by: lua parse_latlong.lua
--dofile("it-2004.sites.gpscoords-0_65039.lua")
--dofile("it-2004.sites.gpscoords-65040_132020.lua")
--dofile("it-2004.sites.gpscoords-132021_141252.lua")
assert(sites)
dofile("analyze_clusters.lua")
init_gps_dom_cache()


type_of_cluster="random"
imbalance_file,err=io.open("data/imbalance_"..type_of_cluster..".txt","w")	

parts={16,32,64,128,256,512,1024}

for _,p in pairs(parts) do
	dofile("random_cluster_"..p..".lua")
	assert(clusters)
	analyze(clusters, type_of_cluster, p, sites, imbalance_file)	
	clusters=nil 
end

imbalance_file:close()