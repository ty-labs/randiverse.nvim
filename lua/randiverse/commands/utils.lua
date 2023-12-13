local M = {}

M.parse_command_flags = function(args, flag_mappings)
	local flags = {}
	local i = 1

	while i <= #args do
		local arg = args[i]
		local flag = arg:match("^%-%-?(%w+)$")

		-- get the flag
		if not flag then
			error("invalid flag format: ", arg) -- error for flag
		end
		i = i + 1

		local mapped_flag = flag_mappings[flag] or flag
		if i <= #args and (not args[i]:match("^%-%-?(%w+)$") or args[i]:match("^%-?%d+$")) then
			-- we want optional flag value if NOT flag or it is a number (potentially negative)
			-- TODO: i wonder if this would bug out somehow?
			flags[mapped_flag] = args[i]
			i = i + 1
		else
			flags[mapped_flag] = true
		end
	end

	return flags
end

M.validate_command_args = function(expected, received)
	for flag, value in pairs(received) do
		-- check if key is fictious
		if not expected[flag] then
			error("unknown flag: " .. flag)
		end
		-- check if key does not expect value but value provided
		if expected[flag]["bool"] and value ~= true then
			error("flag `" .. flag .. "` is boolean and does not expect a value")
		end
		-- check if key does expect value but no value provided
		if not expected[flag]["bool"] and value == true then
			error("flag `" .. flag .. "` expects a value and no value provided")
		end
		-- check if key validator function works on flags with provided value
		if not expected[flag]["bool"] and not expected[flag]["validator"](value) then
			error("flag `" .. flag .. "` can not accept type of value `" .. value .. "`")
		end
	end
	return nil -- return true if they are valid (otherwise errors where unknown or invalid values)
end

M.string_is_integer = function(s)
	local n = tonumber(s)
	return n ~= nil and n == math.floor(n)
end

return M
