local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
    start = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
    },
    stop = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
    },
}

local flag_mappings = {
    s = "start",
    S = "stop",
}

M.normal_random_int = function(args)
    print("inside normal_random_int")
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    -- defaults: [1-100] range
    local start = transformed_flags["start"] or 1
    local stop = transformed_flags["stop"] or 100
    if stop < start then
        error("range stop can not be less than range start (consider the default [1-100] range when passing flags)")
    end
    local random_int = math.random(start, stop)

    print("finished normal_random_int")
    return tostring(random_int)
end

return M
