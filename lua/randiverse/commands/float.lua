local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local flag_mappings = {
    s = "start",
    S = "stop",
    d = "decimals",
}

local expected_flags = {
    ["start"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_integer(s) then
                error(string.format("flag 'start' can not accept value '%s': value must be an integer", s))
            end
        end,
        transformer = utils.string_to_integer,
    },
    ["stop"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_integer(s) then
                error(string.format("flag 'stop' can not accept value '%s': value must be an integer", s))
            end
        end,
        transformer = utils.string_to_integer,
    },
    ["decimals"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_non_negative_integer(s) then
                error(
                    string.format("flag 'decimals' can not accept value '%s': value must be a non-negative integer", s)
                )
            end
        end,
        transformer = utils.string_to_integer,
    },
    cross_flags_validator = utils.no_validations,
}

M.normal_random_float = function(args)
    local parsed_flags = utils.parse_command_flags(args or {}, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local start = transformed_flags["start"] or config.user_opts.data.float.default_start
    local stop = transformed_flags["stop"] or config.user_opts.data.float.default_stop
    local decimals = transformed_flags["decimals"] or config.user_opts.data.float.default_decimals
    if stop < start then
        error(string.format("the range stop can not be less than range start: currently [%s, %s]", start, stop))
    end
    local random_float = start + math.random() * (stop - start)
    return string.format("%." .. decimals .. "f", random_float)
end

return M
