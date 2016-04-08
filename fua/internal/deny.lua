
-- use it like the standard error except it return a function.
-- the error will be raise when the function is called
-- like error the default level is 1, the internal implementation increase the level, use it like `error`.

local function deny(access, level)
	return function()
		error(access or "access denied", (level and level or 1)+1)
	end
end

return deny
