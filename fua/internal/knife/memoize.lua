local fua = require "fua"
local loadstring = fua.loadluacode
local new_weak_keys_table = fua.new_weak_keys_table

local cache = new_weak_keys_table()
local resultsKey = {}
local nilKey = {}

local function getMetaCall (callable)
    local meta = getmetatable(callable)
    return meta and meta.__call
end

local tupleConstructorCache = {}

local function buildTupleConstructor (n)
    if tupleConstructorCache[n] then
        return tupleConstructorCache[n]
    end
    local t = {}
    for i = 1, n do
        t[i] = "a" .. i
    end
    local args = table.concat(t, ',')
    local ctor = loadstring('return function(' .. args ..
        ') return function() return ' .. args .. ' end end')()
    tupleConstructorCache[n] = ctor
    return ctor
end

local function tuple (...)
    return buildTupleConstructor(select('#', ...))(...)
end

return function (callable)
    local metaCall = getMetaCall(callable)

    if type(callable) ~= 'function' and not metaCall then
        error 'Attempted to memoize a non-callable value.'
    end

    cache[callable] = new_weak_keys_table()

    local function run (...)
        local node = cache[callable]
        local argc = select('#', ...)
        for i = 1, argc do
            local key = select(i, ...)
            if key == nil then
                key = nilKey
            end
            if not node[key] then
                node[key] = new_weak_keys_table()
            end
            node = node[key]
        end

        if not node[resultsKey] then
            node[resultsKey] = tuple(callable(...))
        end

        return node[resultsKey]()
    end

    if metaCall then
        return function (...)
            local call = getMetaCall(callable)

            if call ~= metaCall then
                cache[callable] = new_weak_keys_table()
                metaCall = call
            end

            return run(...)
        end, cache, resultsKey, nilKey
    end

    return run, cache, resultsKey, nilKey
end
