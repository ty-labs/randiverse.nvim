local config = require("randiverse.config")
local lorem = require("randiverse.commands.lorem")
local utils = require("randiverse.commands.utils")

local test_utils = require("tests.utils")

describe("Randiverse 'lorem' command", function()
    it("should return random lorem ipsum text with no flags", function()
        -- test comma placement? --
        -- lorem ipsum @ start --
        for _ = 1, 20 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {})
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local words, sentences = {}, {}
            for word in random_lorem:gmatch("%S+") do
                table.insert(words, word)
            end
            for sentence in random_lorem:gmatch("[^.]+") do
                table.insert(sentences, sentence)
            end
            assert.is_true(
                -- not always possible to get exact length since sentences vary --
                config.user_opts.data.lorem.default_length - 2 <= #words
                    and #words <= config.user_opts.data.lorem.default_length
            )
            assert.same(config.user_opts.data.lorem.default_length, #words)
            local corpus = utils.read_lines(
                config.user_opts.data.ROOT
                    .. config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
            )
            for _, word in ipairs(words) do
                word = string.lower(word:gsub("%A", ""))
                assert.is_true(test_utils.list_contains(corpus, word))
            end
            local sentence_length =
                config.user_opts.data.lorem.sentence_lengths[config.user_opts.data.lorem.default_sentence_length]
            local lower_bound, upper_bound = sentence_length[1], sentence_length[2]
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
                assert.is_true(lower_bound <= word_count and word_count <= upper_bound)
            end
        end
    end)

    it("should return random lorem ipsum text with '-c' flag", function()
        for _ = 1, 50 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "-c",
                "lorem",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local match = random_lorem:match("^(%a+)$")
            assert.is_truthy(match)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["short"]),
                    match
                )
            )
        end
    end)

    it("should return a random lorem with '--corpus' flag", function()
        for _ = 1, 50 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--corpus",
                "long",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local match = random_lorem:match("^(%a+)$")
            assert.is_truthy(match)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["long"]),
                    match
                )
            )
        end
    end)

    it("should return a random lorem with '-a' flag", function()
        for _ = 1, 50 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "-a",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local match = random_lorem:match("^(%a+)$")
            assert.is_truthy(match)
            local short = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["short"]),
                match
            )
            local medium = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["medium"]),
                match
            )
            local long = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["long"]),
                match
            )
            assert.is_true(
                (short and not medium and not long)
                    or (not short and medium and not long)
                    or (not short and not medium and long)
            )
        end
    end)

    it("should return a random lorem with '--all' flag", function()
        for _ = 1, 50 do
            local success, random_lorem = pcall(lorem.normal_random_lorem, {
                "--all",
            })
            assert.is_true(success)
            assert.same(type(random_lorem), "string")
            local match = random_lorem:match("^(%a+)$")
            assert.is_truthy(match)
            local short = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["short"]),
                match
            )
            local medium = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["medium"]),
                match
            )
            local long = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["long"]),
                match
            )
            assert.is_true(
                (short and not medium and not long)
                    or (not short and medium and not long)
                    or (not short and not medium and long)
            )
        end
    end)

    it("should return multiple lorems with '-l 50' flag", function()
        local success, random_lorems = pcall(lorem.normal_random_lorem, {
            "-l",
            "50",
        })
        assert.is_true(success)
        assert.same(type(random_lorems), "string")
        local lorems = {}
        for w in random_lorems:gmatch("%S+") do
            table.insert(lorems, w)
        end
        assert.same(50, #lorems)
        local default = config.user_opts.data.lorem.corpuses[config.user_opts.data.lorem.default_corpus]
        for _, w in ipairs(lorems) do
            assert.same(type(w), "string")
            assert.is_true(
                assert.is_true(test_utils.list_contains(utils.read_lines(config.user_opts.data.ROOT .. default), w))
            )
        end
    end)

    it("should return multiple lorems with '--length 50 --all' flag", function()
        local success, random_lorems = pcall(lorem.normal_random_lorem, {
            "--length",
            "50",
            "--all",
        })
        assert.is_true(success)
        assert.same(type(random_lorems), "string")
        local lorems = {}
        for w in random_lorems:gmatch("%S+") do
            table.insert(lorems, w)
        end
        assert.same(50, #lorems)
        for _, w in ipairs(lorems) do
            assert.same(type(w), "string")
            local short = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["short"]),
                w
            )
            local medium = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["medium"]),
                w
            )
            local long = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["long"]),
                w
            )
            assert.is_true(
                (short and not medium and not long)
                    or (not short and medium and not long)
                    or (not short and not medium and long)
            )
        end
    end)

    it("should return multiple lorems with '-c short -l 100' flag", function()
        local success, random_lorems = pcall(lorem.normal_random_lorem, {
            "-c",
            "short",
            "-l",
            "100",
        })
        assert.is_true(success)
        assert.same(type(random_lorems), "string")
        local lorems = {}
        for w in random_lorems:gmatch("%S+") do
            table.insert(lorems, w)
        end
        assert.same(100, #lorems)
        for _, w in ipairs(lorems) do
            assert.same(type(w), "string")
            assert.is_true(
                assert.is_true(
                    test_utils.list_contains(
                        utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.lorem.corpuses["short"]),
                        w
                    )
                )
            )
        end
    end)

    it("should error when called with '-c' flag and invalid value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "-c",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'corpus' can not accept value 'dummy': value must be one of the following %[")
        )
    end)

    it("should error when called with '-a' flag and a value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "-a",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'all' is boolean and does not expect a value"))
    end)

    it("should error when called with '--all' flag and a value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--all",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'all' is boolean and does not expect a value"))
    end)

    it("should error when called with '-l' flag and invalid value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "-l",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'length' can not accept value 'dummy': value must be a positive integer")
        )
    end)

    it("should error when called with '--length' flag and invalid value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "-l",
            "0",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'length' can not accept value '0': value must be a positive integer"))
    end)

    it("should error when called with '-l' flag and no value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "-l",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'length' expects a value and no value was provided"))
    end)

    it("should error when called with '-a' flag and a value", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "-a",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'all' is boolean and does not expect a value"))
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(lorem.normal_random_lorem, {
            "--all",
            "--quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)
end)
