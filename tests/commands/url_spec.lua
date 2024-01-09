local config = require("randiverse.config")
local url = require("randiverse.commands.url")
local utils = require("randiverse.commands.utils")

local test_utils = require("tests.utils")

describe("Randiverse 'url' command", function()
    it("should return random url with no flags", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {})
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)$")
            assert.is_truthy(protocol and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return random url with '--subdomains 1'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--subdomains",
                "1",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, subdomain, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)%.(%l+)$")
            assert.is_truthy(protocol and subdomain and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    subdomain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return random url with '--subdomains 3'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--subdomains",
                "3",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, s1, s2, s3, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)%.(%l+)%.(%l+)%.(%l+)$")
            assert.is_truthy(protocol and s1 and s2 and s3 and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    s1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    s2
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    s3
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return random url with '--subdomains 0'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--subdomains",
                "0",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)$")
            assert.is_truthy(protocol and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return random url with '--paths 1'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--paths",
                "1",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld, path = random_url:match("^(%l+)://(%l+)%.(%l+)/(%l+)$")
            assert.is_truthy(protocol and domain and tld and path)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    path
                )
            )
        end
    end)

    it("should return random url with '--paths 2'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--paths",
                "2",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld, p1, p2 = random_url:match("^(%l+)://(%l+)%.(%l+)/(%l+)/(%l+)$")
            assert.is_truthy(protocol and domain and tld and p1 and p2)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    p1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    p2
                )
            )
        end
    end)

    it("should return random url with '--paths 0'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--paths",
                "0",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)$")
            assert.is_truthy(protocol and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return random url with '--fragment'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--fragment",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld, fragment = random_url:match("^(%l+)://(%l+)%.(%l+)#(%l+)$")
            assert.is_truthy(protocol and domain and tld and fragment)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_fragment_corpus]
                    ),
                    fragment
                )
            )
        end
    end)

    it("should return random url with '--query-params 1'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--query-params",
                "1",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld, param, value = random_url:match("^(%l+)://(%l+)%.(%l+)%?(%l+)=(%l+)$")
            assert.is_truthy(protocol and domain and tld and param and value)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_param_corpus]
                    ),
                    param
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_value_corpus]
                    ),
                    value
                )
            )
        end
    end)

    it("should return random url with '--query-params 2'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--query-params",
                "2",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld, p1, v1, p2, v2 =
                random_url:match("^(%l+)://(%l+)%.(%l+)%?(%l+)=(%l+)&(%l+)=(%l+)$")
            assert.is_truthy(protocol and domain and tld and p1 and v1 and p2 and v2)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_param_corpus]
                    ),
                    p1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_param_corpus]
                    ),
                    p2
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_value_corpus]
                    ),
                    v1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_value_corpus]
                    ),
                    v2
                )
            )
        end
    end)

    it("should return random url with '--query-params 0'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--query-params",
                "0",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)$")
            assert.is_truthy(protocol and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return long random url with '--paths 3 --fragment --subdomains 2 --query-params 2'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--paths",
                "3",
                "--fragment",
                "--subdomains",
                "2",
                "--query-params",
                "2",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, s1, s2, domain, tld, p1, p2, p3, param1, v1, param2, v2, fragment = random_url:match(
                "^(%l+)://(%l+)%.(%l+)%.(%l+)%.(%l+)/(%l+)/(%l+)/(%l+)%?(%l+)=(%l+)&(%l+)=(%l+)#(%l+)$"
            )
            assert.is_truthy(
                protocol
                    and s1
                    and s2
                    and domain
                    and tld
                    and p1
                    and p2
                    and p3
                    and param1
                    and v1
                    and param2
                    and v2
                    and fragment
            )
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    s1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    s2
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    p1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    p2
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    p3
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_param_corpus]
                    ),
                    param1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_value_corpus]
                    ),
                    v1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_param_corpus]
                    ),
                    param2
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_value_corpus]
                    ),
                    v2
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_fragment_corpus]
                    ),
                    fragment
                )
            )
        end
    end)

    it("should error when called with '--subdomains' flag and invalid value", function()
        local success, error = pcall(url.normal_random_url, {
            "--subdomains",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'subdomains' can not accept value 'dummy': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--subdomains' flag and non-integer", function()
        local success, error = pcall(url.normal_random_url, {
            "--subdomains",
            "2.5",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'subdomains' can not accept value '2.5': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--subdomains' flag and negative integer", function()
        local success, error = pcall(url.normal_random_url, {
            "--subdomains",
            "-1",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'subdomains' can not accept value '%-1': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--subdomains' flag and no value", function()
        local success, error = pcall(url.normal_random_url, {
            "--subdomains",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'subdomains' expects a value and no value was provided"))
    end)

    it("should error when called with '--paths' flag and invalid value", function()
        local success, error = pcall(url.normal_random_url, {
            "--paths",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'paths' can not accept value 'dummy': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--paths' flag and non-integer", function()
        local success, error = pcall(url.normal_random_url, {
            "--paths",
            "2.5",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'paths' can not accept value '2.5': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--paths' flag and negative integer", function()
        local success, error = pcall(url.normal_random_url, {
            "--paths",
            "-1",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'paths' can not accept value '%-1': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--paths' flag and no value", function()
        local success, error = pcall(url.normal_random_url, {
            "--paths",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'paths' expects a value and no value was provided"))
    end)

    it("should error when called with '--query-params' flag and invalid value", function()
        local success, error = pcall(url.normal_random_url, {
            "--query-params",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(
                error,
                "flag 'query%-params' can not accept value 'dummy': value must be a non%-negative integer"
            )
        )
    end)
    it("should error when called with '--query-params' flag and non-integer", function()
        local success, error = pcall(url.normal_random_url, {
            "--query-params",
            "2.5",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'query%-params' can not accept value '2.5': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--query-params' flag and negative integer", function()
        local success, error = pcall(url.normal_random_url, {
            "--query-params",
            "-1",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'query%-params' can not accept value '%-1': value must be a non%-negative integer")
        )
    end)
    it("should error when called with '--query-params' flag and no value", function()
        local success, error = pcall(url.normal_random_url, {
            "--query-params",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'query%-params' expects a value and no value was provided"))
    end)

    it("should error when called with '--fragment' and a value", function()
        local success, error = pcall(url.normal_random_url, {
            "--fragment",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'fragment' is boolean and does not expect a value"))
    end)

    it("should error when called with unknown '-e' flag", function()
        local success, error = pcall(url.normal_random_url, {
            "-e",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'e'"))
    end)
    it("should error when called with unknown '--even-longer-longer-command' flag", function()
        local success, error = pcall(url.normal_random_url, {
            "--even-longer-longer-command",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'even%-longer%-longer%-command'"))
    end)
end)
