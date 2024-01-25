local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local flag_mappings = {
    c = "capitalize",
    d = "digits",
    s = "specials",
    S = "separate",
    m = "muddle-property",
}

local expected_flags = {
    ["capitalize"] = {
        bool = true,
    },
    ["digits"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_non_negative_integer(s) then
                error(string.format("flag 'digits' can not accept value '%s': value must be a non-negative integer", s))
            end
        end,
        transformer = utils.string_to_integer,
    },
    ["specials"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_non_negative_integer(s) then
                error(
                    string.format("flag 'specials' can not accept value '%s': value must be a non-negative integer", s)
                )
            end
        end,
        transformer = utils.string_to_integer,
    },
    ["separate"] = {
        bool = true,
    },
    ["muddle-property"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_probability(s) then
                error(
                    string.format(
                        "flag 'muddle-property' can not accept value '%s': value must be in range [0.0, 1.0]",
                        s
                    )
                )
            end
        end,
        transformer = utils.string_to_number,
    },
    cross_flags_validator = utils.pass_through,
}

local generate_username = function(flags)
    local first_name = utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST)
    local last_name = utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST)

    local username_components = {}
    if math.random() < 0.7 then
        table.insert(username_components, first_name)
        table.insert(username_components, last_name)
    else
        table.insert(username_components, last_name)
        table.insert(username_components, first_name)
    end
    if flags["separate"] then
        local separators = config.user_opts.data.email.separators
        table.insert(username_components, 2, separators[math.random(#separators)])
    end

    local digit_list = config.user_opts.data.email.digits
    for _ = 1, flags["digits"] or config.user_opts.data.email.default_digits do
        table.insert(username_components, digit_list[math.random(#digit_list)])
    end
    local special_list = config.user_opts.data.email.specials
    for _ = 1, flags["specials"] or config.user_opts.data.email.default_specials do
        table.insert(username_components, special_list[math.random(#special_list)])
    end

    local chars = {}
    for char in table.concat(username_components):gmatch(".") do
        table.insert(chars, char)
    end
    for i = #chars, 1, -1 do
        if math.random() < (flags["muddle-property"] or config.user_opts.data.email.default_muddle_property) then
            local j = math.random(i)
            chars[i], chars[j] = chars[j], chars[i]
        end
    end
    if utils.list_contains(config.user_opts.data.email.separators, chars[1]) then
        local j = math.random(2, #chars - 1) -- prevent separators from being first/last
        chars[1], chars[j] = chars[j], chars[1]
    end
    if utils.list_contains(config.user_opts.data.email.separators, chars[#chars]) then
        local j = math.random(2, #chars - 1)
        chars[#chars], chars[j] = chars[j], chars[#chars]
    end
    local username = table.concat(chars)

    if flags["capitalize"] then
        return username
    end
    return string.lower(username)
end

M.normal_random_email = function(args)
    local parsed_flags = utils.parse_command_flags(args or {}, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local username = generate_username(transformed_flags)
    local domains = config.user_opts.data.email.domains
    local tlds = config.user_opts.data.email.tlds
    return string.format("%s@%s.%s", username, domains[math.random(#domains)], tlds[math.random(#tlds)])
end

return M
