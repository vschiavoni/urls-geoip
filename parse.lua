misc=require"splay.misc"
io.input("it-2004.sites.resolved")
l_c=0
for line in io.lines() do
	--print(line)
	l_c=l_c+1
	
	--local idx_lat_start,idx_lat_stop=line:find('latitude=')
	--local idx_lat_end=line:find(",",idx_lat_stop)
	--local lat=line:sub(idx_lat_start,idx_lat_end)
	--print("LAT:"..lat)
	local tokens=misc.split(line)
	if tokens[1]=="#<struct" then
		
		local idx_lat_start,idx_lat_stop=line:find('latitude=',1)
		local idx_lat_end=line:find(",",idx_lat_stop)
		local lat=line:sub(idx_lat_stop+1,idx_lat_end-1)
		--print("LAT:"..lat)
		
		local idx_long_start,idx_long_stop=line:find('longitude=',1) --from the beginning
		local idx_long_end=line:find(",",idx_long_stop)
		local long=line:sub(idx_long_stop+1,idx_long_end-1)		
		--print("LONG:"..long)
		
		print(long,lat)
		
		----print(tokens[12],tokens[13])
		--local lat=tokens[12]:match("%p(%p*%d+%p%d+)%p")
		--local lon=tokens[13]:match("%p(%p*%d+%p%d+)%p")		
		--if lat ==nil or  lon==nil then
		--	print("Some error occurred while parsing line:"..line)
		--else
		--	print(lon,lat)		
		--end		
	end
end