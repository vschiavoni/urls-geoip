function split(s, sep)
       local res = {}
       sep = sep or ' '
       for v in s:gmatch('[^' .. sep .. ']+') do
               res[#res + 1] = v
       end
       return res
end

local file_hops,err = io.open("traceroute_hops.txt","w")
local file_latencies,err = io.open("traceroute_latencies.txt","w")

io.input("traceroute")
start_read=os.time()

--[[
Input line:
1340158500      189.81.25.249   182.181.120.56  udp     1:200.164.176.130:20ms,30ms,30ms;2:200.164.28.125:30ms,30ms,20ms;
3:200.223.44.233:30ms,30ms,30ms;4:200.223.254.121:40ms,50ms,40ms;5:200.223.45.173:70ms,60ms,70ms;6:200.223.46.138:210ms,170ms,170ms;
7:63.218.9.237:260ms,240ms,200ms;8::*,*,*;9:154.54.31.161:190ms,200ms,160ms;10:154.54.24.97:180ms,200ms,200ms;
11:154.54.41.18:180ms,180ms,200ms;12:154.54.43.153:240ms,250ms,250ms;13:154.54.59.238:250ms,260ms,260ms;
14:154.54.39.134:260ms,270ms,260ms;15:149.6.154.170:360ms,360ms,360ms;16:202.125.128.173:360ms,350ms,360ms;
17:221.120.251.2:410ms,400ms,370ms;

First  token: timestamp
Second token: source IP
Third  token: destination IP
Fourth token: protocol
Fifth  token: traceroute path
]]

for l in io.lines() do
	local tokens=split(l,'\t')
	local s=tokens[2]
	local d=tokens[3]
	local path=tokens[5]
	--now split the path, hops separated by ';'
	if path~=nil then
		local hops=split(path,';') 
		file_hops:write(#hops,"\n")
		--splite the latencies
		for _,h in pairs(hops) do
			local latencies_s =split(h,':')[3]
			if latencies_s~=nil then 
		
				local lat_sum=0
				local lat_values=0
				for num in latencies_s:gmatch("(%d+)") do 
					lat_sum= lat_sum+num
					lat_values=lat_values+1
				end
				local avg_latencies_until_this_hop=lat_sum/lat_values
				file_latencies:write(avg_latencies_until_this_hop, "\n")		
			end
	
		end	
	else
		--print("Error: Malformed line:",l)
	end
end
stop_read=os.time()-start_read
print("Reading took:", stop_read, "seconds")

file_hops:close()
file_latencies:close()