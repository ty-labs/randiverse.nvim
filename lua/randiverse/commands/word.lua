local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local flag_mappings = {
    a = "all",
    c = "corpus",
    l = "length",
}

local expected_flags = {
    ["all"] = {
        bool = true,
    },
    ["corpus"] = {
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
        end,
        transformer = utils.pass_through,
    },
    ["length"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_positive_integer(s) then
                error(string.format("flag 'length' can not accept value '%s': value must be a positive integer", s))
            end
        end,
        transformer = utils.string_to_integer,
    },
    cross_flags_validator = function(flags)
        if flags["all"] and flags["corpus"] then
            error("flags 'all' and 'corpus' can not be both set")
        end
    end,
}

M.normal_random_word = function(args)
    local parsed_flags = utils.parse_command_flags(args or {}, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    -- set word corpus(es) --
    local corpus_mappings = config.user_opts.data.word.corpuses
    local corpus_set = {}
    if not transformed_flags["all"] and not transformed_flags["corpus"] then
        corpus_set[corpus_mappings[config.user_opts.data.word.default_corpus]] = true
    end
    if transformed_flags["all"] then
        for _, v in pairs(corpus_mappings) do
            corpus_set[v] = true
        end
    end
    if transformed_flags["corpus"] then
        corpus_set[corpus_mappings[transformed_flags["corpus"]]] = true
    end
    local corpus = {}
    for k, _ in pairs(corpus_set) do
        local c = utils.read_lines(config.user_opts.data.ROOT .. k)
        for _, w in ipairs(c) do
            table.insert(corpus, w)
        end
    end

    local words = {}
    for _ = 1, transformed_flags["length"] or config.user_opts.data.word.default_length do
        table.insert(words, corpus[math.random(#corpus)])
    end
    return table.concat(words, " ")
end

return M
