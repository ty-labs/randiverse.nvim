local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local flag_mappings = {
    f = "first",
    l = "last",
}

local expected_flags = {
    ["first"] = {
        bool = true,
    },
    ["last"] = {
        bool = true,
    },
    cross_flags_validator = utils.no_validations,
}

M.normal_random_name = function(args)
    local parsed_flags = utils.parse_command_flags(args or {}, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local include_first, include_last = true, true
    if transformed_flags["first"] or transformed_flags["last"] then
        include_first = transformed_flags["first"] or false
        include_last = transformed_flags["last"] or false
    end

    local first = include_first
            and utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST)
        or ""
    local last = include_last and utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST)
        or ""
    local include_full_name = include_first and include_last
    local random_name = include_full_name and (first .. " " .. last) or (first .. last)
    return random_name
end

return M
