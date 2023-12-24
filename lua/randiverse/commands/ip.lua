local utils = require("randiverse.commands.utils")

local M = {}

local ip_mappings = {
    ["4"] = "ipv4",
    ["6"] = "ipv6",
    ["ipv4"] = "ipv4",
    ["ipv6"] = "ipv6",
}

local expected_flags = {
    version = {
        bool = false,
        validator = function(s)
            return ip_mappings[s] ~= nil
        end,
        transformer = function(s)
            return ip_mappings[s]
        end,
    },
}

local flag_mappings = {
    v = "version",
}

local ip_generators = {
    ipv4 = function()
        local ipv4_blocks = {}
        for _ = 1, 4 do
            table.insert(ipv4_blocks, math.random(0, 255))
        end
        return table.concat(ipv4_blocks, ".")
    end,
    ipv6 = function()
        local ipv6_blocks = {}
        for _ = 1, 8 do
            table.insert(ipv6_blocks, string.format("%04X", math.random(0, 65535)))
        end
        return table.concat(ipv6_blocks, ":")
    end,
}

-- TODO: Flag --lowercase / -l to enable Hexadecimal to be lower
M.normal_random_ip = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    if not transformed_flags["version"] then
        return ip_generators["ipv4"]()
    end
    return ip_generators[transformed_flags["version"]]()
end

return M
