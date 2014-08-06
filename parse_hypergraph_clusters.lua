misc=require"splay.misc"
dofile("it-2004.sites.gpscoords_dom.lua") --precomputed by: lua parse_latlong.lua
dofile("analyze_clusters.lua")
init_gps_dom_cache()
parts={16,32,64,128,256,512,1024}
type_of_cluster="hypergraph"
imbalance_file,err=io.open("data/imbalance_"..type_of_cluster..".txt","w")	

for _,p in pairs(parts) do

	local clusters={}
	local file_part="it-ascii.hypergraph.site.part."..p
	print("INPUT PARTITIONING:",file_part)
	io.input(file_part)
	local tokens_in_file_counter=0 
	local ln=0 --line number in current file
	local current_token=0
		
	for l in io.lines() do
		ln=ln+1		
		local tokens_in_line=misc.split(l," ")
		tokens_in_file_counter=tokens_in_file_counter + #tokens_in_line
		for _,t in pairs(tokens_in_line) do
			current_token=current_token+1
			current_token_cluster=tonumber(t)
			if current_token_cluster > p then 
				error("Invalid part size in ",file_part..":"..ln) --should not happen if file_part is well-formed
			end
			
			if clusters[current_token_cluster]==nil then
				clusters[current_token_cluster]={}
			end
			local node_id=tonumber(current_token)
			if sites[node_id]~=nil then
				table.insert(clusters[current_token_cluster],node_id)
			end
		end		
	end
	print("Tokens:",tokens_in_file_counter) --all files have the same number of tokens, exactly 1 token per site		
	----from this moment on, every clusters[k] lists the sites in the cluster for different groupings	
	analyze(clusters,type_of_cluster,p,sites, imbalance_file)	
end

imbalance_file:close()