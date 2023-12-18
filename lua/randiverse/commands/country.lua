local utils = require("randiverse.commands.utils")

local M = {}

-- no flags ATM: eventually, could do ranges or pick a starting letter for countries (require work on files)
local expected_flags = {}

local flag_mappings = {}

M.normal_random_country = function(args)
	print("inside normal_random_country")
	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local _ = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	local path = utils.get_asset_path()
	local random_country = utils.read_random_line(path .. utils.COUNTRIES_FILE)

	print("finished normal_random_country")
	return random_country
end

return M
