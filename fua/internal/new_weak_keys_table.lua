local meta_perm_lock = require "fua.internal.meta_perm_lock"

local weak_keys_mt = meta_perm_lock { __mode = 'k' }

local function new_weak_keys_table()
	return setmetatable({}, weak_keys_mt)
end

return new_weak_keys_table

