os=require"os"
dofile("stats.lua")
gps_dom_cache={}
gps_pos_cache={}
function init_gps_dom_cache()
	for k,v in pairs(sites) do
		local key=v[1]..":"..v[2]
		gps_dom_cache[key]=v[3]		
		gps_pos_cache[key]=k --reverse index for quick lookup
	end
	print("GPS_DOM_CACHE/GPS_POS_CACHE initialized.")
	
end

--initialize the domains_pages table
dofile("valid_domains_pages_0-65039.lua")
dofile("valid_domains_pages_65040-109381.lua")
assert(domains_pages)

function gps_to_domain(t)
	local key=t[1]..":"..t[2]
	return gps_dom_cache[key]
end
function gps_to_pos(t)
	local key=t[1]..":"..t[2]
	return gps_pos_cache[key]
end

function compute_imbalance(clusters, type_of_cluster, partitions, sites, imbalance_file)
	local all_cluster_sizes={}
	for k,cluster in pairs(clusters) do						
		local pages_for_sites_in_cluster=0
		local long,lat=0,0
		for _,site in pairs(cluster) do
			local site_pos=nil
			local site_long, site_lat = nil, nil						
			if type(site)=="table" then
				site_long, site_lat= table.unpack(site) --long/lat
				assert(site_long,site_lat)
			elseif 	type(site)=="number" then
				if sites[site]~=nil then 
					site_long, site_lat= table.unpack(sites[site]) --long/lat
				end				
			end
			if site_long and site_lat then
				local site_pos= gps_to_pos({site_long,site_lat})
				local site_pages= domains_pages[site_pos]
				if not site_pages then 
					print("Cannot find site_pages for site in pos: "..site_pos)
				else		
					pages_for_sites_in_cluster=pages_for_sites_in_cluster+site_pages
				end
			end			
		end		
		table.insert(all_cluster_sizes, pages_for_sites_in_cluster) --take into account pagesPerSite							
	end	
	local maxWeightedPart=math.max(table.unpack(all_cluster_sizes))
	local avgPartWeight= mean(all_cluster_sizes)
	local imbalance=(maxWeightedPart-avgPartWeight)/avgPartWeight
	imbalance_file:write(partitions, " ",imbalance,"\n")
end