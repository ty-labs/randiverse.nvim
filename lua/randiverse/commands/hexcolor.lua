local utils = require("randiverse.commands.utils")

local M = {}

local flag_mappings = {
    l = "lowercase",
}

local expected_flags = {
    ["lowercase"] = {
        bool = true,
    },
    cross_flags_validator = utils.no_validations,
}

M.normal_random_hexcolor = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local format = transformed_flags["lowercase"] and "%02x" or "%02X"
    local r = string.format(format, math.random(0, 255))
    local g = string.format(format, math.random(0, 255))
    local b = string.format(format, math.random(0, 255))
    return "#" .. r .. g .. b
end

return M
