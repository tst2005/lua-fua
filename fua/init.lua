local M = {}

-------------------------------------------

local searcher = require "fua.searcher"

function M:enable()
	searcher:init()
	searcher:enable()
end

-------------------------------------------


-------------------------------------------


local new_weak_keys_table = require "fua.internal.new_weak_keys_table"

M.new_weak_keys_table = new_weak_keys_table

return M
