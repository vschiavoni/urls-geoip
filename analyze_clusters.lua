dofile("stats.lua")

local sin, asin, cos, sqrt, rad = math.sin, math.asin, math.cos, math.sqrt, math.rad
function haversine_distance(a_lon, a_lat, b_lon, b_lat)
	local radius = 6371.0
	local lon_d = rad((b_lon - a_lon))
	local lat_d = rad((a_lat - a_lat))    
	local t1 = sin(lat_d / 2)^2 + cos(rad(a_lat)) * cos(rad(b_lat)) * sin(lon_d/2)^2
	local t2 = 2 * asin(sqrt(t1))
	return radius * t2
end

function analyze(clusters,type_of_cluster,partitions)
	--from this moment on, every clusters[k] lists the sites in the cluster for different groupings
	local all_avg_stdev={}
	for k,cluster in pairs(clusters) do				
		local cluster_size=#cluster
		print("Cluster:",k,"sites in cluster:",cluster_size)
		local long,lat=0,0
		--compute the gravity-center/centroid of this cluster
		for _,site in pairs(cluster) do
			local site_long, site_lat = nil, nil						
			if type(site)=="table" then
				site_long, site_lat= table.unpack(site) --long/lat
				assert(site_long,site_lat)
			elseif 	type(site)=="number" then
				if sites[site]~=nil then 
					site_long, site_lat= table.unpack(sites[site]) --long/lat
				end				
			end
			if site_long and site_lat then
				long=long+site_long			
				lat	=lat+site_lat
			end							
		end
		local gravity_long=long/cluster_size
		local gravity_lat=lat/cluster_size
		print("Cluster gravity center:",gravity_long,gravity_lat)		
		--now compute teh distance of each point in this cluster from the gravity center
		--ugly because same loop as before, but how prevent it ?
		local distances={}
		for _,site in pairs(cluster) do
			
			local site_long, site_lat = nil, nil
			if type(site)=="table" then
				site_long, site_lat= table.unpack(site) --long/lat
				assert(site_long,site_lat)
			elseif 	type(site)=="number" then
				if sites[site]~=nil then 
					site_long, site_lat= table.unpack(sites[site]) --long/lat
				end				
			end
			if site_long and site_lat then
				local distance_from_center= haversine_distance(gravity_long, gravity_lat, site_long, site_lat)
				assert(distance_from_center)	
				table.insert(distances,distance_from_center)
			end				
		end
		
		table.sort(distances)
		print("Total distance values per cluster:",#distances)
		local percs=assert(percentiles({25,50,75,90},distances))
		io.output("distances_"..type_of_cluster.."_"..partitions..".txt") --generate CDFs over these values
		for _,dis in pairs(distances) do
			io.write(dis.."\n")
		end
		io.close()
		print("Distance percentiles:",table.unpack(percs))
		stdev,avg=standardDeviation(distances)
		table.insert(all_avg_stdev,{avg,stdev})
		print("StDev/Mean distance:", stdev, avg)	
	end
	table.sort(all_avg_stdev,function(a,b) return a[1]<b[1] end)
	local f,err = io.open("data/avg_distances_"..type_of_cluster.."_"..partitions..".txt","w")
	for i,v in pairs(all_avg_stdev) do
		f:write(i," ",v[1]," ",v[2],"\n")					
	end
	f:close()
end