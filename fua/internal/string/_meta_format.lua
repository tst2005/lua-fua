local string = require"string"
local type,unpack,format = type,unpack,string.format

local mt = getmetatable("")

function mt.__mod(a, b)
   if type(b) == "table" then
      return a:format(unpack(b))
   else
      return a:format(b)
   end
end

