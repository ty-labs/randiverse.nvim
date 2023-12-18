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
}

local flag_mappings = {
	a = "all",
	c = "corpus",
}

local corpus_mappings = {
	short = utils.WORDS_SHORT_FILE,
	medium = utils.WORDS_MEDIUM_FILE,
	long = utils.WORDS_LONG_FILE,
}

-- TODO: Validate the word corpuses to ensure it is in the English dictionary and not a name!
-- TODO: Add a means to pass multiple corpuses into word for selection (Ex: Med + Long corpuses -- probably space separated after -c flag)
-- TODO: Flag that specifies the start letter for the word!
M.normal_random_word = function(args)
	print("inside normal_random_word")

	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

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
	local random_word = utils.read_random_line(path .. utils.get_random_from_set(corpus_set))

	print("finished normal_random_word")
	return random_word
end

return M
