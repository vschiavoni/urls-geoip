function string:split(sep)
        local sep, fields = sep or ":", {}
        local pattern = string.format("([^%s]+)", sep)
        self:gsub(pattern, function(c) fields[#fields+1] = c end)
        return fields
end

io.input("traceroute/traceroute")
for l in io.lines() do
	local t= l:split("\t")
	--print(t[2],t[3])
	local ip1=t[2]
	local ip2=t[3]
	print(ip1)
	print(ip2)
	local path=t[5]
	if path then
	for ip in path:gmatch("((%d+)%.(%d+)%.(%d+)%.(%d+))") do 
		print(ip)
	end
	end
end
