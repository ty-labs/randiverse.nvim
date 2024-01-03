local config = require("randiverse.config")
local lorem = require("randiverse.commands.lorem")
local utils = require("randiverse.commands.utils")

local test_utils = require("tests.utils")

local function assert_lorem_words(random_lorem, corpuses, length)
    local words = {}
    for word in random_lorem:gmatch("%S+") do
        table.insert(words, word)
    end
    assert.is_true(length - 2 <= #words and #words <= length)
    for _, word in ipairs(words) do
        word = string.lower(word:gsub("%A", ""))
        local seen = 0
        for _, corpus in ipairs(corpuses) do
            seen = test_utils.list_contains(corpus, word) and seen + 1 or seen
        end
        assert.same(1, seen)
    end
end

local function assert_lorem_sentences(random_lorem, sentence_length)
    local sentences = {}
    local lower_bound, upper_bound = sentence_length[1], sentence_length[2]
    for sentence in random_lorem:gmatch("[^.]+") do
        table.insert(sentences, sentence)
    end
    for i = 1, #sentences - 1 do
        local sentence = sentences[i]
        local word_count = 0
        for _ in sentence:gmatch("%S+") do
            word_count = word_count + 1
        end
        assert.is_true(lower_bound <= word_count and word_count <= upper_bound)
    end
end

local function assert_default_lorem_commas(random_lorem)
    local sentences = {}
    for sentence in random_lorem:gmatch("[^.]+") do
        table.insert(sentences, sentence)
    end
    for i = 1, #sentences - 1 do
        local sentence = sentences[i]
        local word_count, last_comma_seen = 0, 0
        for word in sentence:gmatch("%S+") do
            word_count = word_count + 1
            if string.find(word, ",") ~= nil then
                assert.is_true(word_count - last_comma_seen >= 3)
                last_comma_seen = word_count
            end
        end
    end
end

describe("Randiverse 'lorem' command", function()
    it("should return random lorem ipsum text with no flags", function()
        -- lorem ipsum @ start --
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {})
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {
                utils.read_lines(
                    config.user_opts.data.ROOT
                        .. config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
                ),
            }
            assert_lorem_words(random_lorem, corpuses, config.user_opts.data.lorem.default_length)
            local sentence_length =
                config.user_opts.data.lorem.sentence_lengths[config.user_opts.data.lorem.default_sentence_length]
            assert_lorem_sentences(random_lorem, sentence_length)
            assert_default_lorem_commas(random_lorem)
        end
    end)

    it("should return random lorem ipsum text with '--corpus lorem'", function()
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--corpus",
                "lorem",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["lorem"]),
            }
            assert_lorem_words(random_lorem, corpuses, config.user_opts.data.lorem.default_length)
            local sentence_length =
                config.user_opts.data.lorem.sentence_lengths[config.user_opts.data.lorem.default_sentence_length]
            assert_lorem_sentences(random_lorem, sentence_length)
            assert_default_lorem_commas(random_lorem)
        end
    end)

    it("should return random lorem text with '--all'", function()
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--all",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {}
            for _, v in pairs(config.user_opts.data.lorem.corpuses) do
                table.insert(corpuses, utils.read_lines(config.user_opts.data.ROOT .. v))
            end
            assert_lorem_words(random_lorem, corpuses, config.user_opts.data.lorem.default_length)
            local sentence_length =
                config.user_opts.data.lorem.sentence_lengths[config.user_opts.data.lorem.default_sentence_length]
            assert_lorem_sentences(random_lorem, sentence_length)
            assert_default_lorem_commas(random_lorem)
        end
    end)

    it("should return random lorem ipsum with '--length 50'", function()
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--length",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {
                utils.read_lines(
                    config.user_opts.data.ROOT
                        .. config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
                ),
            }
            assert_lorem_words(random_lorem, corpuses, 50)
            local sentence_length =
                config.user_opts.data.lorem.sentence_lengths[config.user_opts.data.lorem.default_sentence_length]
            assert_lorem_sentences(random_lorem, sentence_length)
            assert_default_lorem_commas(random_lorem)
        end
    end)

    it("should return random lorem ipsum with '--length 300'", function()
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--length",
                "300",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {
                utils.read_lines(
                    config.user_opts.data.ROOT
                        .. config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
                ),
            }
            assert_lorem_words(random_lorem, corpuses, 300)
            local sentence_length =
                config.user_opts.data.lorem.sentence_lengths[config.user_opts.data.lorem.default_sentence_length]
            assert_lorem_sentences(random_lorem, sentence_length)
            assert_default_lorem_commas(random_lorem)
        end
    end)

    it("should return no-comma random lorem ipsum with '--comma 0.0'", function()
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--comma",
                "0.0",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {
                utils.read_lines(
                    config.user_opts.data.ROOT
                        .. config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
                ),
            }
            assert_lorem_words(random_lorem, corpuses, config.user_opts.data.lorem.default_length)
            local sentence_length =
                config.user_opts.data.lorem.sentence_lengths[config.user_opts.data.lorem.default_sentence_length]
            assert_lorem_sentences(random_lorem, sentence_length)
            assert.is_falsy(string.find(random_lorem, ","))
        end
    end)

    it("should return comma-every-third-word random lorem ipsum with '--comma 1.0'", function()
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--comma",
                "1.0",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {
                utils.read_lines(
                    config.user_opts.data.ROOT
                        .. config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
                ),
            }
            assert_lorem_words(random_lorem, corpuses, config.user_opts.data.lorem.default_length)
            local sentence_length =
                config.user_opts.data.lorem.sentence_lengths[config.user_opts.data.lorem.default_sentence_length]
            assert_lorem_sentences(random_lorem, sentence_length)
            local sentences = {}
            for sentence in random_lorem:gmatch("[^.]+") do
                local sentence_words = {}
                for word in sentence:gmatch("%S+") do
                    table.insert(sentence_words, word)
                end
                table.insert(sentences, sentence_words)
            end
            for i = 1, #sentences - 1 do
                local sentence = sentences[i]
                local word_count, last_comma_seen = 0, 0
                for _, word in ipairs(sentence) do
                    word_count = word_count + 1
                    if word_count < #sentence and word_count - last_comma_seen == 3 then
                        assert.is_truthy(string.find(word, ","))
                        last_comma_seen = word_count
                    end
                end
            end
        end
    end)

    it("should return longer random lorem ipsum sentences with '--sentence-length long'", function()
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--sentence-length",
                "long",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {
                utils.read_lines(
                    config.user_opts.data.ROOT
                        .. config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
                ),
            }
            assert_lorem_words(random_lorem, corpuses, config.user_opts.data.lorem.default_length)
            local sentence_length = config.user_opts.data.lorem.sentence_lengths["long"]
            assert_lorem_sentences(random_lorem, sentence_length)
            assert_default_lorem_commas(random_lorem)
        end
    end)
    it("should return shorter random lorem ipsum sentences with '--sentence-length short'", function()
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--sentence-length",
                "short",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local corpuses = {
                utils.read_lines(
                    config.user_opts.data.ROOT
                        .. config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
                ),
            }
            assert_lorem_words(random_lorem, corpuses, config.user_opts.data.lorem.default_length)
            local sentence_length = config.user_opts.data.lorem.sentence_lengths["short"]
            assert_lorem_sentences(random_lorem, sentence_length)
            assert_default_lorem_commas(random_lorem)
        end
    end)

    it("should error when called with '--corpus' flag and invalid value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--corpus",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'corpus' can not accept value 'dummy': value must be one of the following %[")
        )
    end)
    it("should error when called with '--corpus' flag and no value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--corpus",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'corpus' expects a value and no value was provided"))
    end)

    it("should error when called with '--comma' flag and invalid value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--comma",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'comma' can not accept value 'dummy': value must be in range %[0.0, 1.0%]")
        )
    end)
    it("should error when called with '--comma' flag and non-probability number", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--comma",
            "1.5",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'comma' can not accept value '1.5': value must be in range %[0.0, 1.0%]")
        )
    end)
    it("should error when called with '--comma' flag and no value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--comma",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'comma' expects a value and no value was provided"))
    end)

    it("should error when called with '--length' flag and no value", function() end)
    it("should error when called with '--length' flag and invalid value", function() end)

    it("should error when called with '--sentence-length' flag and no value", function() end)
    it("should error when called with '--sentence-length' flag and invalid value", function() end)

    it("should error when called with '--all' flag and a value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--all",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'all' is boolean and does not expect a value"))
    end)

    it("should error when called with incompatable flags", function() end)

    it("should error when called with unknown '-e' flag", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "-e",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'e'"))
    end)
    it("should error when called with unknown '--even-longer-command' flag", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--even-longer-command",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'even%-longer%-command'"))
    end)
end)
