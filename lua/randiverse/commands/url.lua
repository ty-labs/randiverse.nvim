local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local flag_mappings = {
    s = "subdomains",
    p = "paths",
    q = "query-params",
    f = "fragment",
}

local expected_flags = {
    ["subdomains"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_non_negative_integer(s) then
                error(
                    string.format(
                        "flag 'subdomains' can not accept value '%s': value must be a non-negative integer",
                        s
                    )
                )
            end
        end,
        transformer = utils.string_to_integer,
    },
    ["paths"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_non_negative_integer(s) then
                error(string.format("flag 'paths' can not accept value '%s': value must be a non-negative integer", s))
            end
        end,
        transformer = utils.string_to_integer,
    },
    ["query-params"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_non_negative_integer(s) then
                error(
                    string.format(
                        "flag 'query-params' can not accept value '%s': value must be a non-negative integer",
                        s
                    )
                )
            end
        end,
        transformer = utils.string_to_integer,
    },
    ["fragment"] = {
        bool = true,
    },
    cross_flags_validator = utils.pass_through,
}

M.normal_random_url = function(args)
    local parsed_flags = utils.parse_command_flags(args or {}, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local protocols = config.user_opts.data.url.protocols
    local tlds = config.user_opts.data.url.tlds

    local domains = {}
    local subdomain_corpus = config.user_opts.data.ROOT
        .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
    for _ = 1, transformed_flags["subdomains"] or config.user_opts.data.url.default_subdomains do
        table.insert(domains, utils.read_random_line(subdomain_corpus))
    end
    local domain_corpus = config.user_opts.data.ROOT
        .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
    table.insert(domains, utils.read_random_line(domain_corpus))

    local random_url = string.format(
        "%s://%s.%s",
        protocols[math.random(#protocols)],
        table.concat(domains, "."),
        tlds[math.random(#tlds)]
    )

    local paths = {}
    local path_corpus = config.user_opts.data.ROOT
        .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
    for _ = 1, transformed_flags["paths"] or config.user_opts.data.url.default_paths do
        table.insert(paths, utils.read_random_line(path_corpus))
    end
    if #paths > 0 then
        random_url = random_url .. "/" .. table.concat(paths, "/")
    end

    local query_params = {}
    local param_corpus = config.user_opts.data.ROOT
        .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_param_corpus]
    local value_corpus = config.user_opts.data.ROOT
        .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_value_corpus]
    for _ = 1, transformed_flags["query-params"] or config.user_opts.data.url.default_query_params do
        local param = utils.read_random_line(param_corpus)
        local value = utils.read_random_line(value_corpus)
        table.insert(query_params, param .. "=" .. value)
    end
    if #query_params > 0 then
        random_url = random_url .. "?" .. table.concat(query_params, "&")
    end

    if transformed_flags["fragment"] then
        local fragment_corpus = config.user_opts.data.ROOT
            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_fragment_corpus]
        random_url = random_url .. "#" .. utils.read_random_line(fragment_corpus)
    end

    return random_url
end

return M
