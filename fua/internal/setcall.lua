
local setcall = function(o, f, nowrapper)
	local mt = getmetatable(mt) or {}
	if nowrapper then
		mt.__call = f
	else
		mt.__call = function(_self, ...) return f(...) end
	end
	setmetatable(o, mt)
	return o
end

return setcall({setcall=setcall}, setcall)
