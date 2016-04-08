local searcher = require "fua.loader.searcher"

function M:enable()
        searcher:init()
        searcher:enable()
end

