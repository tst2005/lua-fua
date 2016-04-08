local M = {}

local getmetafield = require "fua.internal.getmetafield"

local classimplementation = require "fua.internal.class-system.default"

-- use metainfo to know what ClassCommons handler use
M.class = function(name, parent ) return getmetafield(o, "class")(...) end
M.instance = function(o) return getmetafield(o, "instance") end
M.extend = function(o) return getmetafield(o, "extend") end

return M
