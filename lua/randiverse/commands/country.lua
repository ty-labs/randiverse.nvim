local utils = require("randiverse.commands.utils")

local M = {}

local code_mappings = {
	["2"] = "alpha-2",
	["3"] = "alpha-3",
	["alpha-2"] = "alpha-2",
	["alpha-3"] = "alpha-3",
}

local data_indexes = {
	["country"] = 1,
	["alpha-2"] = 2,
	["alpha-3"] = 3,
	["numeric"] = 4,
}

local expected_flags = {
	numeric = {
		bool = true,
	},
	code = {
		bool = false,
		validator = function(s)
			return code_mappings[s] ~= nil
		end,
		transformer = function(s)
			return code_mappings[s]
		end,
	},
}

local flag_mappings = {
	n = "numeric",
	c = "code",
}

-- TODO: Flag for staring letter
M.normal_random_country = function(args)
	print("inside normal_random_country")
	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	local country_table = require("randiverse.data.countries")()
	local index = data_indexes["country"] -- default is country --
	index = transformed_flags["numeric"] and data_indexes["numeric"] or index
	index = transformed_flags["code"] and data_indexes[transformed_flags["code"]] or index
	local random_country = country_table[math.random(#country_table)][index]

	print("finished normal_random_country")
	return random_country
end

return M
