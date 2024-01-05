local utils = require("randiverse.commands.utils")

local M = {}

local ip_mappings = {
    ["4"] = "ipv4",
    ["6"] = "ipv6",
    ["ipv4"] = "ipv4",
    ["ipv6"] = "ipv6",
}

local flag_mappings = {
    v = "version",
    l = "lowercase",
}

local expected_flags = {
    ["version"] = {
        bool = false,
        validator = function(s)
            if ip_mappings[s] == nil then
                error(
                    string.format(
                        "flag 'version' can not accept value '%s': value must be one of the following [%s]",
                        s,
                        utils.concat_table_keys(ip_mappings)
                    )
                )
            end
        end,
        transformer = function(s)
            return ip_mappings[s]
        end,
    },
    ["lowercase"] = {
        bool = true,
    },
    cross_flags_validator = function(flags)
        if (flags["version"] == "ipv4" or not flags["version"]) and flags["lowercase"] then
            error("flag 'lowercase' is only applicable with '--version ipv6'")
        end
    end,
}

local ip_generators = {
    ipv4 = function(_)
        local ipv4_blocks = {}
        for _ = 1, 4 do
            table.insert(ipv4_blocks, math.random(0, 255))
        end
        return table.concat(ipv4_blocks, ".")
    end,
    ipv6 = function(flags)
        local ipv6_blocks = {}
        local format = flags["lowercase"] and "%04x" or "%04X"
        for _ = 1, 8 do
            table.insert(ipv6_blocks, string.format(format, math.random(0, 65535)))
        end
        return table.concat(ipv6_blocks, ":")
    end,
}

M.normal_random_ip = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    if not transformed_flags["version"] then
        return ip_generators["ipv4"](transformed_flags)
    end
    return ip_generators[transformed_flags["version"]](transformed_flags)
end

return M
