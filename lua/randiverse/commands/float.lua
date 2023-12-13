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

M.normal_random_float = function(args)
	print("inside normal_random_float")
	args = args or {}
	local rand_int = tostring(math.random(-100, 100))
	print("finished normal_random_float")
	return rand_int
end

return M
