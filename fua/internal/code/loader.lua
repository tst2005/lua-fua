local compatenv = require "fua.internal.compat_env.compat_env"

-- TODO: long term: transform to a 'code' class
-- code:new():loadfromdata("data")()
-- code:new():format("luacode"):loadfromdata("print'hello world'")()
-- code:new():format("bytecode"):loadfromfile("file.lua.dump")()
-- code:new():format("luacode"):loadfromstream(fd)()
-- code:new():format("lisp"):loadfromfile("file.lisp")()

local load = compatenv.load -- or require"_G".loadstring or require"_G".load

local function loadluacode(code, e)
	-- error if code is bytecode !
	return load(code, code, 't', e)
end

local function loadbytecode(code, e)
	-- error if code is NOT bytecode !
	return load(code, nil, 'b', e)
end

local M = {
	loadluacode	= loadluacode,
	loadbytecode	= loadbytecode,
	loadcodefromfunction = loadcodefromfunction,
}
return M
