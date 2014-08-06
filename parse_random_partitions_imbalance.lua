--[[
Generate 100 different random partitioning clusters using 100 seeds.
]]

dofile("it-2004.sites.gpscoords_dom.lua") --precomputed by: lua parse_latlong.lua
assert(sites)
dofile("compute_imbalance.lua")
init_gps_dom_cache()

type_of_cluster="random"

parts={16,32,64,128,256,512,1024}

for s=1,100 do
	print("Computing imbalance for seed",s)
	local imbalance_file,err=io.open("random_partitions/"..s.."/imbalance_"..s.."_"..type_of_cluster..".txt","w")
	for _,p in pairs(parts) do
		dofile("random_partitions/"..s.."/random_cluster_"..p..".lua")
		assert(clusters)
		compute_imbalance(clusters, type_of_cluster, p, sites, imbalance_file)	
		clusters=nil 
	end
	imbalance_file:close()
end


