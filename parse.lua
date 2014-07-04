misc=require"splay.misc"
io.input("it-2004.sites.resolved")
l_c=0
for line in io.lines() do
	--print(line)
	l_c=l_c+1
	
	--local idx_lat_start,idx_lat_stop=line:find('latitude=')
	--local idx_lat_val=line:find(",",idx_lat_stop)
	
	local tokens=misc.split(line)
	if tokens[1]=="#<struct" then
		--print(tokens[12],tokens[13])
		local lat=tokens[12]:match("%p(%p*%d+%p%d+)%p")
		local lon=tokens[13]:match("%p(%p*%d+%p%d+)%p")		
		if lat ==nil or  lon==nil then
			--print(line)
		else
			print(lon,lat)		
		end
		--local long=misc.split(tokens[13],"=")[2]
		--print(lat,long)
	end
end