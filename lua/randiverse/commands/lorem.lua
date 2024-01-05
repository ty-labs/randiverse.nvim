local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")

local M = {}

local flag_mappings = {
    a = "all",
    c = "corpus",
    C = "comma",
    l = "length",
    s = "sentence-length",
}

local expected_flags = {
    ["all"] = {
        bool = true,
    },
    ["comma"] = {
        bool = false,
        validator = function(s)
            if not utils.string_is_probability(s) then
                error(string.format("flag 'comma' can not accept value '%s': value must be in range [0.0, 1.0]", s))
            end
        end,
        transformer = utils.string_to_number,
    },
    ["corpus"] = {
        bool = false,
        validator = function(s)
            if config.user_opts.data.lorem.corpuses[s] == nil then
                error(
                    string.format(
                        "flag 'corpus' can not accept value '%s': value must be one of the following [%s]",
                        s,
                        utils.concat_table_keys(config.user_opts.data.lorem.corpuses)
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
    ["sentence-length"] = {
        bool = false,
        validator = function(s)
            if config.user_opts.data.lorem.sentence_lengths[s] == nil then
                error(
                    string.format(
                        "flag 'sentence-length' can not accept value '%s': value must be one of the following [%s]",
                        s,
                        utils.concat_table_keys(config.user_opts.data.lorem.sentence_lengths)
                    )
                )
            end
        end,
        transformer = utils.pass_through,
    },
    cross_flags_validator = function(flags)
        if flags["all"] and flags["corpus"] then
            error("flags 'all' and 'corpus' can not be both set")
        end
    end,
}

local function generate_lorem_sentence(comma, corpus, length)
    local sentence_table = {}

    local last_comma = 0
    for i = 1, length do
        table.insert(sentence_table, corpus[math.random(#corpus)])

        if i < length and i - last_comma > 2 and math.random() < comma then
            sentence_table[i] = sentence_table[i] .. ","
            last_comma = i
        end
    end

    sentence_table[1] = sentence_table[1]:gsub("^%l", string.upper)
    sentence_table[length] = sentence_table[length] .. "."

    return table.concat(sentence_table, " ")
end

local function generate_lorem(flags)
    local length = flags["length"] or config.user_opts.data.lorem.default_length
    local comma = flags["comma"] or config.user_opts.data.lorem.default_comma_property

    -- set lorem ipsum sentence bounds --
    local sentence_length_mappings = config.user_opts.data.lorem.sentence_lengths
    local bounds = flags["sentence-length"] and sentence_length_mappings[flags["sentence-length"]]
        or sentence_length_mappings[config.user_opts.data.lorem.default_sentence_length]
    local lower_bound, upper_bound = bounds[1], bounds[2]

    -- set lorem ipsum text corpus(es) --
    local corpus_mappings = config.user_opts.data.lorem.corpuses
    local corpus_set = {}
    if not flags["all"] and not flags["corpus"] then
        corpus_set[corpus_mappings[config.user_opts.data.lorem.default_corpus]] = true
    end
    if flags["all"] then
        for _, v in pairs(corpus_mappings) do
            corpus_set[v] = true
        end
    end
    if flags["corpus"] then
        corpus_set[corpus_mappings[flags["corpus"]]] = true
    end
    local corpus = {}
    for k, _ in pairs(corpus_set) do
        local c = utils.read_lines(config.user_opts.data.ROOT .. k)
        for _, w in ipairs(c) do
            table.insert(corpus, w)
        end
    end

    local lorem_table, lorem_length = {}, 0
    while lorem_length + upper_bound <= length do
        local sentence_length = math.random(lower_bound, upper_bound)
        table.insert(lorem_table, generate_lorem_sentence(comma, corpus, sentence_length))
        lorem_length = lorem_length + sentence_length
    end

    local remains = length - lorem_length
    if remains > 2 then
        table.insert(lorem_table, generate_lorem_sentence(comma, corpus, remains))
    end

    return table.concat(lorem_table, " ")
end

-- TODO: Flag -p/--paragraphs to enable # of paragraphs in output text (separated by \n\n)
-- TODO: Flag to DISABLE prefixing of "Lorem ipsum" to the text
M.normal_random_lorem = function(args)
    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    return generate_lorem(transformed_flags)
end

return M
