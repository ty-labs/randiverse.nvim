local utils = require("randiverse.commands.utils")

local M = {}

local format_mappings = {
	iso = "%H:%M:%S",
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

-- TODO: Potential flags to set start/stop year, day, month
M.normal_random_time = function(args)
	print("inside normal_random_time")

	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	local dummy_year = os.date("*t")
	local timestamp = os.time({
		year = dummy_year.year,
		month = dummy_year.month,
		day = dummy_year.day,
		hour = math.random(0, 23),
		min = math.random(0, 59),
		sec = math.random(0, 59),
	})
	local format = transformed_flags["format"] and format_mappings[transformed_flags["format"]]
		or format_mappings["iso"]
	local random_time = os.date(format, timestamp)
	print("finished normal_random_time")
	return random_time
end

return M
