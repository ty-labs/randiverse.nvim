local config = require("randiverse.config")
local utils = require("randiverse.commands.utils")
local word = require("randiverse.commands.word")

local test_utils = require("tests.utils")

describe("Randiverse 'word' command", function()
    it("should return a random word with no flags", function()
        for _ = 1, 50 do
            local success, random_word = pcall(word.normal_random_word, {})
            assert.is_true(success)
            assert.same(type(random_word), "string")
            local match = random_word:match("^(%a+)$")
            assert.is_truthy(match)
            local default = config.user_opts.data.word.corpuses[config.user_opts.data.word.default_corpus]
            assert.is_true(test_utils.list_contains(utils.read_lines(config.user_opts.data.ROOT .. default), match))
        end
    end)

    it("should return a random word with '-c' flag", function()
        for _ = 1, 50 do
            local success, random_word = pcall(word.normal_random_word, {
                "-c",
                "short",
            })
            assert.is_true(success)
            assert.same(type(random_word), "string")
            local match = random_word:match("^(%a+)$")
            assert.is_truthy(match)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["short"]),
                    match
                )
            )
        end
    end)

    it("should return a random word with '--corpus' flag", function()
        for _ = 1, 50 do
            local success, random_word = pcall(word.normal_random_word, {
                "--corpus",
                "long",
            })
            assert.is_true(success)
            assert.same(type(random_word), "string")
            local match = random_word:match("^(%a+)$")
            assert.is_truthy(match)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["long"]),
                    match
                )
            )
        end
    end)

    it("should return a random word with '-a' flag", function()
        for _ = 1, 50 do
            local success, random_word = pcall(word.normal_random_word, {
                "-a",
            })
            assert.is_true(success)
            assert.same(type(random_word), "string")
            local match = random_word:match("^(%a+)$")
            assert.is_truthy(match)
            local short = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["short"]),
                match
            )
            local medium = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["medium"]),
                match
            )
            local long = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["long"]),
                match
            )
            assert.is_true(
                (short and not medium and not long)
                    or (not short and medium and not long)
                    or (not short and not medium and long)
            )
        end
    end)

    it("should return a random word with '--all' flag", function()
        for _ = 1, 50 do
            local success, random_word = pcall(word.normal_random_word, {
                "--all",
            })
            assert.is_true(success)
            assert.same(type(random_word), "string")
            local match = random_word:match("^(%a+)$")
            assert.is_truthy(match)
            local short = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["short"]),
                match
            )
            local medium = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["medium"]),
                match
            )
            local long = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["long"]),
                match
            )
            assert.is_true(
                (short and not medium and not long)
                    or (not short and medium and not long)
                    or (not short and not medium and long)
            )
        end
    end)

    it("should return multiple words with '-s 50' flag", function()
        local success, random_words = pcall(word.normal_random_word, {
            "-s",
            "50",
        })
        assert.is_true(success)
        assert.same(type(random_words), "string")
        local words = {}
        for w in random_words:gmatch("%S+") do
            table.insert(words, w)
        end
        assert.same(50, #words)
        local default = config.user_opts.data.word.corpuses[config.user_opts.data.word.default_corpus]
        for _, w in ipairs(words) do
            assert.same(type(w), "string")
            assert.is_true(
                assert.is_true(test_utils.list_contains(utils.read_lines(config.user_opts.data.ROOT .. default), w))
            )
        end
    end)

    it("should return multiple words with '--size 50 --all' flag", function()
        local success, random_words = pcall(word.normal_random_word, {
            "--size",
            "50",
            "--all",
        })
        assert.is_true(success)
        assert.same(type(random_words), "string")
        local words = {}
        for w in random_words:gmatch("%S+") do
            table.insert(words, w)
        end
        assert.same(50, #words)
        for _, w in ipairs(words) do
            assert.same(type(w), "string")
            local short = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["short"]),
                w
            )
            local medium = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["medium"]),
                w
            )
            local long = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["long"]),
                w
            )
            assert.is_true(
                (short and not medium and not long)
                    or (not short and medium and not long)
                    or (not short and not medium and long)
            )
        end
    end)

    it("should return multiple words with '-c short -s 100' flag", function()
        local success, random_words = pcall(word.normal_random_word, {
            "-c",
            "short",
            "-s",
            "100",
        })
        assert.is_true(success)
        assert.same(type(random_words), "string")
        local words = {}
        for w in random_words:gmatch("%S+") do
            table.insert(words, w)
        end
        assert.same(100, #words)
        for _, w in ipairs(words) do
            assert.same(type(w), "string")
            assert.is_true(
                assert.is_true(
                    test_utils.list_contains(
                        utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.word.corpuses["short"]),
                        w
                    )
                )
            )
        end
    end)

    it("should error when called with '-c' flag and invalid value", function()
        local success, error = pcall(word.normal_random_word, {
            "-c",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'corpus' can not accept value 'dummy': value must be one of the following %[")
        )
    end)

    it("should error when called with '-a' flag and a value", function()
        local success, error = pcall(word.normal_random_word, {
            "-a",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'all' is boolean and does not expect a value"))
    end)

    it("should error when called with '--all' flag and a value", function()
        local success, error = pcall(word.normal_random_word, {
            "--all",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'all' is boolean and does not expect a value"))
    end)

    it("should error when called with '-s' flag and invalid value", function()
        local success, error = pcall(word.normal_random_word, {
            "-s",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'size' can not accept value 'dummy': value must be a positive integer")
        )
    end)

    it("should error when called with '--size' flag and invalid value", function()
        local success, error = pcall(word.normal_random_word, {
            "-s",
            "0",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'size' can not accept value '0': value must be a positive integer"))
    end)

    it("should error when called with '-s' flag and no value", function()
        local success, error = pcall(word.normal_random_word, {
            "-s",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'size' expects a value and no value was provided"))
    end)

    it("should error when called with '-a' flag and a value", function()
        local success, error = pcall(word.normal_random_word, {
            "-a",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'all' is boolean and does not expect a value"))
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(word.normal_random_word, {
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(word.normal_random_word, {
            "--all",
            "--quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)
end)
