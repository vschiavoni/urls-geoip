local function compact(t)
	-- count elements
	local count = 0
	for k in pairs(t) do
		count = count + 1
	end
	-- iterate
	local hole = 1
	while hole <= count do
		-- find first hole
		while t[hole] do
			hole = hole + 1
		end
		-- find next non-nil
		local data = hole + 1
		while t[data]==nil do
			data = data + 1
		end
		-- move to the hole
		t[hole],t[data] = t[data],nil
		-- iterate
		hole = hole + 1
	end
end

dofile("it-2004.sites.gpscoords.lua")
print("before compat:",#sites)
compact(sites)
print("after compat:",#sites)

