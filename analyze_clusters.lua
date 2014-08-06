os=require"os"
dofile("stats.lua")
gps_dom_cache={}
gps_pos_cache={}
function init_gps_dom_cache()
	for k,v in pairs(sites) do
		local key=v[1]..":"..v[2]
		gps_dom_cache[key]=v[3]		
		gps_pos_cache[key]=k --reverse index for quick lookup
	end
	print("GPS_DOM_CACHE/GPS_POS_CACHE initialized.")
	
end

--initialize the domains_pages table
dofile("valid_domains_pages_0-65039.lua")
dofile("valid_domains_pages_65040-109381.lua")
assert(domains_pages)

function gps_to_domain(t)
	local key=t[1]..":"..t[2]
	return gps_dom_cache[key]
end
function gps_to_pos(t)
	local key=t[1]..":"..t[2]
	return gps_pos_cache[key]
end

local sin, asin, cos, sqrt, rad = math.sin, math.asin, math.cos, math.sqrt, math.rad
function haversine_distance(a_lon, a_lat, b_lon, b_lat)
	local radius = 6371.0
	local lon_d = rad((b_lon - a_lon))
	local lat_d = rad((a_lat - a_lat))    
	local t1 = sin(lat_d / 2)^2 + cos(rad(a_lat)) * cos(rad(b_lat)) * sin(lon_d/2)^2
	local t2 = 2 * asin(sqrt(t1))
	return radius * t2
end

function analyze(clusters,type_of_cluster,partitions, sites, imbalance_file)
	local cluster_domains,err=io.open("data/cluster_domains_"..type_of_cluster.."_"..partitions..".txt","w")	
	for k,nodes_cluster in pairs(clusters) do
		for _,v in pairs(nodes_cluster) do
			local domain = nil
			if type(v)=="number" then --hypergraph input
				domain = sites[v][3]
			else --in this case, v is a table (kmeans, random)
				if type_of_cluster=="kmeans" then
					v[1],v[2]=v[2],v[1] --in kmeans, values are swapped
				end
				domain=gps_to_domain(v)
			end	
	 		cluster_domains:write(k, " ", domain,"\n")					
		end
	end	
	cluster_domains:close()
	
	--from this moment on, every clusters[k] lists the sites in the cluster for different groupings
	local all_avg_stdev={}
	local all_cluster_sizes={}
	for k,cluster in pairs(clusters) do				
		local cluster_coords,err = io.open("data/cluster_coordinates_"..type_of_cluster.."_"..partitions.."_"..k..".txt","w")
	
		local cluster_size=#cluster
		
		local pages_for_sites_in_cluster=0
		
		--table.insert(all_cluster_sizes, cluster_size) --does not take into account pagesPerSite
		print("Cluster:",k,"sites in cluster:",cluster_size)
		local long,lat=0,0
		--compute the gravity-center/centroid of this cluster
		for _,site in pairs(cluster) do
			
			local site_pos=nil
			
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
			if site_long and site_lat then
				cluster_coords:write(site_lat," ",site_long,"\n")
				
				local site_pos= gps_to_pos({site_long,site_lat})
				local site_pages= domains_pages[site_pos]
				if not site_pages then 
					print("Cannot find site_pages for site in pos: "..site_pos)
				else		
					pages_for_sites_in_cluster=pages_for_sites_in_cluster+site_pages
				end
			end			
			--now add the number of pages associated with this site to the all_cluster_sizes						
		end
		
		table.insert(all_cluster_sizes, pages_for_sites_in_cluster) --take into account pagesPerSite						
		
		
		cluster_coords:close()
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
		io.output("data/distances_"..type_of_cluster.."_"..partitions..".txt") --generate CDFs over these values
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
	
	local maxWeightedPart=math.max(table.unpack(all_cluster_sizes))
	local avgPartWeight= mean(all_cluster_sizes)
	local imbalance=(maxWeightedPart-avgPartWeight)/avgPartWeight
	
	imbalance_file:write(partitions, " ",imbalance,"\n")
	
	local sizef_name="size_clusters_"..type_of_cluster.."_"..partitions..".txt"
	local sizef,err=io.open("data/"..sizef_name,"w")
	sizef:write(table.concat(all_cluster_sizes,"\n"))
	sizef:close()
	--write the imbalance to the head of each file
	os.execute("touch data/cdf_"..sizef_name)
	local cdffile,err=io.open("data/cdf_"..sizef_name,"w")
	cdffile:write("#imbalance "..imbalance.."\n")
	cdffile:close()
	os.execute("ruby gen_cdf.rb -f data/"..sizef_name.." >> data/cdf_"..sizef_name)
	os.remove(sizef_name)
	
end