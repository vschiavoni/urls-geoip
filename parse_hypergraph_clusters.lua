misc=require"splay.misc"
print("Reading coordinate files from : it-2004.sites.gpscoords.lua")
dofile("it-2004.sites.gpscoords.lua") --precomputed by: lua parse_latlong.lua
dofile("analyze_clusters.lua")
assert(sites)

parts={16,32,64,128,256,512,1024}

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
			table.insert(clusters[current_token_cluster],tonumber(current_token))
		end		
	end
	print("Tokens:",tokens_in_file_counter) --all files have the same numbe of tokens, exactly 1 token per site
	
	----from this moment on, every clusters[k] lists the sites in the cluster for different groupings	
	analyze(clusters,"hypergraph",p)	
end
