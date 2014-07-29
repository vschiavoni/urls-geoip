dofile("it-2004.sites.gpscoords.lua")
misc=require"splay.misc"
io.input("it-2004.sites.resolved")
l_c=0
for line in io.lines() do
	--print(line)
	l_c=l_c+1		
	local tokens=misc.split(line)
	if tokens[1]=="#<struct" then			
		local idx_domain_start,idx_domain_stop=line:find('request=\"',1)
		local idx_domain_end=line:find("\"",idx_domain_stop+1)
		local domain=line:sub(idx_domain_stop+1,idx_domain_end-1)
		sites[l_c][3]=domain
	end
end
io.stdout:write("sites={}\n")
for k,v in pairs(sites) do
	io.stdout:write("sites["..k.."]={",v[1],",",v[2],",\"",v[3],"\"}\n")
end
