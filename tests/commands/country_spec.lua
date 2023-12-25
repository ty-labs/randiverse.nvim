local config = require("randiverse.config")
local country = require("randiverse.commands.country")
local utils = require("randiverse.commands.utils")

local test_utils = require("tests.utils")

describe("Randiverse 'country' command", function()
    it("should return a random country with no flags", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {})
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.is_true(#random_country >= 3)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.COUNTRIES),
                    random_country
                )
            )
        end
    end)

    it("should return a random country code with '-c 2' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "-c",
                "2",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%u]", ""))
            assert.is_true(#random_country == 2)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA2),
                    random_country
                )
            )
        end
    end)

    it("should return a random country code with '-c alpha-2' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "-c",
                "alpha-2",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%u]", ""))
            assert.is_true(#random_country == 2)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA2),
                    random_country
                )
            )
        end
    end)

    it("should return a random country code with '-c 3' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "-c",
                "3",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%u]", ""))
            assert.is_true(#random_country == 3)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA3),
                    random_country
                )
            )
        end
    end)

    it("should return a random country code with '-c alpha-3' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "-c",
                "alpha-3",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%u]", ""))
            assert.is_true(#random_country == 3)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA3),
                    random_country
                )
            )
        end
    end)

    it("should return a random country code with '--code 2' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "--code",
                "2",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%u]", ""))
            assert.is_true(#random_country == 2)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA2),
                    random_country
                )
            )
        end
    end)

    it("should return a random country code with '--code alpha-2' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "--code",
                "alpha-2",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%u]", ""))
            assert.is_true(#random_country == 2)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA2),
                    random_country
                )
            )
        end
    end)

    it("should return a random country code with '--code 3' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "--code",
                "3",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%u]", ""))
            assert.is_true(#random_country == 3)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA3),
                    random_country
                )
            )
        end
    end)

    it("should return a random country code with '--code alpha-3' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "--code",
                "alpha-3",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%u]", ""))
            assert.is_true(#random_country == 3)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.ALPHA3),
                    random_country
                )
            )
        end
    end)

    it("should return a random country numeric code with '-n' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "-n",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%d]", ""))
            assert.is_true(#random_country == 3)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.NUMERIC),
                    random_country
                )
            )
        end
    end)

    it("should return a random country numeric code with '--numeric' flag", function()
        for _ = 1, 50 do
            local success, random_country = pcall(country.normal_random_country, {
                "--numeric",
            })
            assert.is_true(success)
            assert.same(type(random_country), "string")
            assert.same(random_country, random_country:gsub("[^%d]", ""))
            assert.is_true(#random_country == 3)
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.country.NUMERIC),
                    random_country
                )
            )
        end
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(country.normal_random_country, {
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(country.normal_random_country, {
            "-quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)

    it("should error when called with '-c' flag and no value", function()
        local success, error = pcall(country.normal_random_country, {
            "-c",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'code' expects a value and no value was provided"))
    end)

    it("should error when called with '--code' flag and no value", function()
        local success, error = pcall(country.normal_random_country, {
            "--code",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'code' expects a value and no value was provided"))
    end)

    it("should error when called with '-c' flag and invalid value", function()
        local success, error = pcall(country.normal_random_country, {
            "-c",
            "test",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'code' can not accept value 'test'"))
    end)

    it("should error when called with '--code' flag and invalid value", function()
        local success, error = pcall(country.normal_random_country, {
            "--code",
            "4",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'code' can not accept value '4'"))
    end)

    it("should error when called with '-n' flag and a value", function()
        local success, error = pcall(country.normal_random_country, {
            "-n",
            "4",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'numeric' is boolean and does not expect a value"))
    end)
end)
