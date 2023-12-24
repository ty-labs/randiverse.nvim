local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
    capital = {
        bool = true,
    },
}

local flag_mappings = {
    f = "format",
}

-- TODO: Flag --lowercase / -l to enable Hexadecimal to be lower
M.normal_random_uuid = function(args)
    print("inside normal_random_uuid")

    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local _ = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local format = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    local random_uuid = string.gsub(format, "[xy]", function(c)
        local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format("%X", v)
    end)
    print("finished normal_random_uuid")
    return random_uuid
end

return M
