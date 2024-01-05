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

-- TODO: Perhaps in the future other UUID versions (besides 4)
M.normal_random_uuid = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local uuid_format = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    local replace = transformed_flags["lowercase"] and "%x" or "%X"
    local random_uuid = string.gsub(uuid_format, "[xy]", function(c)
        local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format(replace, v)
    end)
    return random_uuid
end

return M
