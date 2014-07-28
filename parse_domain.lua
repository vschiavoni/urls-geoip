misc=require"splay.misc"
io.input("it-2004.sites.resolved")
io.output("it-2004.sites.gpscoords.lua")
io.write("sites={}\n")
math.randomseed(666)
BIG_UPPERBOUND=100000000000000000000
pm={-1,1}
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
		
		local idx_domain_start,idx_domain_stop=line:find('request=\"',1)
		local idx_domain_end=line:find("\"",idx_domain_stop+1)
		--print(idx_domain_stop,idx_domain_end)
		local domain=line:sub(idx_domain_stop+1,idx_domain_end-1)
		--add small noise to the values, to prevent duplicates as much as possible
		lat =tonumber(lat) +(math.random(1,BIG_UPPERBOUND)/BIG_UPPERBOUND)*pm[math.random(2)]
		long=tonumber(long)+(math.random(1,BIG_UPPERBOUND)/BIG_UPPERBOUND)*pm[math.random(2)]						
		print(lat..","..long..","..domain)
		io.write("sites["..l_c.."]={"..long..","..lat..",\""..domain.."\"}\n")
	end
end
