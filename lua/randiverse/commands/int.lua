local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
	start = {
		bool = false,
		validator = utils.string_is_integer,
	},
	stop = {
		bool = false,
		validator = utils.string_is_integer,
	},
}

local flag_mappings = {
	s = "start",
	S = "stop",
}

M.normal_random_int = function(args)
	print("inside normal_random_int")
	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	utils.validate_command_args(expected_flags, parsed_flags)

	local start = parsed_flags["start"] or 1
	local stop = parsed_flags["stop"] or 100

	local random_int = math.random(start, stop)

	print("finished normal_random_int")
	return tostring(random_int)
end

return M
