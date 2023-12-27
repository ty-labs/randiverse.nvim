local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
    start = {
        bool = false,
        validator = utils.string_is_integer,
        validator_error_msg = "value must be an integer",
        transformer = utils.string_to_integer,
    },
    stop = {
        bool = false,
        validator = utils.string_is_integer,
        validator_error_msg = "value must be an integer",
        transformer = utils.string_to_integer,
    },
    decimals = {
        bool = false,
        validator = utils.string_is_non_negative_integer,
        validator_error_msg = "value must be a non-negative integer",
        transformer = utils.string_to_integer,
    },
    cross_flags_validator = utils.no_validations,
}

local flag_mappings = {
    s = "start",
    S = "stop",
    d = "decimals",
}

M.normal_random_float = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    -- defaults: [1-100] float range w/ 2 decimal places
    local start = transformed_flags["start"] or 1
    local stop = transformed_flags["stop"] or 100
    local decimals = transformed_flags["decimals"] or 2
    if stop < start then
        error(string.format("the range stop can not be less than range start: currently [%s, %s]", start, stop))
    end
    local random_float = start + math.random() * (stop - start)
    return string.format("%." .. decimals .. "f", random_float)
end

return M
