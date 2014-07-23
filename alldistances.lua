--[[
Compute the all-pairs distance between the coordiantes.
This code is serial, and it takes approx 3h30min to complete on the input coordantes.
Once parallelized (using LuaLanes or others), we should observe massive speedup on multi-core machines.

--]]
require"os"
local sin, asin, cos, sqrt, rad = math.sin, math.asin, math.cos, math.sqrt, math.rad
function haversine_distance(a_lon, a_lat, b_lon, b_lat)
	local radius = 6371.0
	local lon_d = rad((b_lon - a_lon))
	local lat_d = rad((a_lat - a_lat))    
	local t1 = sin(lat_d / 2)^2 + cos(rad(a_lat)) * cos(rad(b_lat)) * sin(lon_d/2)^2
	local t2 = 2 * asin(sqrt(t1))
	return radius * t2
end
dofile("it-2004.sites.gpscoords.lua")
x = os.clock()
for i=1,#sites do
	local i_dist={}
	if sites[i]~=nil then
		for j=1,#sites do
			if sites[j]~=nil then
				table.insert(i_dist,haversine_distance(sites[i][1], sites[i][2], sites[j][1], sites[j][2]))
			--else
			--	table.insert(i_dist[j],-1)					
			end
		end
	--else
	--	table.insert(i_dist,-1)
	end
	print(table.concat(i_dist," "))
	--if i%100==0 then
	--	print(string.format("elapsed time: %.2f", os.clock() - x),i.."/"..#sites)
	--end
	--print(string.format("elapsed time: %.2f\n", (os.clock() - x), "Done: ",i.."/"..#sites)
end
