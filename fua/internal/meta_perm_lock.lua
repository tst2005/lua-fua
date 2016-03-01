
local function metapermlock(mt)
	assert(type(mt)=="table")
	mt.__metatable=true
	return mt
end

return metapermlock

