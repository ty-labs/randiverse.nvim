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
            local default = config.user_opts.data.word.corpuses[config.user_opts.data.word.default]
            assert.is_true(test_utils.list_contains(utils.read_lines(config.user_opts.data.ROOT .. default), match))
        end
    end)

    it("should return a random first word with '-c' flag", function()
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

    it("should return a random first word with '--corpus' flag", function()
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

    it("should return a random last word with '-a' flag", function()
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

    it("should return a random last word with '--all' flag", function()
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

    it("should error when called with '-c' flag and invalid value", function()
        local success, error = pcall(word.normal_random_word, {
            "-c",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'corpus' can not accept value 'dummy': value must be one of the following")
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
