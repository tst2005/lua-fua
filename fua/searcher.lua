local M = {}

local enabled=false
local _package

local loadcodefromfunction = require "fua.internal.code.loader".loadcodefromfunction or _G.load

local readall = require "fua.internal.file.readall"

local new_iterator = function(tdata)
	local n = 1
	return function()
		if n > #tdata then
			return nil
		end
		n=n+1
		return tdata[n-1]
	end
end

local function fuasearcher(modname, ...)
	if not _package.fpath then
		return '\n\tno fua module for '..modname
	end

	if not _package.searchpath then
		error("require package.searchpath", 2)
	end

	local found = _package.searchpath(modname, _package.fpath)
	assert(found)

	-- TODO: support read all from a steam with iterator
	local data = readall(found)
	local tdata = {
		[[local __name__=]]..('%q'):format(modname).."\n",
		[[local fua=require"fua";]].."\n",
		"-- body --".."\n",
		data,
		"-- /body --".. "\n",
	}
	local f = new_iterator(tdata)
	return assert(loadcodefromfunction(f))
end


function M:enable()
	-- protect against multiple call
	if enabled then return false end
	enabled = true

	local searchers = assert(_package.searchers or _package.loaders, "missing package searchers")
	if type(searchers) == "table" then
		-- TODO: check if already exists in the searchers items...
		local before = #searchers
		--table.insert(searchers, 2, fuasearcher)
		searchers[#searchers+1] = fuasearcher
		assert( #searchers == before+1)
	end
	_package.fpath = _package.fpath or "./?.fua;./?/init.fua"
end

function M:disable()
	-- protect against multiple call
	if not enabled then return false end
	enabled = false

	local searchers = assert(_package.searchers or _package.loaders, "missing package searchers")
	for i,f in ipairs(searchers) do
		if fuasearcher == f then
			table.remove(searchers, i)
			return true
		end
	end
	return false
end

function M:init()
	_package = require "package"
end

return M
