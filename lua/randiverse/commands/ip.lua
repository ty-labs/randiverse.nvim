local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
	v = {
		bool = false,
	},
}

local flag_mappings = {
	v = "version",
}

M.normal_random_ip = function(args)
	print("inside normal_random_ip")

	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	-- TODO: logic!

	local random_ip = ""

	print("finished normal_random_ip")
	return random_ip
end

return M
