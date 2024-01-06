local config = require("randiverse.config")
local email = require("randiverse.commands.email")
local utils = require("randiverse.commands.utils")

local test_utils = require("tests.utils")

describe("Randiverse 'email' command", function()
    it("should return random email with no flags", function()
        for _ = 1, 20 do
            local success, random_email = pcall(email.normal_random_email, {})
            assert.is_true(success)
            assert.same(type(random_email), "string")
            local username, domain, tld = random_email:match("^(%l+)@(%l+)%.(%l+)$")
            assert.is_truthy(username and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.domains, domain))
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.tlds, tld))
        end
    end)

    it("should return random email with '--separator'", function()
        for _ = 1, 20 do
            local success, random_email = pcall(email.normal_random_email, {
                "--separator",
            })
            assert.is_true(success)
            assert.same(type(random_email), "string")
            local name_1, separator, name_2, domain, tld = random_email:match("^(%l+)([^%l])(%l+)@(%l+)%.(%l+)$")
            assert.is_truthy(name_1 and separator and name_2 and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.domains, domain))
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.tlds, tld))
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.separators, separator))
            name_1, name_2 = name_1:gsub("^%l", string.upper), name_2:gsub("^%l", string.upper)
            local name_1_first = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                name_1
            )
            local name_1_last = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                name_1
            )
            assert.is_true(name_1_first or name_1_last)
            local name_2_first = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                name_2
            )
            local name_2_last = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                name_2
            )
            assert.is_true(name_2_first or name_2_last)
        end
    end)

    it("should return capitalized random email with '--capitalize' flag", function()
        for _ = 1, 20 do
            local success, random_email = pcall(email.normal_random_email, {
                "--capitalize",
            })
            assert.is_true(success)
            assert.same(type(random_email), "string")
            local name_1, name_2, domain, tld = random_email:match("^(%u%l+)(%u%l+)@(%l+)%.(%l+)$")
            assert.is_truthy(name_1 and name_2 and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.domains, domain))
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.tlds, tld))
            local name_1_first = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                name_1
            )
            local name_1_last = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                name_1
            )
            assert.is_true(name_1_first or name_1_last)
            local name_2_first = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                name_2
            )
            local name_2_last = test_utils.list_contains(
                utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                name_2
            )
            assert.is_true(name_2_first or name_2_last)
        end
    end)

    it("should return random email with 2-digit suffix with '--digits 2'", function()
        for _ = 1, 20 do
            local success, random_email = pcall(email.normal_random_email, {
                "--digits",
                "2",
            })
            assert.is_true(success)
            assert.same(type(random_email), "string")
            local username, digits, domain, tld = random_email:match("^(%l+)(%d%d)@(%l+)%.(%l+)$")
            assert.is_truthy(username and digits and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.domains, domain))
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.tlds, tld))
        end
    end)

    it("should return random email with 4-digit suffix with '--digits 4'", function()
        for _ = 1, 20 do
            local success, random_email = pcall(email.normal_random_email, {
                "--digits",
                "4",
            })
            assert.is_true(success)
            assert.same(type(random_email), "string")
            local username, digits, domain, tld = random_email:match("^(%l+)(%d%d%d%d)@(%l+)%.(%l+)$")
            assert.is_truthy(username and digits and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.domains, domain))
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.tlds, tld))
        end
    end)

    it("should return random email with 2-special character suffix with '--specials 2'", function()
        for _ = 1, 20 do
            local success, random_email = pcall(email.normal_random_email, {
                "--specials",
                "2",
            })
            assert.is_true(success)
            assert.same(type(random_email), "string")
            local username, specials, domain, tld = random_email:match("^(%l+)([^%w][^%w])@(%l+)%.(%l+)$")
            assert.is_truthy(username and specials and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.domains, domain))
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.tlds, tld))
        end
    end)

    it("should return random email with 4-special character suffix with '--specials 4'", function()
        for _ = 1, 20 do
            local success, random_email = pcall(email.normal_random_email, {
                "--specials",
                "4",
            })
            assert.is_true(success)
            assert.same(type(random_email), "string")
            local username, specials, domain, tld = random_email:match("^(%l+)([^%w][^%w][^%w][^%w])@(%l+)%.(%l+)$")
            assert.is_truthy(username and specials and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.domains, domain))
            assert.is_true(test_utils.list_contains(config.user_opts.data.email.tlds, tld))
        end
    end)

    it(
        "should return a capitalized random email with 2-digit, 1-special suffix with '--separator --digits 2 --capitalize --specials 1'",
        function()
            for _ = 1, 20 do
                local success, random_email = pcall(email.normal_random_email, {
                    "--separator",
                    "--digits",
                    "2",
                    "--capitalize",
                    "--specials",
                    "1",
                })
                assert.is_true(success)
                assert.same(type(random_email), "string")
                local name_1, separator, name_2, digits, specials, domain, tld =
                    random_email:match("^(%u%l+)([^%w])(%u%l+)(%d%d)([^%w])@(%l+)%.(%l+)$")
                assert.is_truthy(name_1 and separator and name_2 and digits and specials and domain and tld)
                assert.is_true(test_utils.list_contains(config.user_opts.data.email.domains, domain))
                assert.is_true(test_utils.list_contains(config.user_opts.data.email.tlds, tld))
                assert.is_true(test_utils.list_contains(config.user_opts.data.email.separators, separator))
                local name_1_first = test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                    name_1
                )
                local name_1_last = test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                    name_1
                )
                assert.is_true(name_1_first or name_1_last)
                local name_2_first = test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.FIRST),
                    name_2
                )
                local name_2_last = test_utils.list_contains(
                    utils.read_lines(config.user_opts.data.ROOT .. config.user_opts.data.name.LAST),
                    name_2
                )
                assert.is_true(name_2_first or name_2_last)
            end
        end
    )

    it("should return muddled random email with '--muddle-property'", function() end)

    it("should error when called with 'digits' flag and invalid value", function()
        local success, error = pcall(email.normal_random_email, {
            "--digits",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'digits' can not accept value 'dummy': value must be a non%-negative integer")
        )
    end)
    it("should error when called with 'digits' flag and non-integer", function()
        local success, error = pcall(email.normal_random_email, {
            "--digits",
            "2.5",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'digits' can not accept value '2.5': value must be a non%-negative integer")
        )
    end)
    it("should error when called with 'digits' flag and negative integer", function()
        local success, error = pcall(email.normal_random_email, {
            "--digits",
            "-1",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'digits' can not accept value '%-1': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--digits' flag and no value", function()
        local success, error = pcall(email.normal_random_email, {
            "--digits",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'digits' expects a value and no value was provided"))
    end)

    it("should error when called with 'specials' flag and invalid value", function()
        local success, error = pcall(email.normal_random_email, {
            "--specials",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'specials' can not accept value 'dummy': value must be a non%-negative integer")
        )
    end)
    it("should error when called with 'specials' flag and negative integer", function()
        local success, error = pcall(email.normal_random_email, {
            "--specials",
            "-1",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'specials' can not accept value '%-1': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--specials' flag and no value", function()
        local success, error = pcall(email.normal_random_email, {
            "--specials",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'specials' expects a value and no value was provided"))
    end)

    it("should error when called with '--muddle-property' flag and invalid value", function()
        local success, error = pcall(email.normal_random_email, {
            "--muddle-property",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(
                error,
                "flag 'muddle%-property' can not accept value 'dummy': value must be in range %[0.0, 1.0%]"
            )
        )
    end)
    it("should error when called with '--muddle-property' flag and non-probability number", function()
        local success, error = pcall(email.normal_random_email, {
            "--muddle-property",
            "1.5",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(
                error,
                "flag 'muddle%-property' can not accept value '1.5': value must be in range %[0.0, 1.0%]"
            )
        )
    end)
    it("should error when called with '--muddle-property' flag and non-probability number", function()
        local success, error = pcall(email.normal_random_email, {
            "--muddle-property",
            "-0.1",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(
                error,
                "flag 'muddle%-property' can not accept value '%-0.1': value must be in range %[0.0, 1.0%]"
            )
        )
    end)
    it("should error when called with '--muddle-property' flag and no value", function()
        local success, error = pcall(email.normal_random_email, {
            "--muddle-property",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'muddle%-property' expects a value and no value was provided"))
    end)

    it("should error when called with '--separator' and a value", function()
        local success, error = pcall(email.normal_random_email, {
            "--separator",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'separator' is boolean and does not expect a value"))
    end)

    it("should error when called with '--capitalize' and a value", function()
        local success, error = pcall(email.normal_random_email, {
            "--capitalize",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'capitalize' is boolean and does not expect a value"))
    end)

    it("should error when called with unknown '-e' flag", function()
        local success, error = pcall(email.normal_random_email, {
            "-e",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'e'"))
    end)
    it("should error when called with unknown '--even-longer-longer-command' flag", function()
        local success, error = pcall(email.normal_random_email, {
            "--even-longer-longer-command",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'even%-longer%-longer%-command'"))
    end)
end)
