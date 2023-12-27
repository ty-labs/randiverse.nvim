local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
    all = {
        bool = true,
    },
    corpus = {
        bool = false,
        validator = function(s)
            if config.user_opts.data.word.corpuses[s] == nil then
                error(
                    string.format(
                        "flag 'corpus' can not accept value '%s': value must be one of the following [%s]",
                        s,
                        utils.concat_table_keys(config.user_opts.data.word.corpuses)
                    )
                )
            end
            return config.user_opts.data.word.corpuses[s] ~= nil
        end,
        transformer = utils.pass_through,
    },
    cross_flags_validator = function(flags)
        if flags["all"] and flags["corpus"] then
            error("flags 'all' and 'corpus' can not be both set")
        end
    end,
}

local flag_mappings = {
    a = "all",
    c = "corpus",
}

-- TODO: Validate the word corpuses to ensure it is in the English dictionary and not a name!
-- TODO: Add a means to pass multiple corpuses into word for selection (Ex: Med + Long corpuses -- probably space separated after -c flag)
-- TODO: Flag that specifies the start letter for the word! (-s [--sort])
-- TODO: MERGE TEXT/WORD together --> They do literally same thing just with a size parameter lol
M.normal_random_word = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local corpus_mappings = config.user_opts.data.word.corpuses
    local corpus_set = {}

    if not transformed_flags["all"] and not transformed_flags["corpus"] then
        corpus_set[corpus_mappings[config.user_opts.data.word.default]] = true
    end
    if transformed_flags["all"] then
        for _, v in pairs(corpus_mappings) do
            corpus_set[v] = true
        end
    end
    if transformed_flags["corpus"] then
        corpus_set[corpus_mappings[transformed_flags["corpus"]]] = true
    end

    local random_word = utils.read_random_line(config.user_opts.data.ROOT .. utils.get_random_from_set(corpus_set))
    return random_word
end

return M
