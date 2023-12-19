local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {}

local flag_mappings = {}

-- TODO: Flag --lowercase / -l to enable Hexadecimal to be lower
M.normal_random_hexcolor = function(args)
	print("inside normal_random_hexcolor")

	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local _ = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	local r = string.format("%02X", math.random(0, 255))
	local g = string.format("%02X", math.random(0, 255))
	local b = string.format("%02X", math.random(0, 255))
	return "#" .. r .. g .. b
end

return M
