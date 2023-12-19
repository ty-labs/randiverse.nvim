local utils = require("randiverse.commands.utils")

local M = {}

local sentence_length = {
	["mixed"] = { 5, 100 },
	["mixed-long"] = { 30, 100 },
	["mixed-short"] = { 5, 30 },
	["long"] = { 40, 60 },
	["medium"] = { 20, 40 },
	["short"] = { 5, 20 },
}

local expected_flags = {
	paragraphs = {
		bool = false,
		validator = function(s) end,
		transformer = function(s) end,
	},
	comma = {
		bool = false,
		validator = function(s)
			local n = tonumber(s)
			return n ~= nil and n >= 0.0 and n <= 1.0
		end,
		transformer = function(s)
			return tonumber(s)
		end,
	},
	length = {
		bool = false,
		validator = utils.string_is_integer,
		transformer = utils.string_to_integer,
	},
	["sentence-length"] = {
		bool = false,
		validator = function(s)
			return sentence_length[s] ~= nil
		end,
		transformer = function(s)
			return s
		end,
	},
}

local flag_mappings = {
	p = "paragraphs",
	c = "comma",
	s = "sentence-length",
	l = "length",
}

-- PERF: These could use tables and joins instead of ".." operation
-- TODO: Next word should not be equal to previous word, check if last has comma before appending .
local function generate_lorem_sentence(comma, corpus, length)
	local sentence = ""

	local last_comma = 0
	for i = 1, length do
		sentence = sentence .. corpus[math.random(#corpus)] .. " "

		if (i - last_comma) > 2 and math.random() < comma then
			sentence = sentence:sub(1, -2) .. ", "
			last_comma = i
		end
	end

	sentence = (sentence:gsub("^%l", string.upper))
	sentence = sentence:sub(1, -2) .. "."

	return sentence
end

local function generate_lorem(flags)
	local length = flags["length"] or 100
	local comma = flags["comma"] or 0.1

	local bounds = flags["sentence-length"] and sentence_length[flags["sentence-length"]]
		or sentence_length["mixed-short"]
	local lower_bound, upper_bound = bounds[1], bounds[2]

	local corpus = require("randiverse.assets.words_lorem")()
	local lorem, lorem_length = "", 0
	while lorem_length + upper_bound <= length do
		lorem = lorem .. generate_lorem_sentence(comma, corpus, math.random(lower_bound, upper_bound)) .. " "
		_, lorem_length = lorem:gsub("%S+", "")
	end

	local remains = length - lorem_length
	if remains > 2 then
		lorem = lorem .. generate_lorem_sentence(comma, corpus, remains)
	end

	return lorem
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
