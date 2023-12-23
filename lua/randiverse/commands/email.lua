local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
    ["muddleness"] = {
        bool = false,
        validator = utils.string_is_probability,
        transformer = utils.string_to_number,
    },
    ["letters-only"] = {
        bool = true,
    },
    ["alphanumeric-only"] = {
        bool = true,
    },
    ["specials"] = {
        bool = true,
    },
    ["capitalize"] = {
        bool = true,
    },
}

local flag_mappings = {
    m = "muddleness",
    l = "letters-only",
    a = "alphanumeric-only",
    s = "specials",
    c = "capitalize",
}

-- TODO: Probability that first/last name is substring + first/last name positions odds

-- Generally produces username = [fname/lname][separator][remaining fname/lname][0-2 letters]
local generate_username = function(flags)
    local first_name = utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST)
    local last_name = utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST)
    local separators = { "_", "-", ".", "" }

    -- default does not muddleness but just
    local username_components = {}
    if math.random() < 0.6 then
        table.insert(username_components, first_name)
        table.insert(username_components, last_name)
    else
        table.insert(username_components, last_name)
        table.insert(username_components, first_name)
    end

    if not flags["letters-only"] and not flags["alphanumeric-only"] then
        table.insert(username_components, 2, separators[math.random(#separators)])
    end

    local numbers = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    local numbers_special = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "!", "#", "$", "%", "^", "&", "*" }
    if not flags["letters-only"] and not flags["specials"] then
        for _ = 1, math.random(0, 2) do
            table.insert(username_components, numbers[math.random(#numbers)])
        end
    end
    if not flags["letters-only"] and not flags["alphanumeric-only"] and flags["specials"] then
        for _ = 1, math.random(0, 2) do
            table.insert(username_components, numbers_special[math.random(#numbers_special)])
        end
    end

    if flags["muddleness"] then
        local chars = {}
        for char in table.concat(username_components):gmatch(".") do
            table.insert(chars, char)
        end
        for i = #chars, 1, -1 do
            if math.random() <= flags["muddleness"] then
                -- TODO: don't allow separators to exist in 1 or last range!
                local j = math.random(i)
                chars[i], chars[j] = chars[j], chars[i]
            end
        end
        username_components = chars
    end

    if flags["capitalize"] then
        return table.concat(username_components)
    end

    return string.lower(table.concat(username_components))
end

-- TODO: Domain + TLDS should be able to be passed in configuration + muddle-ness
M.normal_random_email = function(args)
    print("inside normal_random_email")
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local username = generate_username(transformed_flags)
    local domains = { "example", "company", "mail", "gmail", "yahoo", "outlook" }
    local tlds = { "com", "net", "org" }
    local random_email = string.format("%s@%s.%s", username, domains[math.random(#domains)], tlds[math.random(#tlds)])

    print("finished normal_random_email")
    return random_email
end

return M
