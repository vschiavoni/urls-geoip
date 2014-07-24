--[[
Compute the all-pairs distance between the coordiantes.
--]]
require"os"
local sin, asin, cos, sqrt, rad = math.sin, math.asin, math.cos, math.sqrt, math.rad
local dr2 = 0.0174532925199433 --replace calls to math.rad(..)
function haversine_distance(a_lon, a_lat, b_lon, b_lat)
	local radius = 6371.0
	local lon_d = dr2*(b_lon - a_lon)
	local lat_d = dr2*(a_lat - a_lat)    
	local t1 = sin(lat_d / 2)^2 + cos(dr2*(a_lat)) * cos(dr2*(b_lat)) * sin(lon_d/2)^2
	local t2 = 2 * asin(sqrt(t1))
	return radius * t2
end
--the dofile imports the sites table in the global namespace
dofile("it-2004.sites.gpscoords-0_65039.lua")
io.stderr:write(#sites,"\n")
dofile("it-2004.sites.gpscoords-65040_132020.lua")
io.stderr:write(#sites,"\n")
dofile("it-2004.sites.gpscoords-132021_141252.lua")
io.stderr:write(#sites,"\n")
x = os.clock()
for i=1,#sites do
	local i_dist={}
	local c_i=1 --index for the current column
	if sites[i]~=nil then
		local sites_i = sites[i]
		for j=1,#sites do
			local sites_j = sites[j] 
			if sites_j ~=nil then
				i_dist[c_i]= haversine_distance(sites_i[1], sites_i[2], sites_j[1], sites_j[2])				
			else
				i_dist[c_i]=-1
			end
			c_i=c_i+1
		end
	end
	local to_s=table.concat(i_dist," "),"\n"
	io.stdout:write(to_s)
	if i%100==0 then
		io.stderr:write(string.format("Elapsed: %.2f", os.clock() - x)," ",i,"/",#sites," ",(i/#sites)*100,"\n")
	end
end
