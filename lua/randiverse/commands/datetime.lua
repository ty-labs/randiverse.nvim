local utils = require("randiverse.commands.utils")

local M = {}

local format_mappings = {
	iso = "%Y-%m-%dT%H:%M:%SZ",
	iso_tzo = "%Y-%m-%dT%H:%M:%S%z",
	rfc = "%a, %d %b %Y %H:%M:%S",
	sortable = "%Y%m%d%H%M%S",
	human = "%A, %B %d, %Y %I:%M:%S %p",
	epoch = "%s",
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

-- TODO: I would prefer to have datetime/date/time all wrapped under datetime
M.normal_random_datetime = function(args)
	print("inside normal_random_datetime")

	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	local curr_year = os.date("*t").year
	local timestamp = os.time({
		year = math.random(curr_year - 10, curr_year + 10),
		month = math.random(1, 12),
		day = math.random(1, 28),
		hour = math.random(0, 23),
		min = math.random(0, 59),
		sec = math.random(0, 59),
	})
	local format = transformed_flags["format"] and format_mappings[transformed_flags["format"]]
		or format_mappings["iso"]
	local random_datetime = os.date(format, timestamp)
	print("finished normal_random_datetime")
	return random_datetime
end

return M
