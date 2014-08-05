dofile("it-2004.sites.gpscoords-0_65039.lua")
dofile("it-2004.sites.gpscoords-65040_132020.lua")
dofile("it-2004.sites.gpscoords-132021_141252.lua")
assert(sites)

misc=require"splay.misc"
io.input("it-2004.pageToSiteMap")
p=0
invalid_map={} --position in this map=site, value=number of pages in site
valid_map={} --position in this map=site, value=number of pages in site

valid_sites=0
invalid_sites=0
invalid_sites_pages=0
for l in io.lines() do
	p=p+1
	local t=misc.split(l)
	local site=tonumber(t[2])
	
	local is_valid=true
	if sites[site]==nil then
		invalid_sites=invalid_sites+1
		is_valid=false
		invalid_sites_pages=invalid_sites_pages+1
	end
	
	local tp = invalid_map
	if is_valid then tp = valid_map end
		
	--print(t[1],t[2])
	if tp[site]==nil then
		tp[site] = 1
	else
		tp[site]=tp[site]+1
	end
end
print("Total Pages:",p, "Valid pages:", (p-invalid_sites_pages), "Invalid Pages:",invalid_sites_pages)

a=0
for _,_ in pairs(invalid_map) do
	a=a+1
end
v=0
for _,_ in pairs(valid_map) do
	v=v+1
end
print("all_map entries:",a," valid_map entries:",v)

local f,err=io.open("pages_domain_invalid_count.txt","w")
for k,v in pairs(invalid_map) do
	f:write(k," ",v,"\n")
end
f:close()

local f,err=io.open("pages_domain_valid_count.txt","w")
for k,v in pairs(valid_map) do
	f:write(k," ",v,"\n")
end
f:close()