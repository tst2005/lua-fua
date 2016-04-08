local function getmetafield(obj, name)
        local _ok, value = pcall(
                function()
                        local mt = getmetatable(obj)
                        return mt and mt["__"..name]
                end)
        return _ok and value
end

return getmetafield
