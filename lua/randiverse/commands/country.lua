local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local code_mappings = {
    ["2"] = "alpha-2",
    ["3"] = "alpha-3",
    ["alpha-2"] = "alpha-2",
    ["alpha-3"] = "alpha-3",
}

local flag_mappings = {
    c = "code",
    n = "numeric",
}

local expected_flags = {
    ["code"] = {
        bool = false,
        validator = function(s)
            if code_mappings[s] == nil then
                error(
                    string.format(
                        "flag 'code' can not accept value '%s': value must be one of the following [%s]",
                        s,
                        utils.concat_table_keys(code_mappings)
                    )
                )
            end
        end,
        transformer = function(s)
            return code_mappings[s]
        end,
    },
    ["numeric"] = {
        bool = true,
    },
    cross_flags_validator = function(flags)
        if flags["code"] and flags["numeric"] then
            error("'code' and 'numeric' can't both be set")
        end
    end,
}

-- TODO: Flag for staring letter
-- TODO: Add cross-flag validations (code and numeric can't both be set...)
-- TODO: Peraps v1 should only have ACTUAL countries and no accents?
M.normal_random_country = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    if transformed_flags["code"] and transformed_flags["code"] == "alpha-2" then
        return utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA2)
    end
    if transformed_flags["code"] and transformed_flags["code"] == "alpha-3" then
        return utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA3)
    end
    if transformed_flags["numeric"] then
        return utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.country.NUMERIC)
    end
    return utils.read_random_line(config.user_opts.data.ROOT .. config.user_opts.data.country.COUNTRIES)
end

return M
