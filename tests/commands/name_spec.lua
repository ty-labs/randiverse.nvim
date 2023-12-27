local config = require("randiverse.config")
local name = require("randiverse.commands.name")
local utils = require("randiverse.commands.utils")

local test_utils = require("tests.utils")

describe("Randiverse 'name' command", function()
    it("should return a random name with no flags", function()
        for _ = 1, 50 do
            local success, random_name = pcall(name.normal_random_name, {})
            assert.is_true(success)
            assert.same(type(random_name), "string")
            local first, last = random_name:match("^(%a+) (%a+)$")
            assert.is_truthy(first and last)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                    first
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                    last
                )
            )
        end
    end)

    it("should return a random first name with '-f' flag", function()
        for _ = 1, 50 do
            local success, random_name = pcall(name.normal_random_name, {
                "-f",
            })
            assert.is_true(success)
            assert.same(type(random_name), "string")
            local first = random_name:match("^(%a+)$")
            assert.is_truthy(first)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                    first
                )
            )
        end
    end)

    it("should return a random first name with '--first' flag", function()
        for _ = 1, 50 do
            local success, random_name = pcall(name.normal_random_name, {
                "--first",
            })
            assert.is_true(success)
            assert.same(type(random_name), "string")
            local first = random_name:match("^(%a+)$")
            assert.is_truthy(first)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                    first
                )
            )
        end
    end)

    it("should return a random last name with '-l' flag", function()
        for _ = 1, 50 do
            local success, random_name = pcall(name.normal_random_name, {
                "-l",
            })
            assert.is_true(success)
            assert.same(type(random_name), "string")
            local last = random_name:match("^(%a+)$")
            assert.is_truthy(last)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                    last
                )
            )
        end
    end)

    it("should return a random last name with '--last' flag", function()
        for _ = 1, 50 do
            local success, random_name = pcall(name.normal_random_name, {
                "--last",
            })
            assert.is_true(success)
            assert.same(type(random_name), "string")
            local last = random_name:match("^(%a+)$")
            assert.is_truthy(last)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                    last
                )
            )
        end
    end)

    it("should error when called with '-f' flag and a value", function()
        local success, error = pcall(name.normal_random_name, {
            "-f",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'first' is boolean and does not expect a value"))
    end)

    it("should error when called with '-l' flag and a value", function()
        local success, error = pcall(name.normal_random_name, {
            "-l",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'last' is boolean and does not expect a value"))
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(name.normal_random_name, {
            "-f",
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(name.normal_random_name, {
            "--last",
            "--quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)
end)
