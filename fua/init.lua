local M = {}

-------------------------------------------

local searcher = require "fua.searcher"

function M:enable()
	searcher:init()
	searcher:enable()
end

-------------------------------------------


-------------------------------------------


return M
