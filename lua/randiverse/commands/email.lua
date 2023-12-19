local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
	numeric = {
		bool = true,
	},
	code = {
		bool = false,
		validator = function(s) end,
		transformer = function(s) end,
	},
}

local flag_mappings = {
	n = "numeric",
	c = "code",
}

-- TODO: Enhance scramble w/ full/part of last name potential as well! (Either before or after firstname)
local generate_username = function(first_name, last_name)
	-- to scramble: chance either first or last is first, grab piece of fname and lname, potentially sprinkle w/ specials between and at end
	local first_name = utils.read_random_line(utils.get_asset_path() .. utils.FIRST_NAMES_FILE)
	local last_name = utils.read_random_line(utils.get_asset_path() .. utils.LAST_NAMES_FILE)
	local username = first_name .. last_name
	local chars = {}
	local special = "0123456789!#$%^&*"
	for _ = 1, math.random(0, 2) do
		local i = math.random(#special)
		local c = special:sub(i, i)
		username = username .. c
	end

	local prefix = string.lower(username:sub(1, 3))
	local suffix = username:sub(4)

	for char in suffix:gmatch(".") do
		table.insert(chars, char)
	end
	for i = #chars, 2, -3 do
		local j = math.random(i)
		chars[i], chars[j] = chars[j], chars[i]
	end

	return prefix .. table.concat(chars)
end

-- Domain + TLDS should be able to be passed in configuration (not arguments)
M.normal_random_email = function(args)
	print("inside normal_random_email")
	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	local username = generate_username()
	local domains = { "example", "company", "mail", "gmail", "yahoo", "outlook" }
	local tlds = { "com", "net", "org" }
	local random_email = string.format("%s@%s.%s", username, domains[math.random(#domains)], tlds[math.random(#tlds)])

	print("finished normal_random_email")
	return random_email
end

return M
