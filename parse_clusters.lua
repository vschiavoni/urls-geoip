
----return angle and euclidian distance between two points on a thorus (as lat/long coordinates)
--function dist_angle(x1,y1,x2,y2)	
--	local deltaY=y2-y1
--	local deltaX=x2-x1
--	local deg = math.deg(math.atan2(deltaY,deltaX))
--	local dist = math.sqrt( 
--			math.min(math.abs(x1-x2), torus_w - math.abs(x1-x2))^2 + 
--			math.min(math.abs(y2-y1), torus_h - math.abs(y1-y2))^2 )
--	return dist,deg
--end
----these are the thorus boundaries. we can precompute them, in a real impl
----the boundaries should be computed against the currently known area. 
--max_x, min_x, max_y, min_y =0,0,0,0
--torus_w, torus_h = nil,nil
--function refresh_torus_boundaries(nodes)
--	for _,coords in pairs(nodes) do
--		local nlat,nlong =coords[1], coords[2]	
--		if nlat<min_x then min_x=nlat end
--		if nlong<min_y then min_y=nlong end		
--		if nlat>max_x then max_x=nlat end
--		if nlong>max_y then max_y=nlong end		
--	end
--	torus_w = math.max( math.abs(max_x), math.abs(min_x)  ) + math.min( math.abs(max_x), math.abs(min_x) )
--	torus_h = math.max( math.abs(max_y), math.abs(min_y)  ) + math.min( math.abs(max_y), math.abs(min_y) )
--	--log:debug("Torus boundaries refreshed", torus_w, torus_h)
--end

local sin, asin, cos, sqrt, rad = math.sin, math.asin, math.cos, math.sqrt, math.rad
function haversine_distance(a_lon, a_lat, b_lon, b_lat)
	local radius = 6371.0
	local lon_d = rad((b_lon - a_lon))
	local lat_d = rad((a_lat - a_lat))    
	local t1 = sin(lat_d / 2)^2 + cos(rad(a_lat)) * cos(rad(b_lat)) * sin(lon_d/2)^2
	local t2 = 2 * asin(sqrt(t1))
	return radius * t2
end
--[[]]
misc=require"splay.misc"
print("Reading coordinate files from : it-2004.sites.gpscoords.lua")
dofile("it-2004.sites.gpscoords.lua") --precomputed by: lua parse_latlong.lua
assert(sites)

--refresh_torus_boundaries(sites)
--print("Torus_w:",torus_w)
--print("Torus_h:",torus_h)

parts={16,32,64,128,256,512,1024}
--parts={16} 

for _,p in pairs(parts) do

	local clusters={}
	local file_part="it-ascii.hypergraph.site.part."..p
	print("INPUT PARTITIONING:",file_part)
	io.input(file_part)
	local tokens_in_file_counter=0 
	local ln=0 --line number in current file
	local current_token=0
	for l in io.lines() do
		ln=ln+1		
		local tokens_in_line=misc.split(l," ")
		tokens_in_file_counter=tokens_in_file_counter + #tokens_in_line
		for _,t in pairs(tokens_in_line) do
			current_token=current_token+1
			current_token_cluster=tonumber(t)
			if current_token_cluster > p then 
				error("Invalid part size in ",file_part..":"..ln) --should not happen if file_part is well-formed
			end
			
			if clusters[current_token_cluster]==nil then
				clusters[current_token_cluster]={}
			end
			table.insert(clusters[current_token_cluster],tonumber(current_token))
		end		
	end
	print("Tokens:",tokens_in_file_counter) --all files have the same numbe of tokens, exactly 1 token per site
	
	--from this moment on, every clusters[k] lists the sites in the cluster for different groupings
	for k,cluster in pairs(clusters) do
		local cluster_size=#cluster
		print("Cluster:",k,"sites in cluster:",cluster_size)
		local long,lat=0,0
		--compute the gravity-center of this cluster
		for _,site in pairs(cluster) do
			if sites[site]~=nil then --this was an invalid DNS entryp
				local site_long, site_lat= table.unpack(sites[site]) --long/lat
				assert(site_long,site_lat)
				long=long+site_long
				lat=lat+site_lat
			end
		end
		local gravity_long=long/cluster_size
		local gravity_lat=lat/cluster_size
		print("Cluster gravity center:",gravity_long,gravity_lat)		
		--now compute teh distance of each point in this cluster from the gravity center
		--ugly because same loop as before, but how prevent it ?
		local distances={}
		for _,site in pairs(cluster) do
			if sites[site]~=nil then
				local site_long, site_lat= table.unpack(sites[site]) --long/lat
				local distance_from_center= haversine_distance(gravity_long, gravity_lat, site_long, site_lat)
				assert(distance_from_center)	
				table.insert(distances,distance_from_center)			
			end
		end
		table.sort(distances)
		local percs=assert(percentiles({25,50,75,90},distances))
		print("Distance percentiles:",table.unpack(percs))
		print("StDev/Mean distance:", standardDeviation(distances))			
	end
end
