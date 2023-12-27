local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
    format = {
        bool = false,
        validator = utils.no_validations,
        transformer = utils.pass_through,
    },
    date = {
        bool = true,
    },
    time = {
        bool = true,
    },
    cross_flags_validator = function(flags)
        local type = "datetime"
        if flags["date"] or flags["time"] then
            local date = flags["date"] and "date" or ""
            local time = flags["time"] and "time" or ""
            type = date .. time
        end
        if flags["format"] and config.user_opts.formats.datetime[type][flags["format"]] == nil then
            local valid = string.format(
                "value must be one of the following [%s]",
                utils.concat_table_keys(config.user_opts.formats.datetime[type])
            )
            error(string.format("flag '%s' can not accept value '%s': %s", "format", flags["format"], valid))
        end
    end,
}

local flag_mappings = {
    f = "format",
    d = "date",
    t = "time",
}

-- TODO: Add the ability to specify start/stop Y/M/D/H/M/S + ability to pass own datetime format string!
-- TODO: Add cross-flag validations (code and numeric can't both be set...)
M.normal_random_datetime = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local output_type = "datetime"
    if transformed_flags["date"] or transformed_flags["time"] then
        local date = transformed_flags["date"] and "date" or ""
        local time = transformed_flags["time"] and "time" or ""
        output_type = date .. time
    end

    if
        transformed_flags["format"]
        and config.user_opts.formats.datetime[output_type][transformed_flags["format"]] == nil
    then
        local valid = string.format(
            "value must be one of the following [%s]",
            utils.concat_table_keys(config.user_opts.formats.datetime[output_type])
        )
        error(string.format("flag '%s' can not accept value '%s': %s", "format", transformed_flags["format"], valid))
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
    local format = transformed_flags["format"]
            and config.user_opts.formats.datetime[output_type][transformed_flags["format"]]
        or config.user_opts.formats.datetime.defaults[output_type]
    local random_datetime = os.date(format, timestamp)
    return random_datetime
end

return M
