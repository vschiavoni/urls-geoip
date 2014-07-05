misc=require"splay.misc"
io.input("it-2004.sites.resolved")
io.output("it-2004.sites.gpscoords.lua")
io.write("sites={}\n")
l_c=0
for line in io.lines() do
	--print(line)
	l_c=l_c+1	
	local tokens=misc.split(line)
	if tokens[1]=="#<struct" then		
		local idx_lat_start,idx_lat_stop=line:find('latitude=',1)
		local idx_lat_end=line:find(",",idx_lat_stop)
		local lat=line:sub(idx_lat_stop+1,idx_lat_end-1)		
		local idx_long_start,idx_long_stop=line:find('longitude=',1) --from the beginning
		local idx_long_end=line:find(",",idx_long_stop)
		local long=line:sub(idx_long_stop+1,idx_long_end-1)					
		print(long,lat)
		io.write("sites["..l_c.."]={"..long..","..lat.."}\n")
	end
end