math.randomseed(666)
parts={16,32,64,128,256,512,1024}
dofile("it-2004.sites.gpscoords.lua")

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
	--dofile(file_name) --test that lua can load this file
end