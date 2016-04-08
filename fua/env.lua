local M = {}

local getmetafield = require "fua.internal.getmetafield"

-- use metainfo to know what ClassCommons handler use
M.class = function(o) return getmetafield(o, "class") end
M.instance = function(o) return getmetafield(o, "instance") end
M.extend = function(o) return getmetafield(o, "extend") end


--M.new = require "fua.env.new"

--do
--local new = require "fua.internal.new"
--M.str   = function(s) return new("string")(s) end
--M.u     = function(s) return new("ustring")(s) end
--M.array = function(t) return new("array")(t) end
--end

-- Idea: convert non-object to object (or change object type?)
-- Sample: cast("list", {x=1}) -- cast("ustring", "x") -- convert("boolean", false) -- cast("class"??, Foo)
--M.cast = function(typename, target) end

-- Idea: extended type checking .... with object check type
--M.type = function() end


M.new_weak_keys_table = require "fua.env.new_weak_keys_table"

--M.getmetafield = require "fua.internal.getmetafield"

-- enable formating form : ('%s' % x)
--require "fua.internal.string._meta_format"

return M

-- api:from("implementation"):to("specs")
-- api:from("middleclass"):to("classcommons")
-- api:from("middleclass"):to("fua") -- api:with("middleclass"):with("knife.memoize"):require("fua")
-- api:from("middleclass"):rawaccess()
-- // api:use( api:from("middleclass"):to("fua.class") ):for("fua.memoize")
-- api:setupfor("fua.memoize"):useimpl("middleclass"), "fua.class"
-- api:alias("memoize", "fua.memoise"):alias("loadluacode", "fua.load")




