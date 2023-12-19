local utils = require("randiverse.commands.utils")

local M = {}

local format_mappings = {
	iso = "%Y-%m-%d",
	rfc = "%a, %d %b %Y",
	epoch = "%s",
	short = "%m/%d/%y",
	long = "%B %d, %Y",
}

local expected_flags = {
	format = {
		bool = false,
		validator = function(s)
			return format_mappings[s] ~= nil
		end,
		transformer = function(v)
			return v
		end,
	},
}

local flag_mappings = {
	f = "format",
}

-- TODO: Set day better based on selected month...
-- TODO: Potential flags to set start/stop year, day, month
M.normal_random_date = function(args)
	print("inside normal_random_date")

	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	local curr_year = os.date("*t").year
	local timestamp = os.time({
		year = math.random(curr_year - 10, curr_year + 10),
		month = math.random(1, 12),
		day = math.random(1, 28),
	})
	local format = transformed_flags["format"] and format_mappings[transformed_flags["format"]]
		or format_mappings["iso"]
	local random_date = os.date(format, timestamp)
	print("finished normal_random_date")
	return random_date
end

return M
