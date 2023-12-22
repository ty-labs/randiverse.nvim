local utils = require("randiverse.commands.utils")

local M = {}

local format_mappings = {
    datetime = {
        iso = "%Y-%m-%dT%H:%M:%SZ",
        rfc = "%a, %d %b %Y %H:%M:%S",
        sortable = "%Y%m%d%H%M%S",
        human = "%B %d, %Y %I:%M:%S %p",
        short = "%m/%d/%y %H:%M:%S",
        long = "%A, %B %d, %Y %I:%M:%S %p",
        epoch = "%s",
    },
    date = {
        iso = "%Y-%m-%d",
        rfc = "%a, %d %b %Y",
        sortable = "%Y%m%d",
        human = "%B %d, %Y",
        short = "%m/%d/%y",
        long = "%A, %B %d, %Y",
        epoch = "%s",
    },
    time = {
        iso = "%H:%M:%S",
        rfc = "%H:%M:%S",
        sortable = "H%M%S",
        human = "%I:%M:%S %p",
        short = "%H:%M:%S",
        long = "%%I:%M:%S %p",
    },
}

local expected_flags = {
    format = {
        bool = false,
        validator = function(s)
            return format_mappings["datetime"][s] ~= nil
        end,
        transformer = function(v)
            return v
        end,
    },
    date = {
        bool = true,
    },
    time = {
        bool = true,
    },
}

local flag_mappings = {
    f = "format",
    d = "date",
    t = "time",
}

-- TODO: Add the ability to specify start/stop Y/M/D/H/M/S
M.normal_random_datetime = function(args)
    print("inside normal_random_datetime")

    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local output_type = "datetime"
    if transformed_flags["date"] or transformed_flags["time"] then
        local date = transformed_flags["date"] and "date" or ""
        local time = transformed_flags["time"] and "time" or ""
        output_type = date .. time
    end

    local curr_year = os.date("*t").year
    local timestamp = os.time({
        year = math.random(curr_year - 10, curr_year + 0),
        month = math.random(1, 12),
        day = math.random(1, 28),
        hour = math.random(0, 23),
        min = math.random(0, 59),
        sec = math.random(0, 59),
    })
    local format = transformed_flags["format"] and format_mappings[output_type][transformed_flags["format"]]
        or format_mappings[output_type]["iso"]
    local random_datetime = os.date(format, timestamp)

    print("finished normal_random_datetime")
    return random_datetime
end

return M
