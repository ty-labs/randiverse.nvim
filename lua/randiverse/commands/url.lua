local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local flag_mappings = {
    s = "subdomains",
    p = "paths",
    q = "query-params",
    f = "fragement",
}

local expected_flags = {
    ["subdomains"] = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
    },
    ["paths"] = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
    },
    ["query-params"] = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
    },
    ["fragement"] = {
        bool = true,
    },
}

M.normal_random_url = function(args)
    print("inside normal_random_email")
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    -- let protocols/tld to be overridden in plugin configuration! --
    -- perhaps we should allow which corpus they choose strings for params? --
    local protocols = { "http", "https" }
    local domain = utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.word.LONG)
    if transformed_flags["subdomains"] then
        local subdomains = {}
        for _ = 1, transformed_flags["subdomains"] do
            table.insert(
                subdomains,
                utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.word.SHORT)
            )
        end
        domain = string.format("%s.%s", table.concat(subdomains, "."), domain)
    end
    local tld = { "com", "org", "net", "edu", "gov" }

    local random_url = string.format("%s://%s.%s", protocols[math.random(#protocols)], domain, tld[math.random(#tld)])

    -- add paths, params, then fragement if requested
    -- there can be mulitple levels of paths...
    if transformed_flags["paths"] then
        local paths = {}
        for _ = 1, transformed_flags["paths"] do
            table.insert(paths, utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.word.MEDIUM))
        end
        random_url = random_url .. "/" .. table.concat(paths, "/")
    end
    if transformed_flags["query-params"] then
        local query_params = {}
        for _ = 1, transformed_flags["query-params"] do
            local param = utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.word.MEDIUM)
            local value = utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.word.MEDIUM)
            table.insert(query_params, param .. "=" .. value)
        end
        random_url = random_url .. "?" .. table.concat(query_params, "&")
    end
    if transformed_flags["fragement"] then
        random_url = random_url
            .. "#"
            .. utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.word.LONG)
    end

    print("finished normal_random_email")
    return random_url
end

return M
