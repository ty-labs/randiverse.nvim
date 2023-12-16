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

M.validate_and_transform_command_flags = function(expected, received)
	local transformed_flags = {}
	for flag, value in pairs(received) do
		-- perform checks on the command flags --
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

		-- transform the command flags (if applicable) --
		if expected[flag]["bool"] then
			transformed_flags[flag] = true
		else
			transformed_flags[flag] = expected[flag]["transformer"](value)
		end
	end
	return transformed_flags
end

-- common validator/transformers for command flags --
M.FIRST_NAMES_FILE = "first_names.txt"
M.LAST_NAMES_FILE = "last_names.txt"
M.COUNTRIES_FILE = "countries.txt"
M.WORDS_FILE = "words.txt"

M.string_is_integer = function(s)
	local n = tonumber(s)
	return n ~= nil and n == math.floor(n)
end

M.string_to_integer = function(s)
	return math.floor(tonumber(s) or 0)
end

-- for assets and reading --
M.get_asset_path = function()
	local path = debug.getinfo(1, "S").source:sub(2)
	path = path:match("(.*/)")
	return path .. "../assets/"
end

M.read_random_line = function(path)
	local file, error = io.open(path, "r")
	if not file then
		print("Error opening file:", error)
		vim.api.nvim_err_writeln("Unable to open file")
		return
	end

	local file_size = file:seek("end")
	file:seek("set", 0)

	local random_position = math.random(file_size)

	-- TODO: there is a basecase to consider if we had chosen last line already...
	-- TODO: there needs to be a caching mechansim for file lengths to speed up process...
	file:seek("set", random_position)
	_ = file:read()

	local line = file:read("*l")
	file:close()
	return line
end

return M
