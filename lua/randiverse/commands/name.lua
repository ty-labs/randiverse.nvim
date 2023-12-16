local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
	fname = {
		bool = true,
	},
	lname = {
		bool = true,
	},
}

local flag_mappings = {
	f = "fname",
	l = "lname",
}

M.normal_random_name = function(args)
	print("inside normal_random_name")
	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	-- defaults: first & last name included (potentially in future include A-Z + languages)
	local include_fname, include_lname = true, true
	if transformed_flags["fname"] or transformed_flags["lname"] then
		include_fname = transformed_flags["fname"] or false
		include_lname = transformed_flags["lname"] or false
	end

	local path = utils.get_asset_path()
	local fname = include_fname and utils.read_random_line(path .. utils.FIRST_NAMES_FILE) or ""
	local lname = include_lname and utils.read_random_line(path .. utils.LAST_NAMES_FILE) or ""
	local include_full_name = include_fname and include_lname
	local random_name = include_full_name and (fname .. " " .. lname) or (fname .. lname)
	print("finished normal_random_name")

	return random_name
end

return M
