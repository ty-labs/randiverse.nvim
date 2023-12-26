local utils = require("randiverse.commands.utils")

local M = {}

-- TODO: Add a cross_flag validator to each (if applicable), then add a fn to validate all params together??
local expected_flags = {
    start = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
        validator_error_msg = "value must be an integer",
    },
    stop = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
        validator_error_msg = "value must be an integer",
    },
    cross_flags_validator = utils.no_cross_flag_checks,
}

local flag_mappings = {
    s = "start",
    S = "stop",
}

M.normal_random_int = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    -- defaults: [1-100] range
    local start = transformed_flags["start"] or 1
    local stop = transformed_flags["stop"] or 100
    if stop < start then
        error(string.format("the range stop can not be less than range start: currently [%s, %s]", start, stop))
    end

    return tostring(math.random(start, stop))
end

return M
