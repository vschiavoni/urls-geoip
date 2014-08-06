math.randomseed(666)
parts={16,32,64,128,256,512,1024}
dofile("it-2004.sites.gpscoords_dom.lua")

for _,p in pairs(parts) do
	local file_name="random_cluster_"..p..".lua"
	print("Generating ", file_name)
	io.output(file_name)
	io.write("clusters={}\n")	
	for i=1,p do
		io.write("clusters["..i.."]={}\n")
	end	
	for _,v in pairs(sites) do
		local rcl=math.random(p) --assign to one random cluster
		io.write("table.insert(clusters["..rcl.."],{"..v[1]..","..v[2].."})\n")
	end
end

for i=1,100 do
	print("Seed",i)
	math.randomseed(i)
	for _,p in pairs(parts) do
		os.execute("mkdir -p random_partitions/"..i)
		local file_name="random_partitions/"..i.."/random_cluster_"..p..".lua"
		print("Generating ", file_name)
		local f,err=assert(io.open(file_name,"w"))	
		
		f:write("clusters={}\n")	
		for i=1,p do
			f:write("clusters["..i.."]={}\n")
		end	
		for _,v in pairs(sites) do
			local rcl=math.random(p) --assign to one random cluster
			f:write("table.insert(clusters["..rcl.."],{"..v[1]..","..v[2].."})\n")
		end
		f:close()
	end
	
end