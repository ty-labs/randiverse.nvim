local utils = require("randiverse.commands.utils")

local M = {}

-- TODO: These should be configurations for lorem
local sentence_lengths = {
    ["mixed"] = { 5, 100 },
    ["mixed-long"] = { 30, 100 },
    ["mixed-short"] = { 5, 30 },
    ["long"] = { 40, 60 },
    ["medium"] = { 20, 40 },
    ["short"] = { 5, 20 },
}

-- TODO: cross_flags_validator + updated validators
local expected_flags = {
    length = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
    },
    ["sentence-length"] = {
        bool = false,
        validator = function(s)
            return sentence_lengths[s] ~= nil
        end,
        transformer = function(s)
            return s
        end,
    },
    comma = {
        bool = false,
        validator = utils.string_is_probability,
        transformer = utils.string_to_number,
    },
    paragraphs = {
        bool = false,
        validator = utils.string_is_integer,
        transformer = utils.string_to_integer,
    },
}

local flag_mappings = {
    l = "length",
    s = "sentence-length",
    c = "comma",
    p = "paragraphs",
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
    local length = flags["length"] or 100
    local comma = flags["comma"] or 0.1

    local bounds = flags["sentence-length"] and sentence_lengths[flags["sentence-length"]]
        or sentence_lengths["mixed-short"]
    local lower_bound, upper_bound = bounds[1], bounds[2]

    local corpus = require("randiverse.data.words_lorem")()
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
M.normal_random_lorem = function(args)
    print("inside normal_random_lorem")

    args = args or {}
    local parsed_flags = utils.parse_command_flags(args, flag_mappings)
    local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

    local random_lorem = generate_lorem(transformed_flags)

    print("finished normal_random_lorem")
    return random_lorem
end

return M
