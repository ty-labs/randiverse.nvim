local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
    all = {
        bool = true,
    },
    corpus = {
        bool = false,
        validator = utils.string_is_valid_corpus,
        transformer = function(v)
            return v
        end,
    },
    size = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
    },
}

local flag_mappings = {
    a = "all",
    c = "corpus",
    s = "size",
}

-- TODO: Add a means to pass multiple corpuses into word for selection (Ex: Med + Long corpuses -- probably space separated after -c flag)
-- TODO: Flag that specifies the start letter for the word!
-- TODO: I sense in the future we need to refactor `read_random_line` s.t. there is caching or we return a table of all lines as text
-- TODO: Flag -p/--paragraphs to enable # of paragraphs in output text (separated by \n\n)
M.normal_random_text = function(args)
    print("inside normal_random_text")

    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    -- cant put outside bc not known then --
    local corpus_mappings = {
        short = config.user_opts.data.word.SHORT,
        medium = config.user_opts.data.word.MEDIUM,
        long = config.user_opts.data.word.LONG,
    }

    local corpus_set = {}
    if not transformed_flags["all"] and not transformed_flags["corpus"] then
        corpus_set[corpus_mappings.medium] = true
    end
    if transformed_flags["all"] then
        for _, v in pairs(corpus_mappings) do
            corpus_set[v] = true
        end
    end
    if transformed_flags["corpus"] then
        corpus_set[corpus_mappings[transformed_flags["corpus"]]] = true
    end

    local path = utils.get_asset_path()
    local corpus = utils.get_random_from_set(corpus_set)
    local words = {}
    for _ = 1, transformed_flags["size"] or 20 do
        -- PERF: This will be slow for big 's' values and costly bc file open-close
        table.insert(words, utils.read_random_line(path .. corpus))
    end
    local random_text = table.concat(words, " ")

    print("finished normal_random_text")
    return random_text
end

return M
