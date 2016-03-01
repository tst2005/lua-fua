
local io_open = assert(require "io".open)
local function readall(filename)
	local fd = io_open(filename, "r")
	local data = fd:read("*all")
	fd:close()
	return data
end

return readall
