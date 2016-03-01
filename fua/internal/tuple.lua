
local loadluacode = require "fua.internal.loadluacode"
local table_concat = assert(require "table".concat)

local tupleConstructorCache = {}

local function buildTupleConstructor (n)
    if tupleConstructorCache[n] then
        return tupleConstructorCache[n]
    end
    local t = {}
    for i = 1, n do
        t[i] = "a" .. i
    end
    local args = table_concat(t, ',')
    local ctor = loadluacode('return function(' .. args ..
        ') return function() return ' .. args .. ' end end')()
    tupleConstructorCache[n] = ctor
    return ctor
end

local function tuple (...)
    return buildTupleConstructor(select('#', ...))(...)
end

local function cache_reset()
    tupleConstructorCache = {}
end

return tuple
